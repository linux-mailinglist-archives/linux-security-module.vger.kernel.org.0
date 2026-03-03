Return-Path: <linux-security-module+bounces-15203-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IqMuFDFepmkAOwAAu9opvQ
	(envelope-from <linux-security-module+bounces-15203-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Tue, 03 Mar 2026 05:06:09 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3436F1E8A13
	for <lists+linux-security-module@lfdr.de>; Tue, 03 Mar 2026 05:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8D5F3002D30
	for <lists+linux-security-module@lfdr.de>; Tue,  3 Mar 2026 04:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9577037DEBC;
	Tue,  3 Mar 2026 04:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCR+VWRT"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFDB37DE98
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772510763; cv=none; b=h+lvhyUvQKotmh3wH5YAbAVI63IwVUfcP98/O6RMwfQKchYNi3hNdZtz/3hdu4gClMhyzwCyH/MHGT9hhQA+kruiMrr9tlsHoSOxVVJv0oPgWKlQpcqB5OFAy2b1/EieaXITZzBVMaAPT7Ws4VGAT9ZPpWmFhFYx0IRtKsL3RqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772510763; c=relaxed/simple;
	bh=R3pk+QnzDkvc3M/L2/XHinNfJwQE7pCTuITYB1UaXK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXnGeFNauu+8l2NKTzvWwj/RbwqJ81feSljenycrJ+UnzWwK0mnWdQLJtbikTg+RUF2R0UH1JMNmFBPFToeE4/zLLwMgwltL18kHBFD9+bkOsp44KH8e4LwzcPmiF6Y8spHiUQDTb8sLuSPkbRTxAl+EpaQf1+7tOBcUGuNYj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCR+VWRT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79827d28fc4so47366157b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 02 Mar 2026 20:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772510761; x=1773115561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HD3gU2egcPEtetPwEoYbiqC85QEBataao3jPvk2HXFc=;
        b=gCR+VWRTOqU5LUM6DkVraFOPcqUyffnLKMFrTwalsg9EX1IvN7LTyL95U5eG5C8ZSg
         VM5S9DcPd1dkvQLmcvaE0l+xNNRvKmkfKSYzBLi9BPXI8hgeTAkv/bFEPXCzwxfs4EIU
         53GcQ7l0le96z8aZACl07d2i6UJ8aOcXqBGz4VjRiMMW9cNpCeqSq1qDamt4fvyLvvTm
         dOJVqPh/kabgsdSEaJONrWlJ3hFxHeEnWv8ah7araPYUpiFLposQAPeBdjDtYKngVwdz
         ALtrJhGm6AK5QVkteNE6Qmc0XqIjED5kiv9Hzz8+tntU3ZcJcpKUErOuYKQxVVhvUYj9
         xO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772510761; x=1773115561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HD3gU2egcPEtetPwEoYbiqC85QEBataao3jPvk2HXFc=;
        b=pE0J/5FwVBvi/E2HZ1at7krrFi3cdUyTKk8LuaZtDHCOa4znmGM1kVDO6m8kqbnbwH
         aBQyCiSSRZEPyLctQMLZ1cxFPKbIDSGoHDIzJGd1LHikALRpnbV323vYcA5xmpfm10kf
         EoHrixFgzH5HN3pallpnZg10mr3jgfdIX561DEauRmFbepvqHwx6I2QwG0rIwK9UCfuh
         HMG5VvmNTZB8skgZQD0C8HvIxwsheg4ni8OST+INC0QWlwAZWBDUKU3HlXkQryVffGb0
         s3W98yhcYG/EhKUKSFGhKXd4WpJcuyaH9LiYWuBlGIjosfkSIQIH8tjORsiM1MAjSwDK
         UbHA==
X-Gm-Message-State: AOJu0Yz4/N424PZ6WyutIG9147+bf8+UacRXRhlWvMHuknw3FYiu+GTI
	slwTG9tbxVazKcJ+FhuGAZpWsDidWvqiKwFtTafLfP45ecSFVznC2J68z/S+Aw==
X-Gm-Gg: ATEYQzw8+UoMANN+VbHYmmGKzERSGYGNkpJw6qtjjTtjDFmmCCZO+3WlQKzNPBtmO1w
	OnvM3qMgHxfrqWfQ4cia0Md8FZ06JXGu8/dSSeXGkMXiWbBA03CIzz6/d6xmg/Yy1XCgyT5iJt9
	4DoRSMQo46UMSYrrM036EMcHFZ8vu/4NOYVBuRuR+8Q8lAF36/RNV58frXqn9j8DFyZ/JdzTNvw
	n3V2K9AefG8jjvudGWY8JXoam591yE5DeTle4ZlZVvNTzYb6WGvQcL2FuXxeZhvADKKumPuRCPS
	+D9SN+SnDxtJVf9FB3Pyq2hcf4NWFueAH02bwe87Z9wT4p33TqGsJ2QFGeM7EF7+PDxqaP+Hzq7
	tYlef1kkPT7cg7frJjZr/NqFB7O0HrusM+S/8UrloFdj9bgRct49gucyYidWea+UdnN3gEOtvnu
	WFQsR3C+kKyrlTXs5Qv5h2
X-Received: by 2002:a05:690c:6112:b0:798:7e05:ee9 with SMTP id 00721157ae682-798854dbb7fmr121732397b3.19.1772510761072;
        Mon, 02 Mar 2026 20:06:01 -0800 (PST)
Received: from zenbox ([71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798ac64fa32sm17460047b3.14.2026.03.02.20.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 20:06:00 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH v2 0/2] landlock: Simplify path walk logic
Date: Mon,  2 Mar 2026 23:05:38 -0500
Message-ID: <20260303040540.3124770-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3436F1E8A13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,maowtm.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-15203-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[utilityemal77@gmail.com,linux-security-module@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-security-module];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

This is v2 of a 2-patch Landlock cleanup series for security/landlock/fs.c.

These patches simplify path handling and path-based access checks. The cleanup
was initially part of my LANDLOCK_ADD_RULE_NO_INHERIT work, but it is more
appropriate as a separate preparatory series.

v1: https://lore.kernel.org/linux-security-module/20260218201857.1194667-1-utilityemal77@gmail.com/

Changes since v1
-----

- Split and clarified the series as:
  1) "landlock: Add path walk helper"
  2) "landlock: Refactor path access checks"
