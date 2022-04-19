Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84D505FDA
	for <lists+linux-security-module@lfdr.de>; Tue, 19 Apr 2022 00:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbiDRWqN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 Apr 2022 18:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiDRWqK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 Apr 2022 18:46:10 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4F2AC7D
        for <linux-security-module@vger.kernel.org>; Mon, 18 Apr 2022 15:43:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id k14so21479157pga.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 Apr 2022 15:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MWGw+I8Rgl/opd43ebHHMAj95ulAD46oHN9fU4DvNpo=;
        b=RJB5VJlfpWuoUefGZyScMaomY4DRb6B11jXnHXlNxpMYTpsSmgHEIex9Xu8XXZRhMQ
         KocBLzvItOgf2xNj9jTpA7/rQGDXuV0EG8bmfCAGh7Oy/K3ULN6eF6t+GDCYkML5TWax
         Ql+z6+pHnoM0e70w8R488SFOiSeaO77l0jXhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MWGw+I8Rgl/opd43ebHHMAj95ulAD46oHN9fU4DvNpo=;
        b=VbUJWZss7a9Tez1V0tlrNqKU7BKsLjr5Zoc3CfWSB66KxVtFL6cf0VbtOoiYpwXXXR
         qcxj0nJKSeD7CSJVjFKumqGMZDDIRfWytpDdMR3C58C5sPlcrsUSlHx10h0V+4QGA0kE
         3dMg/bBFF8Iso7ogkr3p217py22g250NC7D6/EG5pb3XeaRrubYdoKNn6ARTKmKeQpH9
         yGE4/FpXMY0grsyudL8FxnmyXV91mteccmxq6/0tMBr5ZcZNRUkwR4qylgXxvr9hSn8z
         3r6CXN6M0d26nOvLV050O3xeTyQd+MQbllK0G47SzrSZeFRwHpCHddPwPpQVgTkvV7gd
         1M0A==
X-Gm-Message-State: AOAM533JP+w13XpPNbekrIUfm4AaqkU4nDDOC93UGIAX9Butgu8rEhcK
        DFGlT3HcJ45GWJUoj7dmvhkLLA==
X-Google-Smtp-Source: ABdhPJzCwRyTVg95a0VNni8DDkvimLaSN54/K64RZIVo/TLCFqUrkHEvTzI8UPMiQhfcOb3Sebf+WQ==
X-Received: by 2002:a63:5013:0:b0:399:5816:fd0d with SMTP id e19-20020a635013000000b003995816fd0dmr11795301pgb.68.1650321809394;
        Mon, 18 Apr 2022 15:43:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b32:a0a5:ec32:c287])
        by smtp.gmail.com with UTF8SMTPSA id e13-20020a63370d000000b003810782e0cdsm14078821pga.56.2022.04.18.15.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 15:43:28 -0700 (PDT)
Date:   Mon, 18 Apr 2022 15:43:27 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        linux-security-module@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>, dm-devel@redhat.com
Subject: Re: [PATCH 0/3] LoadPin: Enable loading from trusted dm-verity
 devices
Message-ID: <Yl3pj72hM/Bo+Kf5@google.com>
References: <20220418211559.3832724-1-mka@chromium.org>
 <202204181512.DA0C0C6EBD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202204181512.DA0C0C6EBD@keescook>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Kees,

On Mon, Apr 18, 2022 at 03:14:14PM -0700, Kees Cook wrote:
> [oops, resending to actual CC list]
> 
> On Mon, Apr 18, 2022 at 02:15:56PM -0700, Matthias Kaehlcke wrote:
> > This series extends LoadPin to allow loading of kernel files
> > from trusted dm-verity devices. It adds the concept of
> > trusted verity devices to LoadPin. Userspace can use the
> > new systl file 'loadpin/trusted_verity_root_digests' to
> > provide LoadPin with a list of root digests from dm-verity
> > devices that LoadPin should consider as trusted. When a
> > kernel file is read LoadPin first checks (as usual) whether
> > the file is located on the pinned root, if so the file can
> > be loaded. Otherwise, if the verity extension is enabled,
> > LoadPin determines whether the file is located on a verity
> > backed device and whether the root digest of that device
> > is in the list of trusted digests. The file can be loaded
> > if the verity device has a trusted root digest.
> > 
> > The list of trusted root digests can only be written once
> > (typically at boot time), to limit the possiblity of
> > attackers setting up rogue verity devices and marking them
> > as trusted.


> Thanks for working all this out! Where does the list of trusted
> roothashes come from? I assume some chain of trust exists. Is the list
> maybe already stored on the rootfs?

Yes, at least the content of the list comes from the rootfs. The
userspace part is still TBD (also pending on the evolution of this
patchset), having the list pre-formatted in a single file on the
rootfs should be fine.

> It'd be nice if there was some way to pass the trust chain to LoadPin
> more directly.

I imagine you envision LoadPin reading the file itself, instead of
just processing the content. That should be doable. One option would
be to pass the path of the file with the hashes through the sysctl
file and use kernel_read_file_from_path() to read it if the path is
in the pinned root (or maybe even in any trusted file system ;-)
