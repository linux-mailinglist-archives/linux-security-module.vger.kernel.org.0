Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D628358B75F
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Aug 2022 19:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiHFRwI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 6 Aug 2022 13:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiHFRwH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Aug 2022 13:52:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970D411A35;
        Sat,  6 Aug 2022 10:52:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C5CFB80782;
        Sat,  6 Aug 2022 17:52:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D6BC433C1;
        Sat,  6 Aug 2022 17:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659808324;
        bh=7HGiSqN/EHcN9D8kyq1sdrnKB/xgOAyB/4Z/HAGfkS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BjHsQYzURuriGDPM435lOYMqE0WldZo0qjKNcLMqiV/WYUiEK/ilJ/oIlnYQLqErS
         Ikz7HqgnD/hLxs6p74IsAqi/1hcCA4gDXtra6/J7AdkDhMKlmfjkAT8ppfKwQePKc9
         P06RvbaLsVYEIBwiPcojioX0MlittjjVRiOEDQF+7VwGZaA82oNAqT1H6+nvF7TUIj
         DxWkr7hnO7ZiOASeVUC4V6xVQy6f3E/obV+VX7fVDhvFdzP5temJgfIKa/6Ji4L7YZ
         71Y0X4F0OolGGmAYdhXl4wI56tkpkbhoQKuKHMyWu+8EFbSL6qo9BhLCsUR87pzWUm
         RyTiY9cRKL+9w==
Date:   Sat, 6 Aug 2022 20:52:00 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for v5.20
Message-ID: <Yu6qQHMoBzC4zprg@kernel.org>
References: <20220803210228.158993-1-jarkko@kernel.org>
 <87pmhgikhk.fsf@kernel.org>
 <5653318a776a8044f413ed1a4b6e3965fac2297e.camel@HansenPartnership.com>
 <87czdfi6t9.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czdfi6t9.fsf@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Aug 05, 2022 at 08:43:30AM +0300, Kalle Valo wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> 
> > On Thu, 2022-08-04 at 09:35 +0300, Kalle Valo wrote:
> >> Jarkko Sakkinen <jarkko@kernel.org> writes:
> > [...]
> >> > M...rten Lindahl (1):
> >> >       tpm: Add check for Failure mode for TPM2 modules
> >> 
> >> Some encoding problems in the name? At least my Gnus didn't show them
> >> correctly.
> >
> > My mail tool correctly renders the '�' character, and lore has it too:
> >
> > https://lore.kernel.org/all/20220803210228.158993-1-jarkko@kernel.org/
> >
> > So I think you have a local UTF-8 translation problem.
> 
> Odd, I haven't noticed any UTF-8 problems in my setup but Gnus/Emacs is
> known to be picky. After some more investigation I noticed this in
> Jarkko's email:
> 
> Content-Type: text/plain; charset=y
> 
> I admit I'm not up to par with the latest cool stuff but that charset
> can't be valid, right? :)
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

I must have pressed 'y' and enter, instead of enter,
when git send-email asked whether to use UTF-8 or
something like that.

Sorry about that :-) I don't recall doing that but
that is what it looks like for me.

BR, Jarkko
