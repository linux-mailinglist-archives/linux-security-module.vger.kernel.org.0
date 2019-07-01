Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD5B5877D
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Jun 2019 18:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF0QoI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 27 Jun 2019 12:44:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33722 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfF0QoI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 12:44:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so2314514qkc.0
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2BmOlVfFwkgLZSQC1w8R20Owu5XUJlV/BzLLVY15k0=;
        b=geImDuUK3nzgaKe4rg1kDwEEwfUdwvxURv/YU09DF9oFlWMFeIGMHkNFo+kl+Mvfgp
         3NO8fx+rX1WWjRagnKQMMJXa7pZt+GIeetEEtjHApswcGjlKc+gxyDCKrAzKCe62curu
         iW3bdzqK2OkSXzpeeJRpbwoTJgCh3u5Amano2cgvcnouqqXbiCvwAk366bvP8GkEgKAY
         1XYyATJFDwDk7/D++da1v3yBiCjkjfVbCeUbPEqBas4q+imDOQ1Gp08PVnQ835YTl4e3
         KVWwxlF+N5UDMQYpCb+jztRgrugr2eMpS3t4p9tRj4wNkE5ZVAADfT74LIah+lTkfQlG
         fWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2BmOlVfFwkgLZSQC1w8R20Owu5XUJlV/BzLLVY15k0=;
        b=VOqz2y9749OgnPh6M7NIG+irvT1k00/3McTsQDwhJgxFh6v2tWsxdOhKLE4TJTUFTe
         nZQfrgCiUpidE6VA3UW2MSHkgl5WQsJgPZYyVjtHlMLKk5zDiE5Lw+MDYmYSoGwn778u
         P8C/qro1kh+Jtb8Kgn2AevpjASDkHWmswiqLWZOx+fhQxKixV2Z/ArLBQk1KLIhec5V4
         /FCETlRU5BHBJ9vnQM99+XMX0aS0GM4A00Ivu5rhYQnx1NFh1pHhHvwTjyr6Jh5SKoYw
         GH0xtwzs486A7o4HcOTIjCuEWmP56LW0ZWtsQq8+VbKkSVRnLnujg0kh9lZoVS2PjDZN
         3B9A==
X-Gm-Message-State: APjAAAXZdtXBqD7ueI2w+N+Hn54n2qJrv3wpC/X8f5cAbPzbTISzmDbK
        2UULEZUZ+zP95TkQSYQ7kjsgxA==
X-Google-Smtp-Source: APXvYqy634RuieC+fz/WCPxqpxiLBIdyBILOYC+PwsQcQ+t7LBPTDYlzrhZfeWGzOYF9AbMHbkQZYQ==
X-Received: by 2002:a37:5d07:: with SMTP id r7mr4294931qkb.4.1561653847500;
        Thu, 27 Jun 2019 09:44:07 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f3sm1180627qkb.58.2019.06.27.09.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 09:44:06 -0700 (PDT)
Message-ID: <1561653844.5154.87.camel@lca.pw>
Subject: Re: [PATCH v9 1/2] mm: security: introduce init_on_alloc=1 and
 init_on_free=1 boot options
From:   Qian Cai <cai@lca.pw>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Hocko <mhocko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date:   Thu, 27 Jun 2019 12:44:04 -0400
In-Reply-To: <201906270926.02AAEE93@keescook>
References: <20190627130316.254309-1-glider@google.com>
         <20190627130316.254309-2-glider@google.com>
         <1561641911.5154.85.camel@lca.pw> <201906270926.02AAEE93@keescook>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2019-06-27 at 09:29 -0700, Kees Cook wrote:
> On Thu, Jun 27, 2019 at 09:25:11AM -0400, Qian Cai wrote:
> > On Thu, 2019-06-27 at 15:03 +0200, Alexander Potapenko wrote:
> > > +static int __init early_init_on_alloc(char *buf)
> > > +{
> > > +	int ret;
> > > +	bool bool_result;
> > > +
> > > +	if (!buf)
> > > +		return -EINVAL;
> > > +	ret = kstrtobool(buf, &bool_result);
> > > +	if (bool_result && IS_ENABLED(CONFIG_PAGE_POISONING))
> > > +		pr_warn("mem auto-init: CONFIG_PAGE_POISONING is on, will
> > > take precedence over init_on_alloc\n");
> > 
> > I don't like the warning here. It makes people think it is bug that need to
> > be
> > fixed, but actually it is just information. People could enable both in a
> > debug
> > kernel.
> 
> How would you suggest it be adjusted? Should it be silent, or be
> switched to pr_info()?

pr_info() sounds more reasonable to me, so people don't need to guess the
correct behavior. Ideally, CONFIG_PAGE_POISONING should be  renamed to something
like CONFIG_INIT_ON_FREE_CHECK, and it only does the checking part if enabled,
and init_on_free will gain an ability to poison a pattern other than 0.

Also, there might be some rooms to consolidate with SLAB_POSION as well.

> 
> Also, doesn't this need to check "want_page_poisoning", not just
> CONFIG_PAGE_POISONING? Perhaps just leave the warning out entirely?
> 

Yes, only checking CONFIG_PAGE_POISONING is not enough, and need to check
page_poisoning_enabled().
