Return-Path: <linux-security-module+bounces-1989-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D37876F96
	for <lists+linux-security-module@lfdr.de>; Sat,  9 Mar 2024 08:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A8F2820A3
	for <lists+linux-security-module@lfdr.de>; Sat,  9 Mar 2024 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10D374D1;
	Sat,  9 Mar 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSUQ+KCL"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB097374C2
	for <linux-security-module@vger.kernel.org>; Sat,  9 Mar 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970819; cv=none; b=s2EImUEdB2OJJUlwSrRDSwjJyOzdHQDI3RmhYZC+xXSdFyDn/UzU+3p8z/xtDjAC8GTHB+1bWEGj1DUiywqwgAgW3KCAyy7Pxj6t7Ww+MurYqUWGm8TT5aiPtLO297zUAU1WoMKQRalKRLL8qyRUtiEr0RLi+VWgQIphHI7Au5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970819; c=relaxed/simple;
	bh=EM5NgZxl+/z295IW5qLK4Q86JjQrYvFmb5Dx8M6uibA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dv+xHi/4kx/yx9yRao6Nnn3+xoBlryW553+lBK97QM1pLMRDUwBWcdhbjhv924uKL7sGNB9kZ1WU0WjgrLS6SGt5+4mS2kI4bXlAb1+c58BU+2sPu4a0iXfCPV9aqA69RjFDoaYLhFXdYMp0R5NybdaFHxoi+tfU6Q8BiwajMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSUQ+KCL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so5296977276.1
        for <linux-security-module@vger.kernel.org>; Fri, 08 Mar 2024 23:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970816; x=1710575616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTiLehS4LJD5o9HUwzF3rxHkb5AeJhq43H6981Ab20o=;
        b=kSUQ+KCLY+qebDJaMmdQfkK/NBx+YmGDL631ZTJHSSGFDLjVnuJNXdf/cF61Uw2W48
         MnuhEedFhP6sJElZsczvDcPt46NEcsuhaejrrdrxp9UZvDZ9xGuUHKAzDbj+0z8I759T
         W7HPXZG3A1sMCO53eQvMBpF8nKp2NqtVZfUE7ZrlTKloVdwckDR3sPw5qo5di67VAiYi
         43/yp/p0Qwp/xHKcmQjE2kGBfb87uRGrpNWqpwT11LNEPilnu2D1MOTuy+JFimuwqZk0
         WDrvPJpROKAtSj2LMCXdfGi1HzrI3FiH27quq99VHixwPyI2iClKuQlPJT3g5ilmsTpw
         mhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970816; x=1710575616;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vTiLehS4LJD5o9HUwzF3rxHkb5AeJhq43H6981Ab20o=;
        b=gpJiOLHKVBuONj670qtvgwn09sd1xfwWECjngWFw2N0FerujsQCOLDwjf1C8kRE2QV
         Jgal8u6tVuAKNBKYPCpwfsKeVzRG7XH+mGaaqkgcULmYHSlttrjSr3NYpm3piNars3yz
         +Vs9RXBPA5m4cqwAIKbyMAliDXsyltJxJj6KkJTiNVmXb/Ga+ZL0fG5cFdsfQSkCFm7v
         bPfT4csjaDfwjB5/i+cmYxi+jl44N1i6gj9TBlEPL9IWAHNadWsCf4KESt8vcU591sDl
         t7NBz0TLkJfPe/uc2nYwpKTUtNkB1dU126VT72S3cme01OljUb6ZigHoSgKJThlQJWlj
         4wxw==
X-Gm-Message-State: AOJu0YyrFQHyh2ryxJyAIBWTQ0xS4yMtAIfgnkurAnJUc1WTYLCuJUdw
	Bo3Zx0A7fr+khNtjx5NyOLpZBcXpsg+UCoF/e8NuOSpOcC/RgdQINqSQx+mDHCHMkVtS+nB/1at
	UlcG6LqQ3AyfJkXUREcumwcQRXSynnVi5mYytKp+YnVpfHpTj2K1hDI+Z01W7+DRCZIn/zPssyW
	KIcDTXv7eBq60SZdm8j9UwxouDBoF3cBxLePIEV1q5UEOZqo1sKjKS
X-Google-Smtp-Source: AGHT+IHjhRMSidShXLUw0QQgJexcjKoFuZoKEuDKmaj/QYfeXCiIczp7cpV6e1rADR1i54xH/3kROGyCseI=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1004:b0:dc7:48ce:d17f with SMTP id
 w4-20020a056902100400b00dc748ced17fmr289354ybt.10.1709970816715; Fri, 08 Mar
 2024 23:53:36 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:16 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-6-gnoack@google.com>
Subject: [PATCH v10 5/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
 with open(O_PATH)
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

ioctl(2) and ftruncate(2) operations on files opened with O_PATH
should always return EBADF, independent of the
LANDLOCK_ACCESS_FS_TRUNCATE and LANDLOCK_ACCESS_FS_IOCTL_DEV access
rights in that file hierarchy.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index f0e545c428eb..5c47231a722e 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3884,6 +3884,46 @@ TEST(memfd_ftruncate_and_ioctl)
 	}
 }
=20
+TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
+{
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd;
+
+	/*
+	 * Checks that for files opened with O_PATH, both ioctl(2) and
+	 * ftruncate(2) yield EBADF, as it is documented in open(2) for the
+	 * O_PATH flag.
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks that after enabling Landlock,
+	 * - the file can still be opened with O_PATH
+	 * - both ioctl and truncate still yield EBADF (not EACCES).
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
--=20
2.44.0.278.ge034bb2e1d-goog


