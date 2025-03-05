Return-Path: <linux-security-module+bounces-8538-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37882A50902
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Mar 2025 19:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E33657A5BF3
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Mar 2025 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9891925291D;
	Wed,  5 Mar 2025 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GAwJq+Fb"
X-Original-To: linux-security-module@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B061B2517BA;
	Wed,  5 Mar 2025 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198408; cv=none; b=RloYC+hBm+I+at14LhdZIe1qJfBXyzRuzNakMWydd4wlqupHGhyKtJX9ZScQ6WTvo/6eH+eoms6Eg5t+wXH8LUICfaag8hi/oMmJGRnn/vMqoYo5JjcD3ibVBWXhPWL6G3KGBir9TW9VFXDQV5IhqfgWLRNOrps0u11RSzw5g/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198408; c=relaxed/simple;
	bh=JG9Ch11su9W1caFPf4YXp6ezXPGvnhLDT78TpJqHCd4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K+leXBBha/eAKo6bp9LMVl+P7Yk8u8Zwo8B1t5PF6gYI9/dlpWpfwqGqDbIZIgriJzfhYWV8YbdXDzcuKeNfk05JS/sDw2OAr2n85VvfgE7daYPT1s07ZJ93+iuz1PQNVLK1752uBtcHHzFd0e8BsinfBoqqVtBaijP6KG2boD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GAwJq+Fb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.32.19] (unknown [20.114.144.49])
	by linux.microsoft.com (Postfix) with ESMTPSA id 13F33210EAE2;
	Wed,  5 Mar 2025 10:13:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13F33210EAE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741198406;
	bh=ou2fboICR1zuDaUPlyNNi2fW1sblVAKZlq+5tGL+Hwc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=GAwJq+FbV154M3Rxl8ussSMrycI5Ax9MMoQmQuBo8mrf9GmHzQQGgRU8SuB5rwtDh
	 ugFIegK2TFewz/Q1jmWhHbxs0+eT8IVXc9/8fN3tE+x4uFu8u4VIrEiNEg5rkWNeHA
	 GHCEMxuh6Q5x9634U1cixhac08RtvejHp30pqi3g=
Message-ID: <2224dff1-e2c7-4f62-8b2e-62decd194d67@linux.microsoft.com>
Date: Wed, 5 Mar 2025 10:13:23 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ipe: add errno field to IPE policy load auditing
From: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
To: Fan Wu <wufan@kernel.org>
Cc: audit@vger.kernel.org, corbet@lwn.net, eparis@redhat.com,
 jmorris@namei.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, paul@paul-moore.com
References: <CAKtyLkFyqFCcqUi7TPn9niUwYcHwv8nVq-joKc8kd8tFg58p-Q@mail.gmail.com>
 <1740784265-19829-1-git-send-email-jasjivsingh@linux.microsoft.com>
 <CAKtyLkGV4cGJzbvVUAeLBp=evc_QAWPD8FsskHNVvx-1UZJB-A@mail.gmail.com>
 <0a5e586a-9b55-4905-8663-6ef0112aa32d@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <0a5e586a-9b55-4905-8663-6ef0112aa32d@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/4/2025 4:04 PM, Jasjiv Singh wrote:
