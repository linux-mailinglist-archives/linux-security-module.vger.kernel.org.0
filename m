Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D324DE3B28
	for <lists+linux-security-module@lfdr.de>; Thu, 24 Oct 2019 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440124AbfJXSkQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 24 Oct 2019 14:40:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48390 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440123AbfJXSkQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Oct 2019 14:40:16 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <tyhicks@canonical.com>)
        id 1iNi1j-00084R-70; Thu, 24 Oct 2019 18:40:03 +0000
Date:   Thu, 24 Oct 2019 13:39:59 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        John Johansen <john.johansen@canonical.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] apparmor: fix odd_ptr_err.cocci warnings (fwd)
Message-ID: <20191024183958.GA29190@elm>
References: <alpine.DEB.2.21.1910241326470.9562@hadrien>
 <CAEkB2ER5TOviwk4teTVLJO=jFEbi_NWVqjMEg2jYzL7x4027gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkB2ER5TOviwk4teTVLJO=jFEbi_NWVqjMEg2jYzL7x4027gg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019-10-24 13:35:24, Navid Emamdoost wrote:
> Hello,
> 
> I added Tyler to this conversation.
> I believe v3 of the patch addresses this issue:
> https://lore.kernel.org/patchwork/patch/1142523/

Yes, I agree. v3 is the fix.

Tyler

> 
> 
> On Thu, Oct 24, 2019 at 6:28 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> > Hello,
> >
> > The change suggested by Coccinelle is not correct, but the original code
> > is not correct either because the argument to PTR_ERR should be a pointer,
> > not an integer.
> >
> > julia
> >
> > ---------- Forwarded message ----------
> > Date: Thu, 24 Oct 2019 18:21:57 +0800
> > From: kbuild test robot <lkp@intel.com>
> > To: kbuild@lists.01.org
> > Cc: Julia Lawall <julia.lawall@lip6.fr>
> > Subject: [PATCH] apparmor: fix odd_ptr_err.cocci warnings
> >
> > CC: kbuild-all@lists.01.org
> > In-Reply-To: <20191021152348.3906-1-navid.emamdoost@gmail.com>
> > References: <20191021152348.3906-1-navid.emamdoost@gmail.com>
> > TO: Navid Emamdoost <navid.emamdoost@gmail.com>
> >
> > From: kbuild test robot <lkp@intel.com>
> >
> > security/apparmor/audit.c:199:5-11: inconsistent IS_ERR and PTR_ERR on line 202.
> >
> >  PTR_ERR should access the value just tested by IS_ERR
> >
> > Semantic patch information:
> >  There can be false positives in the patch case, where it is the call to
> >  IS_ERR that is wrong.
> >
> > Generated by: scripts/coccinelle/tests/odd_ptr_err.cocci
> >
> > Fixes: 6f939f24599c ("apparmor: Fix use-after-free in aa_audit_rule_init")
> > CC: Navid Emamdoost <navid.emamdoost@gmail.com>
> > Signed-off-by: kbuild test robot <lkp@intel.com>
> > ---
> >
> > url:    https://github.com/0day-ci/linux/commits/Navid-Emamdoost/apparmor-Fix-use-after-free-in-aa_audit_rule_init/20191024-123239
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-testing
> > :::::: branch date: 6 hours ago
> > :::::: commit date: 6 hours ago
> >
> > Please take the patch only if it's a positive warning. Thanks!
> >
> >  audit.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/security/apparmor/audit.c
> > +++ b/security/apparmor/audit.c
> > @@ -199,7 +199,7 @@ int aa_audit_rule_init(u32 field, u32 op
> >         if (IS_ERR(rule->label)) {
> >                 int err = rule->label;
> >                 aa_audit_rule_free(rule);
> > -               return PTR_ERR(err);
> > +               return PTR_ERR(rule->label);
> >         }
> >
> >         *vrule = rule;
> 
> 
> 
> --
> Navid.
