Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A85CA8D72
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Sep 2019 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfIDQ6E (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 4 Sep 2019 12:58:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37569 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbfIDQ6E (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Sep 2019 12:58:04 -0400
Received: by mail-io1-f68.google.com with SMTP id r4so30520888iop.4
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2019 09:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4AEVHZWDKj5M3XNGlUJpNgGM5Z1l9AtMPF1Hqde4DM=;
        b=asWc2sqIHddJtfzpGPSflNT5pALrlHIbgF4I0kHpFB1oZPYM9gDBwVZGGi7OtxWdXG
         PPLjQaihV0MOd2qP3s+pRow5caaVDzoXH65KvyTmbH6UL6DMpMt+2d17Z1AfLZjo8ep3
         hMdZZxJELA2F5afBUr10xth92mqJc8bLt5d+nWpYIUhxfUurKK4W4Emy+SQnkZRhYi4G
         hjZKiEtB39XoumJNkg1WOWUEmIA6i+ZwBZtg7rStpIivhqv8ekIGDdUZmtoLo/uQshqW
         SgwZHF7mgB/lRouNZ4D25erP6OjzyBkkz78zvxvjAEX6cR1uHIpXgziTDvHHsZpY0+ny
         O8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4AEVHZWDKj5M3XNGlUJpNgGM5Z1l9AtMPF1Hqde4DM=;
        b=NU+SdrxnaWV2v7rZ+H6AwOvvqPaB8TSnLtBWP86nGw0Yynx5VSqDcMOTr9/QmmPdGW
         B/mlgFyPGZNNISJY66DLJqJ0G0agfcwSro3EXga+O6FjMTlqxMKvrAZYAR3pEk5sEZnE
         kKorwGtFz9GCQbh0WQgs9rrQ2z5qoJx4GkXowhHp/TtJ+w8ul78hXg9ZGbMSio9YdYe7
         8CGBA15EvkqJ54ytC0wpcxXiDMFC94BnGT2M8n50HXFNtFZH/7+jDpV+zM43qg+Ie6vU
         OJjl/tCh01gAFE54n21gVy3o9O/MBnp+f0CUOXICn93a8Pt88HTtOjK4lBHgK+55Y8iA
         463A==
X-Gm-Message-State: APjAAAUHatq9AvgpXz2lLoFaLf2HEXdHSe7qHs6yCoi2Mtb7CBxLFUko
        XuzImCslCBUQB8oS9PZmwAQqk9e5i4Se1nRrkIHnew==
X-Google-Smtp-Source: APXvYqzIbsuE/yut9DVBnXppG4ta1mqNva3WuZnN1oWipNNP7O4N/45Gr53DC/XHb8eNNMFecqOhTbvf220xSgyYutU=
X-Received: by 2002:a02:354b:: with SMTP id y11mr17856473jae.53.1567616283414;
 Wed, 04 Sep 2019 09:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-5-matthewgarrett@google.com> <3638.1567182673@warthog.procyon.org.uk>
In-Reply-To: <3638.1567182673@warthog.procyon.org.uk>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 4 Sep 2019 09:57:52 -0700
Message-ID: <CACdnJuuTRQM9SQvLMqW+C=6ukQPpvkwqFZ6U+wnL4uYxcG14Ww@mail.gmail.com>
Subject: Re: [PATCH V40 04/29] lockdown: Enforce module signatures if the
 kernel is locked down
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 30, 2019 at 9:31 AM David Howells <dhowells@redhat.com> wrote:
>
> Matthew Garrett <matthewgarrett@google.com> wrote:
>
> >  enum lockdown_reason {
> >       LOCKDOWN_NONE,
> > +     LOCKDOWN_MODULE_SIGNATURE,
> >       LOCKDOWN_INTEGRITY_MAX,
> >       LOCKDOWN_CONFIDENTIALITY_MAX,
> >  };
>
> Aren't you mixing disjoint sets?

The goal is to be able to check whether any given lockdown reason is a
matter of integrity or confidentiality in a straightforward way.

> > +     [LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>
> Wouldn't it be better to pass this string as a parameter to
> security_locked_down()?

I thought about that, but it's not how any other LSM hooks behave. I
think it's probably easier to revisit that when we see how other LSMs
want to make use of the data.
