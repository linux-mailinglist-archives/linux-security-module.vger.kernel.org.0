Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB73F29F27
	for <lists+linux-security-module@lfdr.de>; Fri, 24 May 2019 21:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfEXTgk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 24 May 2019 15:36:40 -0400
Received: from namei.org ([65.99.196.166]:34308 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbfEXTgk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 May 2019 15:36:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4OJaWYL008551;
        Fri, 24 May 2019 19:36:32 GMT
Date:   Sat, 25 May 2019 05:36:32 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: Stacking patches for 5.3
In-Reply-To: <1106985e-1620-75b2-d6bf-c2c95d9a0fbb@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1905250536020.7233@namei.org>
References: <1106985e-1620-75b2-d6bf-c2c95d9a0fbb@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 24 May 2019, Casey Schaufler wrote:

> I have a set of 59 patches for the nest round of LSM stacking.
> They are all really small. Kees has expressed a preference for
> small patches. I think that the collapsed set of about 10 would
> make more sense. Which would the community as a whole prefer?
> The patches are not much different from what has been presented
> already.

I agree with Kees, smaller patches are easier to review.

-- 
James Morris
<jmorris@namei.org>

