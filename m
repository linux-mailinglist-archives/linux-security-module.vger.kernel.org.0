Return-Path: <linux-security-module+bounces-258-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB5C800D7A
	for <lists+linux-security-module@lfdr.de>; Fri,  1 Dec 2023 15:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF60281B01
	for <lists+linux-security-module@lfdr.de>; Fri,  1 Dec 2023 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0D93E46F
	for <lists+linux-security-module@lfdr.de>; Fri,  1 Dec 2023 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6HaY4mU"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F91707
	for <linux-security-module@vger.kernel.org>; Fri,  1 Dec 2023 06:31:06 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-a19a0e00b01so76430766b.1
        for <linux-security-module@vger.kernel.org>; Fri, 01 Dec 2023 06:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701441065; x=1702045865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJWw2rRjw+FDrrYDfq9YfgKPcMoC9hgcly6YCJoqp+o=;
        b=Y6HaY4mUezI5cwEfI0bEktLzGiSqfIZImpPE4ajZhxDnLw2cNGUHcCruHclV6IkKBr
         ydozwf/Cjq8vcgIfFleNpMlrZoKqYEvi+rw3YwbxaoQ2y8yMl93JQXIYzCZBuMKKKzVX
         Ot8ASAZZZ3Og4D/O9dCO2ksAbz9UOxD14/xO1veH+AhTpFfgwAqQilZk8fXIT8rC68NQ
         1bfr4JlLgwor0sZklCUxHYm8o54tLNAu+IdKfDepY686GFh0ZBh+btd5Jf2Ljm36EuGo
         uq2g1hgkCW1lGStl70rA2imR9I6ERv8VqFbM29/ay1HU45VZ1gqlLe83JvgiDcRj6B5S
         QZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701441065; x=1702045865;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AJWw2rRjw+FDrrYDfq9YfgKPcMoC9hgcly6YCJoqp+o=;
        b=PTr5H/DvfkHK+x++PozW8pWZtqPDWR+a0HhJZWLfFMmcROT0w96mytq1/lFXkqKCaI
         SuJhng5d9a93cDc32bBA6nZ9rYtD89Szo8FosR8nFp3LCi8vPGYdUCAhe8YT8QxG5GgM
         WQwKQhAqxI9Hq5UouJL0Evn2xg0UMctZ8FeWVyuatRxk/8yIvN41or/Ct8QhsAEPFvum
         OXK7/yJXhD79C2vlnE9CSB2HDVA/gjAZJE7MOD9JIY77gANN6BlhG3/4YKvPd0dXn9rl
         v+kBKuPJCoV01yVaRMFJchhyvGcg4dd2a/PtN4t3++X6xmSNwlvsxlUrpXBmbBIFhlMU
         Es1w==
X-Gm-Message-State: AOJu0Ywe2VbwFp6B+LvjtpRqIOWahVegfXI68NVRcAjyUS//KKHOIcBi
	W/hDdK15M0An3iJ7jQCkTPpR+J9Fz0nsRVZhMkMIKXt8aF3VZZAGQHRGZmPzFeA1mENaZljs3sm
	YVZ/9VX5i7qC/JuGJ/DsoMqtzNMiuqqMr62gp8+8W2KsgXS9ikh97oG+lp0hjgwMMFRw94DTqTA
	6P1be9xw==
X-Google-Smtp-Source: AGHT+IFXsCXx8MdE7l3mXTtAfoa1oP5eyclSq6CkBWakVGPK8BdZFksa8u0QvBVAq9ZxbgiDJH4RC6UOLcg=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:fab0:4182:b9df:bfec])
 (user=gnoack job=sendgmr) by 2002:a17:907:6b86:b0:a11:a891:7345 with SMTP id
 rg6-20020a1709076b8600b00a11a8917345mr140176ejc.13.1701441065349; Fri, 01 Dec
 2023 06:31:05 -0800 (PST)
Date: Fri,  1 Dec 2023 15:30:39 +0100
In-Reply-To: <20231201143042.3276833-1-gnoack@google.com>
Message-Id: <20231201143042.3276833-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231201143042.3276833-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v7 6/9] selftests/landlock: Test IOCTL with memfds
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because the LANDLOCK_ACCESS_FS_IOCTL right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 054779ef4527..dcc8ed6cc076 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3841,20 +3841,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
 	return 0;
 }
=20
-TEST(memfd_ftruncate)
+TEST(memfd_ftruncate_and_ioctl)
 {
-	int fd;
-
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd, i;
=20
 	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
+	 * We exercise the same test both with and without Landlock enabled, to
+	 * ensure that it behaves the same in both cases.
 	 */
-	EXPECT_EQ(0, test_ftruncate(fd));
+	for (i =3D 0; i < 2; i++) {
+		/* Creates a new memfd. */
+		fd =3D memfd_create("name", MFD_CLOEXEC);
+		ASSERT_LE(0, fd);
=20
-	ASSERT_EQ(0, close(fd));
+		/*
+		 * Checks that operations associated with the opened file
+		 * (ftruncate, ioctl) are permitted on file descriptors that are
+		 * created in ways other than open(2).
+		 */
+		EXPECT_EQ(0, test_ftruncate(fd));
+		EXPECT_EQ(0, test_fs_ioc_getflags_ioctl(fd));
+
+		ASSERT_EQ(0, close(fd));
+
+		/* Enables Landlock. */
+		ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
 }
=20
 /* clang-format off */
--=20
2.43.0.rc2.451.g8631bc7472-goog


