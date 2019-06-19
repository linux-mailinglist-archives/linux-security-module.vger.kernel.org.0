Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E36714C218
	for <lists+linux-security-module@lfdr.de>; Wed, 19 Jun 2019 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfFSUI1 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 19 Jun 2019 16:08:27 -0400
Received: from namei.org ([65.99.196.166]:46464 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfFSUI0 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Jun 2019 16:08:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5JK83bM026517;
        Wed, 19 Jun 2019 20:08:03 GMT
Date:   Thu, 20 Jun 2019 06:08:03 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov
Subject: Re: [PATCH v2 00/25] LSM: Module stacking for AppArmor
In-Reply-To: <201906182133.EBF2C78D@keescook>
Message-ID: <alpine.LRH.2.21.1906200555400.25930@namei.org>
References: <20190618230551.7475-1-casey@schaufler-ca.com> <201906182133.EBF2C78D@keescook>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 18 Jun 2019, Kees Cook wrote:

> On Tue, Jun 18, 2019 at 04:05:26PM -0700, Casey Schaufler wrote:
> > Patches 0001-0003 complete the process of moving managment
> > of security blobs that might be shared from the individual
> > modules to the infrastructure.
> 
> I think these are happy stand-alone patches and should just go into the
> common LSM tree for v5.3.

We extended stacking support in March to allow Landlock and SARA to be 
merged and have not seen anything from them since.

Is there any point in adding more of the same for v5.3 before the current 
AppArmor stacking changes are fully ready? This seems to carry risk but no 
concrete benefit for the release.

-- 
James Morris
<jmorris@namei.org>

