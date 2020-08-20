Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009A724C54F
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Aug 2020 20:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHTS25 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 20 Aug 2020 14:28:57 -0400
Received: from namei.org ([65.99.196.166]:60258 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgHTS24 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Aug 2020 14:28:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 07KISY9J029978;
        Thu, 20 Aug 2020 18:28:35 GMT
Date:   Fri, 21 Aug 2020 04:28:34 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
cc:     Amol Grover <frextrite@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH RESEND] device_cgroup: Fix RCU list debugging warning
In-Reply-To: <20200817120731.218e1bc5@canb.auug.org.au>
Message-ID: <alpine.LRH.2.21.2008210427590.29407@namei.org>
References: <20200406105950.GA2285@workstation-kernel-dev> <20200607062340.7be7e8d5@canb.auug.org.au> <20200607190840.GG4455@paulmck-ThinkPad-P72> <20200608041734.GA10911@mail.hallyn.com> <20200817120731.218e1bc5@canb.auug.org.au>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 17 Aug 2020, Stephen Rothwell wrote:

> > > mainline, so it can go up any tree.  I can take it if no one else will,
> > > but it might be better going in via the security tree.
> > 
> > James, do you mind pulling it in?
> 
> I am still carrying this patch.  Has it been superceded, or is it still
> necessary?

It appears to be necessary.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.9

-- 
James Morris
<jmorris@namei.org>

