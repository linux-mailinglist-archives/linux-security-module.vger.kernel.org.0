Return-Path: <linux-security-module+bounces-4083-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A858927D8F
	for <lists+linux-security-module@lfdr.de>; Thu,  4 Jul 2024 21:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183BFB244A6
	for <lists+linux-security-module@lfdr.de>; Thu,  4 Jul 2024 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB0A14388E;
	Thu,  4 Jul 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ThRs7c9X"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B13E142E83
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jul 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720119741; cv=none; b=He0pcQg4Msu4VoYwWlSh3yEfBh/SOF+94Cnfu11+SaeCHHs9lLhAUq4xGM30dP+IWPQ3hKdvdXt6CgyUZQRWGxNqKjm8ySxOuEo/feJVZODyISwjqW19geeVni4JzFwXnqIyWa+NYgordLOXsQ0XkSnMm86VW4VuOTWNSS8Reno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720119741; c=relaxed/simple;
	bh=9kEvfh40DrzVZsKjxTdNWubNxHzlStfeHN1CIvOxWb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnpBP9PTfJ2AZ07MUJfmIoiHQV8eh7I03qYDZ/M80LdpPoxN4suBKz1Kkg8iemNA/WYeW82W8+vNvDKW/1oSvSA0Z3LWjLHo0T3NPkRcMcAccW/nye2mwH7VreAYMfXsI0BVQpeJBnVOn2woY2fyniMfsXPbw2fwk1MmeHQtgNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ThRs7c9X; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WFQxc2qp7z9J9;
	Thu,  4 Jul 2024 21:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720119732;
	bh=daNi8bj+uI1GV3NFPcnb4qSetCZapGCSAhuBCp9VMuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ThRs7c9XxrJXhsxBCBf1BgkjK/BWahL0xO9HmmtyK9bdLiJ4fpswPBizU28ADiD+8
	 aOIDrvtiPJgENur37wuN+viYCGh0J5TAJo4Qi4GciV6Mt82ZKsC1Dvp1sweWWvL/Na
	 FkxyZLz0b+yHt23kspra1Bb7GYYXewOJOH2LhNuo=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WFQxb45Fpz2mC;
	Thu,  4 Jul 2024 21:02:11 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	Theodore Ts'o <tytso@mit.edu>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alejandro Colomar <alx.manpages@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Subject: [RFC PATCH v19 4/5] selftests/landlock: Add tests for execveat + AT_CHECK
Date: Thu,  4 Jul 2024 21:01:36 +0200
Message-ID: <20240704190137.696169-5-mic@digikod.net>
In-Reply-To: <20240704190137.696169-1-mic@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Extend layout1.execute with the new AT_CHECK flag.  The semantic with
AT_CHECK is the same as with a simple execve(2),
LANDLOCK_ACCESS_FS_EXECUTE is enforced the same way.

Cc: Günther Noack <gnoack@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240704190137.696169-5-mic@digikod.net
---
 tools/testing/selftests/landlock/fs_test.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 7d063c652be1..85ef36b09a37 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -37,6 +37,10 @@
 #include <linux/fs.h>
 #include <linux/mount.h>
 
+/* Defines AT_CHECK without type conflicts. */
+#define _ASM_GENERIC_FCNTL_H
+#include <linux/fcntl.h>
+
 #include "common.h"
 
 #ifndef renameat2
@@ -2009,6 +2013,21 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
 	};
 }
 
+static void test_check_exec(struct __test_metadata *const _metadata,
+			    const int err, const char *const path)
+{
+	int ret;
+	char *const argv[] = { (char *)path, NULL };
+
+	ret = execveat(AT_FDCWD, path, argv, NULL, AT_EMPTY_PATH | AT_CHECK);
+	if (err) {
+		EXPECT_EQ(-1, ret);
+		EXPECT_EQ(errno, err);
+	} else {
+		EXPECT_EQ(0, ret);
+	}
+}
+
 TEST_F_FORK(layout1, execute)
 {
 	const struct rule rules[] = {
@@ -2026,20 +2045,27 @@ TEST_F_FORK(layout1, execute)
 	copy_binary(_metadata, file1_s1d2);
 	copy_binary(_metadata, file1_s1d3);
 
+	/* Checks before file1_s1d1 being denied. */
+	test_execute(_metadata, 0, file1_s1d1);
+	test_check_exec(_metadata, 0, file1_s1d1);
+
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY));
 	test_execute(_metadata, EACCES, file1_s1d1);
+	test_check_exec(_metadata, EACCES, file1_s1d1);
 
 	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d2);
+	test_check_exec(_metadata, 0, file1_s1d2);
 
 	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 	test_execute(_metadata, 0, file1_s1d3);
+	test_check_exec(_metadata, 0, file1_s1d3);
 }
 
 TEST_F_FORK(layout1, link)
-- 
2.45.2


