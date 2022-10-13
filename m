Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED25FDDD5
	for <lists+linux-security-module@lfdr.de>; Thu, 13 Oct 2022 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJMQAD (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 13 Oct 2022 12:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJMQAB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Oct 2022 12:00:01 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B127B12
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 08:59:59 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 207so2581548ybn.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Oct 2022 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjZ4bHtWh7+B3zm3ZOOTvlCPfk07gc+YS2Fa3DuClcY=;
        b=z65tTNuu5IjqXFQz2UXXKyYyuzKvIMOhj0ajDBeRywjV44SIZazG3rDoq1PJ6O7UuD
         J4mjj5PWrTqFXiBYQgPOHqi+cv4wTe7IBtcxPnfx4G1g2ZeZ3D0AKGGMgrqUqNArGx0g
         MybcTG85MMeMka5bMEB67GwEItRabBEk505azrFLeUylTGA/vI64sUrqSuyohNINNiJH
         Cf2C+8FXB6NKfKeddlf1/raNqRhdaUhhPENkPAKEG1iuMiSdKLhqGUIsxtIwWZrQk7xW
         wreFCMi/KmSANpBWXqKvjn4bmM/QzAxpQwCG6ZdLB69NgOAoBVUteDUH9LgVRPZJWpgx
         vNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjZ4bHtWh7+B3zm3ZOOTvlCPfk07gc+YS2Fa3DuClcY=;
        b=ZJBqxUjytFonDWTsz9MKEt+RAKrTDajYILWiN+UgCkxrg/43gmH6opBNiii38o5xvP
         hQH66DMTudfs0FPv+I8XbfMBc0PvX9vLuknnFmNfoBafVZY6XYQ2iyVECNVEFQwV7kIo
         8pvpmsgZJUxRgE8y0lfU7+1FYH8pJypM5+IKF9agkmKKkxMbcaQlXxjPsCjIoMrRFhxO
         71P1XYc1HSTKTRErC/MQFwBx/Bf5NWraT75Y5UokmnNS/dSE2RElMybWYmfrpvIZqcFD
         FBYxhWmH8j0sZAY51lF8oXP6RkLj9H+TMWJir8eSFpJ10DfYtzo4l/3tyOr5m7kTvR5a
         0fvA==
X-Gm-Message-State: ACrzQf24MPV7KtjDrXqn6i0L71uUx+CYxXdhpOZe1bbjOXr59xzUmM4Q
        BcDhyhPyfBqO4CR5OTFF+rsYr0uAKKDx9Ta+/i8E
X-Google-Smtp-Source: AMsMyM6ekHioKdLRU9IaF0u9DuOLyzXR1r0vs+sR5cWo2O4AWrFXg0Pd9Ibvgv+X2NgXeNca5XH/vV0NdNhzOWvkm40=
X-Received: by 2002:a05:6902:724:b0:6c0:1784:b6c7 with SMTP id
 l4-20020a056902072400b006c01784b6c7mr625781ybt.15.1665676798894; Thu, 13 Oct
 2022 08:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <166543910984.474337.2779830480340611497.stgit@olly> <20221013085333.26288e44@kernel.org>
In-Reply-To: <20221013085333.26288e44@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Oct 2022 11:59:47 -0400
Message-ID: <CAHC9VhT5A6M27PO1_NKgqaRJXkTyZv_kjfPF=VNSLZ1nx5GFrA@mail.gmail.com>
Subject: Re: [PATCH] lsm: make security_socket_getpeersec_stream() sockptr_t safe
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 13, 2022 at 11:53 AM Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 10 Oct 2022 17:58:29 -0400 Paul Moore wrote:
> > Commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
> > sockptr_t argument") made it possible to call sk_getsockopt()
> > with both user and kernel address space buffers through the use of
> > the sockptr_t type.  Unfortunately at the time of conversion the
> > security_socket_getpeersec_stream() LSM hook was written to only
> > accept userspace buffers, and in a desire to avoid having to change
> > the LSM hook the commit author simply passed the sockptr_t's
> > userspace buffer pointer.  Since the only sk_getsockopt() callers
> > at the time of conversion which used kernel sockptr_t buffers did
> > not allow SO_PEERSEC, and hence the
> > security_socket_getpeersec_stream() hook, this was acceptable but
> > also very fragile as future changes presented the possibility of
> > silently passing kernel space pointers to the LSM hook.
> >
> > There are several ways to protect against this, including careful
> > code review of future commits, but since relying on code review to
> > catch bugs is a recipe for disaster and the upstream eBPF maintainer
> > is "strongly against defensive programming", this patch updates the
> > LSM hook, and all of the implementations to support sockptr_t and
> > safely handle both user and kernel space buffers.
>
> Code seems sane, FWIW, but the commit message sounds petty,
> which is likely why nobody is willing to ack it.

Heh, feel free to look at Alexei's comments to my original email; the
commit description seems spot on to me.

FWIW, once Casey and John give a thumbs up on their respective code
areas I do plan to pull this into the lsm/next tree with, or without,
any ACKs from the netdev/bpf folks.  It would be nice if I could get
an ACK from you guys, but since netdev/bpf feels comfortable merging
small security/ code without ACKs from the LSM folks, I see no problem
merging small netdev/bpf code with ACKs from the netdev/bpf folks.

-- 
paul-moore.com
