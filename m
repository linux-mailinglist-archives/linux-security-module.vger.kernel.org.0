Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E4E52C8C3
	for <lists+linux-security-module@lfdr.de>; Thu, 19 May 2022 02:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiESAjX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 18 May 2022 20:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiESAjN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 May 2022 20:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F21C236B6E
        for <linux-security-module@vger.kernel.org>; Wed, 18 May 2022 17:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652920752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dhPoiNFlWhE/EG2LfPsngTKf/wXSwPmET9DKcPeU2e0=;
        b=g20+EyGP9AvxddG+xUW+9AEUm8/0REdAr0DB9+HtKToO70jkscS2bM1W1qrCcYRcZtiSSW
        mAi4Ae4AvAl46dEjpcwzebPYeNGt2qqVl/ZQ4yPuCGwBoY3SE8JyzDZJg7DQS/Wd0BEPlU
        6EL8CjDNkrmlf+lh8n43GEaOEb2XU00=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-L87-ln_FMa6BzS8tUYo5IA-1; Wed, 18 May 2022 20:39:07 -0400
X-MC-Unique: L87-ln_FMa6BzS8tUYo5IA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 021A48015BA;
        Thu, 19 May 2022 00:39:07 +0000 (UTC)
Received: from localhost (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD749492C3B;
        Thu, 19 May 2022 00:39:05 +0000 (UTC)
Date:   Thu, 19 May 2022 08:39:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>, akpm@linux-foundation.org,
        zohar@linux.ibm.com
Cc:     Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michal Suchanek <msuchanek@suse.de>,
        Dave Young <dyoung@redhat.com>, Will Deacon <will@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Chun-Yi Lee <jlee@suse.com>,
        stable@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>,
        linux-security-module@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 4/4] kexec, KEYS, s390: Make use of built-in and
 secondary keyring for signature verification
Message-ID: <20220519003902.GE156677@MiWiFi-R3L-srv>
References: <20220512070123.29486-1-coxu@redhat.com>
 <20220512070123.29486-5-coxu@redhat.com>
 <YoTYm6Fo1vBUuJGu@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoTYm6Fo1vBUuJGu@osiris>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 05/18/22 at 01:29pm, Heiko Carstens wrote:
> On Thu, May 12, 2022 at 03:01:23PM +0800, Coiby Xu wrote:
> > From: Michal Suchanek <msuchanek@suse.de>
> > 
> > commit e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> > adds support for KEXEC_SIG verification with keys from platform keyring
> > but the built-in keys and secondary keyring are not used.
> > 
> > Add support for the built-in keys and secondary keyring as x86 does.
> > 
> > Fixes: e23a8020ce4e ("s390/kexec_file: Signature verification prototype")
> > Cc: stable@vger.kernel.org
> > Cc: Philipp Rudo <prudo@linux.ibm.com>
> > Cc: kexec@lists.infradead.org
> > Cc: keyrings@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
> > Acked-by: Baoquan He <bhe@redhat.com>
> > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > ---
> >  arch/s390/kernel/machine_kexec_file.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> As far as I can tell this doesn't have any dependency to the other
> patches in this series, so should I pick this up for the s390 tree, or
> how will this go upstream?

Thanks, Heiko.

I want to ask Mimi if this can be taken into KEYS-ENCRYPTED tree.
Otherwise I will ask Andrew to help pick this whole series.

Surely, this patch 4 can be taken into s390 seperately since it's
independent, both looks good.

Thanks
Baoquan

