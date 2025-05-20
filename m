Return-Path: <linux-security-module+bounces-10060-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9349ABCB3E
	for <lists+linux-security-module@lfdr.de>; Tue, 20 May 2025 01:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182913BF633
	for <lists+linux-security-module@lfdr.de>; Mon, 19 May 2025 23:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA50121FF26;
	Mon, 19 May 2025 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="kDgEZLfI"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D020DD42
	for <linux-security-module@vger.kernel.org>; Mon, 19 May 2025 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747695670; cv=none; b=FPrx0GpQ6A9aix1HNApZhGOVQLseLUKJks1yqIGLf5N5P9sRiwm4C/1nTlJJN7s6E5JZiMrmz492Xy5ORYQXDckN95bGUXvUxcb2CNbjjkVXvUm+Qi1IyLkPSmM35gp/3iVLP9QVPcuPD80Nwk1WgIUHR/HOmbJiK3uTGKynKtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747695670; c=relaxed/simple;
	bh=ATNfJvLN2RdaN37+gdMKwi/xRzkT0JCaUkz0KtZ8TQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfUbETTjkNCdfQ3/Yt1Js5FEMXl1+AZ/blhJlT6N35E0P2YWe+T2VrJUectWvaz3UIbiU09obKfokWXfO3OtpqkuUvjVq44/iCX4XmxtJwXVuyJsTb1s/40tk9zaX1ksWsa1gpgMCW8IvwyuINbt96wms7JH0kFGMi0BQwUwCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=kDgEZLfI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-231e98e46c0so26659615ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 19 May 2025 16:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1747695668; x=1748300468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waKOIo5gUpaOrddr0SeUUhd92poB67UKhg23Qr5hz4U=;
        b=kDgEZLfIPPqxh3mPPkkQc8tiIaXyWhglgExZyHVdEBDXSWK2BpCtfJuEQQ1agNk+MK
         k6S2YIdCaI+SAFllgi7KB14FRvdRkl97XrgJQtVDvQBeD6fI5Rzgx07mFuLLozbshxQg
         dIBpNXPXWti20/K/dq+hApSSUwKPVm0qHqNCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747695668; x=1748300468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waKOIo5gUpaOrddr0SeUUhd92poB67UKhg23Qr5hz4U=;
        b=BitR9W+CuU8/W3AJD2rvedVgxdNdqRKhV+ggALcRrbpVq3Fqm2gMvtVzaDdfyv0lvW
         2QeNpfFAZnaCjUY1Ri2+WH1fyYeQ8bkVUnDSKhNWvlFRv/QI76g++ckJvgsqUVmVGfN7
         RRO9jwFPgOKpluvq0ah47MDkN3oJ9qkMhtr0msnDURAjlXY59ajHT9BgqFNUiX+yvSqa
         MmI682FVgMGU0t0DrxSceisdW6MvLNXN+O9NsxqyJM+khVrVDasv0lY8NnLKvJcSGT9K
         Aw/xPml+B7gw0nXNuTd67aD8XqNnvgMKTH/ShWQ0zR8qsncZlEV6VaP4vaJ2Uo0y66+M
         3nmw==
X-Forwarded-Encrypted: i=1; AJvYcCX/vpWiT7HWHbo6LEwjAqmOMwnFFK4j0IYer86AZmJjHdE8qB2nM2VqM6ayEZegkWNB8vfDVZ4dclC5QtlEqwN6zAxPjWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUEHwe9I/ZDgKUHwuDZuFXNKrCqAxaHa2O+Q2WcVdXhLRQb3ih
	kSs4Uq1RV0C3rOOjHhDTBA5W8EYATryUNMHw6bWdaqkQbhMDR71MjYW5ZlNpYmx5VzAmAlu6PIw
	O4b4K5Y1R5FSvc6pltph+BNQ/SnckD5SSF4w0W79J7w==
X-Gm-Gg: ASbGncuuq9u40rFX2Uk6e/uODJuukAPJ4GGSUe8QuHOJ8XIBm1fxWetW60LUWIgS6rC
	YxexEfr2Lf+8xSlwP0gJFfyOw4oCBbdOs692+flmhye3eqMXDdvv6vP7jtML6Yr6hZbYYzog40m
	MipRHYaSkmYRnUAl9sieO02X2AMjHzdz4g
