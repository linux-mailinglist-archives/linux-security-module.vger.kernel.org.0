Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0534A07D
	for <lists+linux-security-module@lfdr.de>; Fri, 26 Mar 2021 05:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCZEax (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 26 Mar 2021 00:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhCZEa3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Mar 2021 00:30:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A77C0613E0
        for <linux-security-module@vger.kernel.org>; Thu, 25 Mar 2021 21:30:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so3636415pjq.5
        for <linux-security-module@vger.kernel.org>; Thu, 25 Mar 2021 21:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BOYVi/+atNY4w5a1Eu4AFIfXG1/kriVH66pesNImX2Q=;
        b=Gt0kpo1iHDKszZFpT+Ko0aQvJV+MsUOHDLUaIYJ1Q9zDa/TrEbIi78eqXX6WSu6GX7
         pfRyJz2XC0x5LcOpkmHrIji2a8gZ0UyaNJuQmQkFZtr1MsmTrWXI9hJ4wj7KlwhwdP8r
         3TujOSNdRk4l0XyOTFl+8w69IEFt6kj94zI3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BOYVi/+atNY4w5a1Eu4AFIfXG1/kriVH66pesNImX2Q=;
        b=PpH2qtw1ldRAwLAhKsCNw/eYNHRgrpQIllL1El7Z+yrlzHaLXZvgZvXMs/fqLUWLNR
         hRq3JMms7I1osPRstmSmdCq/Ud4K31q65sqccy36I3hWvYorRoSiNFl1NKxG2cR68q7T
         OQpANNh2/zBV+WRGVnwHn6/WJmoQAtW0IsXo4dSTLZAqoHq2ru0bhYXPKXpUvKMZGwt5
         y/gXnbarMxaDG2Jh5dAj/Ng3iJ7D5lCcuUZHoe6PfQqTFvpu/a2FxrT3A20TsiROlq6U
         RMRkQtPG0z001qq7CCVSQm5FVn75TsXUjqNVhtSAejgiuzCH9H1XpwmmeSGXBTWXmrCm
         WT/w==
X-Gm-Message-State: AOAM532Gh2FmLcfUW4juEOra6o2uUlEYfEKPGV3LauxnAxYbmw8nCmjv
        9ZFisxBERP9+qkLvXHplW66ZZQ==
X-Google-Smtp-Source: ABdhPJxORFz8+uxcEeMqmif00hsBXABZprC7wNExOBK8tI1Vw3fwRZI2qlUPU6jEh98HY5uxsdvogA==
X-Received: by 2002:a17:90a:cc0b:: with SMTP id b11mr12101951pju.216.1616733027910;
        Thu, 25 Mar 2021 21:30:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q14sm7482326pff.94.2021.03.25.21.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 21:30:27 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:30:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v31 12/12] landlock: Add user and kernel documentation
Message-ID: <202103252130.C629319B86@keescook>
References: <20210324191520.125779-1-mic@digikod.net>
 <20210324191520.125779-13-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210324191520.125779-13-mic@digikod.net>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Mar 24, 2021 at 08:15:20PM +0100, Micka�l Sala�n wrote:
> From: Micka�l Sala�n <mic@linux.microsoft.com>
> 
> Add a first document describing userspace API: how to define and enforce
> a Landlock security policy.  This is explained with a simple example.
> The Landlock system calls are described with their expected behavior and
> current limitations.
> 
> Another document is dedicated to kernel developers, describing guiding
> principles and some important kernel structures.
> 
> This documentation can be built with the Sphinx framework.
> 
> Cc: James Morris <jmorris@namei.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Signed-off-by: Micka�l Sala�n <mic@linux.microsoft.com>

Thanks for the changes!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
