Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 512F757A32
	for <lists+linux-security-module@lfdr.de>; Thu, 27 Jun 2019 05:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfF0Dpy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 26 Jun 2019 23:45:54 -0400
Received: from namei.org ([65.99.196.166]:48874 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbfF0Dpy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 26 Jun 2019 23:45:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5R3jeWo016724;
        Thu, 27 Jun 2019 03:45:40 GMT
Date:   Thu, 27 Jun 2019 13:45:40 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4 00/23] LSM: Module stacking for AppArmor
In-Reply-To: <alpine.LRH.2.21.1906271245210.13254@namei.org>
Message-ID: <alpine.LRH.2.21.1906271344480.16512@namei.org>
References: <20190626192234.11725-1-casey@schaufler-ca.com> <alpine.LRH.2.21.1906271230490.12379@namei.org> <alpine.LRH.2.21.1906271245210.13254@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 27 Jun 2019, James Morris wrote:

> On Thu, 27 Jun 2019, James Morris wrote:
> 
> > On Wed, 26 Jun 2019, Casey Schaufler wrote:
> > 
> > > This patchset provides the changes required for
> > > the AppArmor security module to stack safely with any other.
> > 
> > I get a kernel oops with this patchset when running the SELinux testsuite 
> > (binder test) with:
> > 
> > $ cat /sys/kernel/security/lsm 
> > capability,yama,loadpin,safesetid,selinux,tomoyo

Confirming there's no oops when Tomoyo is un-selected in the kernel 
config.

-- 
James Morris
<jmorris@namei.org>

