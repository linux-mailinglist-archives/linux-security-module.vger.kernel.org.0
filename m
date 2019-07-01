Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B81935135
	for <lists+linux-security-module@lfdr.de>; Tue,  4 Jun 2019 22:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFDUm3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 4 Jun 2019 16:42:29 -0400
Received: from namei.org ([65.99.196.166]:36780 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfFDUm2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 4 Jun 2019 16:42:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x54KgCIO031551;
        Tue, 4 Jun 2019 20:42:12 GMT
Date:   Wed, 5 Jun 2019 06:42:12 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com
Subject: Re: [PATCH 00/58] LSM: Module stacking for AppArmor
In-Reply-To: <a493956a-8a2f-6239-e5fe-09030640c397@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1906050638550.31292@namei.org>
References: <20190602165101.25079-1-casey@schaufler-ca.com> <f71388e9-a4c5-8935-137b-8eb50be7f833@tycho.nsa.gov> <66a87b0b-b6f4-74ff-2e51-afc8e2d30de1@schaufler-ca.com> <2a9049a7-6259-5ae0-2790-0aaf337c51a4@tycho.nsa.gov>
 <a493956a-8a2f-6239-e5fe-09030640c397@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 4 Jun 2019, Casey Schaufler wrote:

> > It isn't free so there should be a cost/benefit analysis.
> 
> Some benchmarking is definitely in order, but most
> of what's you're calling out as downside is hypothetical
> or based on assumption. 

When you're proposing changes such as these, which make fundamental and 
far-reaching changes, the burden is on you to present the cost/benefit 
analysis.

You can't just say "Here are some changes and here are the benefits, and 
any possible costs are merely hypothetical".


-- 
James Morris
<jmorris@namei.org>

