Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5797D7A5B
	for <lists+linux-security-module@lfdr.de>; Thu, 26 Oct 2023 03:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjJZBs3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 25 Oct 2023 21:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjJZBs1 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 25 Oct 2023 21:48:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA6137;
        Wed, 25 Oct 2023 18:48:20 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SG7sm0YnMz6K6CJ;
        Thu, 26 Oct 2023 09:45:32 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 26 Oct 2023 02:48:17 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <mic@digikod.net>
CC:     <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [PATCH v14 09/12] selftests/landlock: Share enforce_ruleset()
Date:   Thu, 26 Oct 2023 09:47:48 +0800
Message-ID: <20231026014751.414649-10-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
References: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml500002.china.huawei.com (7.188.26.138) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Move enforce_ruleset() helper function to common.h so that it can be
used both by filesystem tests and network ones.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v13:
* Refactors commit message.

Changes since v12:
* Fixes a bug TEST_F_FORK(layout1) -> TEST_F_FORK(layout0) in fs_test.c.

Changes since v11:
* None.

Changes since v10:
* Refactors commit message.

Changes since v9:
* None.

Changes since v8:
* Adds __maybe_unused attribute for enforce_ruleset() helper.

Changes since v7:
* Refactors commit message.

Changes since v6:
* None.

Changes since v5:
* Splits commit.
* Moves enforce_ruleset helper into common.h
* Formats code with clang-format-14.

---
 tools/testing/selftests/landlock/common.h  | 10 ++++++++++
 tools/testing/selftests/landlock/fs_test.c | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index d7987ae8d7fc..0fd6c4cf5e6f 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -256,3 +256,13 @@ static int __maybe_unused send_fd(int usock, int fd_tx)
 		return -errno;
 	return 0;
 }
+
+static void __maybe_unused
+enforce_ruleset(struct __test_metadata *const _metadata, const int ruleset_fd)
+{
+	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0))
+	{
+		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
+	}
+}
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 251594306d40..68b7a89cf65b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -677,16 +677,6 @@ static int create_ruleset(struct __test_metadata *const _metadata,
 	return ruleset_fd;
 }

-static void enforce_ruleset(struct __test_metadata *const _metadata,
-			    const int ruleset_fd)
-{
-	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
-	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0))
-	{
-		TH_LOG("Failed to enforce ruleset: %s", strerror(errno));
-	}
-}
-
 TEST_F_FORK(layout0, proc_nsfs)
 {
 	const struct rule rules[] = {
--
2.25.1

