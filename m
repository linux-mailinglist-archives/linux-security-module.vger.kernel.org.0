Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661158C48F
	for <lists+linux-security-module@lfdr.de>; Wed, 14 Aug 2019 00:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfHMW7g (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 13 Aug 2019 18:59:36 -0400
Received: from namei.org ([65.99.196.166]:40278 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfHMW7g (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 18:59:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x7DMxYZD007557;
        Tue, 13 Aug 2019 22:59:34 GMT
Date:   Wed, 14 Aug 2019 08:59:34 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/6] lockdown fixups
In-Reply-To: <20190813192126.122370-1-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1908140858410.7339@namei.org>
References: <20190813192126.122370-1-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 13 Aug 2019, Matthew Garrett wrote:

> Fixups for the lockdown patchset. Potentially makes more sense to merge
> these into the relevant original patches rather than keeping them
> separate, but sending them for review.

Yep, it's difficult to guess which Linus would prefer, as this is 
also public development history now.

-- 
James Morris
<jmorris@namei.org>

