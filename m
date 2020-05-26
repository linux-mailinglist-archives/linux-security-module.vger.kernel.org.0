Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A7A1C0CCC
	for <lists+linux-security-module@lfdr.de>; Fri,  1 May 2020 05:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgEADvX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 30 Apr 2020 23:51:23 -0400
Received: from namei.org ([65.99.196.166]:56348 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgEADvW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 30 Apr 2020 23:51:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0413pA7g030035;
        Fri, 1 May 2020 03:51:10 GMT
Date:   Fri, 1 May 2020 13:51:10 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Stefan Hajnoczi <stefanha@redhat.com>
cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities: add description for CAP_SETFCAP
In-Reply-To: <20200428085816.GD15547@stefanha-x1.localdomain>
Message-ID: <alpine.LRH.2.21.2005011350590.29679@namei.org>
References: <20200414154945.142372-1-stefanha@redhat.com> <20200428085816.GD15547@stefanha-x1.localdomain>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 28 Apr 2020, Stefan Hajnoczi wrote:

> On Tue, Apr 14, 2020 at 04:49:45PM +0100, Stefan Hajnoczi wrote:
> > Document the purpose of CAP_SETFCAP.  For some reason this capability
> > had no description while the others did.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/uapi/linux/capability.h | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> Ping?

Please resend and I'll add it to my tree.

> 
> > diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> > index 272dc69fa080..7288f0ad44af 100644
> > --- a/include/uapi/linux/capability.h
> > +++ b/include/uapi/linux/capability.h
> > @@ -332,6 +332,8 @@ struct vfs_ns_cap_data {
> >  
> >  #define CAP_AUDIT_CONTROL    30
> >  
> > +/* Set or remove capabilities on files */
> > +
> >  #define CAP_SETFCAP	     31
> >  
> >  /* Override MAC access.
> > -- 
> > 2.25.1
> > 
> 

-- 
James Morris
<jmorris@namei.org>

