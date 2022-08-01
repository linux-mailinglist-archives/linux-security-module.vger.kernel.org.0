Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14F58743D
	for <lists+linux-security-module@lfdr.de>; Tue,  2 Aug 2022 01:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiHAXGU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 1 Aug 2022 19:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbiHAXGT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 1 Aug 2022 19:06:19 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B82A420
        for <linux-security-module@vger.kernel.org>; Mon,  1 Aug 2022 16:06:17 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w72so10386828oiw.6
        for <linux-security-module@vger.kernel.org>; Mon, 01 Aug 2022 16:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rFaG78hGppqyEaV7sglOcQ+vFBt1MT2K6UHXnsijDug=;
        b=0gpOV2jR9Ldyi7tWjReQ6fHVuZkXi246dTuVekkLE+udpqmfspyyVLV1/zMWAChxc2
         1Ac+d3ITcUQnvPOO7CPt7aVGZa8CfqGOI6sNHCIcsZZnbWq74mAANt7OyqDleRsvdqzL
         YshLVoEhtsghq6x/JkRJvx9rq1ZImRE9esUruyh0fXKTIiSDj0GJLswrLKDp2ersZB8F
         Hu0atpgTHkw0Zi1lKmC2zz5Y4/LG82SL0GX+pwK1VWmiDRPPvrKP1JhVS/xCSLYLwmzy
         909xLAh8M/2hvLyflN9Sq5ICwKhSKT2w2m7GIIJqqQNUukxqnyJ2+ypTBIGq0DJXYWpa
         uUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rFaG78hGppqyEaV7sglOcQ+vFBt1MT2K6UHXnsijDug=;
        b=AS0UHQyY7FCGao9R+DZcus1Sxd4NPeW3YRJ/xWafCrj1ywylpPVApi95kMupW0vPVx
         zqQetO+54/NaVmSeBBU1gMR7kjKHHExE+YxK/MTQtH7uLO1rkGlQ672xv9Ptdm1HbRIN
         0SIldumLerdx4e3dsEctKkkpGY0xW6v+EhGbxLuGsMQ9bK3p+rpHJm3Gom7uUObuV8X7
         jefUILPDy8xN9SNoX0jfooM0P9uYPNQGJOxoJvH2dlDze/0wzqAN0Ab5JLnHpA3ZNzav
         meq6TbxgYj8gTAyPRf3IcJ9SQw+C7gXmH8nU9AsCvP6TEeLNAlrFnhjVdwfx1HiUPyAT
         8c+Q==
X-Gm-Message-State: AJIora8fd5D0sUYHO7F7kRboAOrQqUJYg5wDa/UyFmKRiDJ1ErOjjDhE
        8Vfryd08ce32jG5/QhU1vXqPU4d8IJdDmOj5i+nd
X-Google-Smtp-Source: AGRyM1tW7X8dx4hifAe/n9Vs8A9hR+7H3zIyRYozgA1dH3CB2MVrmhq+7tur1N9HEi6/m2TV1SRxSL/FTg0L+UrrDgo=
X-Received: by 2002:a05:6808:2389:b0:33a:cbdb:f37a with SMTP id
 bp9-20020a056808238900b0033acbdbf37amr7455375oib.136.1659395176996; Mon, 01
 Aug 2022 16:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <20220801180146.1157914-3-fred@cloudflare.com>
 <20220801230030.w4rgzlncgdrcz7q2@macbook-pro-3.dhcp.thefacebook.com>
In-Reply-To: <20220801230030.w4rgzlncgdrcz7q2@macbook-pro-3.dhcp.thefacebook.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Aug 2022 19:06:06 -0400
Message-ID: <CAHC9VhQZAdpQuWu7nHtGq2EtSyD=16awQ5p46Wz6Xd2Mwoew4A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] bpf-lsm: Make bpf_lsm_userns_create() sleepable
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        ebiederm@xmission.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@cloudflare.com,
        cgzones@googlemail.com, karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Aug 1, 2022 at 7:00 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 01, 2022 at 01:01:44PM -0500, Frederick Lawler wrote:
> > Users may want to audit calls to security_create_user_ns() and access
> > user space memory. Also create_user_ns() runs without
> > pagefault_disabled(). Therefore, make bpf_lsm_userns_create() sleepable
> > for mandatory access control policies.
> >
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
>
> We can take this set through bpf-next tree if it's easier.

Thanks Alexei, but I'm currently planning to merge it into the LSM
next branch once the merge window closes.

> Or if it goes through other trees:
> Acked-by: Alexei Starovoitov <ast@kernel.org>

I appreciate the review/ACK, would you mind reviewing the tests too (patch 3/4)?

-- 
paul-moore.com
