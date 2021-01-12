Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C362F252A
	for <lists+linux-security-module@lfdr.de>; Tue, 12 Jan 2021 02:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbhALA4w (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 11 Jan 2021 19:56:52 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47184 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbhALA4v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 11 Jan 2021 19:56:51 -0500
Received: from [192.168.1.2] (unknown [67.183.157.164])
        by linux.microsoft.com (Postfix) with ESMTPSA id F073F20B6C40
        for <linux-security-module@vger.kernel.org>; Mon, 11 Jan 2021 16:56:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F073F20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610412971;
        bh=eFeujejIXY4wfwMx5x9iUp5aKt0caZQO/QFQMuBSg0g=;
        h=To:From:Subject:Date:From;
        b=QtZFOR11EZzKDMe550iTSfmi7NbIjd8hUiKBTG5whGLJ3zEc4gwqNYa7L6tHCoE2m
         UfsqvDzWAtvkvZF35UxCm8rWmto5ldR3wMbC5VFJ0n8l6ZAcMaBVPJtzevvuxqy9WK
         8pgfnHr2Nf3IjtXj/ThANSj7/ZYjr0o93XRlvJgw=
To:     linux-security-module@vger.kernel.org
From:   Fan Wu <wufan@linux.microsoft.com>
Subject: Question about inode security blob
Message-ID: <156f6860-73a4-f754-b460-d64de40ff626@linux.microsoft.com>
Date:   Mon, 11 Jan 2021 16:56:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

I'm trying to learn the security blob infrastructure for my future LSM 
development.

Unlike other blobs, I found inode security blob has a special pattern. I 
couldn’t find useful information on the web so I think this mail list is 
the most appropriate place to ask this question.

The BPF and SELinux will check whether the inode->i_security is NULL 
before use
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/include/linux/bpf_lsm.h#n35
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/security/selinux/include/objsec.h#n164

But for smack, it doesn't do such a check
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/security/smack/smack.h#n347
Is this because smack_set_mnt_opts() already does the NULL check at
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/security/smack/smack_lsm.c#n784 
?

Also, I wonder in which situation will the inode->i_security be NULL?

Thanks, and I hope I could make my contributions to LSM soon.

Best,
Fan
