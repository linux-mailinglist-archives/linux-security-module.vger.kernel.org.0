Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5E19BED
	for <lists+linux-security-module@lfdr.de>; Fri, 10 May 2019 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfEJKuc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 10 May 2019 06:50:32 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54079 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfEJKuc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 10 May 2019 06:50:32 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4AAoSFW059228;
        Fri, 10 May 2019 19:50:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Fri, 10 May 2019 19:50:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4AAoRno059224
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 10 May 2019 19:50:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [GIT PULL] Security subsystem: Smack updates for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>
References: <alpine.LRH.2.21.1905100325330.25349@namei.org>
 <CAHk-=wjjfZSxaivGyE0A3S2ZHCi=BVGdwG4++QVS80OTshBR1Q@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <f7420347-a926-e923-9914-714ead9298ec@I-love.SAKURA.ne.jp>
Date:   Fri, 10 May 2019 19:50:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjjfZSxaivGyE0A3S2ZHCi=BVGdwG4++QVS80OTshBR1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello, Linus.

On 2019/05/10 5:02, Linus Torvalds wrote:
> Security subsystem guys: just send your pull requests to me directly.

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tomoyo
contains 4 patches for this merge window

  commit cff0e6c3ec3e6230 ("tomoyo: Add a kernel config option for fuzzing testing.")
  commit ffd7af3def1985e0 ("tomoyo: Check address length before reading address family")
  commit 5385195a7b57cb3d ("tomoyo: Change pathname calculation for read-only filesystems.")
  commit 5c6b31e31adc31bd ("tomoyo: Don't emit WARNING: string while fuzzing testing.")

but I don't maintain a git tree for sending pull requests.
May I send these patches to you using below command line?

  git format-patch -4
  git send-email --to=you --cc=lsm-ml 000[1-4]-tomoyo-*.patch
