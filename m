Return-Path: <linux-security-module+bounces-58-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0177F8003
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Nov 2023 19:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3B928228A
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Nov 2023 18:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB5228E3A
	for <lists+linux-security-module@lfdr.de>; Fri, 24 Nov 2023 18:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZvIb9Yh"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949131733
	for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:53 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9fd114e21adso166363866b.3
        for <linux-security-module@vger.kernel.org>; Fri, 24 Nov 2023 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700847052; x=1701451852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUD2X0nvvEDGbnvAFUxCT0dn9azP0EmEwTtnwK9EbZA=;
        b=yZvIb9YhLC2ReHet26ki/egokm5tk5I2BtQeaboKCJlNeLDuSne/Vj0altui5WdtTc
         yR56gIhAcTW1tcGos9FJG7HhRHwNUmMoVXaq2Cti2xVfsSqna4vIsp/AKC0ab6sNca4T
         m7V2nOev58IhRVNJDBsMQf8emookxqbHCXCBfZZeVUeVWS4QLs04cjcwbUCOq1GdCYSB
         pG87bOq50gMa1UtDFFd25v5FLiBo9LQOt+3CRFfToLGMU6Tc9jKRPNHtXpv1h3DEvlVX
         Nt77IpM7PZ7PTXKnb7lS7OJ2KN5PjYvT8x7x6IPvaNNC+sGoIfZBux9Tf1/aqN475U6B
         7qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847052; x=1701451852;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gUD2X0nvvEDGbnvAFUxCT0dn9azP0EmEwTtnwK9EbZA=;
        b=YFytaw3i6ICOumTd44zpgoFtgRg1ixNQ8c2zkgTW/CK4hNY6hwa6V1P2xmI4GNR7fI
         TlPbKRAepsa+7554Nvp8qoeUfH8ErxmAs4/rhZvmGrZjJKf9+pUPwl/HUqsQ07yfVczX
         EL+q8x1BmRfRzK+/LD2Vn1+QS8GXR10IWQKtEoLhf0QCFmjzpb7FtrV3EnwEK6W+CECf
         x4vL93ARACU7G5NJO9AEZMK4LSYjUN8CEd/EG14H0gKq+dVAEOPk81xH9MDSojGASsYt
         y9If7ZEqAVxcE0S6kVSeevnrf4ksl0s6T2+Lt3lqGf73V7lbn2WLoRHESU8lJnpayGjg
         2ioA==
X-Gm-Message-State: AOJu0YyUCg1Q4pf8RHFUPKGRp4AO1ZlxA9o69eGGH/vWTNnoCL807g4P
	AF/SryCHdHTCF4HXxRdI3mDUss3ltHuP1xPLru+DrgZAfvsSMkhpk7DjD4o4AwcJXQ6E6C+VAFk
	qqnUWp1gkZ1TD/4JSbnUppxbIr0bS2+66tvsLkDgx9eldgOrkY7w6q+OCnNL82chmcXV+KC69o3
	dBqd00wA==
X-Google-Smtp-Source: AGHT+IFTcw/EFXtkdR8R0nLEagarDUWoyW8dX/3KxQqPUqEDhtE6YxYXpEhFNclq6Dd5odqh5qrVcqgPa4Y=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a17:907:7841:b0:9be:b4e6:4c01 with SMTP id
 lb1-20020a170907784100b009beb4e64c01mr33286ejc.9.1700847052114; Fri, 24 Nov
 2023 09:30:52 -0800 (PST)
Date: Fri, 24 Nov 2023 18:30:25 +0100
In-Reply-To: <20231124173026.3257122-1-gnoack@google.com>
Message-Id: <20231124173026.3257122-9-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v6 8/9] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
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

Add ioctl support to the Landlock sample tool.

The ioctl right is grouped with the read-write rights in the sample
tool, as some ioctl requests provide features that mutate state.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
Co-developed-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
---
 samples/landlock/sandboxer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index 08596c0ef070..d7323e5526be 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***const=
 path_list)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
@@ -199,11 +200,12 @@ static int populate_ruleset_net(const char *const env=
_var, const int ruleset_fd,
 	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
 	LANDLOCK_ACCESS_FS_MAKE_SYM | \
 	LANDLOCK_ACCESS_FS_REFER | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_IOCTL)
=20
 /* clang-format on */
=20
-#define LANDLOCK_ABI_LAST 4
+#define LANDLOCK_ABI_LAST 5
=20
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -317,6 +319,11 @@ int main(const int argc, char *const argv[], char *con=
st *const envp)
 		ruleset_attr.handled_access_net &=3D
 			~(LANDLOCK_ACCESS_NET_BIND_TCP |
 			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
+		__attribute__((fallthrough));
+	case 4:
+		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
+		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
+
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
 			"to leverage Landlock features "
--=20
2.43.0.rc1.413.gea7ed67945-goog


