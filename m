Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CED2ABFA5
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Sep 2019 20:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436612AbfIFSq0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 Sep 2019 14:46:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43087 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436614AbfIFSqZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Sep 2019 14:46:25 -0400
Received: by mail-io1-f65.google.com with SMTP id u185so14915877iod.10
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2019 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QRnJITRgtGPLg2irBHffabraOH6qFTHyLeWEmn2CG4k=;
        b=fW9yI0r5PaavEuDpO3wqhc1PKV3gT7W2PHr0YvMv8yeRB3SF0rAwRE2BkG1RKIldB5
         pk0J20GIWh4t241wQZQAl1zHWNJxStYwy5kxUtaiwtqqhZ1ozaqrys8TEuTqNPhLzMt5
         Zm7do94cFWUwupAl/AOKTQpMgaVyhyVNN+4sksBHKSxv/0mSVTnzzbyVyIbnqt1snF5t
         iguQSIF5qEqKP9/56X/CjyzTRl1ktsNgpb3jvd0i/WW+d9og8BLCwLR8APIzc18T/0uR
         OlizzA0soMA5t0+LMz3QvB2o7vOuygMelmEjFL6nD4NQrfX5rILFVMakZMg0djTuN2a5
         pLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QRnJITRgtGPLg2irBHffabraOH6qFTHyLeWEmn2CG4k=;
        b=ohO0IojSKf+damm/xvnNA3BhqVUMK9IAmbTwJKz74t2B6a7EroPQhJIeoOkks9B9JC
         GU52Ic/yLft2BY4vQRDiJ+XIyVK5GTQU8T7wv+xAv+vY9FZ2UDjJNyMHf9GD58IKqktJ
         IR1PrA1O7GiCxPTn9ZhCNENr6ekqPfq3GL4Nq95rTeKlBTVtJNW1kx+JjJvY3HhHaXBp
         3Fs3qLvPWvE2vcbb/Qc1hBn2iBC7g/ZOP/kk6gBQfTpIWp0WxgdpD2ipoC37ceXSrwLu
         9bT0XThoJu+fPaluYE+3fTXTAwox2GW3kQuZq5PrajwTxsZe0sSVqMRvWxmgLnM8UDQX
         gYxQ==
X-Gm-Message-State: APjAAAUhlRdcGVtlL02UDCxqnwuBTbRNp7DMdFIlvQgQgMsWgDDBP+EU
        vUUHapx5he9kD/dg3Yt/OLEViQ==
X-Google-Smtp-Source: APXvYqx8a3vQaJo05FM2AJxDurm67u0wSOJsrKfOs76p1ALl+/al6SlzLMWYqNVPkldCZ7AZ/oWTyQ==
X-Received: by 2002:a02:ab90:: with SMTP id t16mr12092436jan.110.1567795583168;
        Fri, 06 Sep 2019 11:46:23 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:49a:5f6f:e06:3c33])
        by smtp.gmail.com with ESMTPSA id h4sm5578707iok.1.2019.09.06.11.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 11:46:22 -0700 (PDT)
Date:   Fri, 6 Sep 2019 12:46:20 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on
 sys_open()
Message-ID: <20190906184620.GI7627@cisco>
References: <20190906152455.22757-1-mic@digikod.net>
 <20190906152455.22757-2-mic@digikod.net>
 <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
 <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
 <20190906170739.kk3opr2phidb7ilb@yavin.dot.cyphar.com>
 <20190906172050.v44f43psd6qc6awi@wittgenstein>
 <20190906174041.GH7627@cisco>
 <87v9u5cmb0.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9u5cmb0.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Sep 06, 2019 at 08:27:31PM +0200, Florian Weimer wrote:
> * Tycho Andersen:
> 
> > On Fri, Sep 06, 2019 at 07:20:51PM +0200, Christian Brauner wrote:
> >> On Sat, Sep 07, 2019 at 03:07:39AM +1000, Aleksa Sarai wrote:
> >> > On 2019-09-06, Micka�l Sala�n <mickael.salaun@ssi.gouv.fr> wrote:
> >> > > 
> >> > > On 06/09/2019 17:56, Florian Weimer wrote:
> >> > > > Let's assume I want to add support for this to the glibc dynamic loader,
> >> > > > while still being able to run on older kernels.
> >> > > >
> >> > > > Is it safe to try the open call first, with O_MAYEXEC, and if that fails
> >> > > > with EINVAL, try again without O_MAYEXEC?
> >> > > 
> >> > > The kernel ignore unknown open(2) flags, so yes, it is safe even for
> >> > > older kernel to use O_MAYEXEC.
> >> > 
> >> > Depends on your definition of "safe" -- a security feature that you will
> >> > silently not enable on older kernels doesn't sound super safe to me.
> >> > Unfortunately this is a limitation of open(2) that we cannot change --
> >> > which is why the openat2(2) proposal I've been posting gives -EINVAL for
> >> > unknown O_* flags.
> >> > 
> >> > There is a way to probe for support (though unpleasant), by creating a
> >> > test O_MAYEXEC fd and then checking if the flag is present in
> >> > /proc/self/fdinfo/$n.
> >> 
> >> Which Florian said they can't do for various reasons.
> >> 
> >> It is a major painpoint if there's no easy way for userspace to probe
> >> for support. Especially if it's security related which usually means
> >> that you want to know whether this feature works or not.
> >
> > What about just trying to violate the policy via fexecve() instead of
> > looking around in /proc? Still ugly, though.
> 
> How would we do this?  This is about opening the main executable as part
> of an explicit loader invocation.  Typically, an fexecve will succeed
> and try to run the program, but with the wrong dynamic loader.

Yeah, fexecve() was a think-o, sorry, you don't need to go that far. I
was thinking do what the tests in this series do: create a tmpfs with
MS_NOEXEC, put an executable file in it, and try and open it with
O_MAYEXEC. If that works, the kernel doesn't support the flag, and it
should give you -EACCES if the kernel does support the flag.

Still a lot of work, though. Seems better to just use openat2.

Tycho
