Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F83B5E5DB
	for <lists+linux-security-module@lfdr.de>; Wed,  3 Jul 2019 15:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGCN5z (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 3 Jul 2019 09:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfGCN5z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 3 Jul 2019 09:57:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B52962F8BCB;
        Wed,  3 Jul 2019 13:57:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-9.rdu2.redhat.com [10.10.120.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAF0883CD7;
        Wed,  3 Jul 2019 13:57:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190703025518.6379-1-yuehaibing@huawei.com>
References: <20190703025518.6379-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dhowells@redhat.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kairui Song <kasong@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Thiago Jung Bauermann" <bauerman@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "Eric Biggers" <ebiggers@google.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] integrity: Remove set but not used variable 'acl'
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15690.1562162261.1@warthog.procyon.org.uk>
Date:   Wed, 03 Jul 2019 14:57:41 +0100
Message-ID: <15691.1562162261@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 03 Jul 2019 13:57:55 +0000 (UTC)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

YueHaibing <yuehaibing@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> security/integrity/digsig.c: In function 'integrity_init_keyring':
> security/integrity/digsig.c:99:18: warning:
>  variable 'acl' set but not used [-Wunused-but-set-variable]
> 
> It seems 'acl' is needed in __integrity_init_keyring

I've folded this fix in, thanks.

David
