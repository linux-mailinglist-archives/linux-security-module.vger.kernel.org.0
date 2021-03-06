Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217DA32FAE5
	for <lists+linux-security-module@lfdr.de>; Sat,  6 Mar 2021 14:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCFNi2 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 6 Mar 2021 08:38:28 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:52105 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhCFNiJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 6 Mar 2021 08:38:09 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 126DboK9026971;
        Sat, 6 Mar 2021 22:37:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Sat, 06 Mar 2021 22:37:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 126Dboiq026964
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 6 Mar 2021 22:37:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] security: tomoyo: fix error return code of
 tomoyo_update_domain()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com
References: <20210306130346.16296-1-baijiaju1990@gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <79dd201e-ea6e-8de5-6250-25c23453448d@i-love.sakura.ne.jp>
Date:   Sat, 6 Mar 2021 22:37:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210306130346.16296-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2021/03/06 22:03, Jia-Ju Bai wrote:
> When mutex_lock_interruptible() fails, the error return code of
> tomoyo_update_domain() is not properly assigned.
> To fix this bug, error is assigned with the return value of
> mutex_lock_interruptible(), and then error is checked.

Thanks for a patch, but this patch is wrong.
Since the variable "error" is initialized as

  int error = is_delete ? -ENOENT : -ENOMEM;

at the beginning of this function, unconditionally overwriting
this variable with the return code of mutex_lock_interruptible() breaks

  if (error && !is_delete) {
  }

block of this function.

And the caller does not check if the return code is -EINTR
instead of -ENOENT or -ENOMEM.
