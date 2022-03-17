Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4D4DBC73
	for <lists+linux-security-module@lfdr.de>; Thu, 17 Mar 2022 02:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356017AbiCQB3A (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 16 Mar 2022 21:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358313AbiCQB2x (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 Mar 2022 21:28:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862281EC45
        for <linux-security-module@vger.kernel.org>; Wed, 16 Mar 2022 18:27:07 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w25so4787192edi.11
        for <linux-security-module@vger.kernel.org>; Wed, 16 Mar 2022 18:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IwLQkBh4p0/MlSYiHpWT3LVO0kaAxEAmEy894o/lBAk=;
        b=QdGLAG/PyeyxYlxilJap5GzmvukNm9ZyaNle+oQe0mlud/4tIh33bGgDrnbfokq8TF
         F9vCY5oAoVAw27hbBDaVi10giHe9AaBACGopJfFZEWxXZ+JV5uCfLUV+/ThB1ed7KCQL
         BtJ6KCb32sqFuKw4m38aGiOIG0cIFsZfscm+r+ln3NZbj3+lJ8HF/Lr/aHFretDA3iCo
         SbKdB/Wvso3rIipXfznYMJXlw0iee767ymYRJOQJPJ9RmCtJp3KU9hazCS33LSbJzppD
         0qpNvkPu8cAWp2XTC4m9y1SkYzQnGBm4ifo+EGKF58wtYT0q+BmjeKr/VDTu4EPe+M8x
         HuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IwLQkBh4p0/MlSYiHpWT3LVO0kaAxEAmEy894o/lBAk=;
        b=kOeB9tz8bit2Z0+NG4EL6IameeYCck/R8MUeNoUQXlwYH1GY65ueWLHLIqF6qigl6U
         mgAkeMxyP2RtaIgTEGIUDQPYldL/fFRAZXZ09RV7bf9h7bo4pjT8jHubAxxOBVCuftVX
         OGm737ZaNl8vqk1Qgkan+F8RjznsfmxkG1lGp9/FuNX3TfczL/WocpMAoUy5sfECRN70
         1hdALSbzsJMuQQqsVxOw82chSGSDtNeBjUtMj9czjBLekqV2M6XE2ORNV6jFVIHbcheK
         65Hmu+Ll9H1vcH1WobdkkSifedoRNuXrLH3zSba+OLkk0quLJAj9wToxmLeTDNkuIGm0
         4ghQ==
X-Gm-Message-State: AOAM533vzcPROt/jdxgNLEybmtN9Fv7mxTvR5pqZUw+shSdOU2rhAIk9
        XKw+nhDYE0/RVUu3N8XC5P36sLaupRXw1ZfX8w6S
X-Google-Smtp-Source: ABdhPJwngiMDrHlrSoWnA729RQinXoUDLUX6Mk3PvLSB5d+1UKewSWcwwlpQVbmesK3RoQZPw/mnWOtGWK0iz+LG5iM=
X-Received: by 2002:a05:6402:2552:b0:416:a745:9626 with SMTP id
 l18-20020a056402255200b00416a7459626mr2022463edb.405.1647480426068; Wed, 16
 Mar 2022 18:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220221212522.320243-1-mic@digikod.net> <20220221212522.320243-9-mic@digikod.net>
In-Reply-To: <20220221212522.320243-9-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Mar 2022 21:26:55 -0400
Message-ID: <CAHC9VhRwOfCN3BWVguiM7smVg7Rs9SrQsBZP-wwtFQ-b=gidUQ@mail.gmail.com>
Subject: Re: [PATCH v1 08/11] samples/landlock: Add support for file reparenting
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Feb 21, 2022 at 4:15 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> Add LANDLOCK_ACCESS_FS_REFER to the "roughly write" access rights and
> leverage the Landlock ABI version to only try to enforce it if it is
> supported by the running kernel.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220221212522.320243-9-mic@digikod.net
> ---
>  samples/landlock/sandboxer.c | 37 +++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>


--
paul-moore.com
