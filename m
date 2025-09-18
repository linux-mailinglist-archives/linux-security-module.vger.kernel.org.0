Return-Path: <linux-security-module+bounces-11745-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06345B4405D
	for <lists+linux-security-module@lfdr.de>; Thu,  4 Sep 2025 17:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 849467A2CE0
	for <lists+linux-security-module@lfdr.de>; Thu,  4 Sep 2025 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002B323FC5A;
	Thu,  4 Sep 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NcJKZspB"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715931E3DED
	for <linux-security-module@vger.kernel.org>; Thu,  4 Sep 2025 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999151; cv=none; b=LRifVGJWRwlqN1q/ft05QbcYRDG5bxTOWMCPl32gmtSpfbkpX6D7pOkjpAwuQmIoK9/tZqNmSg3FGhL5jl6LCZiDcgA52C2NXx53RSuqptsmf0d2mqFA/BMwnJP64zH0CP6b5G0Xpz+mHzEmNUne7/zlYW+XZGt65o1xkQsdRm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999151; c=relaxed/simple;
	bh=nYETEdFM2Q23PtRWuaKSlqXYtOHj0CVVvgSenoBh4iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIxOjFYgTBYC/KXmIDD3IIR5hmw4wpCVWGiHzcS1LBis+QX8nRBAqsO/pYFmSb/L5626tZJ7sTGa9wtrufG+Iu/oYFX073YMEWbI/XAPUJz1gPvSjRUPjcMNU+OEwn+qsDK4UG4Xs+LBRzFCiRnJAHr983imo04ulNNXJE07UGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NcJKZspB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4c6fee41c9so878839a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Sep 2025 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756999149; x=1757603949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmTNeG4SrXOqz+4cfRCRJg+2hK/lpQxkTAHLWvqFN5w=;
        b=NcJKZspBpsgaPV2fktZK4DqkkNYyBlWvj+eNsLhMsPLeaP1oVFjboUBLaOJCc/aDmw
         vZjhrJqvOPtp2y2G2v1jnQIXQ6CCoGeznjuFn7dP4DoVOIL9Esr9h3guoCMa6wZLJ4ZL
         K6dRJq6vfhCbdd4C6y1+01pG8pBFVBaUoLPg/0/YMW+PZsh1HHR1GuzdV7Ju2bMjV83s
         LI9dtHk6eBW7uHZDVrCKMOBkEHCz89TQo2t17wZL/b5PIqmcDCGYnlWGv6gDRBnpR0dD
         nMFS0vJr3Bmd4fivQ9FucOIRP1NMmhseDsp2+AJUhGYPib/4+y1u622b8fAMHmT+B9Aw
         5JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756999149; x=1757603949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmTNeG4SrXOqz+4cfRCRJg+2hK/lpQxkTAHLWvqFN5w=;
        b=UIBzyMycbh/zS9p3eG3VqYHEzKMtqef6O7bXVHS/PJfkmjBHV95eNs8LP/72PzdRQv
         h/YWDfU850GEz06SRwigg45houT/z7HgtwnyVzFcLPLnn5IliFsN/CyASl+CoFczZWdN
         s0S7V62/Qqb5P/AEo4+EK2Sw32zUodJR5xw6Hh+AwjkvI7R47oueJZSR9rB902NfvfR/
         4YYT95/9wwQYv3d5SK4jxA/76YVHXKDQO2rPpT8O4/VE7X1jFXVpFnxWJndp+i0ktXWt
         46RT3SVK8gnZapy8DAQ7p2AffGGXPDEc6KKIqdfJKI6iLIIO5qGJ3DYytbJpEiP8GkZ1
         7Efg==
X-Forwarded-Encrypted: i=1; AJvYcCVsXXjNQXjkoC6TUpcbSEOe+R3pVT8v+4KI6KSoepo02G7oCPOG3BsQi/2gU9FYJIq+EReCHf1JcXPfc9lvQxEnWS1J7/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyBy8Z8zDO8PHobMu/VTjwwbMg+MB3Um2d5jIGB3Mgjm8QXmeY
	MfarqwrKR7UbukDPXVAh04qXmRRwF8SPfPgwBuS1Lwul1niAbZI6l0edUVoC4EJaSazjFd6U7b6
	hAwE5Hn9nko5DjGj0UgCk30paSgbII7BUkA1f3ekg
X-Gm-Gg: ASbGncubePztDJb/zGIh/fcZpoaJd9Mya9vIG3jXHcwH3A0kPOT8vVdbGjSMeOdosRr
	f0KOYU0osV8LCRgmIk4k3p2P4BfGPeolNyTv84q/kEl1RFGZHREhQniYQ/IMhOG2Cthas0/Re/g
	A1/1TAmSL6qpCqpzcFGFcARPXAkOJPEWXC5CZ50+gw1Y88FxIq9di9k7nWfbmmUaDwmIxBusrzC
	qukvXNysezECoGP8g==
