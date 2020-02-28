Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D13173B89
	for <lists+linux-security-module@lfdr.de>; Fri, 28 Feb 2020 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgB1PhV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 28 Feb 2020 10:37:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45204 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726905AbgB1PhU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Feb 2020 10:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582904239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xEGrkk+zjNlJLGYUpM0gWgWNU9SlZz3/l/Jsoiki8pg=;
        b=PAEs5QKjlbXK+rj7s6MP9dUwDCuJuX0yLlzBRWyIeR7E8LqxXJkaZFczR6oJlkyJ8/P/Ms
        awHsWslhNEh63TjU/pJH8/JBWgE2/8JgCRFjXNQcTuCKr7K1+yw+cNq/3e7houShSXuJuf
        IQBfzDt/nXFSzY7KXqoMGc5EPOod3BI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-cMBpclJUORqkgvgoSVv8ug-1; Fri, 28 Feb 2020 10:37:17 -0500
X-MC-Unique: cMBpclJUORqkgvgoSVv8ug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C52C18B5FB7;
        Fri, 28 Feb 2020 15:37:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA9FA5DA2C;
        Fri, 28 Feb 2020 15:37:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHC9VhQ=W4R2LGCxaKzVEx4J31m4-F7mDo2BOMTqso2JdScHzw@mail.gmail.com>
References: <CAHC9VhQ=W4R2LGCxaKzVEx4J31m4-F7mDo2BOMTqso2JdScHzw@mail.gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     dhowells@redhat.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: Please revert SELinux/keys patches from the keys linux-next branch
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <101038.1582904234.1@warthog.procyon.org.uk>
Date:   Fri, 28 Feb 2020 15:37:14 +0000
Message-ID: <101039.1582904234@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Paul Moore <paul@paul-moore.com> wrote:

> For some reason we haven't been able to get your attention on the
> related SELinux mailing list threads, but we need you to revert commit
> f981a85690dc ("security/selinux: Add support for new key permissions")
> from your linux-next branch.  Can you please do that?

Sorry, I had to squeeze out a new version of notifications and fsinfo before
disappearing off to Vault - and then I disappeared off to Vault.  However, I
can do that now.

I can drop keyring ACL patches for the moment and pick them back up after the
next merge window.

David

