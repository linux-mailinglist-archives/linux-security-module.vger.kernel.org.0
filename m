Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A332E104A52
	for <lists+linux-security-module@lfdr.de>; Thu, 21 Nov 2019 06:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKUFgZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 21 Nov 2019 00:36:25 -0500
Received: from namei.org ([65.99.196.166]:41466 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUFgZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Nov 2019 00:36:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xAL5a2gx004361;
        Thu, 21 Nov 2019 05:36:02 GMT
Date:   Thu, 21 Nov 2019 16:36:02 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, sds@tycho.nsa.gov
Subject: Re: [PATCH v11 02/25] LSM: Create and manage the lsmblob data
 structure.
In-Reply-To: <20191113175721.2317-3-casey@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1911211632130.3625@namei.org>
References: <20191113175721.2317-1-casey@schaufler-ca.com> <20191113175721.2317-3-casey@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 13 Nov 2019, Casey Schaufler wrote:

> A new lsm_id structure, which contains the name
> of the LSM and its slot number, is created. There
> is an instance for each LSM, which assigns the name
> and passes it to the infrastructure to set the slot.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Hi Casey,

Note that LSM infrastructure changes will need signoffs from the 
maintainers of all major LSMs.

See 
https://lore.kernel.org/linux-security-module/alpine.LRH.2.21.1909060644570.1710@namei.org/

I've set aside some time at the end of this week to take a close look.


-- 
James Morris
<jmorris@namei.org>

