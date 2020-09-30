Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954DF27EA2C
	for <lists+linux-security-module@lfdr.de>; Wed, 30 Sep 2020 15:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgI3NoP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 30 Sep 2020 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729663AbgI3NoP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 30 Sep 2020 09:44:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF066C0613D1
        for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2020 06:44:14 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qp15so1980093ejb.3
        for <linux-security-module@vger.kernel.org>; Wed, 30 Sep 2020 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uv+0SEm3ZBbuCilDEG/CT4tZmdLu+h9w/O+Bpd1VJEw=;
        b=kZXhuwkp+0Pj2nq+Wdm8mrhdY9dD6koq1af5Fk5s6iJWJreLo6FGGg++D7B+iF2Z16
         Gc9IuJzNwpLIbJBk14f/+KcHO4zb07BLd3JdWWZ/6Sq53QRfNWGgZnNYraOqYw+NaV/S
         Oa52DvX7NZE2OAQai8XFn19vQRqJ7DZCWAYCPzunUkclSon5s8WuKyspntOGXBUGi+kM
         gSQSDp6Ih1tOXtz8Jfo8XC+2RHN6ucdjBH/ZZAh5bB8x9kBEAQie6wWnc+SvOSu9cFkb
         00sAviQPAdrFOZOxV0PZQ7ktzrj1OS69sEMG7wsu9RcsJSPo9XGLG0Ver4XX44A5fflG
         WC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uv+0SEm3ZBbuCilDEG/CT4tZmdLu+h9w/O+Bpd1VJEw=;
        b=kO8+bCDQA4uJB6+sOEP7C5rOA1IVZ+JXl2NTO/YQn0VdecKEFgXyUOAFSwq9ALD/8N
         TfBamg28XHliTWPME3p2UCrIvUmurW1x17RSnsdz/bUVA45H5NDPFbg/MWOj6YR5JD9O
         Xii7JM0VLt5cGVc4u5i28QpDG12frntVWn9XW2IQZh2VnPeQiAYUbpuw2JlqeYNHIisC
         vTpREfll0IjDXmsfhqDipTncFRF8dLW284OVDECvIz6y3Xk33PcHAdHriP5Lgbur9UKm
         sOGfc5AxJOT3uSv0bqyqCK5yfhopnjNyPcIlSdHOS7qJc6WH8TKwDb+QhW8cAK/XQGhl
         WULw==
X-Gm-Message-State: AOAM532XF11aeFsmPeemyBqCh9VOzba+W24G3VqzskoEJEi0v3kc6Vqu
        javYDj9qIESyrrEEE6P82T9/vKnHK9JpSXZmrUrHsY987O5t
X-Google-Smtp-Source: ABdhPJyIyHapkdpsMZlH1k0VMzFpSD2bBOeAOJPN9zjb137yZwO+lFN8UEOnqZPlBqsUFSYFjZaRiRi8PRSDcuT8Xyg=
X-Received: by 2002:a17:906:77cd:: with SMTP id m13mr2817282ejn.106.1601473453339;
 Wed, 30 Sep 2020 06:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <160141647786.7997.5490924406329369782.stgit@sifl> <alpine.LRH.2.21.2009300909150.6592@namei.org>
In-Reply-To: <alpine.LRH.2.21.2009300909150.6592@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Sep 2020 09:44:02 -0400
Message-ID: <CAHC9VhTM_a+L8nY8QLVdA1FcL8hjdV1ZNLJcr6G_Q27qPD_5EQ@mail.gmail.com>
Subject: Re: [RFC PATCH] lsm,selinux: pass the family information along with
 xfrm flow
To:     James Morris <jmorris@namei.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Sep 29, 2020 at 7:09 PM James Morris <jmorris@namei.org> wrote:
> I'm not keen on adding a parameter which nobody is using. Perhaps a note
> in the header instead?

On Wed, Sep 30, 2020 at 6:14 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> Please at least change to the struct flowi to flowi_common if we're
> not adding a family field.

It did feel a bit weird adding a (currently) unused parameter, so I
can understand the concern, I just worry that a comment in the code
will be easily overlooked.  I also thought about passing a pointer to
the nested flowi_common struct, but it doesn't appear that this is
done anywhere else in the stack so it felt wrong to do it here.

-- 
paul moore
www.paul-moore.com
