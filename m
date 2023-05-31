Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF29D718A15
	for <lists+linux-security-module@lfdr.de>; Wed, 31 May 2023 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjEaTXs (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 May 2023 15:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjEaTXs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 May 2023 15:23:48 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D88128
        for <linux-security-module@vger.kernel.org>; Wed, 31 May 2023 12:23:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso102036b3a.1
        for <linux-security-module@vger.kernel.org>; Wed, 31 May 2023 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685561025; x=1688153025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=li1rLK9XujeX0q5u14Qp5sO7HKgYaV/K5LyQO1RXxac=;
        b=fbPzdDPXelC0pn8nvQrSsUn3ouI3Mw6fmXmeONg0gi5YJEK+03UFY8G6Zb5Ntfek7u
         oCTHtY3cgTjnDD8ceChY5p5ACghTa0z7m8el2XFecNk8ageNHdtZUEBijdcXaWKEuV52
         qrfkGj6KkkQZ1fa87fyCFIqLCW9KCffsGVwfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685561025; x=1688153025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li1rLK9XujeX0q5u14Qp5sO7HKgYaV/K5LyQO1RXxac=;
        b=CgSFjCcIggeKgewYFa/mILNcYFGahq5XmT1kVbM1hAeBx6AvXw1ABxvYm/77Rhievt
         5BeSkWKuilM6jb082QAKe359P+o5FNkV9sWPozcnLJe+lHW20xX8Dnbptt+duZZR+1qE
         /mY0lnlhT5xkP0k4PEwcDU0lC0CCU6C0x4A53t8idsnGZ6oxONh7bo0VOzCpoz01ly23
         eTeQJyWWMfYe8Y5RzZtx6ucrX0KnmA3nUQ1t/QAz3OBWIQKrPUtKQgtdpVmxplY7uo+A
         LoALIV55fEQNteWgOm2OxuZmBiSiJaWHiCS1wZAewszS5vQDbmlR8RekEday1J1xf84g
         mfHQ==
X-Gm-Message-State: AC+VfDxqBrpX8Sy+FK77ylgw5/mtzfOESlabGqIliXiToWx+EXHYNifF
        8yiC3g+FOKlEiyPyatE2eQrEcw==
X-Google-Smtp-Source: ACHHUZ64HtRLdEcItCsHCYLoBTWTd80K7TF+1H9OHEneqdniae1bp3EZhfltYbgJ92K9NbZJaNV7kQ==
X-Received: by 2002:a05:6a00:21cf:b0:64d:7225:cfff with SMTP id t15-20020a056a0021cf00b0064d7225cfffmr6860176pfj.8.1685561025193;
        Wed, 31 May 2023 12:23:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j8-20020a62e908000000b0064f97ff4506sm3093355pfh.68.2023.05.31.12.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:23:44 -0700 (PDT)
Date:   Wed, 31 May 2023 12:23:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] apparmor: aa_buffer: Convert 1-element array to flexible
 array
Message-ID: <202305311223.5912EDF4@keescook>
References: <20230511213441.never.401-kees@kernel.org>
 <7085879d-4d21-b90a-c08d-60450d1c7d38@canonical.com>
 <202305301555.102E1890@keescook>
 <1f35dbba-9344-75c5-e870-31bc3198dbe0@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f35dbba-9344-75c5-e870-31bc3198dbe0@canonical.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, May 31, 2023 at 05:21:40AM -0700, John Johansen wrote:
> On 5/30/23 15:55, Kees Cook wrote:
> > On Thu, May 11, 2023 at 02:48:29PM -0700, John Johansen wrote:
> > > On 5/11/23 14:34, Kees Cook wrote:
> > > > In the ongoing effort to convert all fake flexible arrays to proper
> > > > flexible arrays, replace aa_buffer's 1-element "buffer" member with a
> > > > flexible array.
> > > > 
> > > > Cc: John Johansen <john.johansen@canonical.com>
> > > > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > Cc: James Morris <jmorris@namei.org>
> > > > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > > > Cc: apparmor@lists.ubuntu.com
> > > > Cc: linux-security-module@vger.kernel.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > 
> > > Acked-by: John Johansen <john.johansen@canonical.com>
> > > 
> > > I have pulled this into my tree.
> > 
> > Just a quick ping: I haven't seen this show up in -next yet...
> > 
> 
> oop, sorry looks like I didn't push, it should be fixed now

Awesome; thanks!

-- 
Kees Cook
