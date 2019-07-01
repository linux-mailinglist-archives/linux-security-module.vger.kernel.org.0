Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 719C218276
	for <lists+linux-security-module@lfdr.de>; Thu,  9 May 2019 00:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfEHWxy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 8 May 2019 18:53:54 -0400
Received: from namei.org ([65.99.196.166]:38114 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfEHWxy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 8 May 2019 18:53:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x48MrlKw014101;
        Wed, 8 May 2019 22:53:48 GMT
Date:   Thu, 9 May 2019 08:53:47 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     linux-security-module@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] tomoyo: Don't emit WARNING: string while fuzzing
 testing.
In-Reply-To: <1557228862-9277-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.21.1905090853260.3142@namei.org>
References: <1557228862-9277-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 7 May 2019, Tetsuo Handa wrote:

> Commit cff0e6c3ec3e6230 ("tomoyo: Add a kernel config option for fuzzing
> testing.") enabled the learning mode, and syzbot started crashing by
> encountering this warning message. Disable this warning if built for
> fuzzing testing; otherwise syzbot can't start fuzzing testing.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Dmitry Vyukov <dvyukov@google.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tomoyo

-- 
James Morris
<jmorris@namei.org>

