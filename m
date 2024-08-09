Return-Path: <linux-security-module+bounces-4748-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F76B94D00C
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Aug 2024 14:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827421C2061C
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Aug 2024 12:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E98A194A48;
	Fri,  9 Aug 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSVtUbdi"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC1194A40;
	Fri,  9 Aug 2024 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723206024; cv=none; b=sxJ4M/qCXVxEaY19yGzffPYhYgMHfTHGiAFmIkYdbeipxvw80BiRaS+zVd393dTI6fEQjLdXwcnVAAfvo+sdnqbbKjRLu/C5T5XpLFO8uAOkHuYueLvg6ozMUjrk0nolU86XlTJZKoCSIpyCWTVo6fbHZQTOREHzrfcUSO/8YJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723206024; c=relaxed/simple;
	bh=h+ds7OiVeWdJ4ojS6Mrf3Z/P231oCN+JkfXtJwD8qVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrQILL8ww2G8fSghyWJng7mVS0w5+gQbD+t6m2f5jxp3wP4VLLwDr1mw7zC7qRP8iDrymsXOxHiCXzdqDvM/IWhwXczJ172XiTMEhRLLQ4t/PddRQAlL9zVh/E00ecKI+HxMqpw78xc13D350UQ3ou7myNYVSGuADoymOfcdrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSVtUbdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C01C4AF12;
	Fri,  9 Aug 2024 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723206023;
	bh=h+ds7OiVeWdJ4ojS6Mrf3Z/P231oCN+JkfXtJwD8qVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fSVtUbdi3hzcn2DpKZVl9V/Xpc8ffvqVX8/H/Gx2fG9aZl0LUTYIit0yhwT++xR+j
	 SW2r8GMNjGO/fs64kq8S1gEczckn/w3LPp1BUAbVhkdD7aRvJZhYA6aqG8IoUdYqQp
	 towgUBsHPA0H1UqsQ2zwmVC+5M93SrTqzgZYnCIMMi4lD+nrzCQQMrBmiyvYLTxf4b
	 ll/BN1MuXPOR2Vucos8Q3IjPJqjQ7IpS6zzlktUJE1yQYai2j6mfVnuwq5uCupbJd4
	 G+NREDSeeXvNnIKvVSlzf+/KJeAtPYk0ZOguiocc6IsVJM4uSSGwU11duDmdfoI2RY
	 NCNKu7Locyqmw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	selinux@vger.kernel.org
Subject: [PATCH 2/2] selinux: move genheaders to security/selinux/
Date: Fri,  9 Aug 2024 21:19:02 +0900
Message-ID: <20240809122007.1220219-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240809122007.1220219-1-masahiroy@kernel.org>
References: <20240809122007.1220219-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tool is only used in security/selinux/Makefile.

There is no reason to keep it under scripts/.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/remove-stale-files                                 | 3 +++
 scripts/selinux/Makefile                                   | 2 +-
 scripts/selinux/genheaders/.gitignore                      | 2 --
 scripts/selinux/genheaders/Makefile                        | 3 ---
 security/selinux/.gitignore                                | 1 +
 security/selinux/Makefile                                  | 7 +++++--
 .../selinux/genheaders => security/selinux}/genheaders.c   | 0
 7 files changed, 10 insertions(+), 8 deletions(-)
 delete mode 100644 scripts/selinux/genheaders/.gitignore
 delete mode 100644 scripts/selinux/genheaders/Makefile
 rename {scripts/selinux/genheaders => security/selinux}/genheaders.c (100%)

diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
index f38d26b78c2a..4e7d25668a98 100755
--- a/scripts/remove-stale-files
+++ b/scripts/remove-stale-files
@@ -20,4 +20,7 @@ set -e
 # yard. Stale files stay in this file for a while (for some release cycles?),
 # then will be really dead and removed from the code base entirely.
 
+# moved to security/selinux/genheaders
+rm -f scripts/selinux/genheaders/genheaders
+
 rm -f *.spec
diff --git a/scripts/selinux/Makefile b/scripts/selinux/Makefile
index 59494e14989b..4b1308fa5732 100644
--- a/scripts/selinux/Makefile
+++ b/scripts/selinux/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-subdir-y := mdp genheaders
+subdir-y := mdp
diff --git a/scripts/selinux/genheaders/.gitignore b/scripts/selinux/genheaders/.gitignore
deleted file mode 100644
index 5fcadd307908..000000000000
--- a/scripts/selinux/genheaders/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-genheaders
diff --git a/scripts/selinux/genheaders/Makefile b/scripts/selinux/genheaders/Makefile
deleted file mode 100644
index 866f60e78882..000000000000
--- a/scripts/selinux/genheaders/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-hostprogs-always-y += genheaders
-HOST_EXTRACFLAGS += -I$(srctree)/security/selinux/include
diff --git a/security/selinux/.gitignore b/security/selinux/.gitignore
index 168fae13ca5a..01c0df8ab009 100644
--- a/security/selinux/.gitignore
+++ b/security/selinux/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 av_permissions.h
 flask.h
+/genheaders
diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index c47519ed8156..86f0575f670d 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -36,7 +36,10 @@ quiet_cmd_genhdrs = GEN     $(addprefix $(obj)/,$(genhdrs))
 # see the note above, replace the $targets and 'flask.h' rule with the lines
 # below:
 #  targets += $(genhdrs)
-#  $(addprefix $(obj)/,$(genhdrs)) &: scripts/selinux/...
+#  $(addprefix $(obj)/,$(genhdrs)) &: $(obj)/genheaders FORCE
 targets += flask.h
-$(obj)/flask.h: scripts/selinux/genheaders/genheaders FORCE
+$(obj)/flask.h: $(obj)/genheaders FORCE
 	$(call if_changed,genhdrs)
+
+hostprogs := genheaders
+HOST_EXTRACFLAGS += -I$(srctree)/security/selinux/include
diff --git a/scripts/selinux/genheaders/genheaders.c b/security/selinux/genheaders.c
similarity index 100%
rename from scripts/selinux/genheaders/genheaders.c
rename to security/selinux/genheaders.c
-- 
2.43.0


