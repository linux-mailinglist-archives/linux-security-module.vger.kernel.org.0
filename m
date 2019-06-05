Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B63A3558C
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Jun 2019 05:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFEDJP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 4 Jun 2019 23:09:15 -0400
Received: from namei.org ([65.99.196.166]:36882 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfFEDJP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jun 2019 23:09:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5538rr3019039;
        Wed, 5 Jun 2019 03:08:53 GMT
Date:   Wed, 5 Jun 2019 13:08:53 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     John Johansen <john.johansen@canonical.com>
cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
In-Reply-To: <42fcfaf2-43a9-642e-2e19-282087c3cdb2@canonical.com>
Message-ID: <alpine.LRH.2.21.1906051305370.17052@namei.org>
References: <20190602165101.25079-1-casey@schaufler-ca.com> <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov> <42fcfaf2-43a9-642e-2e19-282087c3cdb2@canonical.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 4 Jun 2019, John Johansen wrote:

> system as a whole is still being protected by selinux. Similar requests 
> have been made for lxd doing system containers. lxd currently supports 
> nested apparmor, so on an ubuntu system you can run suse container, 
> where the ubuntu host is enforcing policy and the suse container is 
> loading and enforcing its policy as well. In this case the policy of the 
> container is bounded by the policy of the host. The goal is to be able 
> to the same with selinux and smack based systems, LSM stacking is of 
> course only part of what is required to make this work.

Interesting. So you're stacking apparmor with itself, and one is the 
container instance? And you add another stacked apparmor for a 2nd 
container etc. ?

> Ubuntu actually has a very small apparmor delta these days, and we are 
> working on eliminating it entirely. There are no patches in Ubuntu that 
> require new hooks. As for the delta wrt to the stacking work, Ubuntu has 
> pulled in a subset of this delta and has been shipping kernels with 
> stacking enabled for 4 releases now and apparmor development is done 
> with LSM stacking in mind.

A subset of these patches from Casey?

-- 
James Morris
<jmorris@namei.org>

