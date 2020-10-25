Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D00A29834D
	for <lists+linux-security-module@lfdr.de>; Sun, 25 Oct 2020 20:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418415AbgJYTHQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 25 Oct 2020 15:07:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:57935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732698AbgJYTHQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 25 Oct 2020 15:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1603652816;
        bh=OzBPTWP4HniyfRVhLuAvnT82ocK2l9QTQfTuhozWfks=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iKiHad+oFYBEo2S4MDbobe8L98THGorbfMtWMACwPoO8Dw97vLJaBmG9OLmlgSKQx
         +ghSM309QDA31mODmy4e7gatEmuMovE9YgK0nGPM/C5QHQFBTv5Bw6ACD1yrVjOkhr
         10iBRZXuDykHriiTPgyDwBRisAB3xWd9BXeSaA6A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.231.59]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N8ofO-1kIr973kgg-015ob9; Sun, 25 Oct 2020 20:06:56 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     John Wood <john.wood@gmx.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v2 8/8] MAINTAINERS: Add a new entry for the Brute LSM
Date:   Sun, 25 Oct 2020 14:45:40 +0100
Message-Id: <20201025134540.3770-9-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025134540.3770-1-john.wood@gmx.com>
References: <20201025134540.3770-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XIkBc5Sdz3SQJ6bMKfEKk7IVGMhrkpkVRcigKF7B9QVK89FXQOG
 0OXXB3iAd6TG2csWcgUkrut1+4mdxqWBqpFO83i3YUtRy96voZE6A9FMgIZ/yQDRvxXmkRS
 HGMpll8CeJps9oY3WGx9ISJlW5QCpU/dGSm4rYvOqqTUX4F+l8LfJhR8dyAGu9J0DIlpxTP
 plBlxnkMnCnQWNLeICoig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ads6fhSOCR4=:3aznbMalMEe0vjYLyMH/EA
 E/VnASCMh9PuPYgko4bSmr76hG594GPyUWhJC+LzestMxYRLMtE5a9kbL8Erdz/4Zz7nJlgVA
 D+D70QFEDrWD00lU69ZZawkE6jw2uVm8/4KQlbWzdYgNRP7WXqIIbzdiiMxhj3T8ErTBGf/eP
 VZXhTzu1HXkdBCrwVh8tN3D7RYYXFTxoktpmCT0HX6n8AmvVViHKW2Mk8INbwdY34LMNc5iEO
 s8do4oXXxrXhGoa+yAor7VK8nLsVxPKT66j65Hq8JGnRSAXgXNJbxJ/Pew/DtUr/BgcYf4vfg
 O3nZzwxJLw28X+TuoBSLFdE+67SIzxxb5dLzKqTKMgLQvYKrz7FNeWAYxAOLyA+JvHn+Cfp5K
 gF43XgJBwrOxQcUWP4cccUAG6B8J5pmNpVAzapUZtLBLPn+GLiqFcep1PFPDfMUz+2ZaAGi59
 A/yCVU8MKPpqd3ZdzMBENw3/++klckQt7h5Dqp2/BhgIRLtHhGcsS2J4DsE1N6arr42SuNoIB
 ng7PiDh+No/qMh+xNIDCAnIxFQu5mjqczemIAvpifbYrtnou6t2qpZ1SJvsmVmfkzOXWWEJ2J
 tUzySvpoIIurMlxr4Pbb3JRleKUtzdKHjQJCxEfl/1+Hqe72y82JiwcFtriR5FZnF+GR4SWfv
 pP1HOxunDZf4Hq/nL8rFKjnz5vAv3tJDaBtIxZVrXQx33r5IvUH1R4TQIF3FahULszB0kglJX
 VRM2IoZWPfwMwaos8aDNWV0A9ifg4J2EP9+g9SxqDaSvqIvYX4jyyEesKpMfkgRl95fcyoR1C
 fqWANcuXVvbzyT8k3K0vCNXxe4VnbjlIbXpxjf4iYG0s4wTEq2mwXadK8+2eJBTRWwgCVAdLz
 hL46VgBWfWhB2DKAvZxA==
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

In order to maintain the code for the Brute LSM add a new entry to the
maintainers list.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 867157311dc8..3d3b34f87913 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3734,6 +3734,13 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/ethernet/brocade/bna/

+BRUTE SECURITY MODULE
+M:	John Wood <john.wood@gmx.com>
+S:	Maintained
+F:	Documentation/admin-guide/LSM/Brute.rst
+F:	include/brute/
+F:	security/brute/
+
 BSG (block layer generic sg v4 driver)
 M:	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
 L:	linux-scsi@vger.kernel.org
=2D-
2.25.1

