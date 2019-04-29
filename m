Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16B68EB37
	for <lists+linux-security-module@lfdr.de>; Mon, 29 Apr 2019 21:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfD2T7D (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 29 Apr 2019 15:59:03 -0400
Received: from namei.org ([65.99.196.166]:36452 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfD2T7D (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 15:59:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3TJwux6025677;
        Mon, 29 Apr 2019 19:58:57 GMT
Date:   Tue, 30 Apr 2019 05:58:56 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/3] smack: Check address length before reading address
 family
In-Reply-To: <738815cc-ac59-63c9-1768-26df95689d7a@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1904300558310.20645@namei.org>
References: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <1555066776-9758-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <738815cc-ac59-63c9-1768-26df95689d7a@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 12 Apr 2019, Casey Schaufler wrote:

> On 4/12/2019 3:59 AM, Tetsuo Handa wrote:
> > KMSAN will complain if valid address length passed to bind()/connect()/
> > sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.
> > 
> > Also, since smk_ipv6_port_label()/smack_netlabel_send()/
> > smack_ipv6host_label()/smk_ipv6_check()/smk_ipv6_port_check() are not
> > checking valid address length and/or address family, make sure we check
> > both. The minimal valid length in smack_socket_connect() is changed from
> > sizeof(struct sockaddr_in6) bytes to SIN6_LEN_RFC2133 bytes, for it seems
> > that Smack is not using "struct sockaddr_in6"->sin6_scope_id field.
> > 
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Casey: will you be taking this via your tree?

-- 
James Morris
<jmorris@namei.org>

