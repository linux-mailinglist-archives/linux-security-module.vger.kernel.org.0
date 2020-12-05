Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D3D2CF7FD
	for <lists+linux-security-module@lfdr.de>; Sat,  5 Dec 2020 01:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgLEA2y (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 4 Dec 2020 19:28:54 -0500
Received: from namei.org ([65.99.196.166]:58252 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgLEA2y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Dec 2020 19:28:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 0B50RwPI025632;
        Sat, 5 Dec 2020 00:27:58 GMT
Date:   Sat, 5 Dec 2020 11:27:58 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     "Andrew G. Morgan" <morgan@kernel.org>
cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        =?ISO-8859-15?Q?Herv=E9_Guillemet?= <herve@guillemet.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] fix namespaced fscaps when !CONFIG_SECURITY
In-Reply-To: <CALQRfL6OQKuBqbUoC7_yH7W4qabYSamRYUqjM-HE1gj2r_CaHQ@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2012051127160.23731@namei.org>
References: <20201117150856.GA12240@mail.hallyn.com> <CALQRfL6q8ppuWi3ygY6iqh6SX9pnkVnvJDynTD61K2wUqerahg@mail.gmail.com> <20201129211542.GA5227@mail.hallyn.com> <alpine.LRH.2.21.2012011358200.28022@namei.org>
 <CALQRfL6OQKuBqbUoC7_yH7W4qabYSamRYUqjM-HE1gj2r_CaHQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 4 Dec 2020, Andrew G. Morgan wrote:

> The correct bug reference for this patch is:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=209689
> 
> Reviewed-by: Andrew G. Morgan <morgan@kernel.org>

Thanks.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-5.10
and next-testing


-- 
James Morris
<jmorris@namei.org>

