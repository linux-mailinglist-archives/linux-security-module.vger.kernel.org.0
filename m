Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 088E24D514
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Jun 2019 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbfFTRZd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 20 Jun 2019 13:25:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46504 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732138AbfFTRZc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 20 Jun 2019 13:25:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so1905383pgr.13
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2019 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FeK+nLArey4tfBc6iMdmQYlLriZPZ+YeTBb4vv7Yha8=;
        b=TYfI+7SeXp7cHo8lNldWo5BCTONFWWLyFs24BWkZUqahiMMLt/fB89ov2dj08ZFGCL
         +7DGWfZ+UeX9S41IJPHyeq4r/RUt4kA8OV+F5XNnq/ymAiDXwFtEUEQYv00iJKfbhTo5
         8+RBY4bMBGGLASnreup2VT6SVkuSzHV0Br97U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FeK+nLArey4tfBc6iMdmQYlLriZPZ+YeTBb4vv7Yha8=;
        b=hDse8gDJ+zYxS+LtfhGZR4PctpWiz54TKadcUp0OUH3cvSusCyJxBu3/BfPBZ1nLuz
         VhZYxQNtG1UZzSEE8KckmP1MDPpE9oOPPUvF5B1b7Y/HjqF10W/g7YDXtxjezuRWhH65
         1ZEEJ06dVb+QNi85xRa0AWYCfkgB+YBZbt+1R41N2yATYauV6nWY4Fo6dGaAydOBok4E
         56N7hLF0YN48S7hZ1lBjDnwy4lG5+Q6rMMpQZk4KDMA7k3o4DjcfqtDiHP4zXMgpIkqT
         50brgo6cM9UzoDChCD5KuE4gNPXQXjkd91ppQctidY+gGFqaXFjFdS4RFR4s1qTcB/ae
         1Fhg==
X-Gm-Message-State: APjAAAW2yHKUYPxD0jFlI/1DxnGwXJzJ6d6Gv+ALWW3BLTZ+2DBOenX/
        yJvI5EWJg8YCZ/XiCSp6oeH+PA==
X-Google-Smtp-Source: APXvYqxHPYIUFtNR2r7v3ZEED9Y1rHrLpjpj7qih/o54cvgcyyoub60irZ9yFSf5ccbr7qUHIzInlw==
X-Received: by 2002:a63:445b:: with SMTP id t27mr13770852pgk.56.1561051531529;
        Thu, 20 Jun 2019 10:25:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm85264pfo.19.2019.06.20.10.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:25:30 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:25:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v2 18/25] LSM: Use lsmcontext in
 security_dentry_init_security
Message-ID: <201906201024.C5936F66C@keescook>
References: <20190618230551.7475-1-casey@schaufler-ca.com>
 <20190618230551.7475-19-casey@schaufler-ca.com>
 <201906182238.4EBF8C17DB@keescook>
 <063644f9-be64-175e-0bf2-cfa1afadc3d7@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063644f9-be64-175e-0bf2-cfa1afadc3d7@schaufler-ca.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 19, 2019 at 10:31:45AM -0700, Casey Schaufler wrote:
> On 6/18/2019 10:41 PM, Kees Cook wrote:
> > I think this is wrong: for NUL-terminated strings, "context.len" isn't
> > currently including the NUL byte (it's set to strlen()).
> >
> > So, if kmemdup() is used here, it means strlen() isn't correct in the
> > context init helper, it should be using the "size" argument, etc.
> 
> Would all be true if the context where being set by lsmcontext_init,
> but it's not. It's coming from the dentry_init_security hook, and
> the one instance of that, selinux_dentry_init_security() sets the
> size to strlen() + 1. The kmemdup() will include the terminating NUL.

Ah-ha! Okay, thanks, yes. I see now. Carry on! :)

> I too wish that the hooks and their use where more consistent.
> My sincere hope is that this revision of the infrastructure will
> help that to some extent.

Once these changes land it should be much much easier to find ways to
refactor for greater sanity. :)

> > Should label be set to NULL here and len reduced to 0?
> 
> It wasn't before, and I'd hate to make too many assumptions
> about what might be fragile in the NFS code.

Gotcha.

-- 
Kees Cook
