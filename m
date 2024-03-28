Return-Path: <linux-security-module+bounces-2288-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9B688A807
	for <lists+linux-security-module@lfdr.de>; Mon, 25 Mar 2024 17:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF8E1C61EAB
	for <lists+linux-security-module@lfdr.de>; Mon, 25 Mar 2024 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C812BF2C;
	Mon, 25 Mar 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMzGFaWe"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93284D31
	for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 13:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374025; cv=none; b=gMpWbKtchMzHxvEtcg39rtknuavhgJzOLm1ywhm/mNAG7h5AQMzs6T6FbcTy+uPzMiURyu1fktAbHqwmuV1sYEsLok3ZoQfrAWg7He+tizFFNNyWi2hTf3uQh3meWqHvlXlzfQ8I/gYfR/FxtzlLn4DIH6fZf4RFPT5xwdEcb7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374025; c=relaxed/simple;
	bh=4Wux5xa/CaSDeSCUYomCmTq0IllWEfYpxAtQo5oE6Es=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o75R+Zfgcibpbt58P7Plp6TgktzklMvq/Guc/gAC2d1eJNRZYIFGgvuf18OldEpoMd0Lmq0HL4u6hepENDrLcHAF77SkfqB+iNUX/7H4/J0ZEyYkvHkyYixXTP/QDIa2byZUeKLbClam3oQSZ5DZ3+99ywtdFM1JqiHPu9xlIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMzGFaWe; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc3645a6790so7651163276.0
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711374023; x=1711978823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVuQbOd4o/tS0DiPUw74ee5jBWWOCcrb2jESG2kQjGE=;
        b=hMzGFaWecjDgJpjLTmnrV5dLIO4gaCOC4eJuy8NmXt6RdoV/XFhJHOm52wJx59XQyP
         ewSbDYnuc1Wc5J85+d/iYDjp5snUMO1I8qpquSaNgUWoaioocN2hOlvsliw20U0Xrlkw
         LxDRs4cq9fV6v5e7di3tGlPpfEG4EEpy72YRbB2rySPgZK2ssvqUBnGMBWfim4/aOcGq
         euK6HIIh4I1+vfWaxNLG1fqKN5GlMtV2HeueZxLAycCgZQ48eTszHjp1KMpgf+IM1aTh
         5tCwJeL0ANo6O6aml8xBQvtA+FA3PMzmefVLdt6tBOOGBYqj+7oaiAZ++OXi7e66XBz5
         i0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374023; x=1711978823;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wVuQbOd4o/tS0DiPUw74ee5jBWWOCcrb2jESG2kQjGE=;
        b=kqhWfytmh7JepYU57mgcEBOGBa+iQL1vJMTRdogND+OOYT1X8knYmgQp6kzF0Tf6Cy
         7C9FzA7vrR9i8nfTeh4+3gepIIYRJf3vRSEjg+wjVPBwQq+RlWZTFydXDL5a5sO6UDtX
         egqIOAlxDxs9KfOyA8vHPELwKfQi2RH2KXKRW/rMVmo+gIJr4qWFg0BoefuZm4hev/J1
         0jRqEBwzGSXqVzTcovl7lvr11P3rvLLGx/uCKIBy8WDPfjpSrY1umxBbb8MwopvFjQI9
         Xa803ykfSbzE0k2/tZnmkkqqn5dlBax/DxtWJc/ey7SvRbpxVFKmKjVlZs4RxYfbAMX1
         g5CQ==
X-Gm-Message-State: AOJu0YzEfDHIMvQiBsu+x/ZZ4Cty79pToHqEi7KANFddH770AFclh7gh
	UkFcj6SR4BFOiSVNFOb8Jqa8C+DPYNYlIIiujXAD3dFmJtdN0vg8zrdvaFBa/KZI8BwAf9Peze6
	2Pt81Ov/kL3tICHv7HqwrTgGvQtulORGW8HhukqgE9mu0uZnqieuhEZlks1RvfuIL49lkkwnwK0
	tD9msa4aJvA4TN2k//7bkSWblZlus+wh72fuhxBhyWt7exg9khp0L0
X-Google-Smtp-Source: AGHT+IGbHwY+ql76rgvMtMpqDCHgkbKMuAT890a+SIB7RZm/uTFLU6O5lLvv1QatZwiQYzUapleJzG+fhB4=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:100a:b0:dc6:ff2b:7e1b with SMTP id
 w10-20020a056902100a00b00dc6ff2b7e1bmr2206018ybt.4.1711374023137; Mon, 25 Mar
 2024 06:40:23 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:40:01 +0000
In-Reply-To: <20240325134004.4074874-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325134004.4074874-7-gnoack@google.com>
Subject: [PATCH v12 6/9] selftests/landlock: Test IOCTLs on named pipes
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

Named pipes should behave like pipes created with pipe(2),
so we don't want to restrict IOCTLs on them.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index dde4673e2df4..d3aaa343f6e4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3933,6 +3933,49 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/*
+ * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
+ * because they are not character or block devices.
+ */
+TEST_F_FORK(layout1, named_pipe_ioctl)
+{
+	pid_t child_pid;
+	int fd, ruleset_fd;
+	const char *const path =3D file1_s1d1;
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	};
+
+	ASSERT_EQ(0, unlink(path));
+	ASSERT_EQ(0, mkfifo(path, 0600));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* The child process opens the pipe for writing. */
+	child_pid =3D fork();
+	ASSERT_NE(-1, child_pid);
+	if (child_pid =3D=3D 0) {
+		fd =3D open(path, O_WRONLY);
+		close(fd);
+		exit(0);
+	}
+
+	fd =3D open(path, O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	/* FIONREAD is implemented by pipefifo_fops. */
+	EXPECT_EQ(0, test_fionread_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+	ASSERT_EQ(0, unlink(path));
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
--=20
2.44.0.396.g6e790dbe36-goog


