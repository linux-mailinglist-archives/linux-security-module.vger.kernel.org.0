Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A4428509D
	for <lists+linux-security-module@lfdr.de>; Tue,  6 Oct 2020 19:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgJFRTk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 6 Oct 2020 13:19:40 -0400
Received: from namei.org ([65.99.196.166]:33308 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFRTk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 6 Oct 2020 13:19:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 096HJRAa007580;
        Tue, 6 Oct 2020 17:19:27 GMT
Date:   Wed, 7 Oct 2020 04:19:27 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 11/16] LSM: Add "contents" flag to kernel_read_file
 hook
In-Reply-To: <20201002173828.2099543-12-keescook@chromium.org>
Message-ID: <alpine.LRH.2.21.2010070419130.18879@namei.org>
References: <20201002173828.2099543-1-keescook@chromium.org> <20201002173828.2099543-12-keescook@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 2 Oct 2020, Kees Cook wrote:

> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

