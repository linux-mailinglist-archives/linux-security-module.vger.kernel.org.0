Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4763D866
	for <lists+linux-security-module@lfdr.de>; Wed, 30 Nov 2022 15:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiK3OmB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 30 Nov 2022 09:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiK3Ol5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Nov 2022 09:41:57 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E42FC3B;
        Wed, 30 Nov 2022 06:41:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NMhZK5W8Gz9xGWM;
        Wed, 30 Nov 2022 22:35:21 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAXS_eTa4djRKmqAA--.46591S2;
        Wed, 30 Nov 2022 15:41:34 +0100 (CET)
Message-ID: <859f70a2801cffa3cb42ae0d43f5753bb01a7eac.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: Make a copy of sig and digest in
 asymmetric_verify()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        rusty@rustcorp.com.au, axboe@kernel.dk
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Date:   Wed, 30 Nov 2022 15:41:20 +0100
In-Reply-To: <f8f95d37211bac6ce4322a715740d2b2ae20db84.camel@huaweicloud.com>
References: <20221104122023.1750333-1-roberto.sassu@huaweicloud.com>
         <9ef25f1b8621dab8b3cd4373bf6ce1633daae70e.camel@linux.ibm.com>
         <a676b387d23f9ca630418ece20a6761a9437ce76.camel@huaweicloud.com>
         <c6c448c2acc07caf840046067322f3e1110cedff.camel@linux.ibm.com>
         <f8f95d37211bac6ce4322a715740d2b2ae20db84.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAXS_eTa4djRKmqAA--.46591S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr17ZF4UZw1xWw4UGF43trb_yoWrJFy3pF
        48K3WDKr4Dtr1xKF4Iyws8C34rKr4rKFW7W34kCw1rZr1qqr1xZr4kJF47WFyDWryxAF4U
        tFWftr9rZrn8A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4YbEwAAs2
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2022-11-23 at 14:49 +0100, Roberto Sassu wrote:
> On Wed, 2022-11-23 at 08:40 -0500, Mimi Zohar wrote:
> > On Wed, 2022-11-23 at 13:56 +0100, Roberto Sassu wrote:
> > > On Tue, 2022-11-22 at 14:39 -0500, Mimi Zohar wrote:
> > > > Hi Roberto,
> > > > 
> > > > On Fri, 2022-11-04 at 13:20 +0100, Roberto Sassu wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > 
> > > > > Commit ac4e97abce9b8 ("scatterlist: sg_set_buf() argument must be in linear
> > > > > mapping") requires that both the signature and the digest resides in the
> > > > > linear mapping area.
> > > > > 
> > > > > However, more recently commit ba14a194a434c ("fork: Add generic vmalloced
> > > > > stack support"), made it possible to move the stack in the vmalloc area,
> > > > > which could make the requirement of the first commit not satisfied anymore.
> > > > > 
> > > > > If CONFIG_SG=y and CONFIG_VMAP_STACK=y, the following BUG() is triggered:
> > > > 
> > > > ^CONFIG_DEBUG_SG
> > > > 
> > > > > [  467.077359] kernel BUG at include/linux/scatterlist.h:163!
> > > > > [  467.077939] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > > > > 
> > > > > [...]
> > > > > 
> > > > > [  467.095225] Call Trace:
> > > > > [  467.096088]  <TASK>
> > > > > [  467.096928]  ? rcu_read_lock_held_common+0xe/0x50
> > > > > [  467.097569]  ? rcu_read_lock_sched_held+0x13/0x70
> > > > > [  467.098123]  ? trace_hardirqs_on+0x2c/0xd0
> > > > > [  467.098647]  ? public_key_verify_signature+0x470/0x470
> > > > > [  467.099237]  asymmetric_verify+0x14c/0x300
> > > > > [  467.099869]  evm_verify_hmac+0x245/0x360
> > > > > [  467.100391]  evm_inode_setattr+0x43/0x190
> > > > > 
> > > > > The failure happens only for the digest, as the pointer comes from the
> > > > > stack, and not for the signature, which instead was allocated by
> > > > > vfs_getxattr_alloc().
> > > > 
> > > > Only after enabling CONFIG_DEBUG_SG does EVM fail.
> > > > 
> > > > > Fix this by making a copy of both in asymmetric_verify(), so that the
> > > > > linear mapping requirement is always satisfied, regardless of the caller.
> > > > 
> > > > As only EVM is affected, it would make more sense to limit the change
> > > > to EVM.
> > > 
> > > I found another occurrence:
> > > 
> > > static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
> > > 			struct evm_ima_xattr_data *xattr_value, int xattr_len,
> > > 			enum integrity_status *status, const char **cause)
> > > {
> > > 
> > > [...]
> > > 
> > > 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
> > > 					     (const char *)xattr_value,
> > > 					     xattr_len, hash.digest,
> > > 					     hash.hdr.length);
> > > 
> > > Should I do two patches?
> > 
> > I'm just not getting it.  Why did you enable CONFIG_DEBUG_SIG?  Were
> > you testing random kernel configs?  Are you actually seeing signature
> > verifications errors without it enabled?  Or is it causing other
> > problems?  Is the "BUG_ON" still needed?
> 
> When I test patches, I tend to enable more debugging options.
> 
> To be honest, I didn't check if there is any issue without enabling
> CONFIG_DEBUG_SG. I thought that if there is a linear mapping
> requirement, that should be satisfied regardless of whether the
> debugging option is enabled or not.
> 
> + Rusty, Jens for explanations.

Trying to answer the question, with the help of an old discussion:

https://groups.google.com/g/linux.kernel/c/dpIoiY_qSGc

sg_set_buf() calls virt_to_page() to get the page to start from. But if
the buffer spans in two pages, that would not work in the vmalloc area,
since there is no guarantee that the next page is adjiacent.

For small areas, much smaller than the page size, it is unlikely that
the situation above would happen. So, integrity_digsig_verify() will
likely succeeed. Although it is possible that it fails if there are
data in the next page.

Roberto

