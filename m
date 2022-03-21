Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98A44E2F2F
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Mar 2022 18:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349578AbiCURjt (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 21 Mar 2022 13:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349897AbiCURjr (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Mar 2022 13:39:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC325C6F;
        Mon, 21 Mar 2022 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=JcqjpepIm/ba03u887BK7R/DEYTZdLq0VZyazgwGZP0=; b=IK6+bLUNTb1+2TMeKn2sQLXXS3
        vo1ZgcVaimz7r8ID/BG/42edawTPCKkneZdp7v35ILOj0ar/9ly9H6YLZ9COygTSE1HFXi7pDryw3
        326GltSZ5O1o2ATU4eRKMXhLNc7GOq/udxhuFaMd4Pso4gMTElwxORvrx1pBfCEmnEJGR6pUASYh4
        ZY8KqR41Dim2YYACcA4nCKTIrIgzr7JVNx5oIEzR/FdB7mJEfEHM22g0ax/bs6y2nGY4reOqGgZi9
        61n3oFofUPfT9h9JYMCU6LLzLrND0nt+jTB1DGkXxu6mmn5tnBFLd2q6TVl73NiDQxU6LjmYJUwuB
        4ecBKmFQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWLyn-008dxp-Du; Mon, 21 Mar 2022 17:38:05 +0000
Date:   Mon, 21 Mar 2022 10:38:05 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Heimes <christian@python.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steve Dower <steve.dower@python.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] Add trusted_for(2) (was O_MAYEXEC)
Message-ID: <Yji3/ejSErupJZtO@bombadil.infradead.org>
References: <20220321161557.495388-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220321161557.495388-1-mic@digikod.net>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Mar 21, 2022 at 05:15:57PM +0100, Micka�l Sala�n wrote:
> Since I heard no objection, please consider to pull this code for
> v5.18-rc1 .  These five patches have been successfully tested in the
> latest linux-next releases for several weeks.

>  kernel/sysctl.c                                    |   9 +

Please don't add more sysctls there. We're slowly trying to move
all these to their respective places so this does not become a larger
kitchen sink mess.

  Luis
