Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1048079B72
	for <lists+linux-security-module@lfdr.de>; Mon, 29 Jul 2019 23:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfG2VsJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 29 Jul 2019 17:48:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38247 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfG2VsJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Jul 2019 17:48:09 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so3661921ioa.5
        for <linux-security-module@vger.kernel.org>; Mon, 29 Jul 2019 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=piQh2aqA30RCLiw+cIf1d6IHR82wSEf3qDisOX1wwys=;
        b=l/RL7Y2Kyz2I8kqXJkJw/9E/ltkRzEbVMXQD38G56U8PUZAmwtnkKyk1cYdnW4RkE/
         BRx+ImBhz8Kd0e72PSmi6DzIFPzZz64kGMHUiXYdecWyOMNgVaC54BmGAJFKRoNTuut8
         PZd4JDjulvHHx4sqTgtjDyqilDAzhxkxGuPCGpSJoxbcIGu7fdFKOObX4H8TdzQlWyCM
         G23CxF+/n1MtU/bkyCuBe7R2qSG66UQrAnRhW82VgKpIhP1sJHF6XJdewBfIXFoJb6tR
         EDp+Xzcfwt3MI6laa6/wlpnuRJwSVMA/8v0UeVucDpQ8IOX0/R1elEKP78IJ2z5WBQ0k
         ESlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piQh2aqA30RCLiw+cIf1d6IHR82wSEf3qDisOX1wwys=;
        b=akWeK7ravlQacAcjKQJuMv6lmYjzKmYxkXvj5rrHRQvELJ8PxgYFVzAvfStw6+mqdM
         zVQvhAztzvc0OespHsxb4vRmqSb1O4DGtrYAtHJoImhFCciu546tSyQh4ECm/kr0dmEl
         2QRe+WO1vWeh8QDSwbQXgT0KTN8+3DjiU/t6lmOtOhqjAXim8hmde0kPxQVMcxlDppmZ
         ozd/zuPwt2HgaJnBoD473SSJsWca8PmhClVFwlg2YZo42jCRO85ppqdUmqJnOY2IFfLi
         ZNVMEyVa43TIlv3CPakpb/L3qAxI96+wpQaF2BaDilkfYYKLhZWMA31i+YpNiczYR8vz
         e3jQ==
X-Gm-Message-State: APjAAAVXIXaG6QWLfr49LnvIEI5VncRaMuOn9c65G/1oBJjJl5JNQ9Lc
        5IVtstWX0f3KFj/qeRcyAZo3+m0XRCdAl3u9laTjZQ==
X-Google-Smtp-Source: APXvYqxS/upLfLcv1Opnwp9lYxlnoZ2TkKlbL41OpS0AiGsoLM5gWBwfxkyYcoAUnk0nANWmnZfxFJngb/NBSwuBQkk=
X-Received: by 2002:a5e:9404:: with SMTP id q4mr42722436ioj.46.1564436887846;
 Mon, 29 Jul 2019 14:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com> <20190718194415.108476-20-matthewgarrett@google.com>
In-Reply-To: <20190718194415.108476-20-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 29 Jul 2019 14:47:56 -0700
Message-ID: <CACdnJute8aakro+Cb7oNrxgCiZTYj2BOt2WMc1dYF-xktxBucQ@mail.gmail.com>
Subject: Re: [PATCH V36 19/29] Lock down module params that specify hardware
 parameters (eg. ioport)
To:     James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jul 18, 2019 at 12:45 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> From: David Howells <dhowells@redhat.com>
>
> Provided an annotation for module parameters that specify hardware
> parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
> dma buffers and other types).
>
> Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Jessica Yu <jeyu@kernel.org>

Jessica, any feedback on this?
