Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCC34B0E0
	for <lists+linux-security-module@lfdr.de>; Wed, 19 Jun 2019 06:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfFSEeH (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 19 Jun 2019 00:34:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44278 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfFSEeH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Jun 2019 00:34:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so8890596pgp.11
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jun 2019 21:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IV+JYdYPb8Zn3uQ2e6/D+/5ZTRgunkx7DW9vZ1oytDY=;
        b=lZfKjFmpF+kSolMRukVTHY1HGMY8w1a6fITnsVl6bvKUP1DixWL/Ghr0wVEcgrJkMY
         Qk0cqyQB5AWVOQ/5fb8W5i8FgPY8cFoY0Firr3dCq2MV0st2c7vzmSwHq4mP4wx6Ikrx
         D5FbslX/gp7BC0ot8RXVHa3MSR9zfuTrjOXGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IV+JYdYPb8Zn3uQ2e6/D+/5ZTRgunkx7DW9vZ1oytDY=;
        b=P+yrIctOQ7WsZlLbz75wsUDCYYQfCRc6XrjL1cmOayecuEvbUzgVju/64fyz5BTOPx
         3K7utuy3bMwPN9B8ot3BtpZzNRz1YQT91nJE6vGHAR03RVbjJeC+NhakQI1yt5Kri3DZ
         QcsX9L3kM9TGjvK+sO8yY6EmsyzBH0nUjdqoKhKjrRUa4FRyWpAkCze+7hQcWYvUqVK6
         Ep37CGdyvBeyPIdV9bQ7o72kPT1rWipsFYSxMRF4uloErMzA8gyAFEVO0kfgN+R6mfZf
         eznrgDbskYdpKMcjWBsQwReYa7KUnR+Fjr01xLQQUoo5dQ2yrcV2I+o+/8wRfaKjjEiG
         1fZQ==
X-Gm-Message-State: APjAAAWVAtjlqhBUPLP7PerTZPEu2Vxdp6IJ+8TQJgG4cH2Nv85c4rph
        X+O+HOWownOOdqqSS+WhbbQftg==
X-Google-Smtp-Source: APXvYqw/I50P/QEV0Q2f2EtQagyUBrKGuGmRPdOiSIBRzUCW+ZCLiTiEcipy9wce1ESadMev9lxC2A==
X-Received: by 2002:a17:90a:1aa4:: with SMTP id p33mr9096253pjp.27.1560918846482;
        Tue, 18 Jun 2019 21:34:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x26sm14708316pfq.69.2019.06.18.21.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 21:34:05 -0700 (PDT)
Date:   Tue, 18 Jun 2019 21:34:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 00/25] LSM: Module stacking for AppArmor
Message-ID: <201906182133.EBF2C78D@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618230551.7475-1-casey@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 18, 2019 at 04:05:26PM -0700, Casey Schaufler wrote:
> Patches 0001-0003 complete the process of moving managment
> of security blobs that might be shared from the individual
> modules to the infrastructure.

I think these are happy stand-alone patches and should just go into the
common LSM tree for v5.3.

-- 
Kees Cook
