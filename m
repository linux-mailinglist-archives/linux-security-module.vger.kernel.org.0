Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B88757BE0
	for <lists+linux-security-module@lfdr.de>; Tue, 18 Jul 2023 14:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjGRMcS (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 18 Jul 2023 08:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGRMcN (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jul 2023 08:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318CE77
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 05:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689683492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3S7Kay2jll/I2mOMaN0zpbuuSsttp78iRORP+3eGLc=;
        b=at56ZHdIA9hNO0v9M7D5U6zwkQFw5TvVfPOBZzCc9qqfByUvAJJEuKpl5k/SQx8kCeBvF7
        /yBjQPwy0zw9EWHn+2sB2vR2nVPljYjeylnRZRbqwVqdW41q4uMgfk0HZbaL6daebjDG8s
        orJWaeu/7kOkihlc/ZU8Ls1m9iJCu5k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-rxsiZSKIMNGtAmsyiax5mw-1; Tue, 18 Jul 2023 08:31:28 -0400
X-MC-Unique: rxsiZSKIMNGtAmsyiax5mw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7679e5ebad2so830433985a.3
        for <linux-security-module@vger.kernel.org>; Tue, 18 Jul 2023 05:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689683487; x=1692275487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3S7Kay2jll/I2mOMaN0zpbuuSsttp78iRORP+3eGLc=;
        b=dITmTVdOZsyzGPjp8NsxTHjrv7osjvHnFOB2N3fTxrRngBZIjGQcDN3BoiN6Tp6ATU
         KyGSgjDXDh+s6nZ2mJ1LFeFCy4/wmb/ZA/gOhc88HeDS2iEzszEPU55BMCaF9FLuNChf
         OsoOFFfpOJk27oloTDX8VFOKPgpmElOYGGT5WnNNN/bv+DgkvwGSst49WUtksSghkfuB
         gnTEQ8DRZY9sz3W5nZkG+veHFUzPBysIQXT5ifsKoJpeIh7slYpaRM3Tn7Re6QGeS37u
         hRK2yDk+X+vkX4KebCl6lxp9StTRZbv5gGjb2Q7p/eJiznhSfQN90OalWqfzpN9jBTvn
         v5Jw==
X-Gm-Message-State: ABy/qLYP0XZ0J3ffvzx2zyNZXsGrGW3/q7yCcXtKTqejZc9qIIZLydmP
        HrJ1xy/BR6OQIySJzTEVR53AbSw+ceBsWPPAXEmGE/pPeZojHTAaGIJIGJp97dYANwiUsHqKrBe
        rGTXlW04CKQ/oSGFZTyHHhlq4Cg9fuUUCOZJs
X-Received: by 2002:a05:620a:1a09:b0:767:39c5:652d with SMTP id bk9-20020a05620a1a0900b0076739c5652dmr4137269qkb.64.1689683487270;
        Tue, 18 Jul 2023 05:31:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlESfB1eQagyz95lVJvGzD04E1ZtY2Yo3CL8N+9aNpcFEwiK2NCExW2TZ4NWibWjFAaV9ubNIg==
X-Received: by 2002:a05:620a:1a09:b0:767:39c5:652d with SMTP id bk9-20020a05620a1a0900b0076739c5652dmr4137251qkb.64.1689683487062;
        Tue, 18 Jul 2023 05:31:27 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id os8-20020a05620a810800b00767d7fa3d05sm529155qkn.136.2023.07.18.05.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:31:26 -0700 (PDT)
Date:   Tue, 18 Jul 2023 14:31:19 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] security: Constify sk in the sk_getsecid
 hook.
Message-ID: <ZLaGF1uOIrnB9v9Z@debian>
References: <cover.1689077819.git.gnault@redhat.com>
 <980e4d705147a44b119fe30565c40e2424dce563.1689077819.git.gnault@redhat.com>
 <CAHC9VhTrfw+5XJ+Fr0dQg0XayiD5x4-SREjpjOGmqroEbScVgw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTrfw+5XJ+Fr0dQg0XayiD5x4-SREjpjOGmqroEbScVgw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 17, 2023 at 12:05:44PM -0400, Paul Moore wrote:
> On Tue, Jul 11, 2023 at 9:06 AM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > The sk_getsecid hook shouldn't need to modify its socket argument.
> > Make it const so that callers of security_sk_classify_flow() can use a
> > const struct sock *.
> >
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > ---
> >  include/linux/lsm_hook_defs.h | 2 +-
> >  include/linux/security.h      | 5 +++--
> >  security/security.c           | 2 +-
> >  security/selinux/hooks.c      | 4 ++--
> >  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> Thanks Guillaume, this looks good to me.  I had limited network access
> last week and was only monitoring my email for urgent issues, but from
> what I can tell it looks like this was picked up in the netdev tree so
> I'll leave it alone, but if anything changes let me know and I'll
> merge it via the LSM tree.

Thanks Paul, this series has indeed been applied to the networking tree.
So no special action is needed.

> -- 
> paul-moore.com
> 

