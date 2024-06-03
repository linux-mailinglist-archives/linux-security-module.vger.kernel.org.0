Return-Path: <linux-security-module+bounces-3652-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FF8F9F70
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Jun 2024 23:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2BB6B24F5C
	for <lists+linux-security-module@lfdr.de>; Mon,  3 Jun 2024 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C213C811;
	Mon,  3 Jun 2024 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N1eI4ZhZ"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E913C698
	for <linux-security-module@vger.kernel.org>; Mon,  3 Jun 2024 21:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717450952; cv=none; b=AQnngnqFss4vJKf5og3qtVaTX3FpvPoVs+ohaWLbQpZ1WkZB7fuQ8r5a+owexqHn8LiYt1mldAeZ5fKZm43tmreOzn2HFQNkUUTZkAwd5yoQ9cVpZXEz/tOMX0HR7i2bfQZFR7pRC7qUN0xT/qOMlQlQ6G8zK7dPWv3FptB8b1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717450952; c=relaxed/simple;
	bh=t2+3hpTAkuvcywD1/Fq+cZAsXxs3N6zMjhMfwGrJHIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fd2ClzfMrCWQ0CJBGDDRxY3ms3zxnHvZ0DPZluubXNPBBJfBg/dCRxxb56+IYkLuyQelX1Mhvu31c00nCuOLsPudRWIN4AAuFBnDqaOTGb1vkbCy4S9Nv+umxiRLBieYll4RclMtneUbTX0Kw2UeouDfJ2KWZsZqhRQCQ8VJHBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N1eI4ZhZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so368618766b.2
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2024 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717450949; x=1718055749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=N1eI4ZhZlPjf68UnhLGKgEctRtMjOntNIkVhWbizskPmuiRECFIehLROdwxyzTQ9AH
         S9cP0MBrkfaqe7srvrEyx01OYady8bCw+zGe0+e6RweNuBb176fwD8b5ZT0cNBTt5D0R
         vn7DjORx+6oRGzNKhQi4sA6ri3UvO20Z+ast4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717450949; x=1718055749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+C9bWbF6JQXXqqT/WHs93C1W49YzDnZgVk3vpecOx4=;
        b=hNW328zN75SIqowOARZ33SbBgrmmzwYw0TzVOcjClnQCG6q10lmDPl2vXOrEeY0lEj
         KutR1ntD1ZwuNK6Wywzo1D/9rcyipyR5PIqrRYlBobb9GIuPfoEO1ifmXHUnTT/iZ4Zn
         lSaqj6sr7s6rug/xF8lfXEeZ9BgBotLTo1M6YQpD2ys6q/3exz9gpTTAf7rKi+xFPfFQ
         NMD1OLA70tjdVdXJ6gI/iKyFIpCNl59/3xNYGP8d2ZEEYh8TSZAT+88CB+vjhCfvozaU
         kORLM0gpybH6XHcUdksBJSj1YYJ5pydcFYMmmNOhu2ODV3qWZxR1iGPaTUcOF7l2NMcs
         8/qA==
X-Forwarded-Encrypted: i=1; AJvYcCVzHiC5+nzhDIRI0iHa13YmH20c1p4P91C/kx8icLtMjjEbVbpE+ccNzZ67D+RTzqyhgIlg57NPTWGDqFhYLQQO9EPTwHYoPqNBxyMEmJBj3w39dgNz
X-Gm-Message-State: AOJu0YyGBDiZ8rKjMFaXEaK/m4DWDtHoIGj1VB1NGnCQpfZAdyQxx4a2
	79lpjW6V3B9uChUjp0csfOZ4sVWzaWBkdQKrgtMVCKJS6BbLAVM3nPJOSLr/lzDhXMecdx+vtRL
	yckE=
X-Google-Smtp-Source: AGHT+IGjbb2XdVeE3L3zS3hlmzdfZ3e5mdmN3WUX7UpNZ9RdF406Nxd8OnciqcCmwNRVBtCg48/CQQ==
X-Received: by 2002:a17:906:7c8d:b0:a62:4b4d:5447 with SMTP id a640c23a62f3a-a6821b76639mr815927966b.62.1717450948842;
        Mon, 03 Jun 2024 14:42:28 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e6f02e45sm543151366b.29.2024.06.03.14.42.27
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6267778b3aso436309566b.3
        for <linux-security-module@vger.kernel.org>; Mon, 03 Jun 2024 14:42:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCQE/eWkgGCgWUvgW742cS1Suhvf9hD669JyQ05QBMbX/i2Bf/uo5ut3I3pm0OQlKUzF+6ymFsz2s1lSQXgpQAaw0fy8d8Rz6JfM7DHcGFkrf+zEHE
X-Received: by 2002:a17:907:9482:b0:a68:c6c1:cd63 with SMTP id
 a640c23a62f3a-a68c6c1d466mr478691866b.13.1717450947222; Mon, 03 Jun 2024
 14:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home>
In-Reply-To: <20240603172008.19ba98ff@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 14:42:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Message-ID: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 14:19, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> -               __array(        char,   comm,   TASK_COMM_LEN   )
> +               __string(       comm,   strlen(comm)            )

Is this actually safe is 'comm[]' is being modified at the same time?
The 'strlen()' will not be consistent with the string copy.

Because that is very much the case. It's not a stable source.

For example, strlen() may return 5. But by the time  you then actually
copy the data, the string may have changed, and there would not
necessarily be a NUL character at comm[5] any more. It might be
further in the string, or it might be earlier.

                  Linus

