Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB77E955C
	for <lists+linux-security-module@lfdr.de>; Mon, 13 Nov 2023 04:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjKMDPv (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 12 Nov 2023 22:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKMDPu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 12 Nov 2023 22:15:50 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE61716;
        Sun, 12 Nov 2023 19:15:47 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso3697911276.3;
        Sun, 12 Nov 2023 19:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699845347; x=1700450147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8B96Ni+FGUAk/kFVWQhHFafqodPoSpSscy2GJncHQw=;
        b=GNSu4R9LZupKLsPOe8kXj0oo23LGLUTiCbVKeUdW1u3Ol1X+tFjhM5PsFH3yCdToUT
         Kh+5YUr4FWdpGx8ix6Wy6ZV3hqqNbl5RjYs/8mfEghRBjbWntT+ZF4ZqGGJpMXZBCrPB
         ABfssgLRcjrfKgu5NoJJPI8gdaDMyX1nPT7xkrBGwe/RUMc2YWEQh0cTalo6ksa1L4uX
         U+xnuzFxuSsfxlSmQWvxj4N8m28X/mwWQyI5e9jm++yJd1+cKYst4fLFCev/P6BLlHFM
         YGqsvKZHtjoWnS+HTiSVMZp0tu8TcIe/vy9THErRJNkfWTjUFFfgX0nT09p7PU3t2aw6
         dJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699845347; x=1700450147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8B96Ni+FGUAk/kFVWQhHFafqodPoSpSscy2GJncHQw=;
        b=hN6cTuTFBGxBC8uqQYuRkfKMWGNsjHbKRM4zAUGtrVw9JvshfnqQowqiyw1Y/1dRlQ
         YrbOuyVfJ1g0zoJJXYO3AyKJzzvlLcfjOKBTcqbNrLB4Ou/DpWfduXLWZaCrL4fibjcX
         WSYXXFY88mYpMOFha35csce7ELwdA9Hh+H/bS18OxwdJN5NU+YK3ma33sZGT2tEBjOm0
         2sLE3ceG6fcdRB6KnNuFP8fcQoTAzMAxyLlht0jJGkFiYO1VeR0HvEztFWMpCugZjVEk
         ae8fYEPTS/xo3xIHArNk3BdBcIrVXnhRQYl7d1HarPCmNQlUdS/53roPY01N91ABidG1
         gxyA==
X-Gm-Message-State: AOJu0Yw1SgD5ZgcJC7elvdkYPagkNeyEJFt/AakO9ZwA2ObCvJFJDc+O
        6BGkk7LukNUXLSN1QypVCgfRRMVOC3GQP+EIoaA=
X-Google-Smtp-Source: AGHT+IGgoOn1GD9rsX8lEdOR18h9YH3PIsSRn09mwvNzpVQHVvocjvVSovUR6KBjYyKPtj7t4Wtss/58PVhBz+Dl7N4=
X-Received: by 2002:a25:5ca:0:b0:da3:9a65:84b1 with SMTP id
 193-20020a2505ca000000b00da39a6584b1mr2840571ybf.12.1699845346849; Sun, 12
 Nov 2023 19:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20231112073424.4216-1-laoar.shao@gmail.com> <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
In-Reply-To: <188dc90e-864f-4681-88a5-87401c655878@schaufler-ca.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Mon, 13 Nov 2023 11:15:06 +0800
Message-ID: <CALOAHbD+_0tHcm72Q6TM=EXDoZFrVWAsi4AC8_xGqK3wGkEy3g@mail.gmail.com>
Subject: Re: [RFC PATCH -mm 0/4] mm, security, bpf: Fine-grained control over
 memory policy adjustments with lsm bpf
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        ligang.bdlg@bytedance.com, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Nov 13, 2023 at 12:45=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
>
> On 11/11/2023 11:34 PM, Yafang Shao wrote:
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > In our containerized environment, we've identified unexpected OOM event=
s
> > where the OOM-killer terminates tasks despite having ample free memory.
> > This anomaly is traced back to tasks within a container using mbind(2) =
to
> > bind memory to a specific NUMA node. When the allocated memory on this =
node
> > is exhausted, the OOM-killer, prioritizing tasks based on oom_score,
> > indiscriminately kills tasks. This becomes more critical with guarantee=
d
> > tasks (oom_score_adj: -998) aggravating the issue.
>
> Is there some reason why you can't fix the callers of mbind(2)?
> This looks like an user space configuration error rather than a
> system security issue.

It appears my initial description may have caused confusion. In this
scenario, the caller is an unprivileged user lacking any capabilities.
While a privileged user, such as root, experiencing this issue might
indicate a user space configuration error, the concerning aspect is
the potential for an unprivileged user to disrupt the system easily.
If this is perceived as a misconfiguration, the question arises: What
is the correct configuration to prevent an unprivileged user from
utilizing mbind(2)?"

>
> >
> > The selected victim might not have allocated memory on the same NUMA no=
de,
> > rendering the killing ineffective. This patch aims to address this by
> > disabling MPOL_BIND in container environments.
> >
> > In the container environment, our aim is to consolidate memory resource
> > control under the management of kubelet. If users express a preference =
for
> > binding their memory to a specific NUMA node, we encourage the adoption=
 of
> > a standardized approach. Specifically, we recommend configuring this me=
mory
> > policy through kubelet using cpuset.mems in the cpuset controller, rath=
er
> > than individual users setting it autonomously. This centralized approac=
h
> > ensures that NUMA nodes are globally managed through kubelet, promoting
> > consistency and facilitating streamlined administration of memory resou=
rces
> > across the entire containerized environment.
>
> Changing system behavior for a single use case doesn't seem prudent.
> You're introducing a bunch of kernel code to avoid fixing a broken
> user space configuration.

Currently, there is no mechanism in place to proactively prevent an
unprivileged user from utilizing mbind(2). The approach adopted is to
monitor mbind(2) through a BPF program and trigger an alert if its
usage is detected. However, beyond this monitoring, the only recourse
is to verbally communicate with the user, advising against the use of
mbind(2). As a result, users will question why mbind(2) isn't outright
prohibited in the first place.

--=20
Regards
Yafang
