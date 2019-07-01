Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6BF2C65D
	for <lists+linux-security-module@lfdr.de>; Tue, 28 May 2019 14:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfE1MXR (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 28 May 2019 08:23:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfE1MXR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 May 2019 08:23:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4ED3A81132;
        Tue, 28 May 2019 12:23:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 330067C0B5;
        Tue, 28 May 2019 12:23:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com>
References: <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, jose.bollo@iot.bzh,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11439.1559046181.1@warthog.procyon.org.uk>
Date:   Tue, 28 May 2019 13:23:01 +0100
Message-ID: <11440.1559046181@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 28 May 2019 12:23:17 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Casey Schaufler <casey@schaufler-ca.com> wrote:

> The change was made in commit c3300aaf95fb4 from Al Viro.

This should be in a "Fixes:" tag?

> +	fsparam_string("fsdef",		Opt_fsdefault),
>  	fsparam_string("fsdefault",	Opt_fsdefault),
>  	fsparam_string("fsfloor",	Opt_fsfloor),
>  	fsparam_string("fshat",		Opt_fshat),

Would it be better to delete the "fsdefault" line?

Also, should all of these be prefixed with "smack"?  So:

  	fsparam_string("smackfsdef",	Opt_fsdefault),
  	fsparam_string("smackfsfloor",	Opt_fsfloor),
  	fsparam_string("smackfshat",	Opt_fshat),	

David
