Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB21E7B0851
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Sep 2023 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjI0Pd3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 27 Sep 2023 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjI0Pd2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Sep 2023 11:33:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00E9121
        for <linux-security-module@vger.kernel.org>; Wed, 27 Sep 2023 08:33:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42A7C433C7;
        Wed, 27 Sep 2023 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695828807;
        bh=JiQClH+wrT5+gpdkMYYCI4fuk08UiSBAjezXUD3crFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mssSikQWBmYELpuZ9obsEimc2JhsPBI7oC0bpkyGVowZ0lU3o7cLAi1WdE8+eMhtc
         BKtgNaIcqX0PCpffM+euv1Z+f8HXclZ3V/qTSHCVEbj0geZyFHkZ2gYlOIKvWy8bE9
         RzQAcm4LiV9nX1FB8WXA8LcssMCzofg3q30i5oI0=
Date:   Wed, 27 Sep 2023 17:33:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Message-ID: <2023092740-psychic-debating-da77@gregkh>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Sep 28, 2023 at 12:08:47AM +0900, Tetsuo Handa wrote:
> +extern int register_loadable_lsm(struct security_hook_list *hooks, int count,
> +				 const char *lsm);

naming nit, this should be "noun_verb" where ever possible to make it
easier to handle global symbols.  So "lsm_register()" perhaps?

thanks,

greg k-h
