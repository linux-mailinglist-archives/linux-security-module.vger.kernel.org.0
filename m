Return-Path: <linux-security-module+bounces-8415-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A99A4B2DF
	for <lists+linux-security-module@lfdr.de>; Sun,  2 Mar 2025 17:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120E27A780A
	for <lists+linux-security-module@lfdr.de>; Sun,  2 Mar 2025 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1E1EB5FD;
	Sun,  2 Mar 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="L00+6xuu"
X-Original-To: linux-security-module@vger.kernel.org
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0041EB5CB;
	Sun,  2 Mar 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931634; cv=none; b=G2huzP06wyHtke+YS2KXTAZRSr+Md4HmyJDazz2HAnpc6WSJ44nLj2wraIR/8pr5ABfE+lxx7XbQejrx/lTGnCXyYXt5P+Ej+8wxYbm2S5aY6zhVHL4E5Ysa70trtwC8loYLJbgXX1SZwd9/RUy+x9ieIZKCs3qOdQIZ3gF8KL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931634; c=relaxed/simple;
	bh=0EFiP6ygydcKWyW6csJHAZmx3Qp2y0CPOFwjWwSjus4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZxztj8K6itAjEnAQQWLvhYNxg4kk/vECKfKwLR4zQqmNnIuNEZmqDS8Zn+pGrzIYF/HGDUe/Kmtv4VUal0e5Yzm7oKy0p7Zn/eNy4dtHfNCee6XVyzcbD3Rw5tQTHhEceJJt2cFPWy2W3O/RYuvVrSC/rP5GnIOXVcK7MPIz1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=L00+6xuu; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740931630;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7tEjDSgKvohdvK6pTN+ndS8THOOnhPlPkLJOHpGmuo=;
	b=L00+6xuuwiWduCv+ixkmgNqzMue8FepzjU+fPTpLl3F5QZOO27bk7M9wmhhWU8jT4crfSL
	M/7o09GRptVOm+HsIO9YOzFhbaHCvz9w2ZOEuXxwGv+gKYE2NJQPPMme+A8tlGmNwEs9Hc
	zPxhTr1xrvSbV+1FwKr4ooR3KG+Nuqah7c8wXDMWW23rsD/wuGMhE+XSSuxU6acEaBKxjU
	SMoreM+GacqhtPwtqg8XONVAirj0PqdKl+b+IaRgbRc9E8o6K0amJ1WFuaGVHcfzBkbpnz
	CSZFhosDGBLKiF2l0uokkI6/gp4rmRVY4ARa7sYCKIATyzRBtNmg19WhoyltuQ==
To: 
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	cocci@inria.fr,
	Liviu Dudau <liviu.dudau@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 07/11] drm/panthor: reorder capability check last
Date: Sun,  2 Mar 2025 17:06:43 +0100
Message-ID: <20250302160657.127253-6-cgoettsche@seltendoof.de>
In-Reply-To: <20250302160657.127253-1-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
v2: split from previous patch with unrelated subsystem
---
 drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 08136e790ca0..76a10121f8a8 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -791,7 +791,7 @@ static int group_priority_permit(struct drm_file *file,
 		return 0;
 
 	/* Higher priorities require CAP_SYS_NICE or DRM_MASTER */
-	if (capable(CAP_SYS_NICE) || drm_is_current_master(file))
+	if (drm_is_current_master(file) || capable(CAP_SYS_NICE))
 		return 0;
 
 	return -EACCES;
-- 
2.47.2


