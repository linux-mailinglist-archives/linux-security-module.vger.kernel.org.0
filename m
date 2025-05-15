Return-Path: <linux-security-module+bounces-9963-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66688AB8899
	for <lists+linux-security-module@lfdr.de>; Thu, 15 May 2025 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B40B4E3D94
	for <lists+linux-security-module@lfdr.de>; Thu, 15 May 2025 13:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AED41A3152;
	Thu, 15 May 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="eSmpYmn1"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648417A30B
	for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747317392; cv=none; b=b8/2QoISG1/hi5Xj8ly/wGjbhbIEnMTZv6r7LwLi0oAN3Kg/krJRIIvY2FLU3RC86W2SaSHFfCf12NjO5K8tJ+YJvp6yvyZYDmw+gtZAM9hNvsBygZsHtTYH+OJ3EO7qznvSbzq+jPQ3g0dzQXe2pgKFB4Uylt6hl3LRAVHRfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747317392; c=relaxed/simple;
	bh=Sa7GETTQgwfVClLUd5WysYho63CW2Ury9OOVP7i4C9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMXgnJo+YqHFWmiZLH2r7m3L7JAVb0Z97uhvxHHkDywtmqLo8WulMjaznxAIiVJ3CMeBj+a8Ome9aw8DvbE9/Hn9Z3taJDacUCme/WKq+0hCBHCmnT2rQluD4u10+DLCAgBJ3pto1A3fMeH8iHjC5ThudC/ThNo5TC9cZL/YWYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=eSmpYmn1; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-550d4b7a076so1079769e87.2
        for <linux-security-module@vger.kernel.org>; Thu, 15 May 2025 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747317387; x=1747922187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rm0gTtyW2LsxAMkxrNunR4Q/6X7D+Ybvvf7I2m4z9Sc=;
        b=eSmpYmn1Iqh85u9V2kvbtizkz5IuhNwsCxMFXJ3JWMHEM9hDezYfUMf4SERrjznqgj
         M5AW/pYk4myxOrz2rDN1HxUfSmtjQDvE/laJn3yuKs5oXWUGqgp2q3u4KscinaH01CeY
         ZMctDsdcl8UKK9/v6T0YYvMVBl5sd/4tm6R2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747317387; x=1747922187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm0gTtyW2LsxAMkxrNunR4Q/6X7D+Ybvvf7I2m4z9Sc=;
        b=sJ4oYT10j2R13mhtrdccHzjdUHCmSEcXZJnQNhJ4c0zEz1QDLsNBQF5m6MlGdewwEQ
         IRt27MS0PZkC+7DgYd8jCVTOIhcZZlZEt4hSv91+9mu+Nue233e05z0miygs7JEivB2i
         /MGgF8MisuC+5uYqBAdZ20slzS8MDByguLLkkqGm1gX1rT7Vh/54coJ5RAMUxlh3j8BO
         7XyWdl+lyoF4u40Fxcs41Kh40feXTjPUyDKvticRIC5QTlcibMx0C4vw6RtM3cJJDl1v
         zACNfVE4OJC/MWoRQd1LMQexrrbULfQx7Qv+pgzEI/P0wbfd55muS7B5lbURDAwQThp8
         jucA==
X-Forwarded-Encrypted: i=1; AJvYcCVaDM18Bhr/JUDd6h90xf+/L+UnrGCOwO8FJtvdjHHqU0uV8kzb6+s3UaCGFHX6wQPfBdgZ7H+nmgEGiw1IYmJkzmjVIBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Mv2D+qu0GB8GBlGg9LeOoyRPC7AlE8laH7+Tg73WJXwNl0iE
	wrZouYn2UI/Z1VTnfX8jmP2kLodOoR8y88t+JoLzU2/4290dhCt7HSVmxmaMj1guwnCunX4aQng
	BPykbF2d5Eg6S3Ait28U60WmZSAEEYJmylVMLYg==
X-Gm-Gg: ASbGncumIKGswymoR8xnaQjwWDk28b5y0QNzoGuuR3U8JxE0P3ajgASIaTZEjewYcdd
	2aaKTeJNDU0C8+BmzjtYRM4wsdzRoXNhLJGgZXH0A89JfUE+/i+i/sXnGen+BE0P5EO6KlegIGk
	fmwNrSCSAxYJrueJgboyMSw9MMD81Z5QUH/A==
X-Google-Smtp-Source: AGHT+IHGJpz7aWTwl9mwnxLim4Wu4UpJRoyZSChwbFUtfQOjHxlGMmgBOj6a+6ZvRKFBtH84qKDoTSz+2awicFIRtmo=
X-Received: by 2002:a05:6512:3183:b0:549:5b54:2c6c with SMTP id
 2adb3069b0e04-550dd00417amr888488e87.23.1747317385975; Thu, 15 May 2025
 06:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-6-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 15:56:14 +0200
X-Gm-Features: AX0GCFtkXNTU1UNhCQJwYHTj0HQMppT1zbtgyuIpAsA_JMgRpL61RCC5l6sfyU8
Message-ID: <CAJqdLrq4sCbCV7pjVdtSktsgwA-PWrgrY=_gFn0pVTQ59ZTtNw@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] coredump: show supported coredump modes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Allow userspace to discover what coredump modes are supported.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index bfc4a32f737c..6ee38e3da108 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1240,6 +1240,12 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
>
>  static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
>  static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
> +static char core_modes[] = {
> +       "file\npipe"
> +#ifdef CONFIG_UNIX
> +       "\nsocket"
> +#endif
> +};
>
>  static const struct ctl_table coredump_sysctls[] = {
>         {
> @@ -1283,6 +1289,13 @@ static const struct ctl_table coredump_sysctls[] = {
>                 .extra1         = SYSCTL_ZERO,
>                 .extra2         = SYSCTL_ONE,
>         },
> +       {
> +               .procname       = "core_modes",
> +               .data           = core_modes,
> +               .maxlen         = sizeof(core_modes) - 1,
> +               .mode           = 0444,
> +               .proc_handler   = proc_dostring,
> +       },
>  };
>
>  static int __init init_fs_coredump_sysctls(void)
>
> --
> 2.47.2
>

