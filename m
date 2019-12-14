Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA7711EF3B
	for <lists+linux-security-module@lfdr.de>; Sat, 14 Dec 2019 01:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfLNAca (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 13 Dec 2019 19:32:30 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54165 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfLNAca (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Dec 2019 19:32:30 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xBE0W5Kg059018;
        Sat, 14 Dec 2019 09:32:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Sat, 14 Dec 2019 09:32:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xBE0W5s3059014
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 14 Dec 2019 09:32:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     James Morris <jmorris@namei.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>
References: <20191211140833.939845-1-omosnace@redhat.com>
 <66706222-b6af-5099-e485-b99391ad70b3@i-love.sakura.ne.jp>
 <CAFqZXNv=AnPxHuQCusoJQGEJ8Q+yF7_TPBCRyAcE5OPzoYFc9w@mail.gmail.com>
 <alpine.LRH.2.21.1912140547490.9693@namei.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a57a35cf-264a-429b-c4a8-f839f10f3384@i-love.sakura.ne.jp>
Date:   Sat, 14 Dec 2019 09:32:01 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1912140547490.9693@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2019/12/14 3:48, James Morris wrote:
> On Thu, 12 Dec 2019, Ondrej Mosnacek wrote:
> 
>> I'd say the burden of implementing this would lie on the arms of
>> whoever prepares the patches for dynamic load/unload.
> 
> Correct, and I don't see any such patches being accepted.
> 
> Go and look at some exploits, where LSM is used as a rootkit API...
> 

Evaluating trust of LSM modules is a job of module signing / integrity
checking etc. Disallowing loadable LSM modules (because of worrying
about rootkit API) is as stupid as enforcing CONFIG_MODULES=n.
