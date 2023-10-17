Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B67CCA1A
	for <lists+linux-security-module@lfdr.de>; Tue, 17 Oct 2023 19:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjJQRqs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 17 Oct 2023 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQRqr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 17 Oct 2023 13:46:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AFB9E;
        Tue, 17 Oct 2023 10:46:45 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53e84912038so5209798a12.1;
        Tue, 17 Oct 2023 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697564804; x=1698169604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTJcOzkVSYuq3kdfWyM6/478vxCOCOP6lLPkJ2SdCTM=;
        b=W0eBRw7pPBw0LgH7eY75+XKjNwPp6qARg0GYJU1DBzYzRycL2nFcUHueMOW0NjR94r
         iMptzkXIt03mGzygTNRBXA1k4f9D5GtxhdUOvGExTXpIIEtnkKVnrzMzoOq2Ohxcnjpu
         TQTmbHY7isk53BAEgL5M6xITC8UF6TK3o2Eyoii6apY1QXqEZHGO9TrOOn7XD0hcLDE1
         xNsOE2qsMudG3Gd4YDXu5W6v7GBgb3QF1hVZ5EhP7R8DxFGqj+2LgwJZYyGeY+ZW7guG
         jFDaQccXS+mDbxpgT8jQJB5/vNX7Cq4naPyLx/xJd+gHoKAvBDy5XgapNAMG6v7Su22f
         jQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697564804; x=1698169604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTJcOzkVSYuq3kdfWyM6/478vxCOCOP6lLPkJ2SdCTM=;
        b=nIOgyr587rGbEWtdGa15D+x4ASLnnrF5zV4xgPqaDNZd8x2VMJ4/o9Ia3IsR/Ltpa7
         WfhHTT/B1AQ0Ttgh0f+t9Ph0IGmXz8kEKZsOgEgIp//Lap/nitPxorPW5C8ZzpvzaoqX
         JeFhZWiXgQIwNlR8H0pSmythe6tOasYQwx5lXObgFrMpU9Z3RtHP5gVdzw1nWbpHjwaz
         hldcrwQsn9mmjXI+hqV3FGkLG7aC6v4UZX2jRInsprgXcdHw/FNkoKj1CT69CT+x+q3g
         gHVH9ulkwzzAyeKOljg9a47OpgEgow8dRHt1n22GvMZIFxfvAyj64s6l0FCWZxlFJnf0
         a3xw==
X-Gm-Message-State: AOJu0Yy8B0KjElDHJ7m05m6Krpe99/x9gta5Brye3Jz/owNERzhGIr1I
        OJ4hdLD0N9DxwGtOedCrfAw9Go2xkXhDTStrYKM=
X-Google-Smtp-Source: AGHT+IF5SdawNji0JQ5EenvvwzkSH87GiKHVfD8DHFgGHgtaMPq9u4MQVqu7f7GBxWz3XY3Y2YEWNPJNHJ+Djc05Tfg=
X-Received: by 2002:a05:6402:2314:b0:53d:b839:2045 with SMTP id
 l20-20020a056402231400b0053db8392045mr2345712eda.25.1697564803833; Tue, 17
 Oct 2023 10:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231016180220.3866105-10-andrii@kernel.org> <202310172156.zcehiHbq-lkp@intel.com>
In-Reply-To: <202310172156.zcehiHbq-lkp@intel.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 Oct 2023 10:46:32 -0700
Message-ID: <CAEf4BzbJBDkCTO9VOdBiMzrhwOXAd3UsguJqNA5oZAR7Q8Eo8A@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 09/18] bpf,lsm: refactor bpf_prog_alloc/bpf_prog_free
 LSM hooks
To:     kernel test robot <lkp@intel.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Oct 17, 2023 at 6:56=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Andrii,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bpf-next/master]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Andrii-Nakryiko/bp=
f-align-CAP_NET_ADMIN-checks-with-bpf_capable-approach/20231017-152928
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git =
master
> patch link:    https://lore.kernel.org/r/20231016180220.3866105-10-andrii=
%40kernel.org
> patch subject: [PATCH v8 bpf-next 09/18] bpf,lsm: refactor bpf_prog_alloc=
/bpf_prog_free LSM hooks
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/202310=
17/202310172156.zcehiHbq-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231017/202310172156.zcehiHbq-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310172156.zcehiHbq-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> security/security.c:5196: warning: Function parameter or member 'prog'=
 not described in 'security_bpf_prog_load'
>
>
> vim +5196 security/security.c
>
> 55e853201a9e03 Paul Moore      2023-02-16  5181
> 55e853201a9e03 Paul Moore      2023-02-16  5182  /**
> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5183   * security_bpf_prog_loa=
d() - Check if loading of BPF program is allowed
> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5184   * @prog BPF program obj=
ect

missing colon after @prog, cute, will fix

> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5185   * @attr: BPF syscall at=
tributes used to create BPF program
> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5186   * @token: BPF token use=
d to grant user access to BPF subsystem
> 55e853201a9e03 Paul Moore      2023-02-16  5187   *
> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5188   * Do a check when the k=
ernel allocates BPF program object and is about to
> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5189   * pass it to BPF verifi=
er for additional correctness checks. This is also the
> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5190   * point where LSM blob =
is allocated for LSMs that need them.
> 55e853201a9e03 Paul Moore      2023-02-16  5191   *
> 55e853201a9e03 Paul Moore      2023-02-16  5192   * Return: Returns 0 on =
success, error on failure.
> 55e853201a9e03 Paul Moore      2023-02-16  5193   */
> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5194  int security_bpf_prog_lo=
ad(struct bpf_prog *prog, union bpf_attr *attr,
> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5195                          =
  struct bpf_token *token)
> afdb09c720b62b Chenbo Feng     2017-10-18 @5196  {
> 82c20ee03a7a4e Andrii Nakryiko 2023-10-16  5197         return call_int_h=
ook(bpf_prog_load, 0, prog, attr, token);
> afdb09c720b62b Chenbo Feng     2017-10-18  5198  }
> 55e853201a9e03 Paul Moore      2023-02-16  5199
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
