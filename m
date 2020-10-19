Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BE2931C1
	for <lists+linux-security-module@lfdr.de>; Tue, 20 Oct 2020 01:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388893AbgJSXF6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 19 Oct 2020 19:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388880AbgJSXFu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Oct 2020 19:05:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EFBC0613DF
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2020 16:05:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id h7so898567pfn.2
        for <linux-security-module@vger.kernel.org>; Mon, 19 Oct 2020 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KZcwJitFojA7RhzeD/UU8gbzehCBdvf6g5ia0ZYCrq4=;
        b=R0THCPfeT+NjRv5n7wRuWr3+iQQVH5mYQugrcFEorv7jMlZOJpq4gWO8x2sltRZ1S3
         8+uXkfK+0xraFRPc7RLEyC+L1Eqn+lwfgcQ60rCu3Ir6T0iqCUlHxkXPI8IxQxljNihW
         MxA7dERE+Fo0B6yhfEPLGm6gbjuMrGvt0ee7i4ozPAa6C0OwTV1SJBaz+sj8rzyyiIix
         DQ1LhxNguLsVQ2r9xWcmCur9QDHoeimXQtC/UVpN+4Yl8O9ZbpYKUwlrKFZtzYHwjpgZ
         iC+kREvCZvwgmOBCIm7DmgxG6/6ncKrp6QDCnbxkp/qIzrhuMyauJsg53LWTp//HSslk
         z+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KZcwJitFojA7RhzeD/UU8gbzehCBdvf6g5ia0ZYCrq4=;
        b=TzXWSEk3YJX7bbMEsAM2v2yrvCh/vjxq2kg+EouCkmXVMh6giKZJ5e+PuAzZAcZ+da
         HhTLi8W6CGj7MXMgKS1QQkH26eSXfbNIew4iYXhKbR054ibtRMNC5vWMck/9OzJakOO5
         zemZBfCu87+pY6JP/xEKRDrR89GCrNYOlgKIZX/ZcKDJovD4anObcl/e8ZuLuZHOctjs
         U3LdV9jhIv2TnR+vCWpYDQUmMplKc0gknj7DGMWvIqpfrTZ3Q//DBeNoDwY9JwXaCqh7
         E95c2ILJq3ys+upgHHPtA9q6pLhCUS/6kGIPTxOz9wFgvc66YEKtZqCZt8Hl6afYayUc
         Aq6A==
X-Gm-Message-State: AOAM531nL7v+vmXGV7d/e6rD0Mnqo/9vUkeHUc5qnwQOlpj1zsGXhiy5
        yByN7HeGue2k4eEARHj2vD5vjwsKMWCeDQ==
X-Google-Smtp-Source: ABdhPJwE/qhLAedndnNRaUrUDMs331Onaq8Iz+VDEVRJN+4h4B5ckC67pNXDnvS9MRF/DxLJjNlnIQ==
X-Received: by 2002:a6b:5019:: with SMTP id e25mr44377iob.123.1603148748578;
        Mon, 19 Oct 2020 16:05:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u8sm7938ilm.36.2020.10.19.16.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 16:05:47 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kUeDq-002hRf-LL; Mon, 19 Oct 2020 20:05:46 -0300
Date:   Mon, 19 Oct 2020 20:05:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Tom Rix <trix@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        industrypack-devel@lists.sourceforge.net,
        linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org, ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com, linux-nfc@lists.01.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com,
        storagedev@microchip.com, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net,
        linux-watchdog@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        bpf <bpf@vger.kernel.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        alsa-devel@alsa-project.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        George Burgess <gbiv@google.com>
Subject: Re: [RFC] treewide: cleanup unreachable breaks
Message-ID: <20201019230546.GH36674@ziepe.ca>
References: <20201017160928.12698-1-trix@redhat.com>
 <20201018054332.GB593954@kroah.com>
 <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 19, 2020 at 12:42:15PM -0700, Nick Desaulniers wrote:
> On Sat, Oct 17, 2020 at 10:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > >
> > > This is a upcoming change to clean up a new warning treewide.
> > > I am wondering if the change could be one mega patch (see below) or
> > > normal patch per file about 100 patches or somewhere half way by collecting
> > > early acks.
> >
> > Please break it up into one-patch-per-subsystem, like normal, and get it
> > merged that way.
> >
> > Sending us a patch, without even a diffstat to review, isn't going to
> > get you very far...
> 
> Tom,
> If you're able to automate this cleanup, I suggest checking in a
> script that can be run on a directory.  Then for each subsystem you
> can say in your commit "I ran scripts/fix_whatever.py on this subdir."
>  Then others can help you drive the tree wide cleanup.  Then we can
> enable -Wunreachable-code-break either by default, or W=2 right now
> might be a good idea.

I remember using clang-modernize in the past to fix issues very
similar to this, if clang machinery can generate the warning, can't
something like clang-tidy directly generate the patch?

You can send me a patch for drivers/infiniband/* as well

Thanks,
Jason
