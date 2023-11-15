Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF887E4F5A
	for <lists+linux-security-module@lfdr.de>; Wed,  8 Nov 2023 04:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjKHDMi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 7 Nov 2023 22:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjKHDMi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Nov 2023 22:12:38 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F110F6
        for <linux-security-module@vger.kernel.org>; Tue,  7 Nov 2023 19:12:36 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-da7238b3eb4so5490464276.1
        for <linux-security-module@vger.kernel.org>; Tue, 07 Nov 2023 19:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699413155; x=1700017955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGQAU/F2NWyIFo06SHSGqSkCqe/uLciFGr239gofGyM=;
        b=dLiigb+G0iX3pOCOrfkkf28qO2Xs6Eu7wDRgDm1WJl2bXrIzwkiCNlpIL02VTFI5u8
         diuB//DonNPLggaurRe/Q0AwGqZ6PHPRcMqLqO1bZxdQMyLR7VtyEeMHOxSjGPEOdfOP
         3+DyscCMJ4fNuopDl6HVE5SRDKMZbIQV/aEdmYzxBw/8g89N+8bHwctpraAf1tdKH4Fp
         RAMf8r3jD7UW5VuuDkFOdY7ZmB5o+8bHo8i1ejYAR9oE2exzgOYUWHMagFYIyi6w8kPP
         X0hW7i9r5tIireUzY6COkOdRsCY/nCY6ZD8FblJiLXcvODnxLAzKeO6snj1I26VhIGwa
         DGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699413155; x=1700017955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGQAU/F2NWyIFo06SHSGqSkCqe/uLciFGr239gofGyM=;
        b=j7ckjpwxqVMhwmUX/y7ChFR0RbZzc/F/MuI8RemVBIy/8O7VOTKzGavRs9PEujfRnN
         OU2NNFKNCcUBDFVuNKiJM8RPb3fUP/oPE9Bg8jegpaiL86tBdThM1aF1QZLz2hLAIcJW
         /YvjjO8GkKxUqk0kFToBLJPPtz4XK8DoNoDw6aohFNN+cWDGRfOEKhFBq/8U74JSczW0
         NZ2ymdrN5xvfEW4zmB/oXsCgF8XGtuea9VTgLbE/gH1bC2FDFbVd5ohEJwWp7jPMVkff
         gL4en/AFdRoHBToGxeFbxmtlmnmxd4ngGPppSFdsaK0aj28PvX7J2qIqqaIoZg6HOvzI
         /8cA==
X-Gm-Message-State: AOJu0YyLmshzLNEuQYT06oFyudP0eHceYVS9dWbilVDbvUc97F+rtHbE
        mNiplZK1trs3kUeVlm0gJjEVa0c5L20f3O9cUuTC
X-Google-Smtp-Source: AGHT+IG5JhNEPymnvflV2fXuHIa5f+WUp+AIrXmdrAFnAR99bef08BA8r16AQwGdqkypAMD9zwdRfg/gvm7OLwAU2K8=
X-Received: by 2002:a25:c083:0:b0:d9a:c7af:bb4d with SMTP id
 c125-20020a25c083000000b00d9ac7afbb4dmr597877ybf.37.1699413155449; Tue, 07
 Nov 2023 19:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20231031123207.758655-1-omosnace@redhat.com>
In-Reply-To: <20231031123207.758655-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Nov 2023 22:12:24 -0500
Message-ID: <CAHC9VhRo2GzW0jSqmm0Sv3z_-q9PTsvScV5oQwF5uNh+ZcWreA@mail.gmail.com>
Subject: Re: [PATCH 0/2] lsm: fix default return values for some hooks
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 31, 2023 at 8:32=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Some of the default return values listed in <linux/lsm_hook_defs.h>
> don't match the actual no-op value and can be trivially fixed.
>
> Ondrej Mosnacek (2):
>   lsm: fix default return value for vm_enough_memory
>   lsm: fix default return value for inode_getsecctx
>
>  include/linux/lsm_hook_defs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

These both look like reasonable -stable candidates to me, what do you think=
?

--=20
paul-moore.com
