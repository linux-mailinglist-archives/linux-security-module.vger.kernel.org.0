Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B365A0078
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Aug 2022 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239978AbiHXRfC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 24 Aug 2022 13:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbiHXRfA (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 24 Aug 2022 13:35:00 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC525B06D
        for <linux-security-module@vger.kernel.org>; Wed, 24 Aug 2022 10:34:59 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w197so20205315oie.5
        for <linux-security-module@vger.kernel.org>; Wed, 24 Aug 2022 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iUc7iTn6xTAH7nh/o6yxXHdfKGNX4Z/5Jv6PbbsrmvE=;
        b=RlaeiBa5eL8zu0NgF7ARiV93OK31F7GkkyowxpdoTtVaIt6Yd6AwdmZeT4UhqxTOir
         TaQbTq0RY8Y6y+tGLDAhuRgnPvpdkEIOG/XPkwF4v5NCae8dReQI9E0ZTHaROIT2w45q
         f9sqGu0D99xgh/NvOUXrlPA/eOIMcCfk0srM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iUc7iTn6xTAH7nh/o6yxXHdfKGNX4Z/5Jv6PbbsrmvE=;
        b=KcowKatfRtvBWvAIYd3V7pLNvAQ7KKHOSxl7fEPkvSdrx1nuHyuMeJbshqdr4w4J6/
         SZ6QK3oWmhM8j2Oq+OHHWglSYUT0r+R0emADlJ7bTXqQpGJP89STUcWcS9zMRdhtXgqt
         9iLxp8SMi4zuJGOmNuad1t2+PMkJ1Zch3EpEwVlvFTxjARfbOXWaCqVQB0Eb2TLUOz0J
         gGKC4WvenpSpsaNzLXhDVwSFGBzNcVaBVh9rAZjh9j7PrTaBVMkYDq/7l0y13rXRUyiw
         LZBCcoXuPyGacxIfMaGbrTR4dZm/YCvqq3kCgzY8LelRgpBsIGfJcY2TRVdWNIWsVjxg
         qdyg==
X-Gm-Message-State: ACgBeo2Y1Wzl1dCHy7YSLvOEyUQ5ptLPg1Z9DjbHzCVUG9q5AKZc2wzw
        kWWym/W6uD/FDzZdissotk0Qt9J5D1ISKQ==
X-Google-Smtp-Source: AA6agR5VNR2Vot4+Yr/31eLnSnFwPvX+X3dB7C3AUC1SuITsH0PVIKfAVLgm/gYhCmwtwZBYzRHVlA==
X-Received: by 2002:a05:6808:d4d:b0:344:863a:36fb with SMTP id w13-20020a0568080d4d00b00344863a36fbmr3858916oik.235.1661362498836;
        Wed, 24 Aug 2022 10:34:58 -0700 (PDT)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com. [209.85.160.43])
        by smtp.gmail.com with ESMTPSA id r143-20020a4a3795000000b0044a8f5f87a9sm3921765oor.16.2022.08.24.10.34.58
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:34:58 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-11c4d7d4683so21713740fac.8
        for <linux-security-module@vger.kernel.org>; Wed, 24 Aug 2022 10:34:58 -0700 (PDT)
X-Received: by 2002:a05:6808:3096:b0:342:ff93:4672 with SMTP id
 bl22-20020a056808309600b00342ff934672mr120785oib.174.1661362486729; Wed, 24
 Aug 2022 10:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.4.I32591db064b6cdc91850d777f363c9d05c985b39@changeid> <YwYR/rzvrkvgZzBm@farprobe>
In-Reply-To: <YwYR/rzvrkvgZzBm@farprobe>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 24 Aug 2022 10:34:10 -0700
X-Gmail-Original-Message-ID: <CAE=gft48Tg6NnEUqfM-n1eOT3qa35dtowQGYCL3sbYBmr_Wm_w@mail.gmail.com>
Message-ID: <CAE=gft48Tg6NnEUqfM-n1eOT3qa35dtowQGYCL3sbYBmr_Wm_w@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] security: keys: trusted: Allow storage of PCR
 values in creation data
To:     list.lkml.keyrings@me.benboeckel.net
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Jarkko Sakkinen <jarkko@kernel.org>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 24, 2022 at 4:56 AM Ben Boeckel <me@benboeckel.net> wrote:
>
> On Tue, Aug 23, 2022 at 15:25:20 -0700, Evan Green wrote:
> > diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> > index 0bfb4c33974890..dc9e11bb4824da 100644
> > --- a/Documentation/security/keys/trusted-encrypted.rst
> > +++ b/Documentation/security/keys/trusted-encrypted.rst
> > @@ -199,6 +199,10 @@ Usage::
> >         policyhandle= handle to an authorization policy session that defines the
> >                       same policy and with the same hash algorithm as was used to
> >                       seal the key.
> > +       creationpcrs= hex integer representing the set of PCR values to be
> > +                     included in the PCR creation data. The bit corresponding
> > +                  to each PCR should be 1 to be included, 0 to be ignored.
> > +                  TPM2 only.
>
> There's inconsistent whitespace here. Given the context, I suspect the
> tabs should be expanded to spaces.
>
> As for the docs themselves, this might preferrably mention how large
> this is supposed to be. It seems to be limited to 32bits by the code.
> What happens if fewer are provided? More? Will there always be at most
> 32 PCR values? Also, how are the bits interpreted? I presume bit 0 is
> for PCR value 0?

Makes sense, I'll pin down the specification a bit better here and fix
up the spacing.

>
> Thanks for including docs.

Thanks for looking at them!

-Evan
