Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD47D5E8D6B
	for <lists+linux-security-module@lfdr.de>; Sat, 24 Sep 2022 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiIXOoO (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 24 Sep 2022 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIXOoN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 24 Sep 2022 10:44:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E3B31DFE;
        Sat, 24 Sep 2022 07:44:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 854FE21880;
        Sat, 24 Sep 2022 14:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664030646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldCH7q8JyvLEKaktegyDOVQARi1eF2vv5KGzrW1iCKE=;
        b=ZYYExhvhe3hvVYy4oVk/eFH8gYNpGCko5Ihe7Zb9d4XHzj0gN+cbmJ5znD+HxwJBv4rbaf
        xOAiTy+7OSutCerOOUzrNf7vSiurU7B6noAUxrtuNDY8e/xv8++TCq4sPot33lF0rn5bY3
        j5D7iIgKtKQkzwHDFuKS1s7nX1iR+bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664030646;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldCH7q8JyvLEKaktegyDOVQARi1eF2vv5KGzrW1iCKE=;
        b=LwyQx+Mw9MIzMldTchSCV/M9BlwXBCMS+77FXL0rg1zfTVtmjUy+KUTCczSeB7Oi5a4eGF
        DV0wxb7/VTheveCg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2218E2C172;
        Sat, 24 Sep 2022 14:44:05 +0000 (UTC)
Date:   Sat, 24 Sep 2022 16:44:03 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        keyrings@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        Coiby Xu <coxu@redhat.com>, Baoquan He <bhe@redhat.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        Philipp Rudo <prudo@redhat.com>,
        " open list:KEXEC" <kexec@lists.infradead.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 5.15 0/6] arm64: kexec_file: use more system keyrings to
 verify kernel image signature + dependencies
Message-ID: <20220924144403.GA28810@kitsune.suse.cz>
References: <cover.1663951201.git.msuchanek@suse.de>
 <67337b60a4d3cae00794d3cfd0e5add9899f18b7.camel@linux.ibm.com>
 <20220923191650.GX28810@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220923191650.GX28810@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 23, 2022 at 09:16:50PM +0200, Michal Such�nek wrote:
> Hello,
> 
> On Fri, Sep 23, 2022 at 03:03:36PM -0400, Mimi Zohar wrote:
> > On Fri, 2022-09-23 at 19:10 +0200, Michal Suchanek wrote:
> > > Hello,
> > > 
> > > this is backport of commit 0d519cadf751
> > > ("arm64: kexec_file: use more system keyrings to verify kernel image signature")
> > > to table 5.15 tree including the preparatory patches.
> > > 
> > > Some patches needed minor adjustment for context.
> > 
> > In general when backporting this patch set, there should be a
> > dependency on backporting these commits as well.  In this instance for
> > linux-5.15.y, they've already been backported.
> > 
> > 543ce63b664e ("lockdown: Fix kexec lockdown bypass with ima policy")

AFAICT this is everywhere relevant, likely because it's considered a CVE
fix.

> > af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")

This is missing in 5.4, and 5.4 is missing this prerequisite:
fd7af71be542 ("kexec: do not verify the signature without the lockdown or mandatory signature")

> 
> Thanks for bringing these up. It might be in general useful to backport
> these fixes as well.
> 
> However, this patchset does one very specific thing: it lifts the x86
> kexec_file signature verification to arch-independent and uses it on
> arm64 to unify all features (and any existing warts) between EFI
> architectures.
> 
> So unless I am missing something the fixes you pointed out are
> completely independent of this.
> 
> Thanks
> 
> Michal
