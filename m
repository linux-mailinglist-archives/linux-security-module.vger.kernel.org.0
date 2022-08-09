Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3810358E354
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Aug 2022 00:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiHIWk2 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 9 Aug 2022 18:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHIWk0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 9 Aug 2022 18:40:26 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2075C9D5
        for <linux-security-module@vger.kernel.org>; Tue,  9 Aug 2022 15:40:25 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10dc1b16c12so15758870fac.6
        for <linux-security-module@vger.kernel.org>; Tue, 09 Aug 2022 15:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1P7bSaIcMszYR+JCa8vqV0slOGBPYXltybusx5DtRDM=;
        b=ymJZNj+3ZRh6BJ8sdJOKWq3WWbUkXw6pah7LZ66RWLPU/lUKblHjIWaSbD/M/HlxZG
         XvRNSo3oVXm145SSS41Ho65tqsFjNeoaSyRIP0bW6D/OrQGUY/gDwhF2RxO+RUiMyfX8
         raLd9fpQ1xyculvAnmt5+WPihY3ElIT/hyo2mQADbhYzhsin1meT8LB/8oVNtwdYglR2
         8BXLy2uW5Fa5RgTdW9YWJ9qrdQxzYFC7yR7a+zVgLQlWAzRxP+H9g8KpL7B+wKqVG4DB
         gCXguHSRTkIZ5oafCKhLHLSwYLU2AXjEnpPWXLLbU4c91UgqdOJ2Ccc/AD0eJ2fxHc/n
         nDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1P7bSaIcMszYR+JCa8vqV0slOGBPYXltybusx5DtRDM=;
        b=p03JoTLNbOaNkPplstTQGt9sgmcWcO7Dq++8oAFPIX7sJY9oWYzOi7RrCdR2WuZJ2z
         TJMZHnE1Jz0SS9OaIQ+8C+ax4XTxlI5iD3NFiYVUebZW8VaPGDOdcf/cbXT1L56lsdfp
         MTgf+Xsie8mHWM+WW8qzcpv86ymIVTwbqkE13Tp+Yh0ZOEmylVZ8hOZxJv3G7WlGosKX
         UczJjaEdUfQspRafcyxq6owScL5pgE+Li6BIUXWUKgbreBILxzcqsznML0n/Ih243u2I
         vkLyFuBp1H5vR9IXsJRKlRU65+YBK2zi53cHB3hwDNFVlE0BW6U8+/sCTMRnCTybhBA5
         IKVA==
X-Gm-Message-State: ACgBeo1VT3ssas/GhQw/WHSo5ZNYTv6SzGSyAKAMRRoDWezPp3F4FZ36
        +mSG7Enx+k+xnQ+OtTQg8lGcpMlHk2hJaAmdH5wd
X-Google-Smtp-Source: AA6agR4ClJpq8r9ZKoAk/K/rs8TO1cCIg6yZNX6VC6EIP7MbESfv7l10f5WE4D8xn0xBGSvYXyQ13bhBRsm1jf8wpUM=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr292354oao.41.1660084825048; Tue, 09 Aug
 2022 15:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <87les7cq03.fsf@email.froward.int.ebiederm.org>
 <CAHC9VhRpUxyxkPaTz1scGeRm+i4KviQQA7WismOX2q5agzC+DQ@mail.gmail.com>
 <87wnbia7jh.fsf@email.froward.int.ebiederm.org> <CAHC9VhS3udhEecVYVvHm=tuqiPGh034-xPqXYtFjBk23+p-Szg@mail.gmail.com>
 <877d3ia65v.fsf@email.froward.int.ebiederm.org> <87bksu8qs2.fsf@email.froward.int.ebiederm.org>
 <CAHC9VhTEwD2y9Witj-1z3e2TC-NGjghQ4KT4Dqf3UOLzDcDc3Q@mail.gmail.com>
 <87czd95rjc.fsf@email.froward.int.ebiederm.org> <CAHC9VhQY6H4JxOvSYWk2cpH8E3LYeOkMP_ay+ih+ULKKdeob=Q@mail.gmail.com>
 <87a68dccyu.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87a68dccyu.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 9 Aug 2022 18:40:14 -0400
Message-ID: <CAHC9VhRkHuwjrtOoK+vn9zzERU2TM_2PEbQGRAZsr-D1pFv9GQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Introduce security_create_user_ns()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Aug 9, 2022 at 5:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> >
> > What level of due diligence would satisfy you Eric?
>
> Having a real conversation about what a change is doing and to talk
> about it's merits and it's pro's and cons.  I can't promise I would be
> convinced but that is the kind of conversation it would take.

Earlier today you talked about due diligence to ensure that userspace
won't break and I provided my reasoning on why userspace would not
break (at least not because of this change).  Userspace might be
blocked from creating a new user namespace due to a security policy,
but that would be the expected and desired outcome, not breakage.  As
far as your most recent comment regarding merit and pros/cons, I
believe we have had that discussion (quite a few times already); it
just seems you are not satisfied with the majority's conclusion.

Personally, I'm not sure there is anything more I can do to convince
you that this patchset is reasonable; I'm going to leave it to others
at this point, or we can all simply agree to disagree for the moment.
Just as you haven't heard a compelling argument for this patchset, I
haven't heard a compelling argument against it.  Barring some
significant new discussion point, or opinion, I still plan on merging
this into the LSM next branch when the merge window closes next week
so it has time to go through a full round of linux-next testing.
Assuming no unresolvable problems are found during the additional
testing I plan to send it to Linus during the v6.1 merge window and
I'm guessing we will get to go through this all again.  It's less than
ideal, but I think this is where we are at right now.

-- 
paul-moore.com
