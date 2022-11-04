Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D2A61A005
	for <lists+linux-security-module@lfdr.de>; Fri,  4 Nov 2022 19:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiKDSeB (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 4 Nov 2022 14:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiKDSd5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Nov 2022 14:33:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BEA40936
        for <linux-security-module@vger.kernel.org>; Fri,  4 Nov 2022 11:33:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b185so5225635pfb.9
        for <linux-security-module@vger.kernel.org>; Fri, 04 Nov 2022 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cHlujkwLHQA1OWRlitXKA2okTr4nOrBSjZdPzF8hE5c=;
        b=fYGdM/Tg8Tza7nWYNx1gvE5AjwWtFIuP2aMr7NSPrgUEcKXetw2efj4K9ltVVjew/O
         hfXJ6HTPJXObLs10g0NdIXaQf1I9XXduYXsuLGv+V9dxSo0TvDryLnn2dlG70bCeTkio
         Mvw0wCqrgxfpNUxlYb3257rRnrsy7wsaQJrD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHlujkwLHQA1OWRlitXKA2okTr4nOrBSjZdPzF8hE5c=;
        b=jbM094Uyq0cRzWZi24l/MCP5XPImuBVw9KF2lMBURmXe6LU/fHfe3KCNrzhSSvkCup
         wHY2dIWF6YFNUXs4a7uqW4ZbzIybDnVkPsIFqyWqoBDSJeXwv+9GT/7YQ8lH6Dt0ESUb
         r9Xmw21iLSXpiARQS9+16UCEQIv/R9F2uwYFEcbcBnEmeXAOF5OmLa7Ek28aXyeDfmaA
         dCufNAY5BoObZsof2yLv72Z0XghQU2pwbhzxdx/PQQaMQEE6gqGa3MegVE3zwr8Jv4sI
         kVskIO7THmv1VPG7cQsZej0D5AGA2EPBWN/5/ZZOoE6Ay1K85Br8OCd8N1IWsqz8iGkE
         Yf3g==
X-Gm-Message-State: ACrzQf1VUsYHvZ8bKyNuREWxrIqI/UfaqR74Ad6DkAvJVmp1FI3zHhvd
        vkb+f97FekmEsfj8+PIo4RQigg==
X-Google-Smtp-Source: AMsMyM6rQqEYsHld7hqlGdxSuOaXH5JXb85iYTOBX6NHfyLfqeh7au3t/GuMFJWcTQ45Yl98zYA5gw==
X-Received: by 2002:a63:c65:0:b0:470:cb4:aca3 with SMTP id 37-20020a630c65000000b004700cb4aca3mr11424330pgm.389.1667586835979;
        Fri, 04 Nov 2022 11:33:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090a640800b00205fafa6768sm1990807pjj.6.2022.11.04.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 11:33:55 -0700 (PDT)
Date:   Fri, 4 Nov 2022 11:33:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>, jarkko@kernel.org,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 04/11] security: keys: trusted: Include TPM2 creation
 data
Message-ID: <202211041132.E8CB636@keescook>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Nov 03, 2022 at 11:01:12AM -0700, Evan Green wrote:
> In addition to the private key and public key, the TPM2_Create
> command may also return creation data, a creation hash, and a creation
> ticket. These fields allow the TPM to attest to the contents of a
> specified set of PCRs at the time the trusted key was created. Encrypted
> hibernation will use this to ensure that PCRs settable only by the
> kernel were set properly at the time of creation, indicating this is an
> authentic hibernate key.
> 
> Encode these additional parameters into the ASN.1 created to represent
> the key blob. The new fields are made optional so that they don't bloat
> key blobs which don't need them, and to ensure interoperability with
> old blobs.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>

There's a lot of open-coded math for the bounds checking. I didn't
immediately see any problems, but it'd be nice if there was a way to
hook a fuzzer up to this, or at least write some KUnit tests to check
boundary conditions explicitly.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
