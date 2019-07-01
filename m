Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6998737C63
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Jun 2019 20:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfFFSlI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 6 Jun 2019 14:41:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42951 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfFFSlI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Jun 2019 14:41:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so1828493pgd.9
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jun 2019 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I1RvIZcBBHiwbVvIBr1arRbehHK0nHXrZapIdaMQSVw=;
        b=fBsZ4xdkUbk63np1kkziFwGHZcxQN3084zNS+EzhJfrEbMl1syCE5L+INFtlaO/7Ut
         5rgZvVNiZBcdLeSlwIZn5KfuOq0WX1z6nsRSSGQobOiixAm0Rv1N9ToTpwRbWwF7W/B1
         qjIihINcHjPyKB24/ebmEc2kcUiJ5NgdwY89U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1RvIZcBBHiwbVvIBr1arRbehHK0nHXrZapIdaMQSVw=;
        b=SEhW6XBfDgLTL2in3uSBA/9xEdSMHDJ0sPO7DvOA2zjV56/gcfDry1JXDLNfi3Klkg
         D4HYBNbWH661d8S4F6z4Ug3yy4b7eY0cJq5G6T+YFYMg5T2E9JpyF1Sj2mb9e8q4rrDQ
         TCgvDtJICGztVXwhjgjlajFUAGc0Kh8jSOURVz4L/HlK3H+fzfiqBc2Q4IgL+Gk5feJw
         HLIQQwSPWeB2u8Ns8p3VRz8Yw5QWmgPQRPcK8+lUYShGNPhWJ/CriR4MfvjqTbBXi0k3
         BPV2+SHBCkNZ/4aH+OeU8CPZocpauH7RQWC0ziFFOzpl240DWZq0YMd4yepnejMZ9U6G
         nfIQ==
X-Gm-Message-State: APjAAAXWo7Y/rN2CQe8X4taENOklxN/sZd+6C7nASUpba1+WlH7QbanC
        NCsuwWUgIpMk2150h8oEts2kCQ==
X-Google-Smtp-Source: APXvYqwofJQtEfqLSrwKixcn6znXLSy3/RVIbp0hIpDtGOvNUeKKwWrdAnOryxAMInS2c0PZIkEsCg==
X-Received: by 2002:a17:90a:8d0d:: with SMTP id c13mr1167224pjo.137.1559846467669;
        Thu, 06 Jun 2019 11:41:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e12sm3488737pfd.84.2019.06.06.11.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 11:41:06 -0700 (PDT)
Date:   Thu, 6 Jun 2019 11:41:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH 22/58] Audit: Change audit_sig_sid to audit_sig_lsm
Message-ID: <201906061138.BFE4CFEE@keescook>
References: <20190531231020.628-1-casey@schaufler-ca.com>
 <20190531231020.628-23-casey@schaufler-ca.com>
 <201906011900.143B72A@keescook>
 <79cc3300-450f-5263-9b81-3186f84010f5@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79cc3300-450f-5263-9b81-3186f84010f5@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jun 03, 2019 at 03:23:07PM -0700, Casey Schaufler wrote:
> Maybe lsm_export_is_interesting()?
> I'd love to discover there's a convention I could adhere to.

I'd agree "lsm_data" seems meaningless. lsm_export does seem a better
name, though it has the "export is also a verb" issue. Would "lsm_context"
or "lsm_ctx"?
be better?

then we get lsm_ctx_is_interesting() and lsm_ctx_to_secid() ?

-- 
Kees Cook
