Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2F22F7E2
	for <lists+linux-security-module@lfdr.de>; Mon, 27 Jul 2020 20:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgG0SkF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 27 Jul 2020 14:40:05 -0400
Received: from namei.org ([65.99.196.166]:55640 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgG0SkE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jul 2020 14:40:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 06RIduYH022279;
        Mon, 27 Jul 2020 18:39:56 GMT
Date:   Tue, 28 Jul 2020 04:39:56 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] LSM: drop duplicated words in header file comments
In-Reply-To: <9299abf4-75e3-6d73-a8b8-c2617208a990@infradead.org>
Message-ID: <alpine.LRH.2.21.2007280439450.18670@namei.org>
References: <9299abf4-75e3-6d73-a8b8-c2617208a990@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 17 Jul 2020, Randy Dunlap wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled words "the" and "and" in comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

