Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0B25EC22
	for <lists+linux-security-module@lfdr.de>; Sun,  6 Sep 2020 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgIFC2W (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 5 Sep 2020 22:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728767AbgIFC2U (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 5 Sep 2020 22:28:20 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD78CC061575
        for <linux-security-module@vger.kernel.org>; Sat,  5 Sep 2020 19:28:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l17so9397411edq.12
        for <linux-security-module@vger.kernel.org>; Sat, 05 Sep 2020 19:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cCo0id/2is2dpgsXzWC/QchoFeLB3g9IWCE8dT7egww=;
        b=Om8e9r3Jn0kG/I4j02k91QdIii3gApE9mKO9ex2F3QoF4K6JnnPP446L5yncmKgQpd
         a86VEMswzfnHmqY2GgIuGVbB0+rSu4msVxRLdjZthya7yyhatJWPX/nJFbDQ25I7uBq1
         sKmACMjiYjOtKiTvB6orTrT0H1s0pXs9DZyCPtxoxY52H9MR0X+mY42JpUzyrKmLzw5d
         BsjMAVkHLwOodchV7bDnKecKPS9rRYkFPgH7FjRv15ykkHqM7I+4Ir+i4xJ6fdIhP7+l
         xybBVZvjOqhtVuDVR5KaT3qsvB1C8JcRSTmWT0S68g8uYvm532Qh6Uq/knWXmbX6adPH
         Shyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCo0id/2is2dpgsXzWC/QchoFeLB3g9IWCE8dT7egww=;
        b=aQtCX4pwl7NMIK1Aleoyt4UzUabecVX68kBA6Ecgmc9V6EeCD9nuKAYJpZttAElbe+
         nyRpmj6po9j7R7UTtR1hEz9cBvGhRYouI37ZgsfpWQkO5g2hHLnqzRyM70fOLiDVrCMt
         43mkVjQzA65Rcvc5ff7l5LLG7OFYHwDiRyDFyPtXhkfMR5cor7KiACOBf698NLEpDQaS
         MYbHsPDnn3gOLmV/td3s4EAnUETiVa4weHZ5ezvAIGtg0+u89I5OoMC49DEvbpe9ZXgM
         GSvo6jRM8HvSEZa6kIt0iTO6DNcUrH1yIPkM7UOyGI/67ffx+hT0IaAvgQqDAOG0GEzT
         cS+g==
X-Gm-Message-State: AOAM532kDn/+6QBRVkdNuMxEl+XqcgwNK3fb69rLZfEDzzJhbAmdBhZh
        G74N+6Mf1VfGfKe2tGp/7BE6bDjrBC/Bi2U3D3vl
X-Google-Smtp-Source: ABdhPJwHZqHN5sltWYxscWqbmhHYoVAOTXYGd8ZprL26rtgepGpVPWVbQ4OprJf+82+dtQhOf0MFA8fV6g8brrPgmtQ=
X-Received: by 2002:a50:8e17:: with SMTP id 23mr15494957edw.31.1599359296292;
 Sat, 05 Sep 2020 19:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200826145247.10029-1-casey@schaufler-ca.com> <20200826145247.10029-13-casey@schaufler-ca.com>
In-Reply-To: <20200826145247.10029-13-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 5 Sep 2020 22:28:05 -0400
Message-ID: <CAHC9VhTcRmsBtVfUXGrm9+PPzz2ONkqOMvC-bwNdO9fOR9KF-w@mail.gmail.com>
Subject: Re: [PATCH v20 12/23] IMA: Change internal interfaces to use lsmblobs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        Stephen Smalley <sds@tycho.nsa.gov>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Aug 26, 2020 at 11:14 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> The IMA interfaces ima_get_action() and ima_match_policy()
> call LSM functions that use lsmblobs. Change the IMA functions
> to pass the lsmblob to be compatible with the LSM functions.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> cc: linux-integrity@vger.kernel.org
> ---
>  security/integrity/ima/ima.h          | 11 +++++----
>  security/integrity/ima/ima_api.c      | 10 ++++----
>  security/integrity/ima/ima_appraise.c |  6 ++---
>  security/integrity/ima/ima_main.c     | 35 +++++++++++----------------
>  security/integrity/ima/ima_policy.c   | 14 +++++------
>  5 files changed, 34 insertions(+), 42 deletions(-)

...

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index a86b35dad4fa..b057c758b430 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -519,7 +519,6 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>                 case LSM_SUBJ_USER:
>                 case LSM_SUBJ_ROLE:
>                 case LSM_SUBJ_TYPE:
> -                       lsmblob_init(&lsmdata, secid);
>                         rc = ima_filter_rule_match(&lsmdata, rule->lsm[i].type,
>                                                    Audit_equal,
>                                                    rule->lsm[i].rules);

I'm jumping across patches in this patchset so I may have missed
something, but I think the ima_filter_rule_match() call should be
using the passed "blob" pointer and not the local "lsmdata" right?  If
this is correct, I think this patch can also remove the local
"lsmdata" as well.

-- 
paul moore
www.paul-moore.com