X-Google-Smtp-Source: AGHT+IGqGkiGQXKjNuOS/Jzhro9EPxplPI4zYl45YFPAd3e+QPi6agsft/NyAicfvCJMfzlVT/0v96mFansDA2bGSpo=
X-Received: by 2002:a17:902:da86:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-231d4596c6cmr217126845ad.40.1747695667964; Mon, 19 May 2025
 16:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502184421.1424368-1-bboscaccy@linux.microsoft.com>
 <20250502210034.284051-1-kpsingh@kernel.org> <CAHC9VhS5Vevcq90OxTmAp2=XtR1qOiDDe5sSXReX5oXzf+siVQ@mail.gmail.com>
 <CACYkzJ5jsWFiXMRDwoGib5t+Xje6STTuJGRZM9Vg2dFz7uPa-g@mail.gmail.com>
 <CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com>
 <CAHC9VhQL_FkUH8F1fvFZmC-8UwZh3zkwjomCo1PiWNW0EGYUPw@mail.gmail.com>
 <CACYkzJ4+=3owK+ELD9Nw7Rrm-UajxXEw8kVtOTJJ+SNAXpsOpw@mail.gmail.com>
 <CAHC9VhTeFBhdagvw4cT3EvA72EYCfAn6ToptpE9PWipG9YLrFw@mail.gmail.com>
 <CAADnVQJ4GDKvLSWuAMdwajA0V2DEw5m-O228QknW8Eo9jxhyig@mail.gmail.com>
 <CAHC9VhTJcV1mqBpxVUtpLhrN4Y9W_BGgB_La5QCqObGheK28Ug@mail.gmail.com>
 <CAADnVQ+wE5cGhy6tgmWgUwkNutueEsrhh6UR8N2fzrZjt-vb4g@mail.gmail.com>
 <196e1f03128.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <CAADnVQ+=2PnYHui2L0g0brNc+NqV8MtaRaU-XXpoXfJoghXpww@mail.gmail.com>
 <CAHC9VhRKZdEia0XUMs2+hRVC7oDzkBfkk5FPMD+Fq5V7mAk=Vg@mail.gmail.com> <CACYkzJ7oxFA3u9eKDpKgCsZsYsBojVJPHVeHZnVaYQ5e9DavmQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7oxFA3u9eKDpKgCsZsYsBojVJPHVeHZnVaYQ5e9DavmQ@mail.gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Mon, 19 May 2025 16:00:56 -0700
X-Gm-Features: AX0GCFsSVZRnQmnvW7OAmjsIttCmabXOOvUXwiDYzPKxxMnJVpGcvnqs-JPLKgE
Message-ID: <CAC1LvL2F_WbObrdcumVZCKc7yLeq4e9PQhYHrLiyVzpzf=V_Xg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Introducing Hornet LSM
To: KP Singh <kpsingh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, bpf <bpf@vger.kernel.org>, 
	code@tyhicks.com, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, 
	David Howells <dhowells@redhat.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>, 
	James Morris <jmorris@namei.org>, Jan Stancek <jstancek@redhat.com>, 
	Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Schier <nicolas@fjasle.eu>, nkapron@google.com, 
	Roberto Sassu <roberto.sassu@huawei.com>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Shuah Khan <shuah@kernel.org>, Matteo Croce <teknoraver@meta.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, kysrinivasan@gmail.com, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 3:20=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> On Sun, May 18, 2025 at 11:34=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Sun, May 18, 2025 at 11:52=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Sat, May 17, 2025 at 10:49=E2=80=AFPM Paul Moore <paul@paul-moore.=
