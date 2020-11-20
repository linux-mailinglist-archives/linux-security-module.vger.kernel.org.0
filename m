Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D813E2BA106
	for <lists+linux-security-module@lfdr.de>; Fri, 20 Nov 2020 04:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKTDTX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 19 Nov 2020 22:19:23 -0500
Received: from namei.org ([65.99.196.166]:54370 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgKTDTX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 19 Nov 2020 22:19:23 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AK3JFQf021276;
        Fri, 20 Nov 2020 03:19:15 GMT
Date:   Fri, 20 Nov 2020 14:19:15 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
cc:     lkml <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Herv=E9_Guillemet?= <herve@guillemet.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
In-Reply-To: <20201117150856.GA12240@mail.hallyn.com>
Message-ID: <alpine.LRH.2.21.2011201418100.20300@namei.org>
References: <20201117150856.GA12240@mail.hallyn.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 17 Nov 2020, Serge E. Hallyn wrote:

> *1 - note, if libcap is too old for getcap to have the '-n'
> option, then use verify-caps instead.
> 
> Signed-off-by: Serge Hallyn <serge@hallyn.com>
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1593431

"Perf fails to compile with python 3.7" 

Wrong bug ID?


-- 
James Morris
<jmorris@namei.org>

