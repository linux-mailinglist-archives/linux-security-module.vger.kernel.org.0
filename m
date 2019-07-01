Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC6D587F5
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Jun 2019 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfF0RH3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 27 Jun 2019 13:07:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35986 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfF0RH3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 13:07:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so1636270plt.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SjrNNd6jKuOENqivRCcx96Wx7wxTY+hBV+/1VBbN3mg=;
        b=g66r0h14ua6IfSpYMOHuG8frq0vPDk44KGrnt+3UFVkNg8zjZqzxfhEbybAmhFgbYT
         YC1spOx+z3Bt4uYQ0nMM3NElgCxFC4wd+H6U+3jmeSoPzAUtxH+qwKVjRLbG11LsuHPi
         WGZ9t6GN8fcL7P7D1D/5jV/jgNZuemMWmqA/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SjrNNd6jKuOENqivRCcx96Wx7wxTY+hBV+/1VBbN3mg=;
        b=dvjSPjdGXxbue4X3Shj3vpGQylL8zDIQwMGsPsmuWK6Chi//rok4UEIF7tQAwRibTe
         xd3a6oyu31tDfrvfRYsK8z3NsKy7yH07mEmmlC7t0+NhplaWF2eU1rsD7ne/uFPtCcmC
         Z8JcysshJVvFMphyKOTztSDbd3bfCNeDUhuHJvimXjXC7y07f2Y61254bGh+Y3qZk3Es
         1gIsvWm+mfzH11PyT5usGGIsANfPpz0j5sJnkmyT5cm1hh/GZnYpu1G9YC/zY93J0I0n
         pRxcb/MHhbB7HCVFiX123EfwDiOg6YkrYGUDi3JL8LwcbLi1z4t71BowigtsejN+kp6P
         AQkw==
X-Gm-Message-State: APjAAAWb0p/mTIhYVQcidldwnO7zJ4mzUIE3IYhxmgTh0iH+RB7DmouW
        e/OWq/om6hSCvKpb8uZ9985/lg==
X-Google-Smtp-Source: APXvYqxZtxonPJl/JfomojA7Fc6G0iKNGHkEJuxMqYAK6di8HYz3o7UcLfvPVacLLYrn+NunF/MM/w==
X-Received: by 2002:a17:902:f216:: with SMTP id gn22mr5790165plb.118.1561655248797;
        Thu, 27 Jun 2019 10:07:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n89sm11405192pjc.0.2019.06.27.10.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Jun 2019 10:07:28 -0700 (PDT)
Date:   Thu, 27 Jun 2019 10:07:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
Message-ID: <201906271006.57DE3C2@keescook>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <alpine.LRH.2.21.1906271230490.12379@namei.org>
 <alpine.LRH.2.21.1906271245210.13254@namei.org>
 <alpine.LRH.2.21.1906271344480.16512@namei.org>
 <alpine.LRH.2.21.1906271409460.16512@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1906271409460.16512@namei.org>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 27, 2019 at 02:10:18PM +1000, James Morris wrote:
> On Thu, 27 Jun 2019, James Morris wrote:
> 
> > Confirming there's no oops when Tomoyo is un-selected in the kernel 
> > config.
> 
> n/m, the problem is still there.

Were you able to test my fix for this? I wonder if what I found was just
a coincidence.

-- 
Kees Cook
