Return-Path: <linux-security-module+bounces-11572-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E84B34E80
	for <lists+linux-security-module@lfdr.de>; Mon, 25 Aug 2025 23:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B99175E86
	for <lists+linux-security-module@lfdr.de>; Mon, 25 Aug 2025 21:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBCD288511;
	Mon, 25 Aug 2025 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="sWa0A0Mv"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15EC29D29B
	for <linux-security-module@vger.kernel.org>; Mon, 25 Aug 2025 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158994; cv=none; b=mSUKOBxsnduGjrGV+BOqd33IgExB3Ytvp5JuCCO0SEWBqKsKraA9wBOidAXS9S9if7cgPr3fdkF7jGPRDx/tCfWyTk43V3GD5eSULqHwpwdULtPdziKuGxNxjkzo59fF6v4t0XKv0vQj4FIaLCzsYjsImLaRRpQ1COtJiKW5Coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158994; c=relaxed/simple;
	bh=E4NpwkGR+z7tCPgrXM61r560kh8CJ5QMAuInswiHxfM=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=aieOjGT3Xhmoozr76ZSZDShdkzZFQOmKDyA/l3xAa384mZCg+feKaNlYwH2GiTITLPW+s1Uj3EMfK2TIMyw4Uq974/XfAjErtHhyTJteNZ/ploTOz3txpUHLkMlhvfL02MWqmB/qill+2sLKwtsv9c1CgxJfYY2NkTeTbf5Io10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=sWa0A0Mv; arc=none smtp.client-ip=209.85.210.50
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74382002fa6so2330981a34.3
        for <linux-security-module@vger.kernel.org>; Mon, 25 Aug 2025 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1756158992; x=1756763792; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vMUZfpgo6grl0jsKLi/4oV66VhEtUf3p7bHbykWpng=;
        b=sWa0A0MvK5+P5uaeMOcaaeZpDL2Y6ytjQXSyZTZkXg+xvVVoXEoTN4YGeJubfYcmyB
         g7edQF+a1SiQualHi5WBULobkH5fTtG6LKkDY2wngITDX+z2M+1DT2OUYJxX9WrHw3Ad
         mhh/vDlaHjEkWT+mgPGx6/T1vwNlkBeRfb7GeneOGj9uqtZK/Z1PBfv+E7PZVHo7YD6H
         2W8Tme9LnoJ449eSyRNSDZRNQrV9XGcRtDKxmvTe59lUglpQkeYS7+zaPDfXg8rkl3zk
         x1pmh9mOOLEuO2UADtj7onjEAPKN5enRnChLRno1AksFToU2pJgpuMG91InYZ8Xc+o91
         8nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756158992; x=1756763792;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0vMUZfpgo6grl0jsKLi/4oV66VhEtUf3p7bHbykWpng=;
        b=vIcsUMK2GWCn/E8ThkTAhlT7KUt8PRxERiAOTRFHpaYiFyH1mVOHYUYDMnUfbz6mU2
         Z3KkRVW0Nq55Pm4hHtoxkeKUp9mo760wKb3ZVSkqrJ01tXvvtCl7hO1T1jwPmP47IIVp
         HW4R0xXhh3A19eTopIgkOJgSG8FUr521/UHP+ggVoKoXIpPx/V3D0g9CKUicjvDmU5jw
         rtF+v+DxJHD6lZeXs0E26F88mw8kYzSaPipy91BODqN4A7Zt7avBF0BlzXs74buZLmmK
         dEEOojxpP/RaVPHw/ICLPccv77rCYsPqXzPEGP9ES1HSmYPrjigpXnjNSS+B/TBsVDwk
         np1w==
X-Forwarded-Encrypted: i=1; AJvYcCWI1RryvhANo3FGOq8BYZNaq1dPBpHGFHOAHycqjEQh6NWFu8ldgdwn3xGsbsnmyV1enVg0d/zzW7+Ic6NMaFN7Vdoq3l0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA4RpMu9zWBro+b0QR2etHslYk+H3loWbXgw77pSpQXMNYavCH
	irN6dC8/umok/DlyhVUD900IMnlTyCKo9UY4A5FH0xIg2mCHhnmybKZs43BtS2yNhQ==
