Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03626F7D48
	for <lists+linux-security-module@lfdr.de>; Fri,  5 May 2023 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjEEGyS (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 5 May 2023 02:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjEEGyR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 5 May 2023 02:54:17 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112A8AD14;
        Thu,  4 May 2023 23:54:15 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QCLkw0xwyz9xrpD;
        Fri,  5 May 2023 14:44:24 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXnlUCqFRka2V9Ag--.25579S2;
        Fri, 05 May 2023 07:54:00 +0100 (CET)
Message-ID: <6b5f941a4dd57f357f942df4051ccc9995b4ba15.camel@huaweicloud.com>
Subject: Re: NFS mount fail
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Date:   Fri, 05 May 2023 08:53:50 +0200
In-Reply-To: <d34c30ba-55cc-8662-3587-bb66e234b714@schaufler-ca.com>
References: <1923bc2f330f576cd246856f976af448c035d02e.camel@huaweicloud.com>
         <d34c30ba-55cc-8662-3587-bb66e234b714@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDXnlUCqFRka2V9Ag--.25579S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWfXFyDtr1kKw4kJFyxZrb_yoW5tr43pF
        yUXa1rCF48ta40v3yfWw4UJF4F9rWDuF18Cas8X3yjyaySgF12v34UKrW5uayDCr1UCF4I
        vFWaya429F1UCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4zg3wABsO
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2023-05-04 at 17:59 -0700, Casey Schaufler wrote:
> On 5/4/2023 9:11 AM, Roberto Sassu wrote:
> > Hi Casey
> > 
> > while developing the fix for overlayfs, I tried first to address the
> > issue of a NFS filesystem failing to mount.
> > 
> > The NFS server does not like the packets sent by the client:
> > 
> > 14:52:20.827208 IP (tos 0x0, ttl 64, id 60628, offset 0, flags [DF], proto TCP (6), length 72, options (unknown 134,EOL))
> >     localhost.localdomain.omginitialrefs > _gateway.nfs: Flags [S], cksum 0x7618 (incorrect -> 0xa18c), seq 455337903, win 64240, options [mss 1460,sackOK,TS val 2178524519 ecr 0,nop,wscale 7], length 0
> > 14:52:20.827376 IP (tos 0xc0, ttl 64, id 5906, offset 0, flags [none], proto ICMP (1), length 112, options (unknown 134,EOL))
> >     _gateway > localhost.localdomain: ICMP parameter problem - octet 22, length 80
> > 
> > I looked at the possible causes. SELinux works properly.
> 
> SELinux was the reference LSM implementation for labeled networking.
> 
> > What it seems to happen is that there is a default netlabel mapping,
> > that is used to send the packets out.
> 
> Correct. SELinux only uses CIPSO options for MLS. Smack uses CIPSO for
> almost all packets.
> 
> > We are in this part of the code:
> > 
> > Thread 1 hit Breakpoint 2, netlbl_sock_setattr (sk=sk@entry=0xffff888025178000, family=family@entry=2, secattr=0xffff88802504b200) at net/netlabel/netlabel_kapi.c:980
> > 980	{
> > (gdb) n
> > 771		__rcu_read_lock();
> > (gdb) 
> > 985		dom_entry = netlbl_domhsh_getentry(secattr->domain, family);
> > (gdb) 
> > 986		if (dom_entry == NULL) {
> > (gdb) 
> > 990		switch (family) {
> > (gdb) 
> > 992			switch (dom_entry->def.type) {
> > 
> > Here is the difference between Smack and SELinux.
> > 
> > Smack:
> > 
> > (gdb) p *dom_entry
> > $2 = {domain = 0x0 <fixed_percpu_data>, family = 2, def = {type = 3, {addrsel = 0xffff888006bbef40, cipso = 0xffff888006bbef40, calipso = 0xffff888006bbef40}}, valid = 1, list = {next = 0xffff88800767f6e8, prev = 0xffff88800767f6e8}, rcu = {next = 0x0 <fixed_percpu_data>, 
> >     func = 0x0 <fixed_percpu_data>}}
> > 
> > SELinux:
> > 
> > (gdb) p *dom_entry
> > $5 = {domain = 0x0 <fixed_percpu_data>, family = 2, def = {type = 5, {addrsel = 0x0 <fixed_percpu_data>, cipso = 0x0 <fixed_percpu_data>, calipso = 0x0 <fixed_percpu_data>}}, valid = 1, list = {next = 0xffff888006012c88, prev = 0xffff888006012c88}, rcu = {
> >     next = 0x0 <fixed_percpu_data>, func = 0x0 <fixed_percpu_data>}}
> > 
> > 
> > type = 3 (for Smack) is NETLBL_NLTYPE_CIPSOV4.
> > type = 5 (for SELinux) is NETLBL_NLTYPE_UNLABELED.
> > 
> > This is why SELinux works (no incompatible options are sent).
> 
> SELinux "works" because that's the use case that was verified.
> 
> > The netlabel mapping is added here:
> > 
> > static void smk_cipso_doi(void)
> > {
> > 
> > [...]
> > 
> > 	rc = netlbl_cfg_cipsov4_map_add(doip->doi, NULL, NULL, NULL, &nai);
> > 
> > 
> > Not sure exactly how we can solve this issue. Just checked that
> > commenting the call to smk_cipso_doi() in init_smk_fs() allows the NFS
> > filesystem to be mounted.
> 
> Are both the server and client using Smack? Are they on a network that can
> propagate labeled packets? What are you using for a Smack rule configuration?

Only the client (Fedora 38). The server is Ubuntu 20.04.06 LTS and uses
Apparmor. The client is a VM created with libvirt. The connection is
the classic tap attached to a bridge.

Thanks

Roberto

