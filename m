Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620F920AC38
	for <lists+linux-security-module@lfdr.de>; Fri, 26 Jun 2020 08:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgFZGVd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 26 Jun 2020 02:21:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:62741 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgFZGVd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 26 Jun 2020 02:21:33 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 05Q6KZQp052060;
        Fri, 26 Jun 2020 15:20:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Fri, 26 Jun 2020 15:20:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 05Q6KZjY052040
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 26 Jun 2020 15:20:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <20200626015121.qpxkdaqtsywe3zqx@ast-mbp.dhcp.thefacebook.com>
 <eb3bec08-9de4-c708-fb8e-b6a47145eb5e@i-love.sakura.ne.jp>
 <20200626054137.m44jpsvlapuyslzw@ast-mbp.dhcp.thefacebook.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c9a9c2b5-68cc-c35d-72c2-34de79ebfb15@i-love.sakura.ne.jp>
Date:   Fri, 26 Jun 2020 15:20:35 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626054137.m44jpsvlapuyslzw@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2020/06/26 14:41, Alexei Starovoitov wrote:
>> I was hoping that fork_usermode_blob() accepts only simple program
>> like the content of "hello64" generated by
> 
> pretty much. statically compiled elf that is self contained.

But fork_usermode_blob() itself does not check that.

>> due to interference from the rest of the system, how can we say "we trust kernel
>> code executing in userspace" ?
> 
> I answered this already in the previous email.

Previous post is mostly summary for David Miller who responded

  It's kernel code executing in userspace.  If you don't trust the
  signed code you don't trust the signed code.

  Nothing is magic about a piece of code executing in userspace.

without understanding my concerns.

> Use security_ptrace_access_check() LSM hook to make sure that no other process
> can tamper with blob's memory when it's running as user process.

Yes, security_ptrace_access_check() hook is there. But see the reality explained later.

> In the future it would be trivial to add a new ptrace flag to
> make sure that blob's memory is not ptraceable from the start.

I guess it is some PF_* flag (like PF_KTHREAD is used for avoiding some interference).

>> There is security_ptrace_access_check() LSM hook, but no zero-configuration
>> method is available.
> 
> huh?
> tomoyo is not using that hook, but selinux and many other LSMs do.
> please learn from others.

What I am hoping is that we can restrict interference between usermode blob processes
and other processes without using LSMs, for the reality is

  (1) Linux kernel community does not allow legally accessing LSM infrastructure from
      loadable kernel modules since Linux 2.6.24.
  (2) Red Hat folks enable only SELinux in their kernels.
  (3) Customers I'm working for cannot afford enabling SELinux in their environments.

and therefore

  (4) I have to maintain loadable kernel module version of LSM modules which illegally
      access LSM infrastructure in order to implement single function LSM modules.

Implementing security_ptrace_access_check() hook in TOMOYO is not a solution.

>>> security label can carry that execution context.
>>
>> If files get a chance to be associated with appropriate pathname and
>> security label.
> 
> I can easily add a fake pathname to the blob, but it won't help tomoyo.
> That's what I was saying all along.
> pathname based security provides false sense of security.
> 
> I'm pretty sure this old blog has been read by many folks who
> are following this thread, but it's worth reminding again:
> https://securityblog.org/2006/04/19/security-anti-pattern-path-based-access-control/
> I cannot agree more with Joshua.
> Here is a quote:
> "The most obvious problem with this is that not all objects are files and thus do not have paths."

Don't you know that TOMOYO can coexist with SELinux/Smack/AppArmor since Linux 5.1 ? ;-)