> 
> 
> On 3/3/2025 2:11 PM, Fan Wu wrote:
>> On Fri, Feb 28, 2025 at 3:11 PM Jasjiv Singh
>> <jasjivsingh@linux.microsoft.com> wrote:
>>>
>>> Users of IPE require a way to identify when and why an operation fails,
>>> allowing them to both respond to violations of policy and be notified
>>> of potentially malicious actions on their systems with respect to IPE.
>>>
>>> This patch introduces a new error field to the AUDIT_IPE_POLICY_LOAD event
>>> to log policy loading failures. Currently, IPE only logs successful policy
>>> loads, but not failures. Tracking failures is crucial to detect malicious
>>> attempts and ensure a complete audit trail for security events.
>>>
>>> The new error field will capture the following error codes:
>>>
>>> * 0: no error
>>> * -EPERM: Insufficient permission
>>> * -EEXIST: Same name policy already deployed
>>> * -EBADMSG: policy is invalid
>>> * -ENOMEM: out of memory (OOM)
>>> * -ERANGE: policy version number overflow
>>> * -EINVAL: policy version parsing error
>>>
>>
>> These error codes are not exhaustive. We recently introduced the
>> secondary keyring and platform keyring to sign policy so the policy
>> loading could return -ENOKEY or -EKEYREJECT. And also the update
>> policy can return -ESTALE when the policy version is old.
>> This is my fault that I forgot we should also update the documentation
>> of the newly introduced error codes. Could you please go through the
>> whole loading code and find all possible error codes?  Also this is a
>> good chance to update the current stale function documents.
>>
>> ...
>>
> 
> So, I looked into error codes when the policy loads. In ipe_new_policy, 
> the verify_pkcs7_signature can return a lot of errno codes (ex: ENOKEY, 
> EKEYREJECTED, EBADMSG, etc.) while parsing the pkcs7 and other functions 
> as well. Also, In ipe_new_policyfs_node used in new_policy(), I see the same 
> issue with securityfs_create_dir and securityfs_create_file as they 
> return the errno directly from API to. So, what should we return?
> 
> For other functions: I have complied the errno list: 
> 
> * -ENOENT: Policy is not found while updating
> * -EEXIST: Same name policy already deployed
> * -ERANGE: Policy version number overflow
> * -EINVAL: Policy version parsing error
> * -EPERM: Insufficient permission
> * -ESTALE: Policy version is old
> * -ENOMEM: Out of memory (OOM)
> * -EBADMSG: Policy is invalid
> 
> - Jasjiv
> 
>>>
>>> Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
>>> ---
>>>  Documentation/admin-guide/LSM/ipe.rst | 19 ++++++++++++++-----
>>>  security/ipe/audit.c                  | 15 ++++++++++++---
>>>  security/ipe/fs.c                     | 16 +++++++++++-----
>>>  security/ipe/policy_fs.c              | 18 +++++++++++++-----
>>>  4 files changed, 50 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
>>> index f93a467db628..5dbf54471fab 100644
>>> --- a/Documentation/admin-guide/LSM/ipe.rst
>>> +++ b/Documentation/admin-guide/LSM/ipe.rst
>>> @@ -423,7 +423,7 @@ Field descriptions:
>>>
>>>  Event Example::
>>>
>>> -   type=1422 audit(1653425529.927:53): policy_name="boot_verified" policy_version=0.0.0 policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F26765076DD8EED7B8F4DB auid=4294967295 ses=4294967295 lsm=ipe res=1
>>> +   type=1422 audit(1653425529.927:53): policy_name="boot_verified" policy_version=0.0.0 policy_digest=sha256:820EEA5B40CA42B51F68962354BA083122A20BB846F26765076DD8EED7B8F4DB auid=4294967295 ses=4294967295 lsm=ipe res=1 errno=0
>>>     type=1300 audit(1653425529.927:53): arch=c000003e syscall=1 success=yes exit=2567 a0=3 a1=5596fcae1fb0 a2=a07 a3=2 items=0 ppid=184 pid=229 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts0 ses=4294967295 comm="python3" exe="/usr/bin/python3.10" key=(null)
>>>     type=1327 audit(1653425529.927:53): PROCTITLE proctitle=707974686F6E3300746573742F6D61696E2E7079002D66002E2E
>>>
>>> @@ -436,11 +436,11 @@ Field descriptions:
>>>  +----------------+------------+-----------+---------------------------------------------------+
>>>  | Field          | Value Type | Optional? | Description of Value                              |
>>>  +================+============+===========+===================================================+
>>> -| policy_name    | string     | No        | The policy_name                                   |
>>> +| policy_name    | string     | Yes       | The policy_name                                   |
>>>  +----------------+------------+-----------+---------------------------------------------------+
>>> -| policy_version | string     | No        | The policy_version                                |
>>> +| policy_version | string     | Yes       | The policy_version                                |
>>>  +----------------+------------+-----------+---------------------------------------------------+
>>> -| policy_digest  | string     | No        | The policy hash                                   |
>>> +| policy_digest  | string     | Yes       | The policy hash                                   |
>>>  +----------------+------------+-----------+---------------------------------------------------+
>>>  | auid           | integer    | No        | The login user ID                                 |
>>>  +----------------+------------+-----------+---------------------------------------------------+
>>> @@ -450,7 +450,16 @@ Field descriptions:
>>>  +----------------+------------+-----------+---------------------------------------------------+
>>>  | res            | integer    | No        | The result of the audited operation(success/fail) |
>>>  +----------------+------------+-----------+---------------------------------------------------+
>>> -
>>> +| errno          | integer    | No        | The result of the policy error as follows:        |
>>> +|                |            |           |                                                   |
>>> +|                |            |           | +  0: no error                                    |
>>> +|                |            |           | +  -EPERM: Insufficient permission                |
>>> +|                |            |           | +  -EEXIST: Same name policy already deployed     |
>>> +|                |            |           | +  -EBADMSG: policy is invalid                    |
>>> +|                |            |           | +  -ENOMEM: out of memory (OOM)                   |
>>> +|                |            |           | +  -ERANGE: policy version number overflow        |
>>> +|                |            |           | +  -EINVAL: policy version parsing error          |
>>> ++----------------+------------+-----------+---------------------------------------------------+
>>>
>>
>> Might be better to create another table to list all potential erronos.
>> Also please keep the capitalization of sentences consistent.
>>
>>>  1404 AUDIT_MAC_STATUS
>>>  ^^^^^^^^^^^^^^^^^^^^^
>>> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
>>> index f05f0caa4850..8df307bb2bab 100644
>>> --- a/security/ipe/audit.c
>>> +++ b/security/ipe/audit.c
>>> @@ -21,6 +21,8 @@
>>>
>>>  #define AUDIT_POLICY_LOAD_FMT "policy_name=\"%s\" policy_version=%hu.%hu.%hu "\
>>>                               "policy_digest=" IPE_AUDIT_HASH_ALG ":"
>>> +#define AUDIT_POLICY_LOAD_FAIL_FMT "policy_name=? policy_version=? "\
>>> +                                  "policy_digest=?"
>>>  #define AUDIT_OLD_ACTIVE_POLICY_FMT "old_active_pol_name=\"%s\" "\
>>>                                     "old_active_pol_version=%hu.%hu.%hu "\
>>>                                     "old_policy_digest=" IPE_AUDIT_HASH_ALG ":"
>>> @@ -254,16 +256,23 @@ void ipe_audit_policy_activation(const struct ipe_policy *const op,
>>>  void ipe_audit_policy_load(const struct ipe_policy *const p)
>>>  {
>>
>> The documentation of this function should also be updated since it is
>> also auditing errors now.
>>
>>>         struct audit_buffer *ab;
>>> +       int err = 0;
>>>
>>>         ab = audit_log_start(audit_context(), GFP_KERNEL,
>>>                              AUDIT_IPE_POLICY_LOAD);
>>>         if (!ab)
>>>                 return;
>>>
>>> -       audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
>>> -       audit_log_format(ab, " auid=%u ses=%u lsm=ipe res=1",
>>> +       if (!IS_ERR(p)) {
>>> +               audit_policy(ab, AUDIT_POLICY_LOAD_FMT, p);
>>> +       } else {
>>> +               audit_log_format(ab, AUDIT_POLICY_LOAD_FAIL_FMT);
>>> +               err = PTR_ERR(p);
>>> +       }
>>> +
>>> +       audit_log_format(ab, " auid=%u ses=%u lsm=ipe res=%d errno=%d",
>>>                          from_kuid(&init_user_ns, audit_get_loginuid(current)),
>>> -                        audit_get_sessionid(current));
>>> +                        audit_get_sessionid(current), !err, err);
>>>
>>>         audit_log_end(ab);
>>>  }
>>> diff --git a/security/ipe/fs.c b/security/ipe/fs.c
>>> index 5b6d19fb844a..da51264a1d0f 100644
>>> --- a/security/ipe/fs.c
>>> +++ b/security/ipe/fs.c
>>> @@ -141,12 +141,16 @@ static ssize_t new_policy(struct file *f, const char __user *data,
>>>         char *copy = NULL;
>>>         int rc = 0;
>>>
>>> -       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
>>> -               return -EPERM;
>>> +       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN)) {
>>> +               rc = -EPERM;
>>> +               goto out;
>>> +       }
>>>
>>>         copy = memdup_user_nul(data, len);
>>> -       if (IS_ERR(copy))
>>> -               return PTR_ERR(copy);
>>> +       if (IS_ERR(copy)) {
>>> +               rc = PTR_ERR(copy);
>>> +               goto out;
>>> +       }
>>>
>>>         p = ipe_new_policy(NULL, 0, copy, len);
>>>         if (IS_ERR(p)) {
>>> @@ -161,8 +165,10 @@ static ssize_t new_policy(struct file *f, const char __user *data,
>>>         ipe_audit_policy_load(p);
>>>
>>>  out:
>>> -       if (rc < 0)
>>> +       if (rc < 0) {
>>>                 ipe_free_policy(p);
>>> +               ipe_audit_policy_load(ERR_PTR(rc));
>>> +       }
>>>         kfree(copy);
>>>         return (rc < 0) ? rc : len;
>>>  }
>>
>> In case of memdup fail, the kfree(copy) will be called with the error
>> pointer. Also how about refactor the code like
>>
>>         ipe_audit_policy_load(p);
>>         kfree(copy);
>>
>>         return len;
>> err:
>>         ipe_audit_policy_load(ERR_PTR(rc));
>>         ipe_free_policy(p);
>>
>>         return rc;

Another issue I was thinking about that is what if memdup works but then 
ipe_new_policy fails, then we still need to call kfree but the above code 
mentioned by you will not do that.

>>
>>> diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
>>> index 3bcd8cbd09df..5f4a8e92bdcf 100644
>>> --- a/security/ipe/policy_fs.c
>>> +++ b/security/ipe/policy_fs.c
>>> @@ -12,6 +12,7 @@
>>>  #include "policy.h"
>>>  #include "eval.h"
>>>  #include "fs.h"
>>> +#include "audit.h"
>>>
>>>  #define MAX_VERSION_SIZE ARRAY_SIZE("65535.65535.65535")
>>>
>>> @@ -292,21 +293,28 @@ static ssize_t update_policy(struct file *f, const char __user *data,
>>>         char *copy = NULL;
>>>         int rc = 0;
>>>
>>> -       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN))
>>> -               return -EPERM;
>>> +       if (!file_ns_capable(f, &init_user_ns, CAP_MAC_ADMIN)) {
>>> +               rc = -EPERM;
>>> +               goto out;
>>> +       }
>>>
>>>         copy = memdup_user(data, len);
>>> -       if (IS_ERR(copy))
>>> -               return PTR_ERR(copy);
>>> +       if (IS_ERR(copy)) {
>>> +               rc = PTR_ERR(copy);
>>> +               goto out;
>>> +       }
>>>
>>>         root = d_inode(f->f_path.dentry->d_parent);
>>>         inode_lock(root);
>>>         rc = ipe_update_policy(root, NULL, 0, copy, len);
>>>         inode_unlock(root);
>>>
>>> +out:
>>>         kfree(copy);
>>> -       if (rc)
>>> +       if (rc) {
>>> +               ipe_audit_policy_load(ERR_PTR(rc));
>>>                 return rc;
>>> +       }
>>>
>>
>> The above comments also apply to here.
>>
>> -Fan
>>
>>>         return len;
>>>  }
>>> --
>>> 2.34.1
>>>
> 


