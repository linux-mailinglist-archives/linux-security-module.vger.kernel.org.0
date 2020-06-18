Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32B61FE847
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Jun 2020 04:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbgFRCr3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 17 Jun 2020 22:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgFRBKV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jun 2020 21:10:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 027DB2089D;
        Thu, 18 Jun 2020 01:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442620;
        bh=AETcQc/NBCdgyaxxnoeDeyHtubYUFyOAd5oafbpm/c4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=waG7U0o4MUptLFYHFdly3PG4YnNVdpde3QtSE1wh8TrHHUjjqZamoP8dQQMIlLs5x
         3zCaIJGMLsGeObWqHOEO0ah1/7IqCuO0OwZCYSmC0mz82d9BcJVsAPti0xF97MAr1A
         YVcOSzJyQRDk9sGGG3Ln2WACSBjvBo7WHm2KrWFs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        Brian Moyles <bmoyles@netflix.com>,
        John Johansen <john.johansen@canonical.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 100/388] apparmor: check/put label on apparmor_sk_clone_security()
Date:   Wed, 17 Jun 2020 21:03:17 -0400
Message-Id: <20200618010805.600873-100-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Mauricio Faria de Oliveira <mfo@canonical.com>

[ Upstream commit 3b646abc5bc6c0df649daea4c2c976bd4d47e4c8 ]

Currently apparmor_sk_clone_security() does not check for existing
label/peer in the 'new' struct sock; it just overwrites it, if any
(with another reference to the label of the source sock.)

    static void apparmor_sk_clone_security(const struct sock *sk,
                                           struct sock *newsk)
    {
            struct aa_sk_ctx *ctx = SK_CTX(sk);
            struct aa_sk_ctx *new = SK_CTX(newsk);

            new->label = aa_get_label(ctx->label);
            new->peer = aa_get_label(ctx->peer);
    }

This might leak label references, which might overflow under load.
Thus, check for and put labels, to prevent such errors.

Note this is similarly done on:

    static int apparmor_socket_post_create(struct socket *sock, ...)
    ...
            if (sock->sk) {
                    struct aa_sk_ctx *ctx = SK_CTX(sock->sk);

                    aa_put_label(ctx->label);
                    ctx->label = aa_get_label(label);
            }
    ...

Context:
-------

The label reference count leak is observed if apparmor_sock_graft()
is called previously: this sets the 'ctx->label' field by getting
a reference to the current label (later overwritten, without put.)

    static void apparmor_sock_graft(struct sock *sk, ...)
    {
            struct aa_sk_ctx *ctx = SK_CTX(sk);

            if (!ctx->label)
                    ctx->label = aa_get_current_label();
    }

And that is the case on crypto/af_alg.c:af_alg_accept():

    int af_alg_accept(struct sock *sk, struct socket *newsock, ...)
    ...
            struct sock *sk2;
            ...
            sk2 = sk_alloc(...);
            ...
            security_sock_graft(sk2, newsock);
            security_sk_clone(sk, sk2);
    ...

Apparently both calls are done on their own right, especially for
other LSMs, being introduced in 2010/2014, before apparmor socket
mediation in 2017 (see commits [1,2,3,4]).

So, it looks OK there! Let's fix the reference leak in apparmor.

Test-case:
---------

Exercise that code path enough to overflow label reference count.

    $ cat aa-refcnt-af_alg.c
    #include <stdio.h>
    #include <string.h>
    #include <unistd.h>
    #include <sys/socket.h>
    #include <linux/if_alg.h>

    int main() {
            int sockfd;
            struct sockaddr_alg sa;

            /* Setup the crypto API socket */
            sockfd = socket(AF_ALG, SOCK_SEQPACKET, 0);
            if (sockfd < 0) {
                    perror("socket");
                    return 1;
            }

            memset(&sa, 0, sizeof(sa));
            sa.salg_family = AF_ALG;
            strcpy((char *) sa.salg_type, "rng");
            strcpy((char *) sa.salg_name, "stdrng");

            if (bind(sockfd, (struct sockaddr *) &sa, sizeof(sa)) < 0) {
                    perror("bind");
                    return 1;
            }

            /* Accept a "connection" and close it; repeat. */
            while (!close(accept(sockfd, NULL, 0)));

            return 0;
    }

    $ gcc -o aa-refcnt-af_alg aa-refcnt-af_alg.c

    $ ./aa-refcnt-af_alg
    <a few hours later>

    [ 9928.475953] refcount_t overflow at apparmor_sk_clone_security+0x37/0x70 in aa-refcnt-af_alg[1322], uid/euid: 1000/1000
    ...
    [ 9928.507443] RIP: 0010:apparmor_sk_clone_security+0x37/0x70
    ...
    [ 9928.514286]  security_sk_clone+0x33/0x50
    [ 9928.514807]  af_alg_accept+0x81/0x1c0 [af_alg]
    [ 9928.516091]  alg_accept+0x15/0x20 [af_alg]
    [ 9928.516682]  SYSC_accept4+0xff/0x210
    [ 9928.519609]  SyS_accept+0x10/0x20
    [ 9928.520190]  do_syscall_64+0x73/0x130
    [ 9928.520808]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Note that other messages may be seen, not just overflow, depending on
the value being incremented by kref_get(); on another run:

    [ 7273.182666] refcount_t: saturated; leaking memory.
    ...
    [ 7273.185789] refcount_t: underflow; use-after-free.

Kprobes:
-------

Using kprobe events to monitor sk -> sk_security -> label -> count (kref):

Original v5.7 (one reference leak every iteration)

 ... (af_alg_accept+0x0/0x1c0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd2
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd4
 ... (af_alg_accept+0x0/0x1c0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd3
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd5
 ... (af_alg_accept+0x0/0x1c0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd4
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff8a0f36c25eb0 label_refcnt=0x11fd6

Patched v5.7 (zero reference leak per iteration)

 ... (af_alg_accept+0x0/0x1c0) label=0xffff9ff376c25eb0 label_refcnt=0x593
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff9ff376c25eb0 label_refcnt=0x594
 ... (af_alg_accept+0x0/0x1c0) label=0xffff9ff376c25eb0 label_refcnt=0x593
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff9ff376c25eb0 label_refcnt=0x594
 ... (af_alg_accept+0x0/0x1c0) label=0xffff9ff376c25eb0 label_refcnt=0x593
 ... (af_alg_release_parent+0x0/0xd0) label=0xffff9ff376c25eb0 label_refcnt=0x594

Commits:
-------

[1] commit 507cad355fc9 ("crypto: af_alg - Make sure sk_security is initialized on accept()ed sockets")
[2] commit 4c63f83c2c2e ("crypto: af_alg - properly label AF_ALG socket")
[3] commit 2acce6aa9f65 ("Networking") a.k.a ("crypto: af_alg - Avoid sock_graft call warning)
[4] commit 56974a6fcfef ("apparmor: add base infastructure for socket mediation")

Fixes: 56974a6fcfef ("apparmor: add base infastructure for socket mediation")
Reported-by: Brian Moyles <bmoyles@netflix.com>
Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/lsm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b621ad74f54a..66a8504c8bea 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -804,7 +804,12 @@ static void apparmor_sk_clone_security(const struct sock *sk,
 	struct aa_sk_ctx *ctx = SK_CTX(sk);
 	struct aa_sk_ctx *new = SK_CTX(newsk);
 
+	if (new->label)
+		aa_put_label(new->label);
 	new->label = aa_get_label(ctx->label);
+
+	if (new->peer)
+		aa_put_label(new->peer);
 	new->peer = aa_get_label(ctx->peer);
 }
 
-- 
2.25.1

