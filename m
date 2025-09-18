Return-Path: <linux-security-module+bounces-11535-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D374EB2FC5B
	for <lists+linux-security-module@lfdr.de>; Thu, 21 Aug 2025 16:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB79517A6B0
	for <lists+linux-security-module@lfdr.de>; Thu, 21 Aug 2025 14:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1B027C152;
	Thu, 21 Aug 2025 14:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NjWlSLMI"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A444227BB9
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785902; cv=none; b=FiW/hccUA6rcCzIiAaXAkv+lklHGI4TCN0VomJ5de9b84BDFd+2A0ToNxdoFiNEvOlMUxQZPPaiDvjbq/4EEcQAEx5qE2eFjMTVVxLYG3BvlIFs+LD6RvGoxBXmvlpbuh5YjozW15RJ/XoHLz9IDqlQh5i1ycTuyglM5XA+9jbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785902; c=relaxed/simple;
	bh=DRxA2Mr7tAlP7mml4fnsmqjKOt/UWu9kygiH1kCB3Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA9bhNdKN/ILHdYgY7tK3/RhP+1VbQgkAxO+xI4UoKKAEijnUuCBOFrb/1nqjDheL3fhwIdtqtXwi0+H6tpMyZ51uQIRgvtrKtJr8z79g/tWKAdj9HXE26s/Lu9MeAH8p46kWU5jGwdk3FaHFBqk16+fAL0YEIVJrO0jP9zF1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NjWlSLMI; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 52CC63F7BF
	for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1755785890;
	bh=xivpZzkVPbgG+fnH/V11vQdkwMaAtGL75jEXMbnaGYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=NjWlSLMIa2/Ua751akUuvltz+/BLBKMOZu4yiczMmnRCkyV+/l3vmY7rc1Y3uYWXg
	 xAaeIi0ldk+V7U5GChNd2eARNZEfuL77BGLUAAMspc+GdeVxDd7+TyvNYog7Lca9CB
	 F1vnkjPMvQKcTg5GYuyhgv+otgu7g6Jr+j7qNlz4YGb6V19csr8I/fEgW3+oFYNvv/
	 RMg9SeS3UnrH10t8JCpsxAqv/Jg8Ks3Vq/cWDaIxS/VMfwdZYhAzuXnGDrtgFG0z/i
	 9HfUMADEfKEzZLNYwnBdM1t3FolT25HcsDn775NsaA8K/z78bWrMhzG6DvgdNx+iTw
	 TmvA/C/t5QKKA==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47173afd90so1882998a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Aug 2025 07:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785886; x=1756390686;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xivpZzkVPbgG+fnH/V11vQdkwMaAtGL75jEXMbnaGYc=;
        b=lMuWAlNsVZBagDFZpYOCAPct8d0ZFS6fQB1lSOGObbaqhAltUMM0sVXRs71gw58DC9
         sOl35hEWK3RX1eHUmIrP/tfI0xjULIN3JbVif+s0k5SaLQEBDsWBYPCx8fvcjjKwPmEL
         Wusyg/FrU1KzWmD2LwOWJh+CwPNqM473zyxayD+6ENjAKe5/kPCtWhYk9DBYO8jTmmEz
         dkNTntIubAMxtbd8FKvCyGlM6z++oNxWJgqKWWjvL2xt+Z6c3jydMEZDDZVKXgKkThGH
         NMStpqptR69DzIav40gHheEoj+Wwpa5RP5vrUJNPcQhCuvBYAQgIkSIy6+xnRdaSXXJS
         BXLA==
X-Forwarded-Encrypted: i=1; AJvYcCWZUoDHto1i3xqULq34YIV3voLrKBcMKobSaE+ZmSL3O4wqsEV5PhOCTMMADJCgi78ofwxtNmjn4tS3nxVAccXgZooGUMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzggctQvv9N+bf2+T7T8XHcMmytGd41D90Z9LpB6KmrG1hE3lnG
	YIoQX/u299iLKhufU3uQCZizTKT+synUpsbxOlA99uOngNfigAJ3oCToiWLplL48FgJShrBH2AT
	/4j/Qs+oW16dLnhng+4lFvkCKTXEDJfGcMRhHvbBNlAGCS5pm+7OgURzkcJmUEwu0WomV63eBIn
	8097WRxR7DbGdYnJMV5g==
