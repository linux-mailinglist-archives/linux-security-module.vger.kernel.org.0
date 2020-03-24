Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 388B9191933
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Mar 2020 19:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgCXSbg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 24 Mar 2020 14:31:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45062 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgCXSbf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Mar 2020 14:31:35 -0400
Received: by mail-wr1-f66.google.com with SMTP id t7so18119895wrw.12
        for <linux-security-module@vger.kernel.org>; Tue, 24 Mar 2020 11:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TRKPAduhRgzDYFGxEjhwPq1m22owdMRTC7dAMnXK8+o=;
        b=KP8bPH6f3jWjqSWoYd0o9+lv1OOSKO7pfp/BIzm+cXQWQbRWyXDB6S2KJWjLGdnKIl
         5ea+BPNAStIimPJoBw8ecKXfZicIgjyjyL8kEyzlt20kRNpat2FLekmzx7KMzVi+vYV9
         xnyc/6mnkuGv03QWVH50lmoKbLgoC6F7Y7pno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TRKPAduhRgzDYFGxEjhwPq1m22owdMRTC7dAMnXK8+o=;
        b=SYXRXdAN/h4+sqL1M8VqVW2v702zGWdrWbmpxSNbveJxTitbxs8q0x/krvO2UBHhj6
         9uriBJVTLloP73L1aiyr/24KTSQSrDorPV6ApRlRszMjyo80bAtdPhkr6aD4a0m7mFQM
         GH+RZJKxjx4G3lYDcYveFsSIZJlyyQohwGGkSZbFYjkQI/XH6WxEB5L0TpuHuAZbIHTH
         bAiki0B3Tm2u1GKIyqWZg7A/ziT25+o7cWJeuhRnfo3LsRwvMrLVXN9pu7NPLDfLmYGz
         nbbSUUtCzBgjrfq31MVWDcLssy/xSfGv0c9a7GKJRo4DGUESi+pVJVnG8prw1E6pKjWR
         3vIw==
X-Gm-Message-State: ANhLgQ0Zi4n0CE7PRFcB35k6poR9FtamO+f3WpcffC4w2bYvRG5BxhcC
        ldbSpPCIhyhliEREK1qxHshBlA==
X-Google-Smtp-Source: ADFU+vsz6U5HYqm1IBHQRVaOtfu++Ku4RbAz9LTIR4WnMNvtt0HFL+71Dz4au84EA9L6BHhEUTmSTA==
X-Received: by 2002:a5d:4290:: with SMTP id k16mr16437054wrq.406.1585074692983;
        Tue, 24 Mar 2020 11:31:32 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id v26sm29817820wra.7.2020.03.24.11.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:31:32 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 19:31:30 +0100
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
Message-ID: <20200324183130.GA6784@chromium.org>
References: <20200323164415.12943-5-kpsingh@chromium.org>
 <CAEjxPJ4MukexdmAD=py0r7vkE6vnn6T1LVcybP_GSJYsAdRuxA@mail.gmail.com>
 <20200324145003.GA2685@chromium.org>
 <CAEjxPJ4YnCCeQUTK36Ao550AWProHrkrW1a6K5RKuKYcPcfhyA@mail.gmail.com>
 <d578d19f-1d3b-f60d-f803-2fcb46721a4a@schaufler-ca.com>
 <CAEjxPJ59wijpB=wa4ZhPyX_PRXrRAX2+PO6e8+f25wrb9xndRA@mail.gmail.com>
 <202003241100.279457EF@keescook>
 <20200324180652.GA11855@chromium.org>
 <CAEjxPJ7ebh1FHBjfuoWquFLJi0TguipfRq5ozaSepLVt8+qaMQ@mail.gmail.com>
 <20200324182759.GA5557@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200324182759.GA5557@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 24-M�r 19:27, KP Singh wrote:
