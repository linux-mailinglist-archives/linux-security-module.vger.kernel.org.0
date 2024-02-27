Return-Path: <linux-security-module+bounces-1677-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E35D868E90
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Feb 2024 12:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A478283D9C
	for <lists+linux-security-module@lfdr.de>; Tue, 27 Feb 2024 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0FB139585;
	Tue, 27 Feb 2024 11:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="aJAgMZqv"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65F139563
	for <linux-security-module@vger.kernel.org>; Tue, 27 Feb 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032514; cv=none; b=QZxbPEMascT6u+oKd3NuJyS3dBTjoHR2zzkOFNQoSKYhspCXuU8Iq4MX5shdrG68bzn4B6G1Du2fsJEbj7IvjcmlmpzUFSeVzQjt8FJkvYxu8SPMjXeKOj7f4cKC1LBafrC1fONXmYJpzaT0u/aX8JKgM9S94KobaAUUB1I6mzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032514; c=relaxed/simple;
	bh=fo0e4FRJyzZJ6d6n/7sR3VvkreP3rfZ9EhEu8wKED6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zq7JcYG406UgrQtP0KWX4f9J2GA9HxK8A/kNcfxphE7sq5RFFbH6mNXK0q6wk53u2JEitjCLlKm/RIez4o1AanuznDEhqVXrhYQpDSF63bDl1QEJ/xNdmKXyo8ygl4lQ5NIccRQ7Pb/66bqnIEo8l0sg81uId+39/28LljoUQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=aJAgMZqv; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TkZRK3mSFzMq5jp;
	Tue, 27 Feb 2024 12:06:05 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4TkZRJ1SGDzDLf;
	Tue, 27 Feb 2024 12:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709031965;
	bh=fo0e4FRJyzZJ6d6n/7sR3VvkreP3rfZ9EhEu8wKED6Q=;
	h=From:To:Cc:Subject:Date:From;
	b=aJAgMZqvXCuTbBi3QrqQEix+We3BKKkgtSzWSI/iyXVsm+O11Q4WECvzP7XS5p7AK
	 SysOh8oMYi25zAJ5MEnSVlYHTBLoZKpMm1EgyycJhArAgZ+5oaXh/Ej5Es4I7TuWwX
	 6Vizit1a6SoZwfE3jEmCv42kq4iV/5BZJ2nNfIPM=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Shervin Oloumi <enlightened@chromium.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 1/2] landlock: Extend documentation for kernel support
Date: Tue, 27 Feb 2024 12:05:49 +0100
Message-ID: <20240227110550.3702236-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Extend the kernel support section with one subsection for build time
configuration and another for boot time configuration.

Extend the boot time subsection with a concrete example.

Update the journalctl command to include the boot option.

Cc: Günther Noack <gnoack@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
* New patch, suggested by Kees Cook.
---
 Documentation/userspace-api/landlock.rst | 57 +++++++++++++++++++++---
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 2e3822677061..838cc27db232 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -19,11 +19,12 @@ unexpected/malicious behaviors in user space applications.  Landlock empowers
 any process, including unprivileged ones, to securely restrict themselves.
 
 We can quickly make sure that Landlock is enabled in the running system by
-looking for "landlock: Up and running" in kernel logs (as root): ``dmesg | grep
-landlock || journalctl -kg landlock`` .  Developers can also easily check for
-Landlock support with a :ref:`related system call <landlock_abi_versions>`.  If
-Landlock is not currently supported, we need to :ref:`configure the kernel
-appropriately <kernel_support>`.
+looking for "landlock: Up and running" in kernel logs (as root):
+``dmesg | grep landlock || journalctl -kb -g landlock`` .
+Developers can also easily check for Landlock support with a
+:ref:`related system call <landlock_abi_versions>`.
+If Landlock is not currently supported, we need to
+:ref:`configure the kernel appropriately <kernel_support>`.
 
 Landlock rules
 ==============
@@ -499,6 +500,9 @@ access rights.
 Kernel support
 ==============
 
+Build time configuration
+------------------------
+
 Landlock was first introduced in Linux 5.13 but it must be configured at build
 time with ``CONFIG_SECURITY_LANDLOCK=y``.  Landlock must also be enabled at boot
 time as the other security modules.  The list of security modules enabled by
@@ -507,11 +511,52 @@ contains ``CONFIG_LSM=landlock,[...]`` with ``[...]``  as the list of other
 potentially useful security modules for the running system (see the
 ``CONFIG_LSM`` help).
 
+Boot time configuration
+-----------------------
+
 If the running kernel does not have ``landlock`` in ``CONFIG_LSM``, then we can
-still enable it by adding ``lsm=landlock,[...]`` to
+enable Landlock by adding ``lsm=landlock,[...]`` to
 Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
 configuration.
 
+For example, if the current built-in configuration is:
+
+.. code-block:: console
+
+    $ zgrep -h "^CONFIG_LSM=" "/boot/config-$(uname -r)" /proc/config.gz 2>/dev/null
+    CONFIG_LSM="lockdown,yama,integrity,apparmor"
+
+...and if the cmdline doesn't contain ``landlock`` either:
+
+.. code-block:: console
+
+    $ sed -n 's/.*\(\<lsm=\S\+\).*/\1/p' /proc/cmdline
+    lsm=lockdown,yama,integrity,apparmor
+
+...we should configure the bootloader to set a cmdline extending the ``lsm``
+list with the ``landlock,`` prefix::
+
+  lsm=landlock,lockdown,yama,integrity,apparmor
+
+After a reboot, we can check that Landlock is up and running by looking at
+kernel logs:
+
+.. code-block:: console
+
+    # dmesg | grep landlock || journalctl -kb -g landlock
+    [    0.000000] Command line: [...] lsm=landlock,lockdown,yama,integrity,apparmor
+    [    0.000000] Kernel command line: [...] lsm=landlock,lockdown,yama,integrity,apparmor
+    [    0.000000] LSM: initializing lsm=lockdown,capability,landlock,yama,integrity,apparmor
+    [    0.000000] landlock: Up and running.
+
+Note that according to the built time kernel configuration,
+``lockdown,capability,`` may always stay at the beginning of the ``LSM:
+initializing lsm=`` list even if they are not configured with the bootloader,
+which is OK.
+
+Network support
+---------------
+
 To be able to explicitly allow TCP operations (e.g., adding a network rule with
 ``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP
 (``CONFIG_INET=y``).  Otherwise, sys_landlock_add_rule() returns an

base-commit: b4007fd27206c478a4b76e299bddf4a71787f520
-- 
2.44.0


