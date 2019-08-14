Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D648CA8C
	for <lists+linux-security-module@lfdr.de>; Wed, 14 Aug 2019 07:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfHNFGO (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 14 Aug 2019 01:06:14 -0400
Received: from namei.org ([65.99.196.166]:40316 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfHNFGO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 14 Aug 2019 01:06:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x7E56Bv4028867;
        Wed, 14 Aug 2019 05:06:11 GMT
Date:   Wed, 14 Aug 2019 15:06:11 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Garrett <matthewgarrett@google.com>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/6] lockdown fixups
In-Reply-To: <20190813192126.122370-1-matthewgarrett@google.com>
Message-ID: <alpine.LRH.2.21.1908141503240.27654@namei.org>
References: <20190813192126.122370-1-matthewgarrett@google.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-67747878-1565759171=:27654"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-67747878-1565759171=:27654
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 13 Aug 2019, Matthew Garrett wrote:

> Fixups for the lockdown patchset. Potentially makes more sense to merge
> these into the relevant original patches rather than keeping them
> separate, but sending them for review.

Which kernel version are these against?

kernel/kexec_file.c: In function ‘kimage_validate_signature’:
kernel/kexec_file.c:220:4: error: label ‘out’ used but not defined
  220 |    goto out;
      |    ^~~~
kernel/kexec_file.c: In function ‘kimage_file_prepare_segments’:
kernel/kexec_file.c:295:3: error: implicit declaration of function 
‘ima_kexec_cmdline’ [-Werror=implicit-function-declaration]
  295 |   ima_kexec_cmdline(image->cmdline_buf,
      |   ^~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors


My next-lockdown branch is based on v5.2. 





-- 
James Morris
<jmorris@namei.org>

--1665246916-67747878-1565759171=:27654--
