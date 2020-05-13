Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874C21D22D7
	for <lists+linux-security-module@lfdr.de>; Thu, 14 May 2020 01:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbgEMXQW (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 13 May 2020 19:16:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21771 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732408AbgEMXQV (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 May 2020 19:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589411780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5AJR2WaKjGAcCSypFEIypZ7FO4lpByrCMG2GJChQq0=;
        b=WPng1vyGWkw06dZkGmSLWz6xabXNkDmho9BTJ7Yy38X0eWSsCm0VUbdZsELFBvNKyC6YV3
        +FNKXUJIw1HhyDN0eMyEtBdvZ87xIA70H9djjniJg9xeoC1ogF4J0BOriYKok1bdMNEmdC
        yE6ACHy2Pdoe2sofxNBIO8TQl/gphmo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-E8cGbxnwNDOYTGRpB5xLtA-1; Wed, 13 May 2020 19:16:16 -0400
X-MC-Unique: E8cGbxnwNDOYTGRpB5xLtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F20E7461;
        Wed, 13 May 2020 23:16:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5221F600DB;
        Wed, 13 May 2020 23:16:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHC9VhQhYz8xZ6MGv0S9q2D-gReb0Pqqb=2+oX=NVuxb_F5WfA@mail.gmail.com>
References: <CAHC9VhQhYz8xZ6MGv0S9q2D-gReb0Pqqb=2+oX=NVuxb_F5WfA@mail.gmail.com> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com> <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     dhowells@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3611714.1589411772.1@warthog.procyon.org.uk>
Date:   Thu, 14 May 2020 00:16:12 +0100
Message-ID: <3611715.1589411772@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Paul Moore <paul@paul-moore.com> wrote:

> > +       case KEY_NEED_VIEW:     perm = KEY__VIEW;       break;
> > +       case KEY_NEED_READ:     perm = KEY__READ;       break;
> > +       case KEY_NEED_WRITE:    perm = KEY__WRITE;      break;
> > +       case KEY_NEED_SEARCH:   perm = KEY__SEARCH;     break;
> > +       case KEY_NEED_LINK:     perm = KEY__LINK;       break;
> > +       case KEY_NEED_SETATTR:  perm = KEY__SETATTR;    break;
> 
> Please don't put the case statements all on one line, use the more
> traditional multi-line format.  For example:
> 
>   case KEY_NEED_SETATTR:
>           perm = KEY__SETATTR;
>           break;

Tabulation was invented something like 6000 years ago for just this kind of
purpose;-)  It's less readable your way, but whatever...

David

