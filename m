Return-Path: <linux-security-module+bounces-8363-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB69A46D71
	for <lists+linux-security-module@lfdr.de>; Wed, 26 Feb 2025 22:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CB216C0EE
	for <lists+linux-security-module@lfdr.de>; Wed, 26 Feb 2025 21:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F5258CEA;
	Wed, 26 Feb 2025 21:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XLUz3v5K"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD425A32B
	for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 21:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605374; cv=none; b=qp60rD8ahWECXic4064BpF2gjn8JIE/8eFHd1RkzaaLkNNpujQlFnRI/H7YCWv+swboHnJsxaJhGNUTbNUg2Rh/jPGTRn49g6gc3VfIfmJdGeZ7M0R9lKNSag6t2Y2JAQJzTL1h1afeTmTUFJQCeJX78Rx1L4fvShyX5XWFYu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605374; c=relaxed/simple;
	bh=XXTwWlw1L9cwIcmTWNye83rNwNtDzGMGXdQYVArGHhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YNoXQXXwXdp6447xyORd1RzVQq7GIDeC0Pp5dQqzocv+jZLrewQhbwqzaqvjdMcS7xvQIvLcZ0xuUoX1w5Jtj9rirZarSQNixeyPB+tMCnBQnaIBbD+O6cVKZoybdzX7jLbyYt1dSq6wRk/ml/0kYaErRu5nSmA/saSloq2SO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XLUz3v5K; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5ded3946ff9so200519a12.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Feb 2025 13:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740605371; x=1741210171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nN4dXLnIhtrQjDRqDmg2MbFTVMB4VifRQCbR5CB0zc=;
        b=XLUz3v5KEP790Tj22vC7Q0utJQgMBtOnhWfN20SOlPIryD0VN5rrY8MGSAE9jKR1+7
         ++CZsKXvPcakpEuzo6O5pMOoebbuEbBC0AuJVqRUvZmQIuwZ+IofF/WUrMj9UIMMUo1y
         HREHAe6tRT1HMrhzHZ+Jc6vqTTD6DQmjXo+EUSoNDHTSzkYmZxdhPUH6CNPR7d3vGlvM
         8LVm4ys99Tt+GGZntC7COvTHmpgwvx9o0FJlsRD1PIurf6rlT3d+9meJ88yEmGsCoCBR
         xLC2DqaDn3TmcJXIBrA7XaDZcqx+A511awFUm3eAKhSSr9fRNoivV/u2DffvREtmvNjw
         h7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740605371; x=1741210171;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9nN4dXLnIhtrQjDRqDmg2MbFTVMB4VifRQCbR5CB0zc=;
        b=hon8uxKqCdNtyjql5fOjMlvvGMEnFEDCl8Ev3ZenXRV3TqbZou02wwsIfGahS57ckH
         o9PlmkkXhlmxZ/DVAqYecJuDBveuKc2HseNSEC4WCNZzfknpBU5Y9ezC/TvtMF/YE+0l
         2Ch+EFJkerNzv3V+psskgoUMExmfqhhPfSB5X6TTBLlVpIB9JtPHpwczvyOWRCV0Hp7W
         TpXC0LqMivjlexFlKoZDtLgBmgZB8X0IXbfM2MKpUIWs7eZ+CltcIsRyXp4/IevcmZVT
         p3VMdlbBxjxtubGItrnYEK0tSDkZpcQOObMnbLwKp6ojT96NHPI8+hsSJqc/sxjrVT7g
         E+mA==
X-Forwarded-Encrypted: i=1; AJvYcCXsPGa8qxYFktW/LQ6p4OZg/5i4FmZG7iiINHLmq9JBXK2OBYgySIIma2MngwKLC7IJU9P8qqVBDIrZJNeJAXT5qukm06o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGmhcOxDkNXcFnS3BHfMA9JL29rpcGfsukUH8aiUA1k6dCPBEU
	ugw2dVK3l0pyR69S4FeP434g4yR0I41JqnJyJXFS1zeeAiKd6xz51K3OMpkZTOXl2QCXQ3iODr8
	93Q==
X-Google-Smtp-Source: AGHT+IGv/GkWVe0gNZYe/hOcPG4QFSoRFwGh9MrB7hoq2kITgCM8++OEqBDA2m6G8muYjGs4XFfloqxeZ6w=
X-Received: from edbew14.prod.google.com ([2002:a05:6402:538e:b0:5dc:8f78:6eb2])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:26ce:b0:5de:d6c3:111a
 with SMTP id 4fb4d7f45d1cf-5e4a0d491e8mr5378253a12.3.1740605370922; Wed, 26
 Feb 2025 13:29:30 -0800 (PST)
