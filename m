Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3974A9A215
	for <lists+linux-security-module@lfdr.de>; Thu, 22 Aug 2019 23:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbfHVVSq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 22 Aug 2019 17:18:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48990 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbfHVVSq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 22 Aug 2019 17:18:46 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EC98815363ECE;
        Thu, 22 Aug 2019 14:18:45 -0700 (PDT)
Date:   Thu, 22 Aug 2019 14:18:45 -0700 (PDT)
Message-Id: <20190822.141845.217313560870249775.davem@davemloft.net>
To:     casey@schaufler-ca.com
Cc:     fw@strlen.de, paul@paul-moore.com, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: New skb extension for use by LSMs (skb "security blob")?
From:   David Miller <davem@davemloft.net>
In-Reply-To: <32646e98-2ed6-a63a-5589-fefd57e85f66@schaufler-ca.com>
References: <00ab1a3e-fd57-fe42-04fa-d82c1585b360@schaufler-ca.com>
        <20190822201520.GJ20113@breakpoint.cc>
        <32646e98-2ed6-a63a-5589-fefd57e85f66@schaufler-ca.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 14:18:46 -0700 (PDT)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Casey Schaufler <casey@schaufler-ca.com>
Date: Thu, 22 Aug 2019 13:35:01 -0700

> If the secmark where replaced by a security blob, the u32 secmark field
> in an sk_buff would be replaced by a void * security field.

You can already use the secmark to hash to some kind of pointer or other
object.
