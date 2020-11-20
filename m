Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D5F2BA109
	for <lists+linux-security-module@lfdr.de>; Fri, 20 Nov 2020 04:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgKTDUG (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 19 Nov 2020 22:20:06 -0500
Received: from namei.org ([65.99.196.166]:54384 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgKTDUF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 19 Nov 2020 22:20:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0AK3JwlO021317;
        Fri, 20 Nov 2020 03:19:58 GMT
Date:   Fri, 20 Nov 2020 14:19:58 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Andrew G. Morgan" <morgan@kernel.org>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Herv=E9_Guillemet?= <herve@guillemet.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
In-Reply-To: <CALQRfL5UzUt0YkKDAguETmdXM7qsPC9sGmsgutQ-P2cymPte-w@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2011201419210.20300@namei.org>
References: <20201117150856.GA12240@mail.hallyn.com> <CALQRfL5UzUt0YkKDAguETmdXM7qsPC9sGmsgutQ-P2cymPte-w@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 17 Nov 2020, Andrew G. Morgan wrote:

> Signed-off-by: Andrew G. Morgan <morgan@kernel.org>

This should be Acked-by or Reviewed-by, unless this is your patch, or it 
came via your tree.


-- 
James Morris
<jmorris@namei.org>

