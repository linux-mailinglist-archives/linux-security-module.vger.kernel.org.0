Return-Path: <linux-security-module+bounces-3539-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327D78CFC25
	for <lists+linux-security-module@lfdr.de>; Mon, 27 May 2024 10:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 641B51C21942
	for <lists+linux-security-module@lfdr.de>; Mon, 27 May 2024 08:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6048E200A9;
	Mon, 27 May 2024 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UXKgjLEf"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB5B69D31
	for <linux-security-module@vger.kernel.org>; Mon, 27 May 2024 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716799744; cv=none; b=F5TS4QUO+K0ZYVyoV14zRfFukzc/CtaHf+bSDJSCX+z+tkapTvgQspXzCJPIbhFOKx8xLY3mlrqxa5vMRezWMovsKOTWNcSMsl2SGMhku6oicYBgHy3PZpNeKcwmuqLqTRFyOBzFcRF1eSNDQECuV8tO0eyun5Rg7G6+8a/dYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716799744; c=relaxed/simple;
	bh=6hnkCumVKeX0lruCxCw3rgX0CDGw6k01picz6DuzG8Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dwLsar/Q8fP8F7b2qL73qp9NTH02vUIy8p9Kw0wtunvPVPkKYDtgIf/ouixtpK4p2zr89XW6ECfZmiDHPSkxJHQBOrS7SjNnoKIhz9Ln5YtaJSljXTbaiP8igv3y3+jI/QxjV/4fDup2kXYzBwRFOQQBR3hrriGP1OiP8QrncCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UXKgjLEf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df4f32e9f46so3766179276.0
        for <linux-security-module@vger.kernel.org>; Mon, 27 May 2024 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716799742; x=1717404542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNR5DO1CHyjpfDZYPq+x3L8T7L/dl362JOK4DfPxNZs=;
        b=UXKgjLEfwAgzJtkWtzpTfSgNW8EAItvJMecdcczX07IUcrLAF//xS5IegXyvtUai4+
         jxkLLLeL/fqifPA/mEz5jHU6h1CHYbSIvEQ/hRunv69PwQ1e1Gfqe2ldgOrwLd2/Etfh
         rMQSRUWNxxqcAn5NB07xJHfvgolg6KwyB2bqBUU2hTUnegymEdaQUQYeEgNTNDjh51wY
         d6BsdK1YQuOujIUrx4I2QIwsHAxMNYZdfE+k/bOTAatDE28uFMX1oiaclWC7roOFcV88
         nz2XG9WDoWW+NIqk7PH4ikGuIxhmmRt5SEoOThHEudFJioAnrJBmgJq+tXhrPLqqA7/I
         YiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716799742; x=1717404542;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dNR5DO1CHyjpfDZYPq+x3L8T7L/dl362JOK4DfPxNZs=;
        b=DfgGLW9a0W9t5oRWdxusJDkMdK45J0HKePbIof1A2P134/15bWRSSw3D669oCQ93gj
         fqZ4Fr8pVsFmrW9ekFLU1DbzTqKopOWZFlvNwmgiliRQQmq6E97hP78o+oWSvGXU60uq
         RO+4FeuiKzu6Bbwr8+MVOKP29ZqhDobxiU/qln4j2m0GO6o0hOT6Gwn2N2zjNfF+UlYc
         6DN3REL6vqnKTLiiOyf4VGNxfgMfg0WHwxv/Txx0CQZhTw44/dyU7PlBMswzcksHIcRZ
         ugXholVibNwnOnq4H6ETzrQgZFpa/R9qLPi/LIPxNMPi5jAnPxwqsI+F8CMgU5KAq2Uh
         BF7w==
X-Forwarded-Encrypted: i=1; AJvYcCXGh+/5mx9FWymYb7ReBYjOA8dAUDdYlTBahABAPfg4k//AfqLr8mjHRKk+smqeD3YW0c/oGmyuf9KQVM8NhPC3Eszua9Q5kxYTklMh3ext3GaTHMgp
X-Gm-Message-State: AOJu0Yx2SGjIgYtNUx93tkodNvYjTX9rA1ESG8P8fU7qslchL3b/oPSs
	C0HjOu9PHLG+dMqvm/NQNFyM4Ekug/uc+oStwbsY+7TRDE/CmGq6SZYPxTu5vAmLwm/iurK56Y0
	Rfw==
X-Google-Smtp-Source: AGHT+IHJLKjrAfYMfR23BMucCCENKd9d4PeuadLwUvN/ob+x/lnn2t/ndL57JaArcRK5IeZd70rpBAatIAQ=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:d341:0:b0:df4:8ff6:47f4 with SMTP id
 3f1490d57ef6-df7721580c8mr2525115276.1.1716799741829; Mon, 27 May 2024
 01:49:01 -0700 (PDT)
Date: Mon, 27 May 2024 10:48:58 +0200
In-Reply-To: <20240524093015.2402952-3-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240524093015.2402952-1-ivanov.mikhail1@huawei-partners.com> <20240524093015.2402952-3-ivanov.mikhail1@huawei-partners.com>
Message-ID: <ZlRI-gqDNkYOV_Th@google.com>
Subject: Re: [RFC PATCH v2 02/12] landlock: Add hook on socket creation
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Mikhail!

Thanks for sending another revision of this patch set!

On Fri, May 24, 2024 at 05:30:05PM +0800, Mikhail Ivanov wrote:
> Add hook to security_socket_post_create(), which checks whether the socke=
t
> type and family are allowed by domain. Hook is called after initializing
> the socket in the network stack to not wrongfully return EACCES for a
> family-type pair, which is considered invalid by the protocol.
>=20
> Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>

## Some observations that *do not* need to be addressed in this commit, IMH=
O:

get_raw_handled_socket_accesses, get_current_socket_domain and
current_check_access_socket are based on the similarly-named functions from
net.c (and fs.c), and it makes sense to stay consistent with these.

There are some possible refactorings that could maybe be applied to that co=
de,
but given that the same ones would apply to net.c as well, it's probably be=
st to
address these separately.

  * Should get_raw_handled_socket_accesses be inlined?
  * Does the WARN_ON_ONCE(dom->num_layers < 1) check have the right return =
code?
  * Can we refactor out commonalities (probably not worth it right now thou=
gh)?


## The only actionable feedback that I have that is specific to this commit=
 is:

In the past, we have introduced new (non-test) Landlock functionality in a
single commit -- that way, we have no "loose ends" in the code between thes=
e two
commits, and that simplifies it for people who want to patch your feature o=
nto
other kernel trees.  (e.g. I think we should maybe merge commit 01/12 and 0=
2/12
into a single commit.)  WDYT?

=E2=80=94G=C3=BCnther

