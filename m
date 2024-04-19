Return-Path: <linux-security-module+bounces-2778-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 871D88AB2F7
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Apr 2024 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 100DCB2317B
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Apr 2024 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC9131E51;
	Fri, 19 Apr 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N5v//4VE"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2029B131BB8
	for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543105; cv=none; b=mj3RFlO0bGZqM920QVfNaH8V9pwv2fMRet0BrSiztkLUO9vv88761noKcBT6hfYK7nx5Fb5sp+wcgJJgAKlV3gPeGhsGN6/BGrRavvsdcl60RbyVe0m7r3UnnRRDOOoAHkmfle9vzp48nu+u4vtgiczc/IGoiLGvNTh/92U3WbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543105; c=relaxed/simple;
	bh=kh5QUAcOI7RBZEN5h8SIH0WFDUJ09lkH33NG6IWE3bo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=myr+OK+d/F6Zt18vaQnZBcmJxUP+cgkKQjMJijb2u2io84JYMPPhiVo3kG1FhohQNR3WI2z/HL1pVLVBAs4j/e0DV9lATIfOS1GyEaUEkJfdURP9bpsHRF4TBoCbjbaU/HBcUdsLHJf7XoHua7Tk30hpMJ4gEevDnTksBCgPXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N5v//4VE; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a558739aaf4so51515566b.0
        for <linux-security-module@vger.kernel.org>; Fri, 19 Apr 2024 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543102; x=1714147902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1ztm+fTKPRtSermP05/SXl1UA012b6wxHzpXmBHXE4=;
        b=N5v//4VEt+FM3/kzKgdjjKJ0YrZu02qhx4ij36QOtnwmjP2kJ7UHZWywX9vfuYOlUp
         wJ6Pq7D5lHA1q1vCpDQFY2+kbseu7ECIKoxN8fswX6MRvaTIptrTpCi2XtJGWLaMYKhc
         o3dPS3lpVovkGan/DvWcS/kcaRdjOlbPMzOXpXs/GHNa1hA1tX5/uctq7btTTRXjk0w5
         YA9m7zQzhZ8ker+dJiy/k7JHQ3ZgVo2gfj7cU031C1LLQNg188ISmIV2Rm5jK09FHj6O
         UOjcaJ75ZJZpVTdFuxhtEjGXkl9ohTw64YE8LW9uNGNmmfnlqLH52jzjim7JKyByjUze
         W/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543102; x=1714147902;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s1ztm+fTKPRtSermP05/SXl1UA012b6wxHzpXmBHXE4=;
        b=d6AtHAxY0zyWN9HnVZolOz63hOiruei0qqS2RVgjbRYcQ7hSUq3t3rn36mggkfaqFN
         g8/7yGYU03MiTivK3FwxNxvwxmTYHRFZrMdNu4DREcq+N5sZ4MafhdAld1rWbYqGi6V5
         W4ieZvwJfprWKFbpaeunHcGD/HHP64YRDharuBugLziGl4E3ayMjaa4hZKUlAND9uEDo
         j9eeR7GfDLwiecZR8UiGqS78L02qB3YkED/rjIE/9Y6h8bttFIHWtU6paTEVNOb53ybC
         O3PwVpMuLlnbq+azzwO67LV9kA/VHy0Lzlbbkzztl/QDTWjpbluGujB6Ec0BlGTAa7bl
         qcqw==
X-Gm-Message-State: AOJu0YzJdS+cbN1WECdGgVMS/udjFwNs+T6UqoM9hKto7psodwD3F8V8
	2bV9nTGnDqSh4KbtwRMMqFdI76+XI4Mg+SYI+D9iHx3m42IaMSeV8Je4WzNlb6mV3LKqModQhMZ
	7EQJ6WzH9MtzGivVbnVSfdxB+NeOEsS05x/UV0PF/ajUDgKc7g4QpR71u5BTAaCk+ZVhTYKtz8n
	cPYkQhoz4tHHVxQX5rmusfQIIwzx9yVcpSBVIqrksqs7GlpJrmxF4S
X-Google-Smtp-Source: AGHT+IFZYiNXpHftrPvrXtHYkK2NuClawtjOOgaCzFHrQYBnDdkHEsWaDY5Icuy9ZBLfKKYYuAdCrh6qRfQ=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:2cea:b0:a55:63c1:8c4c with SMTP id
 hz10-20020a1709072cea00b00a5563c18c4cmr2441ejc.4.1713543101742; Fri, 19 Apr
 2024 09:11:41 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:16 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-6-gnoack@google.com>
Subject: [PATCH v15 05/11] selftests/landlock: Test IOCTLs on named pipes
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
index 2cfda6af71ab..f4c6b9fadef8 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3935,6 +3935,49 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
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
2.44.0.769.g3c40516874-goog


