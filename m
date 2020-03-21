Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E570018DC3F
	for <lists+linux-security-module@lfdr.de>; Sat, 21 Mar 2020 00:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCTXz0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 20 Mar 2020 19:55:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50895 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727176AbgCTXz0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 20 Mar 2020 19:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584748525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YMUkk0ARH4QnFA1QZkDjLSOJImmLVHTfhOfgY4nYzeY=;
        b=QT+7S1eksyex7pF4Vp4Q04/Z8nyQaQfAJ9sS4zWFWM897gs1Y9TakRIY52v0jnFk3kb4DJ
        jYWu4geoEic+aRA/euVRKeZsyojYLff5nPJP8dJjamCrv/+7nw/xgWZWqL9qaKI8OY7aYc
        DzCdGNMHQ+ICTA1MwjzD3jPTv4NvAzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-J6Id791BNzebo-XDbrltLA-1; Fri, 20 Mar 2020 19:55:22 -0400
X-MC-Unique: J6Id791BNzebo-XDbrltLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87AB8017CC;
        Fri, 20 Mar 2020 23:55:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-126.rdu2.redhat.com [10.10.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46CB660BF1;
        Fri, 20 Mar 2020 23:55:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200320143547.GB3629@linux.intel.com>
References: <20200320143547.GB3629@linux.intel.com> <20200318221457.1330-1-longman@redhat.com> <20200318221457.1330-3-longman@redhat.com> <20200319194650.GA24804@linux.intel.com> <f22757ad-4d6f-ffd2-eed5-6b9bd1621b10@redhat.com> <20200320020717.GC183331@linux.intel.com> <7dbc524f-6c16-026a-a372-2e80b40eab30@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     dhowells@redhat.com, Waiman Long <longman@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Eric Biggers <ebiggers@google.com>,
        Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v5 2/2] KEYS: Avoid false positive ENOMEM error on key read
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3984028.1584748510.1@warthog.procyon.org.uk>
Date:   Fri, 20 Mar 2020 23:55:10 +0000
Message-ID: <3984029.1584748510@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> /* Key data can change as we don not hold key->sem. */

I think you mean "we don't".

David

