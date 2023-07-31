Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E373769346
	for <lists+linux-security-module@lfdr.de>; Mon, 31 Jul 2023 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGaKjk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 31 Jul 2023 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGaKjk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 31 Jul 2023 06:39:40 -0400
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 239A3116
        for <linux-security-module@vger.kernel.org>; Mon, 31 Jul 2023 03:39:39 -0700 (PDT)
Received: from wind.enjellic.com (localhost [127.0.0.1])
        by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 36VAcNIa004142;
        Mon, 31 Jul 2023 05:38:23 -0500
Received: (from greg@localhost)
        by wind.enjellic.com (8.15.2/8.15.2/Submit) id 36VAcMCh004140;
        Mon, 31 Jul 2023 05:38:22 -0500
Date:   Mon, 31 Jul 2023 05:38:22 -0500
From:   "Dr. Greg" <greg@enjellic.com>
To:     paul@paul-moore.com
Cc:     linux-security-module@vger.kernel.org
Subject: TSEM feedback.
Message-ID: <20230731103822.GA4093@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 31 Jul 2023 05:38:23 -0500 (CDT)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Good morning Paul, I hope this note finds your week starting well.

We submitted the patches for the V2 release of TSEM three weeks ago.

We received some feedback from Randy Dunlap on some documentations
issues that we went on to address.

Haven't heard any reflections from you.  Was just wondering if you
were swamped or had possibly missed the submission?  We didn't include
you as a copy on the notion that you didn't need two sets of patches
landing in your inbox.

You can find the series with the following lore link:

https://lore.kernel.org/linux-security-module/20230710102319.19716-1-greg@enjellic.com/T/#t

Will look forward to any reflections you might have.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