com> wrote:
> > > > On May 17, 2025 12:13:50 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > On Sat, May 17, 2025 at 8:03=E2=80=AFAM Paul Moore <paul@paul-moo=
re.com> wrote:
> > > > >> On Fri, May 16, 2025 at 7:49=E2=80=AFPM Alexei Starovoitov
> > > > >> <alexei.starovoitov@gmail.com> wrote:
> > > > >>> On Fri, May 16, 2025 at 12:49=E2=80=AFPM Paul Moore <paul@paul-=
moore.com> wrote:
> > > > >>>>
> > > > >>>> I think we need some clarification on a few of these details, =
it would
> > > > >>>> be good if you could answer the questions below about the
> > > > >>>> authorization aspects of your design?
> > > > >>>>
> > > > >>>> * Is the signature validation code in the BPF verifier *always=
* going
> > > > >>>> to be enforced when a signature is passed in from userspace?  =
In other
> > > > >>>> words, in your design is there going to be either a kernel bui=
ld time
> > > > >>>> or runtime configuration knob that could selectively enable (o=
r
> > > > >>>> disable) signature verification in the BPF verifier?
> > > > >>>
> > > > >>> If there is a signature in union bpf_attr and it's incorrect
> > > > >>> the prog_load command will be rejected.
> > > > >>> No point in adding a knob to control that.
> > > > >>
> > > > >> I agree that when a signature is provided and that signature che=
ck
> > > > >> fails, the BPF load should be rejected.  I'm simply trying to
> > > > >> understand how you envision your design handling all of the case=
s, not
> > > > >> just this one, as well as what build and runtime options you exp=
ect
> > > > >> for controlling various aspects of this behavior.
> > > > >>
> > > > >>>> * In the case where the signature validation code in the BPF v=
erifier
> > > > >>>> is active, what happens when a signature is *not* passed in fr=
om
> > > > >>>> userspace?  Will the BPF verifier allow the program load to ta=
ke
> > > > >>>> place?  Will the load operation be blocked?  Will the load ope=
ration
> > > > >>>> be subject to a more granular policy, and if so, how do you pl=
an to
> > > > >>>> incorporate that policy decision into the BPF program load pat=
h?
> > > > >>>
> > > > >>> If there is no signature the existing loading semantics will re=
main intact.
> > > > >>> We can discuss whether to add a sysctl or cgroup knob to disall=
ow
> > > > >>> loading when signature is not present ...
> > > > >>
> > > > >> As mentioned earlier this week, if the BPF verifier is performin=
g the
> > > > >> signature verification as KP described, we will need a LSM hook =
after
> > > > >> the verifier to serve as an access control point.  Of course tha=
t
> > > > >> doesn't preclude the addition of some type of sysctl/cgroup/what=
ever
> > > > >> based access control, but the LSM hook would be needed regardles=
s.
> > > > >
> > > > > No. New hook is not needed.
> > > >
> > > > It would be good for you to explain how the existing LSM hook is su=
fficient
> > > > to authorize the loading of a BPF program using the signature valid=
ation
> > > > state determined in the BPF verifier.
> > >
> > > I already explained:
> > > .. a job of trivial LSM:
> > > if (prog_attr doesn't have signature &&
> > >    (task =3D=3D .. || task is under certain cgroup || whatever))
> > >   disallow.
> >
> > I read that earlier reply as an example that covers a sample use case,
> > I didn't realize you were asserting that was the only approach you
> > were considering.  Perhaps that was the source of confusion earlier,
> > we may disagree, but I don't intentionally "twist" words; not only is
> > that rude, it's just stupid in public, archived discussions.
> >
> > As I mentioned previously, we really need to see an explicit yes/no
> > flag from the BPF verifier to indicate that the signature on the BPF
> > program has been validated.  It really should be as simple as adding a
> > bool to bpf_prog_aux which the BPF verifier sets to true upon
> > successful signature validation, and then an LSM can use this flag as
> > input to an access control decision in a hook placed after the
> > verifier.  Are you objecting to the addition of a flag in the
> > bpf_prog_aux struct (or some other struct tightly coupled to the BPF
> > program), the LSM hook after the verifier, or both?  It would also be
> > helpful if you can elaborate on the technical reasons behind these
> > objections.
>
> Neither the aux field, nor the hook are required because:
>
> * If the signature is passed, it will be enforced, there are no
> "runtime aspects" that need to be configurable here.
> * What the LSM can specify a policy for is when a signature is not
> passed, for this, it does not need an aux field or a signature or the
> new hook, existing hooks are sufficient.
>

What about wanting to create a policy that requires signatures under certai=
n
situations and allowing the lack of a signature under others? How is that
implemented with the existing hooks?
As I understand it, all the existing hooks know (would know) is that _if_ t=
here
is a signature _then_ it will be enforced. There is no way to know _whether=
_
there is a signature.

An example policy I can think of is that most users (with CAP_BPF) must sub=
mit
signed programs but some users are exempted. Would that policy be able to b=
e
made with the current hooks?

> - KP
>
> >
> > --
> > paul-moore.com
>

