Return-Path: <linux-security-module+bounces-18-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC187F4932
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Nov 2023 15:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDDA2815C5
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Nov 2023 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A37D20300
	for <lists+linux-security-module@lfdr.de>; Wed, 22 Nov 2023 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="OZ2rMpvd"
X-Original-To: linux-security-module@vger.kernel.org
X-Greylist: delayed 438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Nov 2023 06:02:47 PST
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF42197
	for <linux-security-module@vger.kernel.org>; Wed, 22 Nov 2023 06:02:47 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id A1721114CAA9;
	Wed, 22 Nov 2023 16:55:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru A1721114CAA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1700661324; bh=WfKnDkL5/6UmicSAggQzojP2VBLZEawhK5wwMkpVq1E=;
	h=From:To:CC:Subject:Date:From;
	b=OZ2rMpvd/GJ73lWv/91VdsU2sZM9EbQqMl2PcXY1yYh7mpWJJ435lqjs2EumtYveD
	 LOMIL4jCVIm39swBIRBi70L+FUbFbK9kS12PmU2HlwCfeW8Uz0mmlcp1lxxU5FHtqo
	 iUULdiaJ0jWPW9vQbYt3HhoajFJ+0LGXPjDX+D+I=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 9EC4031301CF;
	Wed, 22 Nov 2023 16:55:24 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Paul Moore <paul@paul-moore.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Huw Davies <huw@codeweavers.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net] calipso: Fix memory leak in netlbl_calipso_add_pass()
Thread-Topic: [PATCH net] calipso: Fix memory leak in
 netlbl_calipso_add_pass()
Thread-Index: AQHaHUuKnw2Bkvmb60ybqCKOZMz9OQ==
Date: Wed, 22 Nov 2023 13:55:24 +0000
Message-ID: <20231122135242.2779058-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/11/22 12:40:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/11/22 10:55:00 #22501072
X-KLMS-AntiVirus-Status: Clean, skipped

If IPv6 support is disabled at boot (ipv6.disable=3D1),
the calipso_init() -> netlbl_calipso_ops_register() function isn't called,
and the netlbl_calipso_ops_get() function always returns NULL.
In this case, the netlbl_calipso_add_pass() function allocates memory
for the doi_def variable but doesn't free it with the calipso_doi_free().

BUG: memory leak
unreferenced object 0xffff888011d68180 (size 64):
  comm "syz-executor.1", pid 10746, jiffies 4295410986 (age 17.928s)
  hex dump (first 32 bytes):
    00 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000730d8770>] kmalloc include/linux/slab.h:552 [inline]
    [<00000000730d8770>] netlbl_calipso_add_pass net/netlabel/netlabel_cali=
pso.c:76 [inline]
    [<00000000730d8770>] netlbl_calipso_add+0x22e/0x4f0 net/netlabel/netlab=
el_calipso.c:111
    [<0000000002e662c0>] genl_family_rcv_msg_doit+0x22f/0x330 net/netlink/g=
enetlink.c:739
    [<00000000a08d6d74>] genl_family_rcv_msg net/netlink/genetlink.c:783 [i=
nline]
    [<00000000a08d6d74>] genl_rcv_msg+0x341/0x5a0 net/netlink/genetlink.c:8=
00
    [<0000000098399a97>] netlink_rcv_skb+0x14d/0x440 net/netlink/af_netlink=
.c:2515
    [<00000000ff7db83b>] genl_rcv+0x29/0x40 net/netlink/genetlink.c:811
    [<000000000cf53b8c>] netlink_unicast_kernel net/netlink/af_netlink.c:13=
13 [inline]
    [<000000000cf53b8c>] netlink_unicast+0x54b/0x800 net/netlink/af_netlink=
.c:1339
    [<00000000d78cd38b>] netlink_sendmsg+0x90a/0xdf0 net/netlink/af_netlink=
.c:1934
    [<000000008328a57f>] sock_sendmsg_nosec net/socket.c:651 [inline]
    [<000000008328a57f>] sock_sendmsg+0x157/0x190 net/socket.c:671
    [<000000007b65a1b5>] ____sys_sendmsg+0x712/0x870 net/socket.c:2342
    [<0000000083da800e>] ___sys_sendmsg+0xf8/0x170 net/socket.c:2396
    [<000000004a9b827f>] __sys_sendmsg+0xea/0x1b0 net/socket.c:2429
    [<0000000061b64d3a>] do_syscall_64+0x30/0x40 arch/x86/entry/common.c:46
    [<00000000a1265347>] entry_SYSCALL_64_after_hwframe+0x61/0xc6

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller

Fixes: cb72d38211ea ("netlabel: Initial support for the CALIPSO netlink pro=
tocol.")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 net/netlabel/netlabel_calipso.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/netlabel/netlabel_calipso.c b/net/netlabel/netlabel_calips=
o.c
index f1d5b8465217..76ae57c4df90 100644
--- a/net/netlabel/netlabel_calipso.c
+++ b/net/netlabel/netlabel_calipso.c
@@ -423,6 +423,8 @@ void calipso_doi_free(struct calipso_doi *doi_def)
=20
 	if (ops)
 		ops->doi_free(doi_def);
+	else
+		kfree(doi_def);
 }
=20
 /**
--=20
2.39.2

