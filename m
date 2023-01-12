Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624196685CA
	for <lists+linux-security-module@lfdr.de>; Thu, 12 Jan 2023 22:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjALVrI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 12 Jan 2023 16:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbjALVqm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 12 Jan 2023 16:46:42 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E090A6C7F2
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 13:39:22 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q9so13698951pgq.5
        for <linux-security-module@vger.kernel.org>; Thu, 12 Jan 2023 13:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2G1ZoEYxGQpgfk9wwUZHFbGRL7cXxq7vSTyyjT2OdrE=;
        b=RL/4iEJmfTC51uP/4p2GTfep3Y9t1w6elQSazYFdY6QRYSjvTppjQIpOtNDtKDpcU4
         RUnDv+CeLUjRJGhYrULLlWDGf5ASBUqttj5zeSF8e0GYaUhurhvZvjzRMwanhoso4Zt5
         xY9GvqZnkHeaPkspRHFqz/HyeFIEeGEK/5j2FjzK5+cDXS2ZVC9kwN8Fzq1mDhHn1VIc
         RIpbrvIno2AM2/KDwlxl33qz/rqJXf54CWA9Ev4bYIk8V20fX7Ecc7F6B6dkSgROnArh
         TU6zSQZXyKKu1ev3rpwvAwCwMnDwLIY0jVQBFpLHsw5zvVFLjR7AP86rlaTN0sddoeoo
         IPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G1ZoEYxGQpgfk9wwUZHFbGRL7cXxq7vSTyyjT2OdrE=;
        b=6EN282WIWEF0LZnLRV86LZ5C4i7AqcImKEMQlDx1tVyX03Ti1uFsLQ7PnL6XhP5Usj
         2m4p0tAGFm8D1WZTnxc4lGjF5FfqBH+vHPdW34VgjqvQ1f6K7ccWSPou0nH2Rc8L+cfe
         anb1Cm6OdldhD/ITvNiG1Er/6p9OSPbQ2VxMRqLTbp0IJqs3TqXoqxb0bCkpnxTWVX1G
         mUDuziaB8NULDAQ7KhcUU+k/BCastkcdVaHM0duYVkZCd9PpH7qi20dn/u5SFNESSA/6
         8dsx0ofGgu6nKQy31keLZ+ctH10Ir0/ZBMjJIB7iql0kd5mgBMUTL39fUkotOxxRLeML
         li2Q==
X-Gm-Message-State: AFqh2kp0XOASallOFktbCoZKxW7p4zoS0znc4CUEBVLvxpJFJXRR0miY
        Vf6KFASsj3QZZRRjjfV7OGb1cilw+5AEFivfqHQa
X-Google-Smtp-Source: AMrXdXvBOTxwky5Htp9NUFLASZ+yHQHATlj3a7gvPm0oPR4fxSDvOYBoiF6PzmjXfwgALYXvizdMhkJbqqi76Nf1MKg=
X-Received: by 2002:a62:158f:0:b0:588:e66e:4f05 with SMTP id
 137-20020a62158f000000b00588e66e4f05mr1366618pfv.23.1673559562029; Thu, 12
 Jan 2023 13:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20230109180717.58855-1-casey@schaufler-ca.com>
 <20230109180717.58855-5-casey@schaufler-ca.com> <f8dca9d2-6e5e-4584-88b3-f71f62988dab@app.fastmail.com>
In-Reply-To: <f8dca9d2-6e5e-4584-88b3-f71f62988dab@app.fastmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Jan 2023 16:39:10 -0500
Message-ID: <CAHC9VhRRRo9V-q8jT7AbSh1eTPGN7OmxP9hrPz=GTPQa80RjCg@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] LSM: lsm_get_self_attr syscall for LSM self attributes
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, Kees Cook <keescook@chromium.org>,
        john.johansen@canonical.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jan 12, 2023 at 9:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 9, 2023, at 19:07, Casey Schaufler wrote:
> > +/**
> > + * struct lsm_ctx - LSM context
> > + * @id: the LSM id number, see LSM_ID_XXX
> > + * @flags: context specifier and LSM specific flags
> > + * @ctx_len: the size of @ctx
> > + * @ctx: the LSM context, a nul terminated string
> > + *
> > + * @ctx in a nul terminated string.
> > + *   (strlen(@ctx) < @ctx_len) is always true.
> > + *   (strlen(@ctx) == @ctx_len + 1) is not guaranteed.
> > + */
> > +struct lsm_ctx {
> > +     __u32           id;
> > +     __u64           flags;
> > +     __kernel_size_t ctx_len;
> > +     __u8            ctx[];
> > +};
>
> I think this should be changed to be the same layout on
> all architectures regardless of __u64 alignment and
> sizeof(__kernel_size_t) differences, to avoid the need
> for compat syscalls and explicit clearing of the
> internal padding.
>
> Maybe just use __u64 fields for all three integers?

I have no problem with that ... the ctx[] field is variable length
anyway so keeping it as a __u8 should be fine.

-- 
paul-moore.com