> On 24-M�r 14:21, Stephen Smalley wrote:
> > On Tue, Mar 24, 2020 at 2:06 PM KP Singh <kpsingh@chromium.org> wrote:
> > >
> > > On 24-M�r 11:01, Kees Cook wrote:
> > > > On Tue, Mar 24, 2020 at 01:49:34PM -0400, Stephen Smalley wrote:
> > > > > On Tue, Mar 24, 2020 at 12:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > > > >
> > > > > > On 3/24/2020 7:58 AM, Stephen Smalley wrote:
> > > > > > > On Tue, Mar 24, 2020 at 10:50 AM KP Singh <kpsingh@chromium.org> wrote:
> > > > > > >> On 24-M�r 10:35, Stephen Smalley wrote:
> > > > > > >>> On Mon, Mar 23, 2020 at 12:46 PM KP Singh <kpsingh@chromium.org> wrote:
> > > > > > >>>> From: KP Singh <kpsingh@google.com>
> > > > > > >>>> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > > > > > >>>> index 530d137f7a84..2a8131b640b8 100644
> > > > > > >>>> --- a/kernel/bpf/bpf_lsm.c
> > > > > > >>>> +++ b/kernel/bpf/bpf_lsm.c
> > > > > > >>>> @@ -9,6 +9,9 @@
> > > > > > >>>>  #include <linux/btf.h>
> > > > > > >>>>  #include <linux/lsm_hooks.h>
> > > > > > >>>>  #include <linux/bpf_lsm.h>
> > > > > > >>>> +#include <linux/jump_label.h>
> > > > > > >>>> +#include <linux/kallsyms.h>
> > > > > > >>>> +#include <linux/bpf_verifier.h>
> > > > > > >>>>
> > > > > > >>>>  /* For every LSM hook  that allows attachment of BPF programs, declare a NOP
> > > > > > >>>>   * function where a BPF program can be attached as an fexit trampoline.
> > > > > > >>>> @@ -27,6 +30,32 @@ noinline __weak void bpf_lsm_##NAME(__VA_ARGS__) {}
> > > > > > >>>>  #include <linux/lsm_hook_names.h>
> > > > > > >>>>  #undef LSM_HOOK
> > > > > > >>>>
> > > > > > >>>> +#define BPF_LSM_SYM_PREFX  "bpf_lsm_"
> > > > > > >>>> +
> > > > > > >>>> +int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > > > > >>>> +                       const struct bpf_prog *prog)
> > > > > > >>>> +{
> > > > > > >>>> +       /* Only CAP_MAC_ADMIN users are allowed to make changes to LSM hooks
> > > > > > >>>> +        */
> > > > > > >>>> +       if (!capable(CAP_MAC_ADMIN))
> > > > > > >>>> +               return -EPERM;
> > > > > > >>> I had asked before, and will ask again: please provide an explicit LSM
> > > > > > >>> hook for mediating whether one can make changes to the LSM hooks.
> > > > > > >>> Neither CAP_MAC_ADMIN nor CAP_SYS_ADMIN suffices to check this for SELinux.
> > > > > > >> What do you think about:
> > > > > > >>
> > > > > > >>   int security_check_mutable_hooks(void)
> > > > > > >>
> > > > > > >> Do you have any suggestions on the signature of this hook? Does this
> > > > > > >> hook need to be BPF specific?
> > > > > > > I'd do something like int security_bpf_prog_attach_security(const
> > > > > > > struct bpf_prog *prog) or similar.
> > > > > > > Then the security module can do a check based on the current task
> > > > > > > and/or the prog.  We already have some bpf-specific hooks.
> > > > > >
> > > > > > I *strongly* disagree with Stephen on this. KRSI and SELinux are peers.
> > > > > > Just as Yama policy is independent of SELinux policy so KRSI policy should
> > > > > > be independent of SELinux policy. I understand the argument that BDF programs
> > > > > > ought to be constrained by SELinux, but I don't think it's right. Further,
> > > > > > we've got unholy layering when security modules call security_ functions.
> > > > > > I'm not saying there is no case where it would be appropriate, but this is not
> > > > > > one of them.
> > > > >
> > > > > I explained this previously.  The difference is that the BPF programs
> > > > > are loaded from a userspace
> > > > > process, not a kernel-resident module.  They already recognize there
> > > > > is a difference here or
> > > > > they wouldn't have the CAP_MAC_ADMIN check above in their patch.  The
> > > > > problem with that
> > > > > check is just that CAP_MAC_ADMIN doesn't necessarily mean fully
> > > > > privileged with respect to
> > > > > SELinux, which is why I want an explicit hook.  This gets a NAK from
> > > > > me until there is such a hook.
> > > >
> > > > Doesn't the existing int (*bpf_prog)(struct bpf_prog *prog); cover
> > > > SELinux's need here? I.e. it can already examine that a hook is being
> > > > created for the LSM (since it has a distinct type, etc)?
> > >
> > > I was about to say the same, specifically for the BPF use-case, we do
> > > have the "bpf_prog" i.e. :
> > >
> > > "Do a check when the kernel generate and return a file descriptor for
> > > eBPF programs."
> > >
> > > SELinux can implement its policy logic for BPF_PROG_TYPE_LSM by
> > > providing a callback for this hook.
> > 
> > Ok.  In that case do we really need the capable() check here at all?
> 
> We do not have a specific capable check for BPF_PROG_TYPE_LSM programs
> now. There is a general check which requires CAP_SYS_ADMIN when
> unprivileged BPF is disabled:
> 
> in kernel/bpf/sycall.c:
> 
>         if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> 	        return -EPERM;
> 
> AFAIK, Most distros disable unprivileged eBPF.
> 
> Now that I look at this, I think we might need a CAP_MAC_ADMIN check
> though as unprivileged BPF being enabled will result in an
> unprivileged user being able to load MAC policies.

Actually we do have an extra check for loading BPF programs:


in kernel/bpf/syscall.c:bpf_prog_load

	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
	    type != BPF_PROG_TYPE_CGROUP_SKB &&
	    !capable(CAP_SYS_ADMIN))
		return -EPERM;

Do you think we still need a CAP_MAC_ADMIN check for LSM programs?

- KP

> 
> - KP
