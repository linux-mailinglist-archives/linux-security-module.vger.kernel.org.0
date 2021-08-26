Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD623F8F9D
	for <lists+linux-security-module@lfdr.de>; Thu, 26 Aug 2021 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbhHZU2Z (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 26 Aug 2021 16:28:25 -0400
Received: from mail.hallyn.com ([178.63.66.53]:39278 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhHZU2Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 26 Aug 2021 16:28:25 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 9D1317E8; Thu, 26 Aug 2021 15:27:36 -0500 (CDT)
Date:   Thu, 26 Aug 2021 15:27:36 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@us.ibm.com>
Subject: Re: [PATCH v1] efi: Don't use knowledge about efi_guid_t internals
Message-ID: <20210826202736.GA29151@mail.hallyn.com>
References: <20210209164506.54176-1-andriy.shevchenko@linux.intel.com>
 <CAMj1kXGjoZ4qXxfB-2eH84k9Dg93cWs10DmDkZwv-C3_nKi_Ow@mail.gmail.com>
 <YL5TN6oTtgggIFvv@smile.fi.intel.com>
 <CAMj1kXFHG4G+KCv4KaL6XYtAPs99bsQ-0fik8oKv4GWDw2+GJg@mail.gmail.com>
 <YSeueHLVPsfCO0ah@smile.fi.intel.com>
 <CAMj1kXG6cZK+j-oEURuvLgntZxL-maUs0zk0UexHs3=S0wbLug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG6cZK+j-oEURuvLgntZxL-maUs0zk0UexHs3=S0wbLug@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 26, 2021 at 06:37:06PM +0200, Ard Biesheuvel wrote:
> On Thu, 26 Aug 2021 at 17:08, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Thu, Jun 10, 2021 at 05:05:55PM +0200, Ard Biesheuvel wrote:
> > > On Mon, 7 Jun 2021 at 19:11, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Feb 09, 2021 at 05:51:45PM +0100, Ard Biesheuvel wrote:
> > > > > On Tue, 9 Feb 2021 at 17:45, Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > >
> > > > > > When print GUIDs supply pointer to the efi_guid_t (guid_t) type rather
> > > > > > its internal members.
> > > > > >
> > > > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > >
> > > > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > > >
> > > > Thanks!
> > > >
> > > > Can we get this applied, please?
> > >
> > > Apologies, this one slipped behind the desk.
> >
> > Do I need to resend it?
> >
> 
> No, but I need an ack from James or Serge as it targets security/

It looks correct to me, based on Documentation/core-api/printk-formats.rst
and existing examples.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

thanks
-serge
