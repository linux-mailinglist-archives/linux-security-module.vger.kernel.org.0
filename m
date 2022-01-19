Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2C3493E2B
	for <lists+linux-security-module@lfdr.de>; Wed, 19 Jan 2022 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352612AbiASQPI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 19 Jan 2022 11:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbiASQPI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Jan 2022 11:15:08 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3DDC06173E
        for <linux-security-module@vger.kernel.org>; Wed, 19 Jan 2022 08:15:07 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 25-20020a05600c231900b003497473a9c4so15202741wmo.5
        for <linux-security-module@vger.kernel.org>; Wed, 19 Jan 2022 08:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/740EhzwYoGWwplLvQqVEtpoUmpyOdkwft+pAru/eUg=;
        b=CLleadD2rlpyVmC2Y6vZSEoLi9LN/RUvstwkUMHlt3h7gHDd+Twhzs8oNKymBLJ71M
         +mCmZ512cWOY8OIf9l9LSqDn0RzEX5N4nNE80SRlE4EPdjhpbA+VFlLjEUNdd6c7+gmz
         hc/Es0b3squc/LZ7AtYoKuJMwS6NkmXhvHLNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=/740EhzwYoGWwplLvQqVEtpoUmpyOdkwft+pAru/eUg=;
        b=pm7gYRAGsDA7rslU5s87G+hryRpnqnB+aUIlR1MYq5IpVayKZYpWR2H7+Q9WMfvOQs
         RKkRVwxhuKW/QKbT2hNb5vTDML0hp1USIhfkHt7LN+K4Y2215aGO8Tw54uyz7H2TzeNC
         nyN2yuo4RHKj7KA7uPIMZxIk5PikThvY+PVwjCYwLbSlFcuXiAfibrMUEXTJrRDDoqpW
         hRWpIYFGyHKf/513+oyooJWJ3WuHf3eikFZFDeame8kVU24QayCwGS5FH33bsL9N1UDj
         Kb9XGYA8Jt31I7SDGNlA1iitUgmsmJXU1cZsFCdjyi9H5OfL/529izNbLqF9VDbg5hoy
         zEIA==
X-Gm-Message-State: AOAM531RK/NFObE+B+QH6bhsaeztJRmZ3OGZETmJap2UowqQX5WDSYl+
        A87zCEfdUxHcJQkAllt3ACRHRA==
X-Google-Smtp-Source: ABdhPJwiLLIYLwmxveHTo+l6K6jAbRNMKsadqYtKqTPCn9x60CqA3JeQAqEpCJtSMiU+47LHV4yaMA==
X-Received: by 2002:adf:fb84:: with SMTP id a4mr30060043wrr.315.1642608906005;
        Wed, 19 Jan 2022 08:15:06 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o13sm298372wrq.37.2022.01.19.08.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 08:15:05 -0800 (PST)
Date:   Wed, 19 Jan 2022 17:15:02 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-security-module@vger.kernel.org,
        nouveau@lists.freedesktop.org, netdev@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Emma Anholt <emma@anholt.net>, Eryk Brol <eryk.brol@amd.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Leo Li <sunpeng.li@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vishal Kulkarni <vishal@chelsio.com>
Subject: Re: [PATCH 0/3] lib/string_helpers: Add a few string helpers
Message-ID: <Yeg5BpV8tknSPdSQ@phenom.ffwll.local>
Mail-Followup-To: Jani Nikula <jani.nikula@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-security-module@vger.kernel.org,
        nouveau@lists.freedesktop.org, netdev@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Emma Anholt <emma@anholt.net>, Eryk Brol <eryk.brol@amd.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Leo Li <sunpeng.li@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vishal Kulkarni <vishal@chelsio.com>
References: <20220119072450.2890107-1-lucas.demarchi@intel.com>
 <YegPiR7LU8aVisMf@alley>
 <87tudzbykz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tudzbykz.fsf@intel.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 19, 2022 at 04:16:12PM +0200, Jani Nikula wrote:
> On Wed, 19 Jan 2022, Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2022-01-18 23:24:47, Lucas De Marchi wrote:
> >> Add some helpers under lib/string_helpers.h so they can be used
> >> throughout the kernel. When I started doing this there were 2 other
> >> previous attempts I know of, not counting the iterations each of them
> >> had:
> >> 
> >> 1) https://lore.kernel.org/all/20191023131308.9420-1-jani.nikula@intel.com/
> >> 2) https://lore.kernel.org/all/20210215142137.64476-1-andriy.shevchenko@linux.intel.com/#t
> >> 
> >> Going through the comments I tried to find some common ground and
> >> justification for what is in here, addressing some of the concerns
> >> raised.
> >> 
> >> d. This doesn't bring onoff() helper as there are some places in the
> >>    kernel with onoff as variable - another name is probably needed for
> >>    this function in order not to shadow the variable, or those variables
> >>    could be renamed.  Or if people wanting  <someprefix>
> >>    try to find a short one
> >
> > I would call it str_on_off().
> >
> > And I would actually suggest to use the same style also for
> > the other helpers.
> >
> > The "str_" prefix would make it clear that it is something with
> > string. There are other <prefix>_on_off() that affect some
> > functionality, e.g. mute_led_on_off(), e1000_vlan_filter_on_off().
> >
> > The dash '_' would significantly help to parse the name. yesno() and
> > onoff() are nicely short and kind of acceptable. But "enabledisable()"
> > is a puzzle.
> >
> > IMHO, str_yes_no(), str_on_off(), str_enable_disable() are a good
> > compromise.
> >
> > The main motivation should be code readability. You write the
> > code once. But many people will read it many times. Open coding
> > is sometimes better than misleading macro names.
> >
> > That said, I do not want to block this patchset. If others like
> > it... ;-)
> 
> I don't mind the names either way. Adding the prefix and dashes is
> helpful in that it's possible to add the functions first and convert
> users at leisure, though with a bunch of churn, while using names that
> collide with existing ones requires the changes to happen in one go.
> 
> What I do mind is grinding this series to a halt once again. I sent a
> handful of versions of this three years ago, with inconclusive
> bikeshedding back and forth, eventually threw my hands up in disgust,
> and walked away.

Yeah we can sed this anytime later we want to, but we need to get the foot
in the door. There's also a pile more of these all over.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

on the series, maybe it helps? And yes let's merge this through drm-misc.
-Daniel

> 
> >
> >
> >> e. One alternative to all of this suggested by Christian K�nig
> >>    (43456ba7-c372-84cc-4949-dcb817188e21@amd.com) would be to add a
> >>    printk format. But besides the comment, he also seemed to like
> >>    the common function. This brought the argument from others that the
> >>    simple yesno()/enabledisable() already used in the code is easier to
> >>    remember and use than e.g. %py[DOY]
> >
> > Thanks for not going this way :-)
> >
> >> Last patch also has some additional conversion of open coded cases. I
> >> preferred starting with drm/ since this is "closer to home".
> >> 
> >> I hope this is a good summary of the previous attempts and a way we can
> >> move forward.
> >> 
> >> Andrew Morton, Petr Mladek, Andy Shevchenko: if this is accepted, my
> >> proposal is to take first 2 patches either through mm tree or maybe
> >> vsprintf. Last patch can be taken later through drm.
> >
> > I agree with Andy that it should go via drm tree. It would make it
> > easier to handle potential conflicts.
> >
> > Just in case, you decide to go with str_yes_no() or something similar.
> > Mass changes are typically done at the end on the merge window.
> > The best solution is when it can be done by a script.
> >
> > Best Regards,
> > Petr
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
