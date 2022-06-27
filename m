Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC5655CBB1
	for <lists+linux-security-module@lfdr.de>; Tue, 28 Jun 2022 15:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiF0V7G (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 27 Jun 2022 17:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbiF0V5j (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jun 2022 17:57:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF8DF2C
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jun 2022 14:56:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i67-20020a1c3b46000000b003a03567d5e9so6649866wma.1
        for <linux-security-module@vger.kernel.org>; Mon, 27 Jun 2022 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j50Rgb0UoT37KieYstNf0pUQuA+Xdht7tbivSbvQRIg=;
        b=kNgPnT8A46jB1Z772VOHfNfUU46YYFHUHF/Wey9vzvPcHaO0Z9jD3j8LZU4e+Jisub
         vK8hmqhdWiWSQ95Hdo+ix2mQyzOA9jkBaCgbfsbHnKq4JVo5GMwPJ1442wBQ/mileWbf
         9mYo+EvdIX7WeqBf5wylyUrv9l9eXYUiBdLrzceiZN0BT948fspmog/Yv6bFC/nFQbvW
         ryjWzOewkiJCeqwMKkHdd1a/SWhpBv3PHqKe8slaoOS7Z+rGEeW1344IYDCm9U2Iotk6
         BWwtOsUXNjiGMBup++IkLKdpS5mkqL0+RTt6ngzpFa78W4V62n9dsq7yCP+6Kd6lWZq9
         dIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j50Rgb0UoT37KieYstNf0pUQuA+Xdht7tbivSbvQRIg=;
        b=Ur3PabZusm+2uuQf+RoGxyX8SmZ7Uw4Ytc7DB5O6viAbNqrVyK+cIdtjYxpsP6C8Fc
         ldTWH37K3WKFnjVJIc1/KbXko3FD4Eze16cmJewaSLpFl8AQqFOXIN08kv6qnYTfIvUV
         t7cX97JnIfHqVDFkJjDfSKd7Ad2wdQ+DtC4Vn5wxXdgs1rec5zs6P6en/5OL9XImpbSJ
         zhJrijpGCypQt0JfXg3udn3VlOZ3Eqog9q3s2ITSc83B4oVJHbzJV51StMR1vTqp3CMc
         T5JHSXhWhzB8LEZdxp+HuQ7BTDH6GHD2a/ueWK3FVNauG2vvgbiasQX22ielE9mu+wMa
         lW4g==
X-Gm-Message-State: AJIora9GfA8J+2uDPRSEmrQYFpNCS8mhSPLRj8vj67YB3tUqedsZIGm3
        EN9rFIFoaTLozflUbe496M5zmGXSKv79XIxGIXkL
X-Google-Smtp-Source: AGRyM1ttvt1ApkpTPqcwbne7qYG4tYVamXmU4jEvQ3apNg8AHj9gs6Ech4xvdOAfdmWgLjNkk6YvbCCDCzTzaEHUnFE=
X-Received: by 2002:a05:600c:2246:b0:3a0:4d14:e9d5 with SMTP id
 a6-20020a05600c224600b003a04d14e9d5mr5247909wmm.70.1656366985523; Mon, 27 Jun
 2022 14:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220621233939.993579-1-fred@cloudflare.com> <ce1653b1-feb0-1a99-0e97-8dfb289eeb79@schaufler-ca.com>
 <b72c889a-4a50-3330-baae-3bbf065e7187@cloudflare.com> <CAHC9VhSTkEMT90Tk+=iTyp3npWEm+3imrkFVX2qb=XsOPp9F=A@mail.gmail.com>
 <20220627121137.cnmctlxxtcgzwrws@wittgenstein>
In-Reply-To: <20220627121137.cnmctlxxtcgzwrws@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jun 2022 17:56:14 -0400
Message-ID: <CAHC9VhSQH9tE-NgU6Q-GLqSy7R6FVjSbp4Tc4gVTbjZCqAWy5Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Introduce security_create_user_ns()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Frederick Lawler <fred@cloudflare.com>,
        Casey Schaufler <casey@schaufler-ca.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 27, 2022 at 8:11 AM Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Jun 23, 2022 at 11:21:37PM -0400, Paul Moore wrote:

...

> > This is one of the reasons why I usually like to see at least one LSM
> > implementation to go along with every new/modified hook.  The
> > implementation forces you to think about what information is necessary
> > to perform a basic access control decision; sometimes it isn't always
> > obvious until you have to write the access control :)
>
> I spoke to Frederick at length during LSS and as I've been given to
> understand there's a eBPF program that would immediately use this new
> hook. Now I don't want to get into the whole "Is the eBPF LSM hook
> infrastructure an LSM" but I think we can let this count as a legitimate
> first user of this hook/code.

Yes, for the most part I don't really worry about the "is a BPF LSM a
LSM?" question, it's generally not important for most discussions.
However, there is an issue unique to the BPF LSMs which I think is
relevant here: there is no hook implementation code living under
security/.  While I talked about a hook implementation being helpful
to verify the hook prototype, it is also helpful in providing an
in-tree example for other LSMs; unfortunately we don't get that same
example value when the initial hook implementation is a BPF LSM.

-- 
paul-moore.com
