Return-Path: <linux-security-module+bounces-14132-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MpDL2YQcmksawAAu9opvQ
	(envelope-from <linux-security-module+bounces-14132-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Jan 2026 12:56:22 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C0766474
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Jan 2026 12:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1267D725927
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Jan 2026 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AAA3E8C7D;
	Thu, 22 Jan 2026 11:29:08 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA21F3ACF17
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 11:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081348; cv=none; b=niy1WtG70GTJyNF4SZmVbWP2nd/xobkGLtEkA0JMQcfuHZHK12JVbgZhp0KBus/+hcv3VHj3DnLoXJhqoTBA2UzLY/iWfAfz4ijwJPpCd9uUHNEejDxrvsDLhyhU7t2Ia3Jq+phQjHz8M8h2Aqu7g9SKYuXDiPzg91P9JkSBH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081348; c=relaxed/simple;
	bh=BDs9BOIZZleMsDRbiSZ9uuVmbFcMJG1+Cc5JGKeQAoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNXcwaDhFiRnzKc1b0T+Bjy+wLKJ7nWG1LZMl0Xr8ILZz6ubN+R+fScMp6R/TzI0XbQfjhkQeZhujH558l52/hiN8pkxJd4v4XVueBvUhgcgyglZpBbU+La4Li11XjKFqcmaFl8PGNJTobHbT5ELlnvPzqcSZXGjwVS4+PA0ekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60MBSVGC055241;
	Thu, 22 Jan 2026 20:28:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60MBSV9P055237
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 22 Jan 2026 20:28:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <447378de-3cc9-44f5-872e-a1fc477f591e@I-love.SAKURA.ne.jp>
Date: Thu, 22 Jan 2026 20:28:31 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xfrm: force flush upon NETDEV_UNREGISTER event
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Boris Pismenny <borisp@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
        Raed Salem <raeds@mellanox.com>, Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Yossi Kuperman <yossiku@mellanox.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Aviad Yehezkel <aviadye@nvidia.com>
References: <924f9cf5-599a-48f0-b1e3-94cd971965b0@I-love.SAKURA.ne.jp>
 <537343f7-c580-43b0-9ad2-691701b9fb8e@I-love.SAKURA.ne.jp>
 <287edf7f-85fb-46c3-9c70-c8ec7014a0db@I-love.SAKURA.ne.jp>
 <aXIGxmCB2QU86-iA@secunet.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <aXIGxmCB2QU86-iA@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mellanox.com,davemloft.net,strlen.de,gmail.com,kernel.org,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-14132-lists,linux-security-module=lfdr.de];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[i-love.sakura.ne.jp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,linux-security-module@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,i-love.sakura.ne.jp:email,I-love.SAKURA.ne.jp:mid,appspotmail.com:email]
X-Rspamd-Queue-Id: 44C0766474
X-Rspamd-Action: no action

On 2026/01/22 20:15, Steffen Klassert wrote:
> Hm, I'd say we should not try to offload to a device that does
> not support NETIF_F_HW_ESP.

I was about to post the patch below, but you are suggesting that "do not allow calling
xfrm_dev_state_add()/xfrm_dev_policy_add() if (dev->features & NETIF_F_HW_ESP) == 0" ?

[PATCH] xfrm: always flush state and policy upon NETDEV_DOWN/NETDEV_UNREGISTER events

syzbot is reporting that "struct xfrm_state" refcount is leaking.

  unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
  ref_tracker: netdev@ffff888052f24618 has 1/1 users at
       __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
       netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
       xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316
       xfrm_state_construct net/xfrm/xfrm_user.c:986 [inline]
       xfrm_add_sa+0x34ff/0x5fa0 net/xfrm/xfrm_user.c:1022
       xfrm_user_rcv_msg+0x58e/0xc00 net/xfrm/xfrm_user.c:3507
       netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2550
       xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3529
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0xa5d/0xc30 net/socket.c:2592
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2646
       __sys_sendmsg+0x16d/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

Since xfrm_dev_state_add() takes a reference to "struct net_device",
the corresponding NETDEV_UNREGISTER handler must release that reference.

Commit d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
introduced xfrm_dev_state_add() which grabs a reference to
"struct net_device". That commit called xfrm_dev_state_add() from
xfrm_state_construct() and introduced the NETDEV_UNREGISTER case to
xfrm_dev_event(). But that commit implemented xfrm_dev_unregister() as
a no-op, and implemented xfrm_dev_down() to call xfrm_dev_state_flush()
only if (dev->features & NETIF_F_HW_ESP) != 0. Maybe that commit expected
that NETDEV_DOWN event is fired before NETDEV_UNREGISTER event fires, and
also assumed that xfrm_dev_state_add() is called only if
(dev->features & NETIF_F_HW_ESP) != 0.

Commit ec30d78c14a8 ("xfrm: add xdst pcpu cache") added
xfrm_policy_cache_flush() call to xfrm_dev_unregister(), but
commit e4db5b61c572 ("xfrm: policy: remove pcpu policy cache") removed
xfrm_policy_cache_flush() call from xfrm_dev_unregister() and also
removed the NETDEV_UNREGISTER case from xfrm_dev_event() because
xfrm_dev_unregister() again became no-op.

Commit 03891f820c21 ("xfrm: handle NETDEV_UNREGISTER for xfrm device")
re-introduced the NETDEV_UNREGISTER case to xfrm_dev_event(), but that
commit for unknown reason chose to share xfrm_dev_down() between
the NETDEV_DOWN case and the NETDEV_UNREGISTER case. But since syzbot is
demonstrating that it is possible to call xfrm_dev_state_add() even if
(dev->features & NETIF_F_HW_ESP) == 0, we need to make sure that
netdev_put() from xfrm_dev_state_free() from xfrm_dev_state_flush() is
called upon NETDEV_UNREGISTER event.

Assuming that it is correct behavior to call netdev_put() upon NETDEV_DOWN
event even if (dev->features & NETIF_F_HW_ESP) == 0, this patch updates
xfrm_dev_down() rather than re-introducing xfrm_dev_unregister().

Reported-by: syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Since no reproducer is available for this problem, I can't ask syzbot to
test this change. But I confirmed using linux-next tree that calling
xfrm_dev_state_flush() upon NETDEV_UNREGISTER event even if
(dev->features & NETIF_F_HW_ESP) == 0 solved this problem.

 net/xfrm/xfrm_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 52ae0e034d29..26e62b6a9db5 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -536,10 +536,8 @@ static int xfrm_api_check(struct net_device *dev)
 
 static int xfrm_dev_down(struct net_device *dev)
 {
-	if (dev->features & NETIF_F_HW_ESP) {
-		xfrm_dev_state_flush(dev_net(dev), dev, true);
-		xfrm_dev_policy_flush(dev_net(dev), dev, true);
-	}
+	xfrm_dev_state_flush(dev_net(dev), dev, true);
+	xfrm_dev_policy_flush(dev_net(dev), dev, true);
 
 	return NOTIFY_DONE;
 }
-- 
2.47.3


