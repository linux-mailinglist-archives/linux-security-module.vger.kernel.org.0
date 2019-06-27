Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404E95859A
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Jun 2019 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfF0PbG (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 27 Jun 2019 11:31:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42326 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfF0PbG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 27 Jun 2019 11:31:06 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so5615184ior.9
        for <linux-security-module@vger.kernel.org>; Thu, 27 Jun 2019 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TuO/waTdEbRopCnF+YINnarVye+qG1Wu8zI6yO1vq2Q=;
        b=nnW95Nc4Sck+SCyLDWb6ekZqtVJR9gFDsyfjGL4qdTmxCKqSDzLNB+q6JY04BCTCox
         rNzxKwwVKDRt6j/nSCWITR4woKO3Bg6Pi4yh4DIx201Y7mmDE2vv9BJlTOgg0nWuLodi
         hRrheHz1Qb7gI7AH1/e+uD16A64/DMlbPbvG0GMFSoHN4QgrKWYC61U11c2JmgwNL4fd
         57IHFuNC5SRqpkx1wImVnhsWW7VQAb4Gj74fRFKt/WKH/hZHSXsN2VBtrqFRwm0yMHvP
         qISmxHrhDrDGrXqYK7CvD9tSjcj8q5EF7ls1Z6zh/pEeXldbhUMy3yPshERw4SLH5ZjI
         zL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TuO/waTdEbRopCnF+YINnarVye+qG1Wu8zI6yO1vq2Q=;
        b=Dep7NCzmnmSIQQl5DZ/d/vS5TCbuM+Xf0jnaKIr6S6zp/xDrYnhw0DSzFUmfQomP6u
         /sdKsqCAume2yrozuINRmugQ2UEiIj65j2IXCiWdseUGBCnsMdcVRpoPqgVeFHI5gecl
         MRvJPZcvxQsU1eAk+Pwh81GVChejyv/IXo4Fi9DcsTEQNC+MlClBeUF5rVRzT+IsOOAT
         30Va8t7pxivvk05M4lgr9DISk64golyOvu+Gxv50jO7D5wEHL0AeIdvTjQChqsp5eTcY
         xGiyESfxxdZyLVXw8gPFCGXuDWcBfNOe3b/AsYJjBBYTtD6ca25rzOV1HaFgEL1rViD6
         Yp4w==
X-Gm-Message-State: APjAAAVUL5l6E3ihjzcIPHenbiVz3UhBQxZ3U7BCiGswO7UPYLNAJdLU
        do7Dl0a9swP8614HdnUMjLk8WrL0YLNPNf9IAuQjYZopcQQ=
X-Google-Smtp-Source: APXvYqyWPoDVGM4Ciu+xqxjJUuhEI0J//jkhx4KineosYbAyIwLnim/WCO6ZIrIBAhMlWt7aE44OwKUSv/DF3heQ9b4=
X-Received: by 2002:a6b:b790:: with SMTP id h138mr5109103iof.64.1561649464641;
 Thu, 27 Jun 2019 08:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-20-matthewgarrett@google.com> <87ef3f3ihh.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87ef3f3ihh.fsf@dja-thinkpad.axtens.net>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 27 Jun 2019 08:30:52 -0700
Message-ID: <CACdnJuuUJShbsDt+oV+2nPOX_pQikOPumtMaB-mas6FLVeZ87A@mail.gmail.com>
Subject: Re: [PATCH V34 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
To:     Daniel Axtens <dja@axtens.net>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jun 26, 2019 at 6:49 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Matthew Garrett <matthewgarrett@google.com> writes:
> > +     if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
> > +         security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
> > +             return false;
> > +     return true;
> >  }
>
> Should this test occur before tainting the kernel?

Seems reasonable.
