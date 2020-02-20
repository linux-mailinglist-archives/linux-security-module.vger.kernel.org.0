Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB68165363
	for <lists+linux-security-module@lfdr.de>; Thu, 20 Feb 2020 01:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBTALn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 19 Feb 2020 19:11:43 -0500
Received: from namei.org ([65.99.196.166]:47126 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgBTALm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 19 Feb 2020 19:11:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 01K0AprM011915;
        Thu, 20 Feb 2020 00:10:51 GMT
Date:   Thu, 20 Feb 2020 11:10:51 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [RFC PATCH] security: <linux/lsm_hooks.h>: fix all kernel-doc
 warnings
In-Reply-To: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
Message-ID: <alpine.LRH.2.21.2002201110290.21499@namei.org>
References: <fb2c98bd-b579-6ad0-721a-56a4f81f0d6e@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, 15 Feb 2020, Randy Dunlap wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix all kernel-doc warnings in <linux/lsm_hooks.h>.
> Fixes the following warnings:
> 
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quotactl' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'quota_on' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_free_mnt_opts' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_eat_lsm_opts' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_kern_mount' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_show_options' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'sb_add_mnt_opt' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'd_instantiate' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'getprocattr' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'setprocattr' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'locked_down' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_open' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_alloc' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_free' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_read' not described in 'security_list_options'
> ../include/linux/lsm_hooks.h:1830: warning: Function parameter or member 'perf_event_write' not described in 'security_list_options'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

