Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1606239DC
	for <lists+linux-security-module@lfdr.de>; Thu, 10 Nov 2022 03:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiKJCjd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 9 Nov 2022 21:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKJCj3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Nov 2022 21:39:29 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877EF13EAD
        for <linux-security-module@vger.kernel.org>; Wed,  9 Nov 2022 18:39:28 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-368edbc2c18so3657567b3.13
        for <linux-security-module@vger.kernel.org>; Wed, 09 Nov 2022 18:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OYh8JewXibsPkb2Z3MMAqrhOHn0psMI7TBUe5ndLAK0=;
        b=xpUAr1Z56NY7MMKNr7XMSecr2JNqhyOv2jPPrqp75f5OOE8TjkHD3cHOsGKXQ1j6M6
         kh25cOBc/4aaFQAIeIkls4GvC3z+UwS8caVTToF/OTAD4ZCAQFYJfxz1hmJjwe6blCdd
         rhFf4kkgxLluZvE2lxYmyQTmK5Z3BxVR2Zp/A3e03LVH5R7I/0jjCL+8IuuGkr9wZHJF
         QZVje2nNPGsNl8nfSmi0FdJLmE5B0PlSsDDNuVW4V3NTMxvqKEN23XC8LPDQ9yFG65Za
         V3IDVin4lYw5PdhMABi0ODXWeAUn3AOqRt7XQoT6X/3o8Qh5oE0YU69FDoCo3arNxqIg
         LDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYh8JewXibsPkb2Z3MMAqrhOHn0psMI7TBUe5ndLAK0=;
        b=mShp2vKuiqeIprabEZRewdtWPm4cXfBwY0wjJPxR65tQZLX8xh0zx8TUaQR2vfJenm
         StmAga54Jey+Xhu4+DvvcrfMCshLsrY2Qai5VW3abLyetDmBXs2nJZ1nG+CQVYqe3RKC
         Ikil3E3BmHnr4BS2qH8FM34kdChsciEGw6Ddq0pn3h167m+fz2eBsOw01NPzx7nbiExw
         3pZV+AGkKZtDuk9Aeo96ONBfrQBzBVGiuuGli7fZJPvGUnaLzp+mzEf8Sjwa92bG1MnD
         HGSj/woc/d669rh7VqcfZsiiheYVnApR+Z9rogmUbEgTlrU63d0W02Rp2F9J28ogeIcf
         v+OQ==
X-Gm-Message-State: ACrzQf1TskD7627Tlq6h1uGq37GVw2mYFUzKcrcwpyYZjqcErOBYaQyO
        EYI9pmH5KBqWrlrJjiklhSuZcP+paxZFCZMMySoM
X-Google-Smtp-Source: AMsMyM7ggHlLqO73VgXENfSh0IWNQAS4b0Ryi6fyO/f0IOYiAVuJ+Sx1ExJpFw1F+Vf3UVNZOyPtSifhvUj0RWQNBjU=
X-Received: by 2002:a81:1001:0:b0:36a:6d22:8a0a with SMTP id
 1-20020a811001000000b0036a6d228a0amr59937721ywq.482.1668047967757; Wed, 09
 Nov 2022 18:39:27 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-4-casey@schaufler-ca.com> <CAHC9VhRv2biawm1w=8sR=DMBhy8FLNwxRch13j4EUBkCRUpxrA@mail.gmail.com>
 <1f595d0a-07cd-365d-ef36-8d796b783f22@schaufler-ca.com>
In-Reply-To: <1f595d0a-07cd-365d-ef36-8d796b783f22@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 21:39:16 -0500
Message-ID: <CAHC9VhT34=sNYFcx24CNb5+An+jReQuMJTQAbeZUbbwKKQYLuA@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] LSM: Identify the process attributes for each module
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Nov 9, 2022 at 8:03 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 11/9/2022 3:34 PM, Paul Moore wrote:
> > On Tue, Oct 25, 2022 at 2:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Add an integer member "features" to the struct lsm_id which
> >> identifies the API related data associated with each security
> >> module. The initial set of features maps to information that
> >> has traditionaly been available in /proc/self/attr.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/lsm_hooks.h  |  1 +
> >>  include/uapi/linux/lsm.h   | 14 ++++++++++++++
> >>  security/apparmor/lsm.c    |  1 +
> >>  security/selinux/hooks.c   |  2 ++
> >>  security/smack/smack_lsm.c |  1 +
> >>  5 files changed, 19 insertions(+)
> > Everything Greg already said with one additional comment below.
> >
> >> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> >> index dd4b4d95a172..46b2aa6a677e 100644
> >> --- a/include/linux/lsm_hooks.h
> >> +++ b/include/linux/lsm_hooks.h
> >> @@ -1608,6 +1608,7 @@ struct security_hook_heads {
> >>  struct lsm_id {
> >>         const char      *lsm;           /* Name of the LSM */
> >>         int             id;             /* LSM ID */
> >> +       int             features;       /* Set of LSM features */
> > I understand why you called the field "features", but I worry it is a
> > bit too generic for 32-bits of flags. Let's make it specific to the
> > LSM label attributes; how about 'feat_attr', 'sup_attr', or something
> > along those lines?
>
> How about 'attrs_used'? I'm open to anything except 'late_for_dinner' :)

Works for me.  It's also worth noting that this struct isn't part of
the UAPI so if we need to change it in the future we can.

-- 
paul-moore.com
