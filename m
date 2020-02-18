Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0244C16334B
	for <lists+linux-security-module@lfdr.de>; Tue, 18 Feb 2020 21:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBRUon (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 18 Feb 2020 15:44:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37032 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgBRUon (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Feb 2020 15:44:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 72A04123BBFB7;
        Tue, 18 Feb 2020 12:44:42 -0800 (PST)
Date:   Tue, 18 Feb 2020 12:44:42 -0800 (PST)
Message-Id: <20200218.124442.1822657847722655409.davem@davemloft.net>
To:     madhuparnabhowmik10@gmail.com
Cc:     paul@paul-moore.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH] netlabel_domainhash.c: Use built-in RCU list checking
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200218184132.20363-1-madhuparnabhowmik10@gmail.com>
References: <20200218184132.20363-1-madhuparnabhowmik10@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Feb 2020 12:44:42 -0800 (PST)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: madhuparnabhowmik10@gmail.com
Date: Wed, 19 Feb 2020 00:11:32 +0530

> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> list_for_each_entry_rcu() has built-in RCU and lock checking.
> 
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
> by default.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Applied.
