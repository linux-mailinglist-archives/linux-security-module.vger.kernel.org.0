Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF9732197
	for <lists+linux-security-module@lfdr.de>; Sun,  2 Jun 2019 04:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfFBCDE (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 1 Jun 2019 22:03:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41541 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFBCDE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 1 Jun 2019 22:03:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so6195240pgp.8
        for <linux-security-module@vger.kernel.org>; Sat, 01 Jun 2019 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZgEAVNFKNlxJIYjf2q9gNpxGUL5h8eMBtr3zjNUeNsA=;
        b=dXyRow6BXcmWzq6M0XK/C/3vrWvP83U7oK+4zIQmeLs/87MtF8n0f92u6z01rXFv2A
         J97GHsZUs/Q0h5bz6uiLFZpEk3jbrvegZFdV7gNy56o8DLPpId1jQpzpGNodjxhyDmCa
         9M6EFesWF/N38qhN0eDgqfucyKuXuMJJtRDK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZgEAVNFKNlxJIYjf2q9gNpxGUL5h8eMBtr3zjNUeNsA=;
        b=Tlsk0T0UWdFs+ICm9VhOxoXmiOCAK3ylnhlQM5aF0hHw/Mpl8fm3uGOmBUtvSm9Hy2
         kxfhOfADnw9rMSuAJe7ar6h//WLOL8fSEo3t/FQh+td7fYizNrvSgjs6A/u3taZ9Wlph
         Wy9h2suLXnH8ycO0DKf2dPA1RcAOsHnOWgWT3KOFSBpsspgmPqBQeokHVakXxJVATn+N
         /8PjuTfhZygXTaVeQ1Q5/gQSbmGeMm5N/Y7972LnJiLm/TkRXet7d2/VOlo4AsOWYRa1
         EAxyYxF7lsjP5rK7nAOK6u46+6TQh1zktivu9r01oqSHzOcnzinxHqa2SgvnpJsUNXd4
         vpwQ==
X-Gm-Message-State: APjAAAUJ04HiKfqYV0p+8zBBlJHnN+zbasNLsR107rGF/p29ub47wZRz
        KkSoA0FdN+vNPhuFJhuv/qE6vw==
X-Google-Smtp-Source: APXvYqxzBEvdf+1uhUhZ2PgvaRnSvh3D7TIKTH+AOkaKwBGDpkMZLSFGHMwWcBhdCKLShnRNb1wlPg==
X-Received: by 2002:a17:90a:9bc4:: with SMTP id b4mr20891291pjw.100.1559440984102;
        Sat, 01 Jun 2019 19:03:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8sm9403416pjp.17.2019.06.01.19.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 19:03:03 -0700 (PDT)
Date:   Sat, 1 Jun 2019 19:03:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
Message-ID: <201906011900.143B72A@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-23-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531231020.628-23-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, May 31, 2019 at 04:09:44PM -0700, Casey Schaufler wrote:
> Remove lsm_export scaffolding around audit_sig_sid by
> changing the u32 secid into an lsm_export structure named
> audit_sig_lsm.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h |  7 +++++++
>  kernel/audit.c           | 18 ++++++++----------
>  kernel/audit.h           |  2 +-
>  kernel/auditsc.c         |  3 +--
>  4 files changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 40aa7b9f3c83..e76d7a9dbe50 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -93,6 +93,13 @@ static inline void lsm_export_init(struct lsm_export *l)
>  	memset(l, 0, sizeof(*l));
>  }
>  
> +static inline bool lsm_export_any(struct lsm_export *l)
> +{
> +	return (((l->flags & LSM_EXPORT_SELINUX) && l->selinux) ||
> +		((l->flags & LSM_EXPORT_SMACK) && l->smack) ||
> +		((l->flags & LSM_EXPORT_APPARMOR) && l->apparmor));
> +}

All of these helpers need kerndoc.

Bikeshed on naming:
- struct lsm_export renamed to lsm_secid
- lsm_export_any renamed to lsm_secid_defined() or ..._is_set() or
  ..._non_zero() ?

-- 
Kees Cook
