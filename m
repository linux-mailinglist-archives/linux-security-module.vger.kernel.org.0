Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3D5206D
	for <lists+linux-security-module@lfdr.de>; Tue, 25 Jun 2019 03:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbfFYBrA (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 24 Jun 2019 21:47:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40268 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbfFYBrA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jun 2019 21:47:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so14499366ljh.7
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jun 2019 18:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yY0buOnDBXDxAC7PLVBtYI3pFTakloh8+6q+akNwwUY=;
        b=18/XRgS968rYTsu5WnfR3Grv4B0yDOon1KV28UOCSURWf6rac6dp8hhq01n27l5NbQ
         8Kcv3CfoSX1LBTxjARXMnytBH/Uf07XHfAl4UafAaRDTxxzgPn+g6igK0PGm8YhgIV/R
         zDALb0Bagl+RcN/n1vm5lHGZhXGLVaQZIXxt49wp24/BXXwx0lSl0Wbb5DPxbycL3D2j
         ERaa9UinCF3CKKsJahIuE5w/yMeg6mPA58tm14Cvm3ApIincqpTjvVGgOe0yUEty7aGa
         gWBamm7HPnIPYXKJ+1uufJcQsCI3ZZKCH9w4y79SWDGOmie3goPCqB55qfrcq3/3FbHa
         hoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yY0buOnDBXDxAC7PLVBtYI3pFTakloh8+6q+akNwwUY=;
        b=HikS6cvhGnzvMPS1w2eCt+DAodyH4fveRBE9qHLlEm1bAb8gfkgMPgEt+SiayPe4v3
         DK5BwHDHx1IiC/g4krPYStxDHA9WD4rI1Z7vyeuvSqYtAOn6+EDh10AzwSjpNZWH8P5e
         OSCRqPo1eYvcsAJcy8fVnY9h7kqKF+u4Uk1NEwbZeOTsdE5g9WGAS+8FMcDx3M8jVOnw
         VhT+NcZMJa488IsokOr8Z2qHjyzlig6am6W8hOvoN0/phxuHzDJOPwHh0SOkohO+iXsH
         3EiZ6nMtb9ZtUOSwj7ycsPBYX3WgopgwL0nFN6mmWTs3a3NRKe/L1vK2ceHXJSXawGI5
         tV2g==
X-Gm-Message-State: APjAAAUjkDwlMaN/a+J3GoCbN1KRfDJD+hSCQOJgbkRbq7e35BUrVvT7
        7XrNB5G/lOQ1x5jWUUeDMHTdBb0aSlHKtAJ/qg57
X-Google-Smtp-Source: APXvYqyV/UzNQSyh+uB8UzCU+XP/BX5eQeH5sbBsCUpkW/mXyKWYTvAtmGJKvqMSchug0I0CRMz2KcfEpE1NyKE/iMs=
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr72395341lje.46.1561427217178;
 Mon, 24 Jun 2019 18:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190621185233.6766-1-casey@schaufler-ca.com> <20190621185233.6766-22-casey@schaufler-ca.com>
 <79cd4a92-c221-eda4-58ba-730b5c2680d7@canonical.com> <0ad8f906-16ff-61af-ce7c-0ea1e9760d03@schaufler-ca.com>
In-Reply-To: <0ad8f906-16ff-61af-ce7c-0ea1e9760d03@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Jun 2019 21:46:45 -0400
Message-ID: <CAHC9VhSSwCY8L71x4WTr7kJhF1f_oyQ1NcwyXCAgW7ruKACQdQ@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] Audit: Store LSM audit information in an lsmblob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 24, 2019 at 9:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 6/24/2019 2:33 PM, John Johansen wrote:
> > On 6/21/19 11:52 AM, Casey Schaufler wrote:
> >> Change the audit code to store full lsmblob data instead of
> >> a single u32 secid. This allows for multiple security modules
> >> to use the audit system at the same time. It also allows the
> >> removal of scaffolding code that was included during the
> >> revision of LSM interfaces.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > I know Kees raised this too, but I haven't seen a reply
> >
> > Eric (Paul is already CCed): I have directly added you because of
> > the question below.
> >
> > In summary there isn't necessarily a single secid any more, and
> > we need to know whether dropping the logging of the secid or
> > logging all secids is the correct action.
>
> It is to be considered that this is an error case. If
> everything is working normally you should have produced
> a secctx previously, which you'll have included in the
> audit record. Including the secid in the record ought to
> be pointless, as the secid is strictly an internal token
> with no meaning outside the running kernel. You are providing
> no security relevant information by providing the secid.
> I will grant the possibility that the secid might be useful
> in debugging, but for that a pr_warn is more appropriate
> than a field in the audit record.

FWIW, this probably should have been CC'd to the audit list.

I agree that this is an error case (security_secid_to_secctx() failed
to resolve the secid) and further that logging the secid, or a
collection of secids, has little value the way things currently work.
Since secids are a private kernel implementation detail, we don't
really display them outside the context of the kernel, including in
the audit logs.  Recording a secid in this case doesn't provide
anything meaningful since secids aren't recorded in the audit record
stream, only the secctxs, and there is no "magic decoder ring" to go
between the two in the audit logs, or anywhere else in userspace for
that matter.

> >> ---
> >>  kernel/audit.h   |  6 +++---
> >>  kernel/auditsc.c | 38 +++++++++++---------------------------
> >>  2 files changed, 14 insertions(+), 30 deletions(-)

...

> >> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> >> index 0478680cd0a8..d3ad13f11788 100644
> >> --- a/kernel/auditsc.c
> >> +++ b/kernel/auditsc.c
> >> @@ -1187,21 +1184,18 @@ static void show_special(struct audit_context *context, int *call_panic)
> >>                              context->socketcall.args[i]);
> >>              break; }
> >>      case AUDIT_IPC: {
> >> -            u32 osid = context->ipc.osid;
> >> +            struct lsmblob *olsm = &context->ipc.olsm;
> >>
> >>              audit_log_format(ab, "ouid=%u ogid=%u mode=%#ho",
> >>                               from_kuid(&init_user_ns, context->ipc.uid),
> >>                               from_kgid(&init_user_ns, context->ipc.gid),
> >>                               context->ipc.mode);
> >> -            if (osid) {
> >> +            if (lsmblob_is_set(olsm)) {
> >>                      struct lsmcontext lsmcxt;
> >> -                    struct lsmblob blob;
> >>
> >> -                    lsmblob_init(&blob, osid);
> >> -                    if (security_secid_to_secctx(&blob, &lsmcxt)) {
> >> -                            audit_log_format(ab, " osid=%u", osid);
> > I am not comfortable just dropping this I would think logging all secids is the
> > correct action here.
> >
> >
> >> +                    if (security_secid_to_secctx(olsm, &lsmcxt))
> >>                              *call_panic = 1;
> >> -                    } else {
> >> +                    else {
> >>                              audit_log_format(ab, " obj=%s", lsmcxt.context);
> >>                              security_release_secctx(&lsmcxt);
> >>                      }

-- 
paul moore
www.paul-moore.com
