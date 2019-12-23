Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9E1294F0
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Dec 2019 12:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfLWLWB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Dec 2019 06:22:01 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2215 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbfLWLWB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Dec 2019 06:22:01 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E91352AAB68C71100DAC;
        Mon, 23 Dec 2019 11:21:58 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 23 Dec 2019 11:21:58 +0000
Received: from [127.0.0.1] (10.202.227.179) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 23 Dec
 2019 11:21:58 +0000
To:     "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>
CC:     Anders Roxell <anders.roxell@linaro.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Subject: Report: suspicious RCU usage in security code
Message-ID: <ebded533-8c29-6ceb-6384-f02a77291434@huawei.com>
Date:   Mon, 23 Dec 2019 11:21:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi guys,

I have noticed this WARN on Kernel v5.5-rc3 on my arm64 system:

[   25.952600] =============================
[   25.952602] WARNING: suspicious RCU usage
[   25.952606] 5.5.0-rc3-dirty #816 Not tainted
[   25.952609] -----------------------------
[   25.952613] security/device_cgroup.c:355 RCU-list traversed in 
non-reader section!!
[   25.952615]
                other info that might help us debug this:

[   25.952618]
                rcu_scheduler_active = 2, debug_locks = 1
[   25.952621] 4 locks held by systemd/1:
[   25.952624]  #0: ffff0023de3c4410 (sb_writers#8){.+.+}, at: 
vfs_write+0x1c0/0x1e0
[   25.952637]  #1: ffff0023e732f880 (&of->mutex){+.+.}, at: 
kernfs_fop_write+0x12c/0x250
[   25.952648]  #2: ffff0023e45c4288 (kn->count#30){++++}, at: 
kernfs_fop_write+0x134/0x250
[   25.952656]  #3: ffff800011c4e098 (devcgroup_mutex){+.+.}, at: 
devcgroup_access_write+0x4c/0x6d0
[   25.952663]
                stack backtrace:
[   25.952668] CPU: 6 PID: 1 Comm: systemd Not tainted 5.5.0-rc3-dirty #816
[   25.952670] Hardware name: Huawei D06 /D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.16.01 03/15/2019
[   25.952672] Call trace:
[   25.952675]  dump_backtrace+0x0/0x1a0
[   25.952678]  show_stack+0x14/0x20
[   25.952681]  dump_stack+0xe8/0x150
[   25.952685]  lockdep_rcu_suspicious+0xcc/0x110
[   25.952689]  match_exception_partial+0x118/0x120
[   25.952691]  verify_new_ex+0x64/0xf0
[   25.952694]  devcgroup_access_write+0x3c8/0x6d0
[   25.952697]  cgroup_file_write+0x88/0x1e0
[   25.952700]  kernfs_fop_write+0x15c/0x250
[   25.952703]  __vfs_write+0x18/0x38
[   25.952705]  vfs_write+0xb4/0x1e0
[   25.952708]  ksys_write+0x68/0xf8
[   25.952711]  __arm64_sys_write+0x18/0x20
[   25.952715]  el0_svc_common.constprop.2+0x74/0x170
[   25.952717]  el0_svc_handler+0x20/0x80
[   25.952720]  el0_sync_handler+0x114/0x1d0
[   25.952722]  el0_sync+0x140/0x180
john@ubuntu:~$
john@ubuntu:~$


RCU Kconfig options:

more .config | grep RCU
# RCU Subsystem
CONFIG_PREEMPT_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_FANOUT=64
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FAST_NO_HZ is not set
# CONFIG_RCU_BOOST is not set
# CONFIG_RCU_NOCB_CPU is not set
# end of RCU Subsystem
CONFIG_HAVE_RCU_TABLE_FREE=y
# RCU Debugging
CONFIG_PROVE_RCU=y
CONFIG_PROVE_RCU_LIST=y
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging
john@john-ThinkCentre-M93p:~/kernel-dev$

I notice that verfiy_new_ex() has a RCU lockdep check warning, so the 
condition may just need to be extended to the match_exception_partial() 
RCU list iterator just to remove the WARN.

Note: I am finishing for Christmas vacation today, so can't help further 
ATM.

Cheers,
John