X-Gm-Gg: ASbGncupW35UqNN3Hhv9hfURM2mTV/zUGJ+pwXhg9wZpRIaV6bHVJsUVPLkWopHIQX/
	h+ZDyT3Mo78zGM/HJbEAnnIbMjIbUYBlYjXXNe23fKgxDbNBjBuDtj8f9WI/UWAWBTYd9QXzNrx
	mRPF4u8CW4fwqVs4zr8i8hh+vjslHEL7GN59u+evbB/8WkB7uXm0WieUtFrvkCz9sVx5EdO08rj
	hjjw3mUtqaQ58b4Oh/rS1WL+WFZGE0t6M0+rvJbAnZW+/qqTBGfFsgr2ODSRfK0GvcPpt6g2VMd
	nwyTvSulZonVVfvS/Ki4cRJSgc7pAXao8MAJRWj1yGffuU1uB6goCGtVY4RKQ/IjFJrVQkV6YbD
	sAhvv8cANkuaFtNuX43Y78nH/SHWGSl+oDnBjqE+0pMHBU0hW
X-Google-Smtp-Source: AGHT+IH0zqh5am1c9LUhvOIUND3Fr27yx9vrRpjaozAjD1PSKH7Z/Iy6+QDwmQ4jNnG1UUqeW6IVzg==
X-Received: by 2002:a05:6830:2801:b0:744:f08e:4d30 with SMTP id 46e09a7af769-74500ae61e4mr8071485a34.35.1756158991618;
        Mon, 25 Aug 2025 14:56:31 -0700 (PDT)
Received: from smtpclient.apple ([2600:381:488a:4661:cde9:746f:9e0b:3479])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e28a027sm1987573a34.18.2025.08.25.14.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:56:30 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andy Lutomirski <luto@amacapital.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
Message-Id: <F0E70FC7-8DCE-4057-8E91-9FA1AC5BC758@amacapital.net>
Date: Mon, 25 Aug 2025 14:56:18 -0700
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>,
 Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Heimes <christian@python.org>,
 Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
 Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Luca Boccassi <bluca@debian.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Robert Waite <rowait@microsoft.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Scott Shell <scottsh@microsoft.com>, Steve Dower <steve.dower@python.org>,
 Steve Grubb <sgrubb@redhat.com>, kernel-hardening@lists.openwall.com,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
To: Jeff Xu <jeffxu@google.com>
X-Mailer: iPhone Mail (22G100)

=EF=BB=BF
> On Aug 25, 2025, at 11:10=E2=80=AFAM, Jeff Xu <jeffxu@google.com> wrote:
>=20
> =EF=BB=BFOn Mon, Aug 25, 2025 at 9:43=E2=80=AFAM Andy Lutomirski <luto@ama=
capital.net> wrote:
>>> On Mon, Aug 25, 2025 at 2:31=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
>>> On Sun, Aug 24, 2025 at 11:04:03AM -0700, Andy Lutomirski wrote:
>>>> On Sun, Aug 24, 2025 at 4:03=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
>>>>> On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
>>>>>> On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
>>>>>>> Add a new O_DENY_WRITE flag usable at open time and on opened file (=
e.g.
>>>>>>> passed file descriptors).  This changes the state of the opened file=
 by
>>>>>>> making it read-only until it is closed.  The main use case is for sc=
ript
>>>>>>> interpreters to get the guarantee that script' content cannot be alt=
ered
>>>>>>> while being read and interpreted.  This is useful for generic distro=
s
>>>>>>> that may not have a write-xor-execute policy.  See commit a5874fde3c=
08
>>>>>>> ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
>>>>>>> Both execve(2) and the IOCTL to enable fsverity can already set this=

>>>>>>> property on files with deny_write_access().  This new O_DENY_WRITE m=
ake
>>>>>> The kernel actually tried to get rid of this behavior on execve() in
>>>>>> commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that had
>>>>>> to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
>>>>>> because it broke userspace assumptions.
>>>>> Oh, good to know.
>>>>>>> it widely available.  This is similar to what other OSs may provide
>>>>>>> e.g., opening a file with only FILE_SHARE_READ on Windows.
>>>>>> We used to have the analogous mmap() flag MAP_DENYWRITE, and that was=

