Return-Path: <linux-security-module+bounces-5383-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 243E896F72A
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Sep 2024 16:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C299D1F25B37
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Sep 2024 14:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0201CE71F;
	Fri,  6 Sep 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P3r7zYAr"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FB81D1F6D
	for <linux-security-module@vger.kernel.org>; Fri,  6 Sep 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633772; cv=none; b=AAQMuKLrF+njdLER1fyqLm5fvy7yJS7vfZFnf3FVKMkkXW1gdf8P8WqQQA2BbudRAiDv4tLnAb+hWJ3HEScM19PfW2lhqSKH4IDaZVvYphE2/6kGowEA6lWI75/N1mEDLtE/+q1ZbxlaUiEPl928hTrxFciKfd2E3nNYO0ySJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633772; c=relaxed/simple;
	bh=LJU9AgRZafbRGKRwX9Z9gh0a4h6DSxuz5293f/4NqIc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t2xl7UQ4Yv2NKWDIYyZD56Y7O5e0NHd25DzTevtGEwKRS7rAhnbXRa94S0xNalBRhgPEEwuSa50HKGpnJppwm/B0XXmmzdNU1m1g0uxN2Cymr2VJS996KtuzVFpwWi8+gzm8LBvzgkIYytdY4Q/ii5sj7m/zDSiwyH2Otdmc8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P3r7zYAr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6bada443ffeso16121297b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Sep 2024 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725633770; x=1726238570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OdvfsRmG8gWy8ITHHRQX+/j857fwZkk9D0jFjQ3zW8g=;
        b=P3r7zYAr96F//KkxOCOuOGPLnkLuxkKz1uN7Ct3IxWZaka2u+QdBwSYnW9jqv/7nFF
         N8eYfaQglYSFN7vnmemHCxqJcs29BgRlHDA+iNodNn6qL6q07FddVQpo5YFYGWnxDjO0
         fYvTuLtKyRg+dn+g/LQi7iqCeP5tZ4t6se32+vNJC7FpGcGjZt4399AcxxEUgYDiNm9R
         0Jxw2Ozh3BsDB1jRs8oTLBPXYMcY5rC0+IV75R0/cr28n+/hSmnnhWtc008O6J4xxw7w
         0iTUF+ZKo3rCWqYV6Z8f1KsXECn1JhXTjdhx9vY6GJLpbRRcpsHwgUlZVKrYjHEARfZi
         R95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633770; x=1726238570;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OdvfsRmG8gWy8ITHHRQX+/j857fwZkk9D0jFjQ3zW8g=;
        b=g4Y/BaYdY1yOEEG8vdWbBh+RWA6yxyAhmn52dB9dF+SatDBqV/it2Fch4MsP71uKj7
         DGiSA8jipxJWl74DfPfL84+MmFt+uX8buunuinUk/MV2NxzCZgKJ9w/EoEI+1kiD1v4W
         s3T/Gml7BGg4PWD7ERNudTWjCMMZ2yfhGNpnD4rctNr7r8omxJyi2SAfw4aUZeN4WBMZ
         mQGZpyU2g9v6TJITnIxyk+ngn0/dpszDWT6tDb6eyhMD77gzZbyt0uQaV5uc1M2+LeCG
         CA8CvaDElpxikIa27/3vsFR2oqJS+MVPEkzKj7IDTGDXuBSRxISmHWziRDwPmS9RCZBm
         q9aA==
X-Forwarded-Encrypted: i=1; AJvYcCVTyJjC7xlIzmoMoEl441KuOfeos0r3KBcVO1S8U3qaNLlSI0MogxUjZt0OT91sJlcmaUMXW5+qIXfF2w9njLscNdeCuO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz821m+qfeCozUJnvJiLqW6G8HbC97++j+Pn+AdeQ22w0hVLs78
	gRNQDQR68rZ8PDGj3Aa+OCYZpdJBvdKTFfpuQPEjJLUXVwgoEDoSoA3Ilg+3l9b7qPZBC4Qjbxa
	dV8k1rWHi2ML6FRHQQPGgg+uvk8Kmx1zVK3wI
X-Google-Smtp-Source: AGHT+IFyloP//56s7Tf2Mkhp9TXcL4TAe7nGoLAX93C+OtFA1ZbwJ+YSP4o3ZpN6+R8XILp2R72j+bk+ZnyMbtqi/sA=
X-Received: by 2002:a05:690c:4d82:b0:6d9:d865:46d0 with SMTP id
 00721157ae682-6db25f4767emr87625127b3.4.1725633769789; Fri, 06 Sep 2024
 07:42:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 6 Sep 2024 10:42:39 -0400
Message-ID: <CAHC9VhQvbKsSSfGzUGo3e8ov6p-re_Xn_cEbPK0YJ9VhZXP_Bg@mail.gmail.com>
Subject: linux-next commit 0855feef5235 ("fsnotify: introduce pre-content
 permission event")
To: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi VFS folks,

When you are making changes that impact a LSM, or the LSM framework
itself, especially if they change the permissions/access-controls in
any way, please make sure you CC the relevant mailing lists.  If you
are unsure which lists you should CC, please consult MAINTAINERS or
use the ./scripts/get_maintainer.pl tool.

Thanks.

-- 
paul-moore.com

