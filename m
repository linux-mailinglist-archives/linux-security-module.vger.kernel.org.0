Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1A9C8D69
	for <lists+linux-security-module@lfdr.de>; Wed,  2 Oct 2019 17:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfJBPw1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 2 Oct 2019 11:52:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60348 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJBPw1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 2 Oct 2019 11:52:27 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iFgvO-00064p-C7; Wed, 02 Oct 2019 17:52:22 +0200
Date:   Wed, 2 Oct 2019 17:52:22 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, tglx@linutronix.de
Subject: Re: [PATCH v4] apparmor: Use a memory pool instead per-CPU caches
Message-ID: <20191002155222.exbyzc2iwuugm5cz@linutronix.de>
References: <7b41609f-2592-93c1-55f7-6026ff6dba26@I-love.SAKURA.ne.jp>
 <20190502134730.d3ya46ave6a7bvom@linutronix.de>
 <001f651f-c544-c3fa-c0c2-f2a2b1ed565a@i-love.sakura.ne.jp>
 <20190503114827.yky7r2cjq7zy4dfm@linutronix.de>
 <20190503115145.anv7z4kk7okydthm@linutronix.de>
 <56de7347-b119-155d-675c-23a227ffd516@i-love.sakura.ne.jp>
 <20190503141221.qvqdfbfmmmzc7gfr@linutronix.de>
 <b2bb1be2-2130-3d77-2430-1de526accf2a@canonical.com>
 <20191002085913.xs3oglbegsjrrrcq@linutronix.de>
 <6dd10441-298e-4604-a382-eaeac00a981c@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dd10441-298e-4604-a382-eaeac00a981c@canonical.com>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019-10-02 08:47:58 [-0700], John Johansen wrote:
> I have some patches that are required on top of them. I didn't chase down
> all the issues/get the patches done until after -rc6 so everything waits
> for the next cycle. I am going to update apparmor-next with the new stack
> this week.

Okay, thanks for the update.

Sebastian
