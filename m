Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247A8BD113
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Sep 2019 19:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390356AbfIXR5B (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 24 Sep 2019 13:57:01 -0400
Received: from namei.org ([65.99.196.166]:40076 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390093AbfIXR5B (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 24 Sep 2019 13:57:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x8OHux6r001874;
        Tue, 24 Sep 2019 17:56:59 GMT
Date:   Wed, 25 Sep 2019 03:56:59 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Linux Security Module list <linux-security-module@vger.kernel.org>
Subject: Re: Do you plan to rebase next-general any time soon?
In-Reply-To: <260cc0b6-f19e-36f7-b8e4-dad0dd0c5ded@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1909250355190.1810@namei.org>
References: <260cc0b6-f19e-36f7-b8e4-dad0dd0c5ded@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 24 Sep 2019, Casey Schaufler wrote:

> Hi James. Do you have any plans to rebase next-general? I'm
> working on the next revision of the stacking, and want to be
> prepared for whichever way you decide to go. Thanks.

Not unless there's a need to.

I'd probably create a new branch (next-stacking) from v5.4 for this work.



-- 
James Morris
<jmorris@namei.org>

