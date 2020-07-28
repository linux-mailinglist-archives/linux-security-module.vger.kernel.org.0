Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8B2312FA
	for <lists+linux-security-module@lfdr.de>; Tue, 28 Jul 2020 21:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732955AbgG1Tn7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 28 Jul 2020 15:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbgG1Tn6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 Jul 2020 15:43:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D90C0619D5
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2020 12:43:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k18so4325520pfp.7
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jul 2020 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9heSWvK+yRSCWH0FUufTfQBWh+umkfCd2hlFkX04++k=;
        b=nCLucWk+Dyfu97vMzTeRd0pPVzYtyDNd2u/hsiI1JS+JNzt9OPNMBUUcXoQPSNKzCE
         sxgq9zXhcvrt/uWcVzsLxXuu99WkVd+E7Uz7NHGi5XPz9/SV0mWz+0D0XANYFXj7lKbh
         hrtn+MCSjUVEebJjPSWPZJTk2J/1NZ5OuBXbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9heSWvK+yRSCWH0FUufTfQBWh+umkfCd2hlFkX04++k=;
        b=CIIMot6qXbZ4fKrfXIKd4kGmr2zYA0+Jk2dcqxA6CqheI1dhLuLA7UzAgFqMrTATx7
         53Ysxl94wmJKcxp4zTFP5QnzBM7z9slBTNUb1Lmgmvg1Fq98rER84jViTzfGkHvJe4Xq
         CEaFUFDj0KYG5gYvccBSaxE+C6toR/LRW8OJQkPUkji+VOZR5WfYja52G/iuGjjzg+kV
         bI6/h4I9qRbKHpHBwSD9iDRoT58ucyomVRVBkKVlSOepjcyxuIGM5S2VcCoX9xBRQrzN
         ByPJlVcdGBs6NndOqgeBhCs4t5xXeDvO8RSfAY+OlCHIuT8C1LIYSqkhOFWqquOJQ8oT
         NwAQ==
X-Gm-Message-State: AOAM530+I/+c4Yzg9d9w9wJ6aKMzY+LYWBiSzY1X9Hb46gtRxKH8HMdv
        wanIEChkvb3Evu6I+2fp6lOgbA==
X-Google-Smtp-Source: ABdhPJzcVT5J8m7X1MAMeqes9wtnmVepDmaePDEJZQmpUGLbzYqktl5qY3LrodPx5Xw/lg7qISDOhg==
X-Received: by 2002:aa7:8801:: with SMTP id c1mr25615711pfo.105.1595965438290;
        Tue, 28 Jul 2020 12:43:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m66sm10017751pfd.90.2020.07.28.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:43:57 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:43:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/19] firmware_loader: Use security_post_load_data()
Message-ID: <202007281242.B6016AE4B@keescook>
References: <20200724213640.389191-1-keescook@chromium.org>
 <20200724213640.389191-13-keescook@chromium.org>
 <1595847465.4841.63.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595847465.4841.63.camel@kernel.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 27, 2020 at 06:57:45AM -0400, Mimi Zohar wrote:
> On Fri, 2020-07-24 at 14:36 -0700, Kees Cook wrote:
> > Now that security_post_load_data() is wired up, use it instead
> > of the NULL file argument style of security_post_read_file(),
> > and update the security_kernel_load_data() call to indicate that a
> > security_kernel_post_load_data() call is expected.
> > 
> > Wire up the IMA check to match earlier logic. Perhaps a generalized
> > change to ima_post_load_data() might look something like this:
> > 
> >     return process_buffer_measurement(buf, size,
> >                                       kernel_load_data_id_str(load_id),
> >                                       read_idmap[load_id] ?: FILE_CHECK,
> >                                       0, NULL);
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> process_measurement() measures, verifies a file signature - �both
> signatures stored as an xattr and as an appended buffer signature -
> and augments audit records with the file hash. (Support for measuring,
> augmenting audit records, and/or verifying fs-verity signatures has
> yet to be added.)
> 
> As explained in my response to 11/19, the file descriptor provides the
> file pathname associated with the buffer data. �In addition, IMA
> policy rules may be defined in terms of other file descriptor info -
> uid, euid, uuid, etc.
> 
> Recently support was added for measuring the kexec boot command line,
> certificates being loaded onto a keyring, and blacklisted file hashes
> (limited to appended signatures). �None of these buffers are signed.
> �process_buffer_measurement() was added for this reason and as a
> result is limited to just measuring the buffer data.
> 
> Whether process_measurement() or process_buffer_measurement() should
> be modified, needs to be determined. �In either case to support the
> init_module syscall, would at minimum require the associated file
> pathname.

Right -- I don't intend to make changes to the init_module() syscall
since it's deprecated, so this hook is more of a "fuller LSM coverage
for old syscalls" addition.

IMA can happily continue to ignore it, which is what I have here, but I
thought I'd at least show what it *might* look like. Perhaps BPF LSM is
a better example.

Does anything need to change for this patch?

-- 
Kees Cook
