Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C246919036A
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Mar 2020 02:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCXBw1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Mar 2020 21:52:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41637 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbgCXBw1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Mar 2020 21:52:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9so19568852wrc.8
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2020 18:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GbEsPGbYy5/MMngLexS7oQCXLwm/Hp/VeyWHkCMZX1E=;
        b=E+Ul25EE4P4xI9/A6uidBTsx+WzZyMu7GDfyCMr4tUb5S+8Iq5kNIXaMxobkwzSbDC
         lB6rZfmT0/arSbWGjm6XgK9/ESRu36tu9I72PJkclggd81WizLjHob1+MAwovGjQPyw8
         8EEL+ElBFzl876TjbWP0p10nvBTmOqS60v350=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GbEsPGbYy5/MMngLexS7oQCXLwm/Hp/VeyWHkCMZX1E=;
        b=IE2g8dz+J2UmNwZepZLqUGeOxmm1livljQChcZveX5nET72+NTFu/dBCl5Dob59x76
         u3/x0nHtS953LkY2LZkzXlw6w+FNFE/dbeoJWwrR5f3TYR4XXutkCAslp/+1oWb9I3iB
         ZgKj3x3y8FPZqSJlyf+ZVVZg/Kf3izb+BTwufwwnLjolGeC6kfxN9g+nHaR3ITcD7keY
         Pa6W7q6X05okVswfmviVNXWtFqexCK0GFaV7pTwITBM6b1WV0ykUSqMlTBKwaE9uLOk9
         pB4RAS3kqyR8WhvWTd5R/CXt0M0ce5BseGCbV0q+SFbuU9xYhzBQfVrvwtyTIMdcuV2m
         SBtw==
X-Gm-Message-State: ANhLgQ0wHD3NbWXqRfupewVks6Z3D1Lc5lzBdoQBhuUs0L+pu5mOATeR
        5QRxcIP6hy3zVZZxXQPcokY7Jg==
X-Google-Smtp-Source: ADFU+vvI19XvMNXyXx1gnpAihtkuqve2z3bOLiK5ECPR9jyWujY6Sg1+S+JU2QneQqN3mdI2iXQHhw==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr6132238wro.415.1585014745323;
        Mon, 23 Mar 2020 18:52:25 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id k126sm2116248wme.4.2020.03.23.18.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 18:52:24 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 02:52:21 +0100
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
Message-ID: <20200324015217.GA28487@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <6d45de0d-c59d-4ca7-fcc5-3965a48b5997@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d45de0d-c59d-4ca7-fcc5-3965a48b5997@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 23-M�r 18:13, Casey Schaufler wrote:
> On 3/23/2020 9:44 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> >
> > The bpf_lsm_ nops are initialized into the LSM framework like any other
> > LSM.  Some LSM hooks do not have 0 as their default return value. The
> > __weak symbol for these hooks is overridden by a corresponding
> > definition in security/bpf/hooks.c
> >
> > +	return 0;

[...]

> > +}
> > +
> > +DEFINE_LSM(bpf) = {
> > +	.name = "bpf",
> > +	.init = bpf_lsm_init,
> 
> Have you given up on the "BPF must be last" requirement?

Yes, we dropped it for as the BPF programs require CAP_SYS_ADMIN
anwyays so the position ~shouldn't~ matter. (based on some of the
discussions we had on the BPF_MODIFY_RETURN patches).

However, This can be added later (in a separate patch) if really
deemed necessary.

- KP

> 
> > +};