X-Gm-Gg: ASbGnctTk+RV06dQO9iPpDdm9GWf7rNe1iwNucU4q3gWcztYZa5zsa2j0unYNUmCIJE
	aTRhwqAy0C+USVd0jxo0T3wCowc62GJcSMCMcp1ABYytQ5TZZC0dF0QlUTCZR/yLdytuk0lWg+u
	Ao6Sa8ZqgDIyzmHAEJv5/bCKcubIp0vnpPPTzQo3ExBRQnKYtLchctBQEoiFUd4tkK5zdHFdOLL
	8ZtldeFOI6yitMUQ0/K6RkLxM0TYbGs1LVoSNxrsTHPfFwKnX9lHxfRW2vHrcCvaQMfx9QnjlWn
	AtxcuT3mnyRQzS0aIzNWISCQgMtuTgUjaeZIsmLwSj69gOCeiabP/A==
X-Received: by 2002:a05:6a20:3c90:b0:240:160b:81bf with SMTP id adf61e73a8af0-2433080c5ebmr3944869637.19.1755785885573;
        Thu, 21 Aug 2025 07:18:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWw2ijxFxOY9UJOsrIQAJ1QeMU+CP9CyvYz/5XkQc4bVahPj96yuHIJPEYTbn0gNnzdb/i4A==
X-Received: by 2002:a05:6a20:3c90:b0:240:160b:81bf with SMTP id adf61e73a8af0-2433080c5ebmr3944791637.19.1755785884974;
        Thu, 21 Aug 2025 07:18:04 -0700 (PDT)
Received: from [192.168.192.85] ([50.39.98.232])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b4763fba4cesm4976540a12.9.2025.08.21.07.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:18:04 -0700 (PDT)
Message-ID: <fa4792f1-6f18-4299-88ee-bdf2f736e372@canonical.com>
Date: Thu, 21 Aug 2025 07:18:03 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LSM namespacing API
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <CAEjxPJ5EvR+2fboLu_nBGZu+ZVUpX4KM6xdPUqDErCmw=iA37g@mail.gmail.com>
 <CAHC9VhSubXA4tAUoz7T==UvfrM_DXS6nF5s0tJZ1HrrVizMgZA@mail.gmail.com>
 <20250820.ieNg1quoRouz@digikod.net>
 <CAHC9VhS3c257ywxADRzPYE-DsXSwRp8P2RhAfdDnXJHOX5bXTQ@mail.gmail.com>
 <20250821.Ree4Liedeita@digikod.net>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250821.Ree4Liedeita@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/21/25 02:56, Mickaël Salaün wrote:
> On Wed, Aug 20, 2025 at 04:47:15PM -0400, Paul Moore wrote:
>> On Wed, Aug 20, 2025 at 10:44 AM Mickaël Salaün <mic@digikod.net> wrote:
>>> On Tue, Aug 19, 2025 at 02:51:00PM -0400, Paul Moore wrote:
>>>> On Tue, Aug 19, 2025 at 1:47 PM Stephen Smalley
>>>> <stephen.smalley.work@gmail.com> wrote:
>>
>> ...
>>
>>>> Since we have an existing LSM namespace combination, with processes
>>>> running inside of it, it might be sufficient to simply support moving
>>>> into an existing LSM namespace set with setns(2) using only a pidfd
>>>> and a new CLONE_LSMNS flag (or similar, upstream might want this as
>>>> CLONE_NEWLSM).  This would simply set the LSM namespace set for the
>>>
>>> Bike shedding but, I would prefer CLONE_NEWSEC or something without LSM
>>> because the goal is not to add a new LSM but a new "security" namespace.
>>
>> I disagree with your statement about the goal.  In fact I would argue
>> that one of the goals is to explicitly *not* create a generic
>> "security" namespace.  Defining a single, LSM-wide namespace, is
>> already an almost impossible task, extending it to become a generic
>> "security" namespace seems maddening.
> 
> I didn't suggest a generic "security" namespace that would include
> non-LSM access checks, just using the name "security" instead of "LSM",
> but never mind.
> 
>>
>>>> setns(2) caller to match that of the target pidfd.  We still wouldn't
>>>> want to support CLONE_LSMNS/CLONE_NEWLSM for clone*().
>>>
>>> Why making clone*() support this flag would be an issue?
>>
>> With the understanding that I'm not going to support a single LSM-wide
>> namespace (see my previous comments), we would need multiple flags for
> 
> I'm confused about the goal of this thread...  When I read namespace I
> think about the user space interface that enables to tie a set of
> processes to ambient kernel objects.  I'm not suggesting to force all
> LSM to handle namespaces, but to have a unified user space interface
> (i.e. namespace flag, file descriptor...) that can be used by user space
> to request a new "context" that may or may not be used by running LSMs.
> 

Yes to a unified interface, no to an LSM wide namespace. The interface
could request of the LSM to namespace, but its up to the LSM what it
will do. If it creates a namespace, whether that namespace is hierarchical,
or flat.

