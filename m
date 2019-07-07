Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A26124C
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Jul 2019 19:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfGFROr (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 6 Jul 2019 13:14:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42406 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbfGFROr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Jul 2019 13:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SxTT+EWBfYSwQj+6DsnQ7bR1Cw0W2AhS76xH8+vQQCU=; b=YcI9f/asf/DFbMw8T+yspybRM8
        lhteGuiOCnRNdrnbFgrtWoNM1gI66Mog3qM9y8hn9atK6b9/8WszRUipYCOdMzMtzRc4PuixYVCTz
        C00vj+2SIZ3O2NAvwlVW5ZvymAVxQDAqZcBURUob2vqwKPtaPBlgewGpnKGNe1+98dmCLfMEZ7giP
        l0XJn/zwfute5OFLgywTYAibtTppUhL4FmNoPHZFJ1FeXOWkLMBJXLyySt8nYdIbN55m6g7xrQG4C
        T6hIbeSLkSZX5ORKAYDgSGCJITFtMXhD2Vs1tCeJ5fFkxAgWTez6ZA2ogzAK13+MgHDVaQAkWfrzw
        6Vqv62Yw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjoGZ-0001vH-6M; Sat, 06 Jul 2019 17:14:27 +0000
Subject: Re: [PATCH v5 01/12] S.A.R.A.: add documentation
To:     Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-2-git-send-email-s.mesoraca16@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4d943e67-2e81-93fa-d3f9-e3877403b94d@infradead.org>
Date:   Sat, 6 Jul 2019 10:14:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562410493-8661-2-git-send-email-s.mesoraca16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

Just a few typo fixes (inline).

On 7/6/19 3:54 AM, Salvatore Mesoraca wrote:
> Adding documentation for S.A.R.A. LSM.
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>  Documentation/admin-guide/LSM/SARA.rst          | 177 ++++++++++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst         |   1 +
>  Documentation/admin-guide/kernel-parameters.txt |  24 ++++
>  3 files changed, 202 insertions(+)
>  create mode 100644 Documentation/admin-guide/LSM/SARA.rst
> 
> diff --git a/Documentation/admin-guide/LSM/SARA.rst b/Documentation/admin-guide/LSM/SARA.rst
> new file mode 100644
> index 0000000..fdde04c
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/SARA.rst
> @@ -0,0 +1,177 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========
> +S.A.R.A.
> +========
> +
> +S.A.R.A. (S.A.R.A. is Another Recursive Acronym) is a stacked Linux Security
> +Module that aims to collect heterogeneous security measures, providing a common
> +interface to manage them.
> +As of today it consists of one submodule:
> +
> +- WX Protection
> +
> +
> +The kernel-space part is complemented by its user-space counterpart: `saractl`
> +[2]_.
> +A test suite for WX Protection, called `sara-test` [4]_, is also available.
> +More information about where to find these tools and the full S.A.R.A.
> +documentation are in the `External Links and Documentation`_ section.
> +
> +-------------------------------------------------------------------------------
> +
> +S.A.R.A.'s Submodules
> +=====================
> +
> +WX Protection
> +-------------
> +WX Protection aims to improve user-space programs security by applying:
> +
> +- `W^X enforcement`_
> +- `W!->X (once writable never executable) mprotect restriction`_
> +- `Executable MMAP prevention`_
> +
> +All of the above features can be enabled or disabled both system wide
> +or on a per executable basis through the use of configuration files managed by
> +`saractl` [2]_.
> +
> +It is important to note that some programs may have issues working with
> +WX Protection. In particular:
> +
> +- **W^X enforcement** will cause problems to any programs that needs
> +  memory pages mapped both as writable and executable at the same time e.g.
> +  programs with executable stack markings in the *PT_GNU_STACK* segment.
> +- **W!->X mprotect restriction** will cause problems to any program that
> +  needs to generate executable code at run time or to modify executable
> +  pages e.g. programs with a *JIT* compiler built-in or linked against a
> +  *non-PIC* library.
> +- **Executable MMAP prevention** can work only with programs that have at least
> +  partial *RELRO* support. It's disabled automatically for programs that
> +  lack this feature. It will cause problems to any program that uses *dlopen*
> +  or tries to do an executable mmap. Unfortunately this feature is the one
> +  that could create most problems and should be enabled only after careful
> +  evaluation.
> +
> +To extend the scope of the above features, despite the issues that they may
> +cause, they are complemented by **/proc/PID/attr/sara/wxprot** interface
> +and **trampoline emulation**.
> +
> +At the moment, WX Protection (unless specified otherwise) should work on
> +any architecture supporting the NX bit, including, but not limited to:
> +`x86_64`, `x86_32` (with PAE), `ARM` and `ARM64`.
> +
> +Parts of WX Protection are inspired by some of the features available in PaX.
> +
> +For further information about configuration file format and user-space
> +utilities please take a look at the full documentation [1]_.
> +
> +W^X enforcement
> +^^^^^^^^^^^^^^^
> +W^X means that a program can't have a page of memory that is marked, at the
> +same time, writable and executable. This also allow to detect many bad

                                                 allows

> +behaviours that make life much more easy for attackers. Programs running with
> +this feature enabled will be more difficult to exploit in the case they are
> +affected by some vulnerabilities, because the attacker will be forced
> +to make more steps in order to exploit them.
> +This feature also blocks accesses to /proc/*/mem files that would allow to
> +write the current process read-only memory, bypassing any protection.
> +
> +W!->X (once writable never executable) mprotect restriction
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +"Once writable never executable" means that any page that could have been
> +marked as writable in the past won't ever be allowed to be marked (e.g. via
> +an mprotect syscall) as executable.
> +This goes on the same track as W^X, but is much stricter and prevents
> +the runtime creation of new executable code in memory.
> +Obviously, this feature does not prevent a program from creating a new file and
> +*mmapping* it as executable, however, it will be way more difficult for
> +attackers to exploit vulnerabilities if this feature is enabled.
> +
> +Executable MMAP prevention
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +This feature prevents the creation of new executable mmaps after the dynamic
> +libraries have been loaded. When used in combination with **W!->X mprotect
> +restriction** this feature will completely prevent the creation of new
> +executable code from the current thread.
> +Obviously, this feature does not prevent cases in which an attacker uses an
> +*execve* to start a completely new program. This kind of restriction, if
> +needed, can be applied using one of the other LSM that focuses on MAC.

                                                 LSMs

> +Please be aware that this feature can break many programs and so it should be
> +enabled after careful evaluation.
> +
> +/proc/PID/attr/sara/wxprot interface
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +The `procattr` interface can be used by a thread to discover which
> +WX Protection features are enabled and/or to tighten them: protection
> +can't be softened via procattr.
> +The interface is simple: it's a text file with an hexadecimal

                                             with a

> +number in it representing enabled features (more information can be
> +found in the `Flags values`_ section). Via this interface it is also
> +possible to perform a complete memory scan to remove the write permission
> +from pages that are both writable and executable, please note that this
> +change will also affect other threads of the same process.

[snip]

cheers.
-- 
~Randy
