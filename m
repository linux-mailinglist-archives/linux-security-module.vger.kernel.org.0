Return-Path: <linux-security-module+bounces-2568-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D194D89A637
	for <lists+linux-security-module@lfdr.de>; Fri,  5 Apr 2024 23:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE781C2143D
	for <lists+linux-security-module@lfdr.de>; Fri,  5 Apr 2024 21:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53186175549;
	Fri,  5 Apr 2024 21:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0punSIxU"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5482176FAD
	for <linux-security-module@vger.kernel.org>; Fri,  5 Apr 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353292; cv=none; b=B/w+uUR5Jtot6UJSv1x+Z4AyChHwSssRdhnxuG7UJDPapBneQhSm8CNRu0i/n6X1B5oSk87eoMX3ZA66g7MdX16ViNj3YZZHFSPOlkAFTt2M8X/cqIbA5ckQAeJQdgifaz+DvibShk6aR0gnd/9Ial4JJgjsHHVubBTPpfQfinU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353292; c=relaxed/simple;
	bh=9Bvm7wkelXg3zuWpOV1qRg281JzLxe+nmHUyb7/CNOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M1o0fQqClxi0iyRcPE+Gn8fVkmj6EtjHghYA3d3XxICItsIc23OPVU1lEk98JjDzPeLdkPmVvcmoD8SN4vFnm3kbiuMRpLVLwZyCsVHQfjnVEEAZ3+g87lOYAhMObokIH+d6MuZVQd6v87BHinYPIVadZqMkS/SzwcY7K7LHwm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0punSIxU; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-56bf2d59fceso2209467a12.3
        for <linux-security-module@vger.kernel.org>; Fri, 05 Apr 2024 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353289; x=1712958089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ultcrwgHPiEzFAA7CCqNmrNyImFBzR16Q+4Vi/kOOJw=;
        b=0punSIxUMLsY2JjaLX1i4t4nNfdqVYiFp/m6QIZrY9cRLfyuVdXHDMB1MYpF5sUGwV
         kLlbYQyZL9wEYLYSlxTwBrpQVzBcxoeghdKNoMhRdSNNBDXUoBNmctthPGRe3GJsEAzA
         b5FrYNmaoAVguSJKCZg83MDO+ukqbwI3sKAe1WQt0Q3xULmtLi8QPSmzR1FwGc5nmCte
         qm+ywgb1kelQK8jjpq9MIFGDyA/GDLtURthNYrvvXh2sLdv7SNoqguXqvi6eY7g1QPOw
         1yZIYMzT8C6vKxiEQCeIw3n5zy4mc4PwhLW9SD7ux9jnfKCl5IpqN4nfLl8oAgkrMD5P
         TGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353289; x=1712958089;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ultcrwgHPiEzFAA7CCqNmrNyImFBzR16Q+4Vi/kOOJw=;
        b=qnYHl0ojpt5ns9+VZLgwAIvPZXh1qzJUVOElZc/PxZVsnpvuz9NgkDE9Enzm9xk0M7
         PiJfVy7Sl1AXG6k2pEgM1a9q3oBEK+F2mSq78iWeEQYHQe0a1bFd4HNEMQ5TDQOInDm5
         8ndl/iQ2KoR0BXVSHRBYFGikFrYnmAVP1R1ohIsu8wqPlqwyOgy1EKvcvLLBTsEhAH5p
         WVQGRgK6/oxslZ5gTyoZwgaM6nvdHWPvpaHQ8Zl0Qnmfqd7PxxDoHX9GvqHTEnhuK+vc
         ngGu8NCr6kL9yfeSdwVEaIZyKIKkuiAGr+jkl28GbnXeqvOFloCYwiqq7rAdym/A/c+Y
         +N2g==
X-Gm-Message-State: AOJu0Yztp+2GONUO/GdFd4B0NeMBqdO5FTMwuSx1kDlIedOmVK86p3sR
	XK8j1/BPEKBa5SZ2RgAe7n71ncvWir+sG+YR0pt4K0yjzu2KuBTkiSz99skLzxOgIJybXLOhu8u
	Pmgmk2gCx+llLyTgDUEmTzaQ4ovai4+f6GsbJIHspzJz7a08a0GjLUK0bMwmNltglFG/SBhVT2T
	v0bpp5FrIhT6z75TIiqi8KcfWiBxkH59Hw/jWeh+T4xnA7VQ1AF3sK
X-Google-Smtp-Source: AGHT+IEi1Tr0mj+N7k8dKKy59BA8xsPweUC3pHZOcuxUXuM6/XMmqRsc/RxPwvLE6a6FEGS8k5AJIoSe0jY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:321e:b0:56c:4d33:10a5 with SMTP id
 g30-20020a056402321e00b0056c4d3310a5mr4157eda.2.1712353289057; Fri, 05 Apr
 2024 14:41:29 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:37 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-10-gnoack@google.com>
Subject: [PATCH v14 09/12] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL_DEV
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add IOCTL support to the Landlock sample tool.

The IOCTL right is grouped with the read-write rights in the sample
tool, as some IOCTL requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 8b8ecd65c28c..e8223c3e781a 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
 /* clang-format on */
=20
@@ -202,11 +203,12 @@ static int populate_ruleset_net(const char *const env=
_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
=20
 /* clang-format on */
=20
-#define LANDLOCK_ABI_LAST 4
+#define LANDLOCK_ABI_LAST 5
=20
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -320,6 +322,11 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 		ruleset_attr.handled_access_net &=3D
 			~(LANDLOCK_ACCESS_NET_BIND_TCP |
 			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
+		__attribute__((fallthrough));
+	case 4:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
--=20
2.44.0.478.gd926399ef9-goog