You would at the end of the call likely get a proxy object to a set of
individual LSM namespace contexts. Not that different than you have a
set of different system namespaces, mount, pid, user, ...

>> clone*(), one for each LSM that wanted to implement a namespace.
> 
> My understanding of this proposal was to create a LSM-wide namespace,
> and one of the reason was to avoid one namespace per LSM.  As I

no each LSM will do its own thing wrt namespacing. The proposal is just
to provide a common API and minimal infra around it.

> explained in my previous email, I think it would make sense and could be
> convincing.
> 
I have to agree with Paul that we won't generically agree on what an LSM
namespace should be.

>> While clone3() has expanded the number of flag bits from clone(),
>> there is still a limitation of 64-bits and I'm fairly certain the
>> other kernel devs are not going to be supportive of a flag for each
>> LSM that wants one.
>>
>> Maybe we could argue for our own u64 in cl_args, or create our own
>> lsm_clone(2) syscall that mimics clone3(2) with better LSM support,
>> but neither of these seem like great ideas at the moment.
> 
> My idea was that using CLONE_NEWLSM would just fork the current/initial
> namespace used by LSMs to tie security policies/configurations to
> processes, but as John already said, it would be the responsibility of
> each LSM to either inherit and keep in sync the parent policy (e.g.
> SELinux) or start with a blank/default one (e.g. Yama).
> 
Its not just these options though. The container manager may want to
"drop/add" an LSM.
Eg. one fedora/RH booting an Ubuntu container your host has selinux
the container wants apparmor.

In reality you have both selinux and apparmor active on the system,
but selinux is an enforcing state, and apparmor is in a no-policy
state.

selinux could deny creating the namespace, it could return its current
state, or it could mask itself by creating a namespace for the container
with the default unconfined_t policy, but its current state is still
there bounding the container, the container just doesn't see it.

On the AppArmor side at the request for a new namespace with apparmor
it needs to decide what to do independent of what selinux does. Yes
if configured correctly it should setup its policy namespace for the
container, but it has choices just like selinux that are driven
by policy as well as the userspace request for a specific combination
of LSMs for the cntainer.

> One way to configure a newly created namespace could be to load a
> configuration in the parent namespace (e.g. with one of the new LSM
> config syscall and a dedicated flag) that would only be applied to child
> namespaces when they are created, similarly to attr/exec for execve(2).
host injecting policy into the container certainly could be supported
but I think that would be a per LSM thing.

attr/exec flags Paul was discussing (correct me if I am wrong), where
a way to specify which LSMs should but part of the unshare. So the
whole I want a container to support Ubuntu or RH and need these LSMs.

> I think this is what you meant with the LSM_UNSHARE flag, right?
> 
Per my above understanding the LSM_UNSHARE flag is then just a
namespacing that indicates you want to unshare the LSM and use the afore
mentioned attrs.

I don't think it is actually needed, but maybe desirable for consistency.
If you have already set the above attrs, that already indicates what
you want to do with the namespace at clone/unshare.

This then gets fed into every LSM (whether in the attrs or not). So they
can make current policy decision, and then if allowed, as second hook
with the info, so that they can each setup and return with their context
setup. Not really all that different from exec.

>>
>>>> Any other ideas?
>>>
>>> The goal of a namespace is to configure absolute references (e.g. file
>>> path, network address, PID, time).  I think it would make sense to have
>>> an LSM/MAC/SEC namespace that would enforce a consistent access control
>>> on every processes in this namespace.
>>
>> Once again, I'm not going to support the idea of a namespace at the
>> LSM framework layer, individual LSMs are better suited to implementing
>> their own namespacing concepts.  However, I do support the LSM
>> framework providing an API and/or helpers to help make it easier for
>> individual LSMs and userspace to create/manage individual LSM
>> namespaces.
> 
> Should we still talk about "namespace" or use another name?
> 
its namespaces for LSMs, just not an LSM namespace.

>>
>>> A related namespace file
>>> descriptor could then be used with an LSM-specific syscall to configure
>>> the policy related to a specific namespace (instead of only the current
>>> namespace)
>>
>> That is a reasonable request, and I think the same underlying solution
>> that we would use for setns(2) could also be used here.
> 
> I'm not sure having a set of namespace file descriptors without related
> clone flags would be acceptable, at least for what we currently call
> Linux "namespace".

well Paul did propose a single Clone_LSM flag that would cover them ;-).

Agree with Paul that a per LSM flag would be unlikely and just raise the
whole, security is crazy why can't you agree on one "fun".


