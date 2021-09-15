Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA83340C725
	for <lists+linux-security-module@lfdr.de>; Wed, 15 Sep 2021 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbhIOONv (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 15 Sep 2021 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbhIOONr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Sep 2021 10:13:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E93C061575
        for <linux-security-module@vger.kernel.org>; Wed, 15 Sep 2021 07:12:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h9so6475316ejs.4
        for <linux-security-module@vger.kernel.org>; Wed, 15 Sep 2021 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0pohU1aHJ77epfHLj6ryM5BHHmhwa0qDe7dPwHtdd0=;
        b=eR9PEA1KsnhcujiaSp4R8mWZA6mpDIsh7VwjmTZYtFbgFhGfhC2lDUVPNLsgqluhp1
         ZuikeH6ISYHE0Hn7f+PMrZCFW44ut07bmJZ1SQKvFPC6gjbKsgOvLQZ9auK4V9BR8R8T
         M2bLbsFY3FbDICQAhyIRjW6ppEhUxmEQVUaDKjMbU0nARv/4wsYZYt2AyqQQtAJZpdRY
         5h+2cTsdVYZjWjc50/PPZAppcgb+L8yoY198lgv5cyCD/FGYpqYqoRkKbMWyBhI0bIsc
         x6/KxbY5LcJYMtVQDTniz+9Z+fFHikG6d0ecHdSblx52D5SB7gvPkFyJ72x1ZdhpkNLb
         NScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0pohU1aHJ77epfHLj6ryM5BHHmhwa0qDe7dPwHtdd0=;
        b=kIwfJQf7utD9Q+jALI7rW5fY8Kc24dkbWrlWYtzuSeO9WR63XzNnKW/aVgGaoHn/b4
         /Kq1zt7V+00Jl6iZIalzHoFhpJqAhpk2rdAgB8yPZCWRdua7xz2M9HAle8CMxhL/4Huo
         tDpTia/q36veeMdGbEHQodyOvh+SUamLsnFJdDlU62YDNSKTefAHQOjFCNkr+gPSvZjo
         YaRJkTG5kEs597NjgghAh6XVCgdiqpufysiH8RD+kzU4dbK/iixLss5F8G1+1ogzbAYS
         /clgBy7vtImkrJPNPodCkxPOmTyMIUnUFmTjzOKqEPbnrCcJpzerD/o2lpiZYlehGwrf
         Ok6A==
X-Gm-Message-State: AOAM531PcSuwSRofwd9S36ElgmuwVELp3s3h1Ut3HrOMy2ab5c78HM6M
        RzNgRP56EFsJFFiLrGXQiKV/k2JVbNy2Hn1SYDSnPLgFTYzI
X-Google-Smtp-Source: ABdhPJwpk1md/Mu8TgFO2mVRBp4z/f1TQbOQxsU9h62w+09HhO3nxNPTIDXE3aB83Bt17saG3dLwywyDDJELQSMAYB8=
X-Received: by 2002:a17:907:16ab:: with SMTP id hc43mr187667ejc.195.1631715139966;
 Wed, 15 Sep 2021 07:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTkZ-tUdrFjhc2k1supzW1QJpY-15pf08mw6=ynU9yY5g@mail.gmail.com>
 <20210827133559.GG490529@madcap2.tricolour.ca> <CAHC9VhRqSO6+MVX+LYBWHqwzd3QYgbSz3Gd8E756J0QNEmmHdQ@mail.gmail.com>
 <20210828150356.GH490529@madcap2.tricolour.ca> <CAHC9VhRgc_Fhi4c6L__butuW7cmSFJxTMxb+BBn6P-8Yt0ck_w@mail.gmail.com>
 <CAHC9VhQD8hKekqosjGgWPxZFqS=EFy-_kQL5zAo1sg0MU=6n5A@mail.gmail.com>
 <20210910005858.GL490529@madcap2.tricolour.ca> <CAHC9VhSRJYW7oRq6iLCH_UYukeFfE0pEJ_wBLdr1mw2QGUPh-Q@mail.gmail.com>
 <CAHC9VhTrimTds_miuyRhhHjoG_Fhmk2vH7G3hKeeFWO3BdLpKw@mail.gmail.com>
 <CAHC9VhTUKsijBVV-a3eHajYyOFYLQPWTTqxJ812NnB3_Y=UMeQ@mail.gmail.com> <20210915122907.GM490529@madcap2.tricolour.ca>
In-Reply-To: <20210915122907.GM490529@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 15 Sep 2021 10:12:08 -0400
Message-ID: <CAHC9VhRWzizGXuMk3+qK8jcYSDFEqjj+MOtFhHKYH0mpnA52=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/9] Add LSM access controls and auditing to io_uring
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     sgrubb@redhat.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-audit@redhat.com,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Sep 15, 2021 at 8:29 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> I was in the middle of reviewing the v2 patchset to add my acks when I
> forgot to add the comment that you still haven't convinced me that ses=
> isn't needed or relevant if we are including auid=.

[Side note: v3 was posted on Monday, it would be more helpful to see
the Reviewed-by tags on the v3 patchset.]

Ah, okay, it wasn't clear to me from your earlier comments that this
was your concern.  It sounded as if you were arguing that both session
ID and audit ID needed to be logged for every io_uring op, which
doesn't make sense (as previously discussed).  However, I see your
point, and in fact pulling the audit ID from @current in the
audit_log_uring() function is just plain wrong ... likely a vestige of
the original copy-n-paste or format matching, I'll drop that now.
Thanks.

While a small code change, it is somewhat significant so I'll post an
updated v4 patchset later today once it passes through a round of
testing.

-- 
paul moore
www.paul-moore.com
