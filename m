Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1DC1D22FB
	for <lists+linux-security-module@lfdr.de>; Thu, 14 May 2020 01:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbgEMXZ0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 13 May 2020 19:25:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732374AbgEMXZ0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 13 May 2020 19:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589412325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRvLFN1ITMU2V/ezwJVoycF2INOx4EKs0X6HDBhlvdA=;
        b=D5oE+q1op8nTHw04B0+bNmb9pzyNBipQZnDvvAom1Xquy3DDYGnjBIsWAbRhfwculPYvp3
        itYVSQEfVJnTcWb4tTTefjLoBLVxxC/h0pSmwvP20lFuH+YbAmgthzgYCBh8Ets6lu+s63
        i8Qpx66OF3/efbSFl8FNlFvOvkmQ6SA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Q3t3JDRnPuyTFHa4LvzaUg-1; Wed, 13 May 2020 19:25:23 -0400
X-MC-Unique: Q3t3JDRnPuyTFHa4LvzaUg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A87E580183C;
        Wed, 13 May 2020 23:25:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FAED6E708;
        Wed, 13 May 2020 23:25:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <004ec27a-cc3a-c75c-952b-ff371b82b8d1@schaufler-ca.com>
References: <004ec27a-cc3a-c75c-952b-ff371b82b8d1@schaufler-ca.com> <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com> <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, stephen.smalley.work@gmail.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3612471.1589412319.1@warthog.procyon.org.uk>
Date:   Thu, 14 May 2020 00:25:19 +0100
Message-ID: <3612472.1589412319@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > -	if (perm & ~KEY_NEED_ALL)
> > -		return -EINVAL;
> > +	switch (need_perm) {
> > +	default:
> > +		return -EACCES;
> ...
> Is the change from -EINVAL to -EACCES a bug fix?
> Does it introduce an incompatibility?

It shouldn't happen.  All the actual cases should be covered explicitly in the
switch.  It's to catch a programming issue in the kernel where a new value
gets added to the enum but not propagated to all the places that check for it.

I'd actually prefer it to be something even more obvious, especially as EINVAL
is so widely used in the kernel.  Should I put a WARN_ON in there?

David

