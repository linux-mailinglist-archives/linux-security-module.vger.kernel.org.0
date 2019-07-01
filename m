Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59054EA1B
	for <lists+linux-security-module@lfdr.de>; Mon, 29 Apr 2019 20:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfD2S2x (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 29 Apr 2019 14:28:53 -0400
Received: from namei.org ([65.99.196.166]:36426 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbfD2S2x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 14:28:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3TIQxlq021250;
        Mon, 29 Apr 2019 18:26:59 GMT
Date:   Tue, 30 Apr 2019 04:26:59 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Andy Lutomirski <luto@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jonathan Adams <jwadams@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/7] x86/sci: add core implementation for system call
 isolation
In-Reply-To: <20190427104615.GA55518@gmail.com>
Message-ID: <alpine.LRH.2.21.1904300425200.20645@namei.org>
References: <1556228754-12996-1-git-send-email-rppt@linux.ibm.com> <1556228754-12996-3-git-send-email-rppt@linux.ibm.com> <20190426083144.GA126896@gmail.com> <20190426095802.GA35515@gmail.com> <CALCETrV3xZdaMn_MQ5V5nORJbcAeMmpc=gq1=M9cmC_=tKVL3A@mail.gmail.com>
 <20190427084752.GA99668@gmail.com> <20190427104615.GA55518@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 27 Apr 2019, Ingo Molnar wrote:

>  - A C language runtime that is a subset of current C syntax and 
>    semantics used in the kernel, and which doesn't allow access outside 
>    of existing objects and thus creates a strictly enforced separation 
>    between memory used for data, and memory used for code and control 
>    flow.

Might be better to start with Rust.


-- 
James Morris
<jmorris@namei.org>

