Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8704F10B454
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Nov 2019 18:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0RWZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 27 Nov 2019 12:22:25 -0500
Received: from namei.org ([65.99.196.166]:34938 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfK0RWZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Nov 2019 12:22:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xARHMAm2004256;
        Wed, 27 Nov 2019 17:22:10 GMT
Date:   Thu, 28 Nov 2019 04:22:10 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Stephen Smalley <sds@tycho.nsa.gov>
cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        Audit-ML <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>, matthewgarrett@google.com
Subject: Re: [RFC PATCH v2] security,lockdown,selinux: implement SELinux
 lockdown
In-Reply-To: <20191127170436.4237-1-sds@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1911280421250.3325@namei.org>
References: <20191127170436.4237-1-sds@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 27 Nov 2019, Stephen Smalley wrote:

> avc:  denied  { confidentiality } for pid=4628 comm="cp"
>  lockdown_reason="/proc/kcore access"
>  scontext=unconfined_u:unconfined_r:test_lockdown_integrity_t:s0-s0:c0.c1023
>  tcontext=unconfined_u:unconfined_r:test_lockdown_integrity_t:s0-s0:c0.c1023
>  tclass=lockdown permissive=0
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  include/linux/lsm_audit.h           |  2 ++
>  include/linux/security.h            |  2 ++
>  security/lockdown/lockdown.c        | 24 -----------------------
>  security/lsm_audit.c                |  5 +++++
>  security/security.c                 | 30 +++++++++++++++++++++++++++++
>  security/selinux/hooks.c            | 30 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  7 files changed, 71 insertions(+), 24 deletions(-)

LGTM.

Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

