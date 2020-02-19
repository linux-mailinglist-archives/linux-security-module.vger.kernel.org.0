Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE711648AC
	for <lists+linux-security-module@lfdr.de>; Wed, 19 Feb 2020 16:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBSPd3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 19 Feb 2020 10:33:29 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39732 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSPd2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Feb 2020 10:33:28 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so515947oty.6
        for <linux-security-module@vger.kernel.org>; Wed, 19 Feb 2020 07:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E1sKBvtd2cVQy85wDQQwaHFMe+BR9oZ60u87YmbbgsA=;
        b=rkWnytES8w36IUEEtDRL8rezVYVLF3qfXgFjjxsq5fO+3E5345SKZme9Z180HRGxR8
         eHiL95Ewyfc2QvDvpEY/AONZJWpcGQMcwYK0GODKdShdKRLuQoQJkaIM6OF3NS+qRd+P
         BEjM7iwYtXIihoNMIf8HqHwZVpJtwyFfpr9tNWgUcIjZO6MxLWTAkA3NdhmyPa+V1tAE
         jd2/P/S1EGHEw4HtlEWORJBXhpNs+qzm/sYdf+zoBY46UrEKvXU9ynWGwF2p+y+UGnME
         1EOk8SseFzkw81fh2Kn10sLOz9pLTlLCr+xTG8u+No0GfUuweV59hOowE7GHzVUY4kJ8
         OqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E1sKBvtd2cVQy85wDQQwaHFMe+BR9oZ60u87YmbbgsA=;
        b=nQvhel0reu+LAF7uBZppXGBVzKL/H4ekk9jg5jXeb6chl+zbAiShxbrdD9cvq5ADRn
         w0qCdC/J+lk+lZGY2UXFv1x1o9a8GEz6WYmN6SQEWnTr+fmm3tG7C5m0s0wxJ2cLCDm3
         S7yvI0Uyp22IrZ7byGjcXHL+Rdv3KKW52xedR52wCf1/EB2K3UAk028gv1NgeJA1WhFZ
         aX2ARdYk2D/dnMUWdi58QpVUZb/TPjgkS+bAhnaqDVddt7X95eANVB8kmly4Tyvqyunv
         3qL3jVZHvyVp95uyCRSO4cevKrtdvc5XT2cKfLGHy9yYz5kCKIhYCWiZzlZLm56PtGb4
         OMAA==
X-Gm-Message-State: APjAAAW1WlOWMT0WFT08J11eyYnzSw2xKOgwLcolPcYjVqykzaClfnLi
        Tb8Gmp3DL9hIXfZJBwbrIJyV7XAt6SXVX+7MUvipbw==
X-Google-Smtp-Source: APXvYqzAPTgQ5P4aqucu1AcBe1mbzC38YJT9N/S1MOlBCev/cgDOUGz6H7VRarOAuw8VuUWRyxlBXSPgB2wK1I5CR9U=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr19506704oti.32.1582126408054;
 Wed, 19 Feb 2020 07:33:28 -0800 (PST)
MIME-Version: 1.0
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200218143411.2389182-1-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 16:33:00 +0100
Message-ID: <CAG48ez0mKg-nvcvuU-=a3oi4MTs2eiTQiqtOi89wqUm7uzuSBg@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] user_namespace: introduce fsid mappings
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Stephen Barber <smbarber@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Feb 18, 2020 at 3:35 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
[...]
> - Let the keyctl infrastructure only operate on kfsid which are always
>   mapped/looked up in the id mappings similar to what we do for
>   filesystems that have the same superblock visible in multiple user
>   namespaces.
>
> This version also comes with minimal tests which I intend to expand in
> the future.
>
> From pings and off-list questions and discussions at Google Container
> Security Summit there seems to be quite a lot of interest in this
> patchset with use-cases ranging from layer sharing for app containers
> and k8s, as well as data sharing between containers with different id
> mappings. I haven't Cced all people because I don't have all the email
> adresses at hand but I've at least added Phil now. :)
>
> This is the implementation of shiftfs which was cooked up during lunch at
> Linux Plumbers 2019 the day after the container's microconference. The
> idea is a design-stew from St=C3=A9phane, Aleksa, Eric, and myself (and b=
y
> now also Jann.
> Back then we all were quite busy with other work and couldn't really sit
> down and implement it. But I took a few days last week to do this work,
> including demos and performance testing.
> This implementation does not require us to touch the VFS substantially
> at all. Instead, we implement shiftfs via fsid mappings.
> With this patch, it took me 20 mins to port both LXD and LXC to support
> shiftfs via fsid mappings.
[...]

Can you please grep through the kernel for all uses of ->fsuid and
->fsgid and fix them up appropriately? Some cases I still see:


The SafeSetID LSM wants to enforce that you can only use CAP_SETUID to
gain the privileges of a specific set of IDs:

static int safesetid_task_fix_setuid(struct cred *new,
                                     const struct cred *old,
                                     int flags)
{

        /* Do nothing if there are no setuid restrictions for our old RUID.=
 */
        if (setuid_policy_lookup(old->uid, INVALID_UID) =3D=3D SIDPOL_DEFAU=
LT)
                return 0;

        if (uid_permitted_for_cred(old, new->uid) &&
            uid_permitted_for_cred(old, new->euid) &&
            uid_permitted_for_cred(old, new->suid) &&
            uid_permitted_for_cred(old, new->fsuid))
                return 0;

        /*
         * Kill this process to avoid potential security vulnerabilities
         * that could arise from a missing whitelist entry preventing a
         * privileged process from dropping to a lesser-privileged one.
         */
        force_sig(SIGKILL);
        return -EACCES;
}

This could theoretically be bypassed through setfsuid() if the kuid
based on the fsuid mappings is permitted but the kuid based on the
normal mappings is not.


fs/coredump.c in suid dump mode uses "cred->fsuid =3D GLOBAL_ROOT_UID";
this should probably also fix up the other uid, even if there is no
scenario in which it would actually be used at the moment?


The netfilter xt_owner stuff makes packet filtering decisions based on
the ->fsuid; it might be better to filter on the ->kfsuid so that you
can filter traffic from different user namespaces differently?


audit_log_task_info() is doing "from_kuid(&init_user_ns, cred->fsuid)".
