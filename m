Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE81D0F80
	for <lists+linux-security-module@lfdr.de>; Wed,  9 Oct 2019 15:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbfJINC0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 9 Oct 2019 09:02:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54925 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbfJINC0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 Oct 2019 09:02:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so2504107wmp.4
        for <linux-security-module@vger.kernel.org>; Wed, 09 Oct 2019 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gKyU2lVUG9r8tkVXQwlslVrnGaZcT+vH7d3AbPHYB0=;
        b=GHo82XUApFZmoJ9rbUiaxY0lPH5g1hfz9r8MSUnSI3GN9JdNoZQcA4UQ6OJo1rICO0
         qzfEEIaPLpbItb/8PbB0tgtmMY3OvSBeFhFZiL7aO0dIhyWBySy0Gc4iZkpX6vcuzMon
         Wj//7wE6Nd30Th7JDUX9ivMJk8/CkfEoL9COKkOw/OLGxaSlPBMlO4GEdXfniAHaK+uV
         ThL1YwwiUvNrQ4RoX+Gkqtnk4np+XvZsHPcUah8iL/Z2af9/saPP/imUSPit0/RkYjkD
         lCQnoyj1ClCApdV1FAhLZTizqvX7pcIkRlATP26I2RICqhtg4PmooQaeKNBqRXA5MyyA
         j92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gKyU2lVUG9r8tkVXQwlslVrnGaZcT+vH7d3AbPHYB0=;
        b=maRPfSnQsemla6fykgDUgJiLSWA5h8N/WDmSpFxFy5pLJZRepEoAxWWHZ5/1RKpnNg
         IMxP8DxyUSZmyXF8S6G3xuhf/xCEbK5kO7Er2J1PUdVeqbeRnDFCf87yZY/MdeqTw4bU
         3CJ11JcI9/C85R5rmEL8DW7hwIDGrWXmtlp7Lq+7ijAduoSeIzqgKzPVFzFDGk4cp+48
         qBD+rj4pmSpWGzVVQciP3yn7MlrNw2i4rWILa0VMNSjNsOlfBRAFkvKEv6cC6z+MDXbt
         CRvukuMq1SNmMB554un8HD50SRmBAMKEZwLxLsJ7gZMIA/gSouiqDUK8GIfolj5aNRoT
         hx1w==
X-Gm-Message-State: APjAAAWKbxrijOj241jBbXFEw5xXuC/dZxBI284VKI+o4qZvu2AHwzmz
        eeexouNZ8/BS3RpkAwXBPyWATRf4hdXXUlWzxpfhGg==
X-Google-Smtp-Source: APXvYqx+LxYtjcQzWODIZ+2Z6/00LXRbD8qwCw7fnhTtTZ7OXnXpkwtdFXmQrWSQSDmS0fILF/nvqqpHFCBNgF8/Vuo=
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr2412915wmj.119.1570626144905;
 Wed, 09 Oct 2019 06:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191008105510.6975-1-javierm@redhat.com> <CACdnJusuMQf8B9u83mB2Wye+aZ4aV8v4j2eFrokURHkLGA0G_w@mail.gmail.com>
In-Reply-To: <CACdnJusuMQf8B9u83mB2Wye+aZ4aV8v4j2eFrokURHkLGA0G_w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 9 Oct 2019 15:02:13 +0200
Message-ID: <CAKv+Gu8xgqEqeRPQSyEkcW6q0rosFRsGNdDxfOL2QdQXzkKvWw@mail.gmail.com>
Subject: Re: [PATCH v2] efi/efi_test: lock down /dev/efi_test and require CAP_SYS_ADMIN
To:     Matthew Garrett <mjg59@google.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Hu <ivan.hu@canonical.com>,
        Laszlo Ersek <lersek@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Micah Morton <mortonm@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 9 Oct 2019 at 04:18, Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, Oct 8, 2019 at 9:55 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > Acked-by: Laszlo Ersek <lersek@redhat.com>
>
> Acked-by: Matthew Garrett <mjg59@google.com>

Thanks all. Queued as a fix.