X-Google-Smtp-Source: AGHT+IFhoa8t1irT70EePzG4ai40L7SfCBHvnhGypGx1ev2J21pr9crG6m2DUiO924RVZUUs0vOhBamZg1D3PjHb4rw=
X-Received: by 2002:a17:90a:e708:b0:32b:9595:ea58 with SMTP id
 98e67ed59e1d1-32b9595ec97mr3351549a91.34.1756999149480; Thu, 04 Sep 2025
 08:19:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-47-paul@paul-moore.com>
 <06a68323-b297-4be7-92eb-c2091207b9f0@canonical.com> <dd03266930a7b219c590c54bb2c210366f8d89a1.camel@huaweicloud.com>
 <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com>
In-Reply-To: <e92064a4-06c5-4913-917c-f9aca02378f3@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 11:18:57 -0400
X-Gm-Features: Ac12FXx2OvA4rbsYuJXfl6083HXp7bWTgYTn93ovNHC1jnaP7FZo6lWW50T_8jQ
Message-ID: <CAHC9VhQPmF-RCSUjZo-pe1+sWyw5ZGdnD7P0CWb7yXQQoo+92g@mail.gmail.com>
Subject: Re: [PATCH v3 11/34] lsm: get rid of the lsm_names list and do some cleanup
To: John Johansen <john.johansen@canonical.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Fan Wu <wufan@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 4:48=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 9/4/25 01:12, Roberto Sassu wrote:
> > On Tue, 2025-09-02 at 10:20 -0700, John Johansen wrote:
> >> On 8/14/25 15:50, Paul Moore wrote:
> >>> The LSM currently has a lot of code to maintain a list of the current=
ly
> >>> active LSMs in a human readable string, with the only user being the
> >>> "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> >>> generate the string on first use and then cache it for subsequent use=
.
> >>>
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>>    include/linux/lsm_hooks.h |  1 -
> >>>    security/inode.c          | 59 +++++++++++++++++++++++++++++++++++=
++--
> >>>    security/lsm_init.c       | 49 --------------------------------
> >>>    3 files changed, 57 insertions(+), 52 deletions(-)
> >>>
> >>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> >>> index 7343dd60b1d5..65a8227bece7 100644
> >>> --- a/include/linux/lsm_hooks.h
> >>> +++ b/include/linux/lsm_hooks.h
> >>> @@ -172,7 +172,6 @@ struct lsm_info {
> >>>
> >>>
> >>>    /* DO NOT tamper with these variables outside of the LSM framework=
 */
> >>> -extern char *lsm_names;
> >>>    extern struct lsm_static_calls_table static_calls_table __ro_after=
_init;
> >>>
> >>>    /**
> >>> diff --git a/security/inode.c b/security/inode.c
> >>> index 43382ef8896e..a5e7a073e672 100644
> >>> --- a/security/inode.c
> >>> +++ b/security/inode.c
> >>> @@ -22,6 +22,8 @@
> >>>    #include <linux/lsm_hooks.h>
> >>>    #include <linux/magic.h>
> >>>
> >>> +#include "lsm.h"
> >>> +
> >>>    static struct vfsmount *mount;
> >>>    static int mount_count;
> >>>
> >>> @@ -315,12 +317,65 @@ void securityfs_remove(struct dentry *dentry)
> >>>    EXPORT_SYMBOL_GPL(securityfs_remove);
> >>>
> >>>    #ifdef CONFIG_SECURITY
> >>> +#include <linux/spinlock.h>
> >>> +
> >>>    static struct dentry *lsm_dentry;
> >>> +
> >>> +/* NOTE: we never free the string below once it is set. */
> >>> +static DEFINE_SPINLOCK(lsm_read_lock);
> >>
> >> nit, this is only used on the write side, so not the best name
> >>
> >>> +static char *lsm_read_str =3D NULL;
> >>> +static ssize_t lsm_read_len =3D 0;
> >>> +
> >>>    static ssize_t lsm_read(struct file *filp, char __user *buf, size_=
t count,
> >>>                     loff_t *ppos)
> >>>    {
> >>> -   return simple_read_from_buffer(buf, count, ppos, lsm_names,
> >>> -           strlen(lsm_names));
> >>> +   int i;
> >>> +   char *str;
> >>> +   ssize_t len;
> >>> +
> >>> +restart:
> >>> +
> >>> +   rcu_read_lock();
> >
> > Uhm, it seems we cannot use plain RCU here, simple_read_from_buffer()
> > can sleep.
>
> doh, yes.

D'oh indeed!  Thanks for catching this.

> But we shouldn't need RCU here either. This is a write once, never update
> again situation. Instead we can get away with just a lock on the write
> side to ensure exclusion on setting the value.
>
> We don't even need the read side memory barrier, if the assumption that
> the pointer is read as a single value holds, and the the null read will
> go to the lock, and end up rereading.

It's funny you bring this up, my first draft of this function
(unposted) did just that, although I figured I'd add the RCU read side
protection ... "just in case".

I'll rework this function, but I'll hold off on posting another
revision until I hear back on some of the reviews that are still
pending in case additional edits are needed.

--=20
paul-moore.com

