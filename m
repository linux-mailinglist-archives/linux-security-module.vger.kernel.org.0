Return-Path: <linux-security-module+bounces-2287-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC8188A804
	for <lists+linux-security-module@lfdr.de>; Mon, 25 Mar 2024 17:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290831FA0735
	for <lists+linux-security-module@lfdr.de>; Mon, 25 Mar 2024 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94912BEBB;
	Mon, 25 Mar 2024 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlUH7zDm"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5A12BEB5
	for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374023; cv=none; b=OPhgtiWz7G7z+p/mPG5sIlnHw1CHqfSxnUQ86AoFRnYVBlPRMzD7K6wDnpZrSBgY7vtCjOVg+N6l30pT56VzGkgOmQp/1xAYFXjjaVyKCsYj3SPTxMryS+oH+imYqo7+ShCde+W/ZAsV6SANnIj/WGJOVPqi40puiN4V6cu4QPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374023; c=relaxed/simple;
	bh=HzbXoAKj1O2Axw/b80Ha7oRq747pOMPBeo9PHNh77I4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i7HM1UlYiurFny4N4fTgQDl6zw8E7cK9/rHJ6ZHWT97kYqVXsn5+4xuDsGYgm5cVRfmbM5fTvbu3JmSRqFvTv8rXOwzr2MJmjdi9v0buXVeQM6hFUlx5EKk7RxihV8iauJbpM3ocF3gw8mXV7vF9Rz5NAwCOrtFRiT/vwS1Rwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TlUH7zDm; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc8d4e1a4so79676297b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 25 Mar 2024 06:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711374020; x=1711978820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WK2iXIrfoq6Fz3IO0C5eVV32OG2FmcAULBO6/ELXu64=;
        b=TlUH7zDmWRzsXGPjbSMFzF2zzyLVMrqvAhGcHZppPXEPs0losICJKnpYzuR6DTkGwt
         jWnvyJl+o+JbqQ/JINF9l4D0BqqzDxdnv44N/9yTFxGF7ugeVaH+t1VUPdsYaNURLsag
         Hneb4hCJCBFyrukSgXcU8WQ9XRGpcSvno9TPSKiDjA5lF2HlGvAm/x5fvoV34vXA1gPk
         aSiRf/F0MOpAWbRykR/8TDQ8R2nfYHFmeEEEMfRF9R8V+1jomR5yuN6EOjjx9DSxzIcx
         seeTIMJN90SQZTfEN4mAVr69Fukjsb46aZoPRInuY1/ZBGH6IRVKVNmftXVUkHYpjtBK
         6F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374020; x=1711978820;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WK2iXIrfoq6Fz3IO0C5eVV32OG2FmcAULBO6/ELXu64=;
        b=AB+UwtrKSM3due3hgplujoVDQ+wd+Vjzh9Y+0MVU0QSOPFCMs1lqzFMHua7/bkeewx
         OUng2MDsvpY1UP/QBJusxnWDlVHtslW5NPB7+aS5mh5nTGD2ACIHWjy0z1+5xGYk8MGK
         HRMe+XRWMIBLIjpHn4u5642Ex7Pmslu9xPG1FOjxBZ53QoMi74Ag3rZxnfhO8xfF0Hro
         U+4Gks+pnM46iowi4EIhd42FwoZHidg7MM36Eu7+9HcZsD+Ob2JNzLoWI2sbWljJX4DY
         GAVSRepbQv9csM1Jf02ANHC0C2DMkO6+bFMiCGO4fKWFc7op6IxhBcklBDz3IUmJlbbS
         KSjA==
X-Gm-Message-State: AOJu0YygzJDRmIXGmMGu1YkI0gk8nkT1vNy+qHwyzTH5oUJOGVkH1Z/K
	DUoyYAY4Kysq4e5h40EA3qH0A9wIqCXCC2cM1HcU+aTCpdvD3gZy1B7u589gAMC7W7F6huw9WiT
	rifjO/VdOgCDSYvBwgR4R5daZO6UT51jhVVdncbvnSyNz6H0EVUEjketnzeVT1MQKCdxoJvEYT0
	gaT49UwEKxFpoIvSuMk4/g8SvR/P2iebIycBKORf2UymCwqnjQEAjU
X-Google-Smtp-Source: AGHT+IFUrFEh7Out/8IlV6ySbs+X96Y9uWwXoMVPrjQgbIUR0KHOO0WnAQGkeblmUPeQXIQQAfMrIfLcce0=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a0d:cbc9:0:b0:611:318d:8d4f with SMTP id
 n192-20020a0dcbc9000000b00611318d8d4fmr1737128ywd.0.1711374020629; Mon, 25
 Mar 2024 06:40:20 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:40:00 +0000
In-Reply-To: <20240325134004.4074874-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325134004.4074874-6-gnoack@google.com>
Subject: [PATCH v12 5/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
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
index 32a77757462b..dde4673e2df4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3893,6 +3893,46 @@ static int test_fionread_ioctl(int fd)
 	return 0;
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
2.44.0.396.g6e790dbe36-goog


