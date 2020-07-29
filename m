Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE1232398
	for <lists+linux-security-module@lfdr.de>; Wed, 29 Jul 2020 19:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2Rnn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 29 Jul 2020 13:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2Rnm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 29 Jul 2020 13:43:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C49C061794
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2020 10:43:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so12117438ply.11
        for <linux-security-module@vger.kernel.org>; Wed, 29 Jul 2020 10:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IpEGCE0q6wfkYpfpb/XDXdn9nS+GlD2TddAOE4NPPEI=;
        b=AeIC13m1PsJ9z1wydsneAxkveLemVv0ncScQ95F89DpbbaDUXaLs0ZekavY7hIqmcf
         1cn+yLjaDnBiXc55t/AK+wm85QCn3O3eCId3jp3rGWi9NiUN0pnHpzBedcNhBLblAu/m
         GlQQdatGAdDTMjuMRzH2l+Y5BJt32wYo9cFOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IpEGCE0q6wfkYpfpb/XDXdn9nS+GlD2TddAOE4NPPEI=;
        b=napkrlAlbeD2kR0z0z2k7bmHB6CR07tnLlMMQydEFgkEOEnRPbbx3qgyfouI4CP7Sm
         zLpv0imVRG75RWQWdMSb2KB3iePdyZh/bIERQOUmLe5Hi4Y/O46SlSC25iWJK+0B19sq
         WGLHDdmPvWFVRAWAqnDzWMLnguyjgzHxfIz+gn8FP2FeijCGfvU75b0gJnB0ijsiJH9m
         J8Amk35HizvFx19oh1T/v6Yc7lYBbxrucSOVHpG3EWFt5+NRRjhN6b2CSgX1HfUVYnLN
         021uFpygPR4dzeAms0uegCja1XmjgmL2E/ARBGkS8TCXZ5KUZFZMwpncuvxraJGE5+SJ
         R4AA==
X-Gm-Message-State: AOAM530Dtn0RZPh29q2xVUONbsqv5YdiksIV2OW8+xxJNMnKvUff9mhR
        TJR4ONLMbCzRTiRjXGJBQFENOg==
X-Google-Smtp-Source: ABdhPJxfv+PReysFLw6E6WSNkne32mRmLTJMCFDDzBnP6rL7W8en+DYYRDnVGx8rX3N+fPYgEFIppg==
X-Received: by 2002:a17:90b:112:: with SMTP id p18mr11067747pjz.92.1596044622171;
        Wed, 29 Jul 2020 10:43:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r77sm3226522pfc.193.2020.07.29.10.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:43:40 -0700 (PDT)
Date:   Wed, 29 Jul 2020 10:43:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/19] firmware: Add
 request_partial_firmware_into_buf()
Message-ID: <202007291042.D43AA4AB37@keescook>
References: <20200724213640.389191-1-keescook@chromium.org>
 <20200724213640.389191-19-keescook@chromium.org>
 <20200729011739.GL4332@42.do-not-panic.com>
 <s5ha6zig7s6.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha6zig7s6.wl-tiwai@suse.de>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 29, 2020 at 08:22:17AM +0200, Takashi Iwai wrote:
> On Wed, 29 Jul 2020 03:17:39 +0200,
> Luis Chamberlain wrote:
> > 
> > Long ago Takashi had some points about this strategy breaking
> > compressed file use. Was that considered?
> 
> As long as I read the patch, it tries to skip both the compressed and
> the fallback loading when FW_OPT_PARTIAL is set, which is good.
> 
> However...
> 
> > > @@ -771,18 +805,20 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
> > >  	}
> > >  
> > >  	ret = _request_firmware_prepare(&fw, name, device, buf, size,
> > > -					opt_flags);
> > > +					offset, opt_flags);
> > >  	if (ret <= 0) /* error or already assigned */
> > >  		goto out;
> > >  
> > >  	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
> > > -#ifdef CONFIG_FW_LOADER_COMPRESS
> > > -	if (ret == -ENOENT)
> > > +
> > > +	/* Only full reads can support decompression, platform, and sysfs. */
> > > +	if (!(opt_flags & FW_OPT_PARTIAL))
> > > +		nondirect = true;
> > > +
> > > +	if (ret == -ENOENT && nondirect)
> > >  		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
> > >  						 fw_decompress_xz);
> > > -#endif
> 
> ... by dropping this ifdef, the fw loader would try to access *.xz
> file unnecessarily even if CONFIG_FW_LOADER_COMPRESS is disabled.

Ah, good point. I'd added the -ENOENT fw_decompress_xz, but I take your
point about the needless access. I will switch this back to an #ifdef.

-- 
Kees Cook
