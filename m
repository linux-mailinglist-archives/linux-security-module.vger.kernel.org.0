Return-Path: <linux-security-module+bounces-4397-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 033959374D6
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Jul 2024 10:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58AB1F21DBF
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Jul 2024 08:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B227E782;
	Fri, 19 Jul 2024 08:13:30 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E0664C6;
	Fri, 19 Jul 2024 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376810; cv=none; b=aLKpQRqHVJZzsxSVpfwhRH29+Po1PlNeflaD8q9M3Q8GBP/DVTJAGSpz1ZFpvkqxrLrID0OFCvbS9+3I9GymIR/CGTV7yG5DmytHqnXQF0RYAuICTcs3CVqYOq6nhaTOAGvaXSdPTOKyvDzn4lHpKKzDPXO8zTJxPYmT/fbf/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376810; c=relaxed/simple;
	bh=USl+GS8SjbfAG9TdaFkQ19+FupY8gk0c9UWuJ1wPhLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQKpefDnxpuRQ+co6sgLyXmIP0KMIQRk6Cz7TVFdtdoS5/39wdH8GcOs94iyhrlPDiDxjU9M2VRsgGAyGA/LFzc+Z8ssIcrQoo/hM0zcJFboouJcuv6fsTuJoxMJjJqwxjcLXKWtTj7LyTaUvw/PkgGYBRdqc9/G55+AbiEE6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WQMqr1Czpz4f3l1m;
	Fri, 19 Jul 2024 16:13:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 76E3B1A1337;
	Fri, 19 Jul 2024 16:13:25 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP3 (Coremail) with SMTP id _Ch0CgCXo04hIJpm5CslAg--.56491S8;
	Fri, 19 Jul 2024 16:13:25 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Kees Cook <kees@kernel.org>,
	Brendan Jackman <jackmanb@google.com>,
	Florent Revest <revest@google.com>
Subject: [PATCH bpf-next v1 6/9] selftests/bpf: Avoid load failure for token_lsm.c
Date: Fri, 19 Jul 2024 16:17:46 +0800
Message-Id: <20240719081749.769748-7-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240719081749.769748-1-xukuohai@huaweicloud.com>
References: <20240719081749.769748-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCXo04hIJpm5CslAg--.56491S8
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1rJr4DJry7XFy7Jr1UJrb_yoW5CF48pF
	95W3429rWkJFy2kr1xXF13KryYqFs2va17JF1UCry0q3y7Kw4UXry7GFWakF95Grsayrsa
	vF95XFZ0qr12kaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUI-eODUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The compiler optimized the two bpf progs in token_lsm.c to make return
value from the bool variable in the "return -1" path, causing an
unexpected rejection:

0: R1=ctx() R10=fp0
; int BPF_PROG(bpf_token_capable, struct bpf_token *token, int cap) @ bpf_lsm.c:17
0: (b7) r6 = 0                        ; R6_w=0
; if (my_pid == 0 || my_pid != (bpf_get_current_pid_tgid() >> 32)) @ bpf_lsm.c:19
1: (18) r1 = 0xffffc9000102a000       ; R1_w=map_value(map=bpf_lsm.bss,ks=4,vs=5)
3: (61) r7 = *(u32 *)(r1 +0)          ; R1_w=map_value(map=bpf_lsm.bss,ks=4,vs=5) R7_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
4: (15) if r7 == 0x0 goto pc+11       ; R7_w=scalar(smin=umin=umin32=1,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
5: (67) r7 <<= 32                     ; R7_w=scalar(smax=0x7fffffff00000000,umax=0xffffffff00000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xffffffff00000000))
6: (c7) r7 s>>= 32                    ; R7_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
7: (85) call bpf_get_current_pid_tgid#14      ; R0=scalar()
8: (77) r0 >>= 32                     ; R0_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff))
9: (5d) if r0 != r7 goto pc+6         ; R0_w=scalar(smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff)) R7=scalar(smin=smin32=0,smax=umax=umax32=0x7fffffff,var_off=(0x0; 0x7fffffff))
; if (reject_capable) @ bpf_lsm.c:21
10: (18) r1 = 0xffffc9000102a004      ; R1_w=map_value(map=bpf_lsm.bss,ks=4,vs=5,off=4)
12: (71) r6 = *(u8 *)(r1 +0)          ; R1_w=map_value(map=bpf_lsm.bss,ks=4,vs=5,off=4) R6_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=255,var_off=(0x0; 0xff))
;  @ bpf_lsm.c:0
13: (87) r6 = -r6                     ; R6_w=scalar()
14: (67) r6 <<= 56                    ; R6_w=scalar(smax=0x7f00000000000000,umax=0xff00000000000000,smin32=0,smax32=umax32=0,var_off=(0x0; 0xff00000000000000))
15: (c7) r6 s>>= 56                   ; R6_w=scalar(smin=smin32=-128,smax=smax32=127)
; int BPF_PROG(bpf_token_capable, struct bpf_token *token, int cap) @ bpf_lsm.c:17
16: (bf) r0 = r6                      ; R0_w=scalar(id=1,smin=smin32=-128,smax=smax32=127) R6_w=scalar(id=1,smin=smin32=-128,smax=smax32=127)
17: (95) exit
At program exit the register R0 has smin=-128 smax=127 should have been in [-4095, 0]

To avoid this failure, change the variable type from bool to int.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/progs/token_lsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/token_lsm.c b/tools/testing/selftests/bpf/progs/token_lsm.c
index e4d59b6ba743..a6002d073b1b 100644
--- a/tools/testing/selftests/bpf/progs/token_lsm.c
+++ b/tools/testing/selftests/bpf/progs/token_lsm.c
@@ -8,8 +8,8 @@
 char _license[] SEC("license") = "GPL";
 
 int my_pid;
-bool reject_capable;
-bool reject_cmd;
+int reject_capable;
+int reject_cmd;
 
 SEC("lsm/bpf_token_capable")
 int BPF_PROG(token_capable, struct bpf_token *token, int cap)
-- 
2.30.2