>>>>>> removed for security reasons; as
>>>>>> https://man7.org/linux/man-pages/man2/mmap.2.html says:
>>>>>> |        MAP_DENYWRITE
>>>>>> |               This flag is ignored.  (Long ago=E2=80=94Linux 2.0 an=
d earlier=E2=80=94it
>>>>>> |               signaled that attempts to write to the underlying fil=
e
>>>>>> |               should fail with ETXTBSY.  But this was a source of d=
enial-
>>>>>> |               of-service attacks.)"
>>>>>> It seems to me that the same issue applies to your patch - it would
>>>>>> allow unprivileged processes to essentially lock files such that othe=
r
>>>>>> processes can't write to them anymore. This might allow unprivileged
>>>>>> users to prevent root from updating config files or stuff like that i=
f
>>>>>> they're updated in-place.
>>>>> Yes, I agree, but since it is the case for executed files I though it
>>>>> was worth starting a discussion on this topic.  This new flag could be=

>>>>> restricted to executable files, but we should avoid system-wide locks
>>>>> like this.  I'm not sure how Windows handle these issues though.
>>>>> Anyway, we should rely on the access control policy to control write a=
nd
>>>>> execute access in a consistent way (e.g. write-xor-execute).  Thanks f=
or
>>>>> the references and the background!
>>>> I'm confused.  I understand that there are many contexts in which one
>>>> would want to prevent execution of unapproved content, which might
>>>> include preventing a given process from modifying some code and then
>>>> executing it.
>>>> I don't understand what these deny-write features have to do with it.
>>>> These features merely prevent someone from modifying code *that is
>>>> currently in use*, which is not at all the same thing as preventing
>>>> modifying code that might get executed -- one can often modify
>>>> contents *before* executing those contents.
>>> The order of checks would be:
>>> 1. open script with O_DENY_WRITE
>>> 2. check executability with AT_EXECVE_CHECK
>>> 3. read the content and interpret it
>> Hmm.  Common LSM configurations should be able to handle this without
>> deny write, I think.  If you don't want a program to be able to make
>> their own scripts, then don't allow AT_EXECVE_CHECK to succeed on a
>> script that the program can write.
> Yes, Common LSM could handle this, however, due to historic and app
> backward compability reason, sometimes it is impossible to enforce
> that kind of policy in practice, therefore as an alternative, a
> machinism such as AT_EXECVE_CHECK is really useful.

Can you clarify?  I=E2=80=99m suspicious that we=E2=80=99re taking past each=
 other.

AT_EXECVE_CHECK solves a problem that there are actions that effectively =E2=
=80=9Cexecute=E2=80=9D a file that don=E2=80=99t execute literal CPU instruc=
tions for it. Sometimes open+read has the effect of interpreting the content=
s of the file as something code-like.

But, as I see it, deny-write is almost entirely orthogonal. If you open a fi=
le with the intent of executing it (mmap-execute or interpret =E2=80=94 make=
s little practical difference here), then the kernel can enforce some policy=
. If the file is writable by a process that ought not have permission to exe=
cute code in the context of the opening-for-execute process, then LSMs need d=
eny-write to be enforced so that they can verify the contents at the time of=
 opening.

But let=E2=80=99s step back a moment: is there any actual sensible security p=
olicy that does this?  If I want to *enforce* that a process only execute ap=
proved code, then wouldn=E2=80=99t I do it be only allowing executing files t=
hat the process can=E2=80=99t write?

The reason that the removal of deny-write wasn=E2=80=99t security =E2=80=94 i=
t was a functionality issue: a linker accidentally modified an in-use binary=
. If you have permission to use gcc or lld, etc to create binaries, and you h=
ave permission to run them, then you pretty much have permission to run what=
ever code you like.

So, if there=E2=80=99s a real security use case for deny-write, I=E2=80=99m s=
till not seeing it.

>> Keep in mind that trying to lock this down too hard is pointless for
>> users who are allowed to to ptrace-write to their own processes.  Or
>> for users who can do JIT, or for users who can run a REPL, etc.
> The ptrace-write and /proc/pid/mem writing are on my radar, at least
> for ChomeOS and Android.
> AT_EXECVE_CHECK is orthogonal to those IMO, I hope eventually all
> those paths will be hardened.
>=20
> Thanks and regards,
> -Jeff

