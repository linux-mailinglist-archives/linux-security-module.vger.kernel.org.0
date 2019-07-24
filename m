Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928F3726AE
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Jul 2019 06:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfGXEex (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 24 Jul 2019 00:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfGXEex (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Jul 2019 00:34:53 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF0FF21841;
        Wed, 24 Jul 2019 04:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563942892;
        bh=XFoLGs07OCkuBQXFVahilk1Hef1hE5SSE6f/fkXHSzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tt8V/DaiVHyRZQVj4hsDKR0bktUWQo6UkUg18kH/w1qtiXfqstl08Ltu6Qa2IcXuG
         JUOAMUevpNlM+lUw3CN8t2M1SgVd7W6MSh/dvye735D0maVjKSXbH038k6EQXob6ZN
         q5cuEpFnQ8IHDfKwcO9GoTlx5kD6CzWVw44HSr1A=
Date:   Tue, 23 Jul 2019 21:34:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: Reminder: 2 open syzbot bugs in "security/tomoyo" subsystem
Message-ID: <20190724043450.GZ643@sol.localdomain>
Mail-Followup-To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <20190724024251.GF643@sol.localdomain>
 <7800c28f-bf1c-56cd-c82e-b1ff174ccbc8@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7800c28f-bf1c-56cd-c82e-b1ff174ccbc8@i-love.sakura.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 24, 2019 at 12:18:47PM +0900, Tetsuo Handa wrote:
> > --------------------------------------------------------------------------------
> > Title:              KASAN: invalid-free in tomoyo_realpath_from_path
> > Last occurred:      57 days ago
> > Reported:           56 days ago
> > Branches:           net-next
> > Dashboard link:     https://syzkaller.appspot.com/bug?id=e9e5a1d41c3fb5d0f79aeea0e4cd535f160a6702
> > Original thread:    https://lkml.kernel.org/lkml/000000000000785e9d0589ec359a@google.com/T/#u
> 
> This cannot be a TOMOYO's bug. We are waiting for a reproducer but
> no crash occurred since then. Maybe it is time to close as invalid.

Maybe.  Did you check for stack buffer overflows in the functions that
tomoyo_realpath_from_path() calls?  Perhaps something is corrupting the 'buf'
variable in the parent's stack frame.

- Eric