Date: Wed, 26 Feb 2025 22:29:12 +0100
In-Reply-To: <20250226211814.31420-2-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250226211814.31420-2-gnoack@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250226212911.34502-4-gnoack@google.com>
Subject: [PATCH v2 3/3] landlock.7: Clarify IPC scoping documentation in line
 with kernel side
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Alejandro Colomar <alx@kernel.org>, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, Tahera Fahimi <fahimitahera@gmail.com>
Cc: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Tanya Agarwal <tanyaagarwal25699@gmail.com>, 
	linux-security-module@vger.kernel.org, linux-man@vger.kernel.org, 
	Daniel Burgener <dburgener@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

* Clarify terminology
* Stop mixing the unix(7) and signal(7) aspects in the explanation.

Terminology:

* The *IPC Scope* of a Landlock domain is that Landlock domain and its
  nested domains.

* An *operation* (e.g., signaling, connecting to abstract UDS) is said to
  be *scoped within a domain* when the flag for that operation was set at
  ruleset creation time.  This means that for the purpose of this
  operation, only processes within the domain's IPC scope are reachable.

Link: https://lore.kernel.org/all/20250226211814.31420-4-gnoack@google.com/
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 man/man7/landlock.7 | 73 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/man/man7/landlock.7 b/man/man7/landlock.7
index 30dbac73d..42cd7286f 100644
--- a/man/man7/landlock.7
+++ b/man/man7/landlock.7
@@ -357,46 +357,43 @@ which means the tracee must be in a sub-domain of the=
 tracer.
 Similar to the implicit
 .BR "Ptrace restrictions" ,
 we may want to further restrict interactions between sandboxes.
-Each Landlock domain can be explicitly scoped for a set of actions
-by specifying it on a ruleset.
-For example, if a sandboxed process should not be able to
-.BR connect (2)
-to a non-sandboxed process through abstract
+Therefore, at ruleset creation time,
+each Landlock domain can restrict the scope for certain operations,
+so that these operations can only reach out to processes
+within the same Landlock domain or in a nested Landlock domain (the "scope=
").
+.P
+The operations which can be scoped are:
+.P
+.TP
+.B LANDLOCK_SCOPE_SIGNAL
+This limits the sending of signals to target processes
+which run within the same or a nested Landlock domain.
+.TP
+.B LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
+This limits the set of abstract
 .BR unix (7)
-sockets,
-we can specify such a restriction with
-.BR LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET .
-Moreover, if a sandboxed process should not be able
-to send a signal to a non-sandboxed process,
-we can specify this restriction with
-.BR LANDLOCK_SCOPE_SIGNAL .
+sockets to which we can
+.BR connect (2)
+to socket addresses which were created
+by a process in the same or a nested Landlock domain.
+.IP
+A
+.BR sendto (2)
+on a non-connected datagram socket is treated as if it were doing an impli=
cit
+.BR connect (2)
+and will be blocked if the remote end does not stem
+from the same or a nested Landlock domain.
+.IP
+A
+.BR sendto (2)
+on a socket which was previously connected will not be restricted.
+This works for both datagram and stream sockets.
 .P
-A sandboxed process can connect to a non-sandboxed process
-when its domain is not scoped.
-If a process's domain is scoped,
-it can only connect to sockets created by processes in the same scope.
-Moreover,
-If a process is scoped to send signal to a non-scoped process,
-it can only send signals to processes in the same scope.
-.P
-A connected datagram socket behaves like a stream socket
-when its domain is scoped,
-meaning if the domain is scoped after the socket is connected,
-it can still
-.BR send (2)
-data just like a stream socket.
-However, in the same scenario,
-a non-connected datagram socket cannot send data (with
-.BR sendto (2))
-outside its scope.
-.P
-A process with a scoped domain can inherit a socket
-created by a non-scoped process.
-The process cannot connect to this socket since it has a scoped domain.
-.P
-IPC scoping does not support exceptions, so if a domain is scoped,
-no rules can be added to allow access to resources or processes
-outside of the scope.
+IPC scoping does not support exceptions via
+.BR landlock_add_rule (2).
+If an operation is scoped within a domain,
+no rules can be added to allow access
+to resources or processes outside of the scope.
 .\"
 .SS Truncating files
 The operations covered by
--=20
2.48.1.711.g2feabab25a-goog