- Introduced landlock_walk_path_up() and enum landlock_walk_result to
  centralize upward path traversal state.
- Refactored is_access_to_paths_allowed() and callers around a
  struct landlock_check state object.
- Inlined collect_domain_accesses() into current_check_refer_path() and
  reused current_check_access_path() for same-directory refer checks.

Motivation
-----

Current path-walk logic is tightly coupled to specific call sites and is hard
to read and maintain. Centralizing traversal and per-check state should make
future Landlock path-based features easier to implement and review, including
follow-up work related to no-inherit semantics.

Patch overview
-----

Patch 1 introduces landlock_walk_path_up(), which walks a struct path
toward the VFS root and reports whether the current position is an internal
mount point, the real root, or neither.

Patch 2 applies the helper to access-check paths, introduces a struct landlock_check
to aggregate reused local variables used to check accesses, and removes collect_domain_accesses()
as a standalone helper.

Patch 1 can be applied independently. Patch 2 contains some more aggressive trimming
and refactoring of logic enabled by the first patch.

Thank you for your time.

Kind regards,
Justin Suess

Justin Suess (2):
  landlock: Add path walk helper
  landlock: Refactor path access checks

 security/landlock/fs.c | 507 ++++++++++++++++++-----------------------
 1 file changed, 225 insertions(+), 282 deletions(-)


base-commit: 8ff74a72b8af3672beca7f6b6b72557a9db94382
-- 
2.51.0


