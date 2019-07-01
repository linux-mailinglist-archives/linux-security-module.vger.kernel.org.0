Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0065574A3
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Jun 2019 01:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFZXEq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 26 Jun 2019 19:04:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44456 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfFZXEq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 19:04:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so182483pfe.11
        for <linux-security-module@vger.kernel.org>; Wed, 26 Jun 2019 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O+unN2ppMz+Lxz0HqVzJ4qMUjsNDCJD0N+sZPuyGAeU=;
        b=ClKEuBXTKkr+Kl9RmNFHiZKM8QoJsIpNT9BZJOhNj1AHqMy77A+RHPqGWLdSzNtyl0
         OSz8308toD2AtG3OTLcA/MxuvwQpFlucPmojP8d6UP4FAr/5bSr1qwIWhc8fA0LC03vu
         ta+j2JRkx7kvMUOwcGM3y+THWoOJscgF89Zn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O+unN2ppMz+Lxz0HqVzJ4qMUjsNDCJD0N+sZPuyGAeU=;
        b=eX84h+MB/j8b7x8GgZFX/WKoYTeW2KYMlIG8IA45lygJlpdS4vZ0ueLe6fEKD7EgQr
         Qh1/Grsb378Uy++JWOqCX/kZnGyBIHeID/pD5WbrACg2/NH7B+NOHnXGvxUfjOazR0W7
         CbUBFQV0Pbz1HLcBtMFTDaTU67ARJM3LHpFT7nnb6VbjD1SGqnLXbtt3fX18vYGafPrP
         dfa0sHeqfIu4628wStnRdi6BrpRFOfwBtpURdi9Brm0Kxqc4ZjKspUQbzZ8v7tF+UA3g
         oygtkKLFDSbghhtD5iZj5LQolmEdsVSOtOyAmeFFwmMNNWhWLE1hZ3LqdXPyOyU+IF3k
         jJ1A==
X-Gm-Message-State: APjAAAWxQjeeIvRAAY6tLLjYKVC/lI9qhwvlz8zr2J6Hbnw/P9U04IT6
        qiLek/XmeZo8WPFSzCXd27tKyg==
X-Google-Smtp-Source: APXvYqwuKLw0kIc4ha14kbUR8ZRJlKwgNAQr626qa5CZ7lf898izd/gUEOhmfp2Ok5FMpPuxbKtXzA==
X-Received: by 2002:a17:90a:3590:: with SMTP id r16mr1944100pjb.44.1561590285922;
        Wed, 26 Jun 2019 16:04:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 125sm325062pfg.23.2019.06.26.16.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 16:04:44 -0700 (PDT)
Date:   Wed, 26 Jun 2019 16:04:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
Message-ID: <201906261604.C387F7D7A@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <201906261404.451588F@keescook>
 <47abf84c-208e-3a08-d50b-5d3f51aee271@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47abf84c-208e-3a08-d50b-5d3f51aee271@canonical.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 02:11:23PM -0700, John Johansen wrote:
> On 6/26/19 2:04 PM, Kees Cook wrote:
> > On Wed, Jun 26, 2019 at 12:22:11PM -0700, Casey Schaufler wrote:
> >> This patchset provides the changes required for
> >> the AppArmor security module to stack safely with any other.
> >>
> 
> 
> here v
> 
> >> Because of the changes to slot handling and the rework of
> >> "display" I have not included the Reviewed-by tags from the
> >> previous version.
> 
> 
> >>
> >> v4: Incorporate feedback from v3
> >>     - Mark new lsm_<blob>_alloc functions static
> >>     - Replace the lsm and slot fields of the security_hook_list
> >>       with a pointer to a LSM allocated lsm_id structure. The
> >>       LSM identifies if it needs a slot explicitly. Use the
> >>       lsm_id rather than make security_add_hooks return the
> >>       slot value.
> >>     - Validate slot values used in security.c
> >>     - Reworked the "display" process attribute handling so that
> >>       it works right and doesn't use goofy list processing.
> >>     - fix display value check in dentry_init_security
> >>     - Replace audit_log of secids with '?' instead of deleting
> >>       the audit log
> > 
> > I think you missed adding my and John's Reviewed-bys from v3?
> > 
> Casey stated why above

Oops! Thanks! I skimmed too fast and only read the "v4" log. :P

-- 
Kees Cook
