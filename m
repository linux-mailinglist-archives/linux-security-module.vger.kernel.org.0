Return-Path: <linux-security-module+bounces-348-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E9A8079A3
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Dec 2023 21:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCEDAB20BB0
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Dec 2023 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524BD41852
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Dec 2023 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="n+Xws8bf"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DA4135
	for <linux-security-module@vger.kernel.org>; Wed,  6 Dec 2023 12:24:58 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso20637066b.0
        for <linux-security-module@vger.kernel.org>; Wed, 06 Dec 2023 12:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1701894297; x=1702499097; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EspDDl8Dq3tngLpXRmIDltEe/7IquwN2W8jv0OkYqQc=;
        b=n+Xws8bfaFffRdiIHUc1+D0MYHAfuuVka6vpar78H+cYAdwJfBqtI3qKryginhK0Fv
         UdW9+/2ETk7/jgwGR5p+Qdsq1LXIQmvSN6g3ee5rrpjh2uSoX/oSb0LOZ3D4fqqdfAWq
         QyEozzZKNTsoXSkN0tr2ASoceIOyDeL90Up5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701894297; x=1702499097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EspDDl8Dq3tngLpXRmIDltEe/7IquwN2W8jv0OkYqQc=;
        b=ekr+s3PtNYj2VNpi0+4vdS+KY8PyWsYnQuc5icC8eZqT1vA17k4XvognHD8zaSJpkp
         6/PYPtjWPxrh2anjDlA/WVLWonK0BhW0Ckk+FDIWziglCk9zXLb6L0THRaOg4hG23bst
         qNSdpObzHGkAUnXrPSfEAg4/9zP8DYoApev6Se9S71QJlGTuHTM8mgcWP0LgKnazO1M2
         46xmkx5OAXyk67QD8nfjJUt5buFH2N5P7wZxjcuA/gBnZE5pPH4K8SHuORboigI277J3
         7ykO8lh6fYzTxHoPjRnavSVRgsOWsxaHbT9Esllq1+WkSCHal4Qsv5y/SXoBMCDaaQeh
         jgYQ==
X-Gm-Message-State: AOJu0YzHev3Skozb+myGL0Uh2K3zRS7PnlKs5U2aZU2OFtW8p+lgqKjR
	pYxl8mY57wT9J0Dhm5QF0CsGFnY+mef951a3JCWcPg==
X-Google-Smtp-Source: AGHT+IH+iwdb52KbnDIVMtSgM8sHUxJ0VwQ8KVpecHhoi9seb1w9sznIUZPT9Vqahu6bTmOPlo2a3KD/zljbOdj7EXQ=
X-Received: by 2002:a17:906:3648:b0:a18:ad93:460d with SMTP id
 r8-20020a170906364800b00a18ad93460dmr816177ejb.69.1701894296772; Wed, 06 Dec
 2023 12:24:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128160337.29094-1-mszeredi@redhat.com> <20231128160337.29094-4-mszeredi@redhat.com>
 <20231206195807.GA209606@mail.hallyn.com>
In-Reply-To: <20231206195807.GA209606@mail.hallyn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Dec 2023 21:24:45 +0100
Message-ID: <CAJfpegs-uUEwKrEcmRE4WkzWet_A1f9mnM7UtFqM=szEUi+-1g@mail.gmail.com>
Subject: Re: [PATCH 3/4] listmount: small changes in semantics
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Christian Brauner <christian@brauner.io>, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Dec 2023 at 20:58, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> On Tue, Nov 28, 2023 at 05:03:34PM +0100, Miklos Szeredi wrote:

> > -     if (!is_path_reachable(m, mnt->mnt_root, &rootmnt))
> > -             return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
> > +     if (!capable(CAP_SYS_ADMIN) &&
>
> Was there a reason to do the capable check first?  In general,
> checking capable() when not needed is frowned upon, as it will
> set the PF_SUPERPRIV flag.
>

I synchronized the permission checking with statmount() without
thinking about the order.   I guess we can change the order back in
both syscalls?

I also don't understand the reason behind the using the _noaudit()
variant.  Christian?

Thanks,
Miklos

