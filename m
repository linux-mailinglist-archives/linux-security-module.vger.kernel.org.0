Return-Path: <linux-security-module+bounces-14116-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNy4LkU7cWnKfQAAu9opvQ
	(envelope-from <linux-security-module+bounces-14116-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Jan 2026 21:47:01 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 336065D8C0
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Jan 2026 21:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF40FAAB74C
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Jan 2026 19:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA630F94B;
	Wed, 21 Jan 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUDI/4qh"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463753C1FD2
	for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 19:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025271; cv=none; b=pofIf87IrE3ymm61QREpJSDcSSR6jbAvroQOaD3rk6Q9Jj8VOlxB8zzD6WWJocWL0dXl1heAgZa6OgCV6M7FQXknjElw8p0hZ4jZeWIukAoqc317mI9GHrefEPh9EzFKS9KYsZAnya0Z5vp02/cfKjGgfAZu1hVrdFHaw2BfJw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025271; c=relaxed/simple;
	bh=yxb1cCLikrz2Q1MgxwqzQ5lzefaBn1M5G2M/HCfRNgY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Njy8yp/ELs6NntvLfEPATzO245szTXqRKiVjG3y97lUulCL/HWu3pgK8njVuab48jTPrt5cKsXWLZ7cXEqYvgmzfM+X+0liOlMCPKaGQ4WN8pxkxT2qN+N5npN8DDY1ALBbo8YAJpp8Jd+6WZVMAOPd+uoQ219ovKaQVpxnPFbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUDI/4qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4B2C19425
	for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 19:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025271;
	bh=yxb1cCLikrz2Q1MgxwqzQ5lzefaBn1M5G2M/HCfRNgY=;
	h=From:Date:Subject:To:Cc:From;
	b=GUDI/4qhY0h3SydNMQLjsepsrDn/uXGppXV5x1MgfnxUCxGGVEQ8U0iWoTZ66qgJF
	 naQW0uRQp5hiUCuTexSRO0qBIt3Qpe1rgBNx8oKA9tYr2NaVhkx10H1kZTtqEc2RLS
	 ov7VZO8g96t2Q9wr1mENqAGtX9eWozuj+JE2/n1FLGYq5jDiasWd0N0Bln0c3ewUli
	 PGmdQWu6NF6s5mQLArASgEdaPMTFju0XDzOrzycVqsjsSuS+aSIbab0rEqsH1RWs0m
	 +36sfA9ecJ2xZxKcxst2K4qJOsjcJ+85YH1oFSUJkY3lVwHjVN8nfWXxHdf6elgezU
	 JWfdzDBe27Nzw==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8c655e0ee70so25714085a.3
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 11:54:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpAalikvCnqZvi4Lyd5tphc53Vi/MAozWRjIT5jc6+oVA8naXgQ+ZPzvuCtmaXguZCKarLu8kOzD23Ql5c0YRpXkKkerE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUZVZBDUeuGclgxWIRg9VF3SpIoXvyIvZ+B7TqSzHCwVoNSHJp
	5X+rbh6+d1DSwqM+3KPXQS7RUe5u9lert7e0UrwWX/1BCG4dQqNAoMtewQ+q7u2zfNG+kdEcJpm
	l8bG2fHDUHOWEqW2KhHDI6uZprtkE17A=
X-Received: by 2002:a05:620a:1710:b0:892:ca0f:fc21 with SMTP id
 af79cd13be357-8c6ccde2807mr822897485a.40.1769025270110; Wed, 21 Jan 2026
 11:54:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Song Liu <song@kernel.org>
Date: Wed, 21 Jan 2026 11:54:18 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
X-Gm-Features: AZwV_QgsgjhWfk0YsKkFKCqOs7PpeRWozME_nBh0y5sHUbGGKqGmpO-fzfyjEZo
Message-ID: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-14116-lists,linux-security-module=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,linux-security-module@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 336065D8C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Current LSM hooks do not have good coverage for VFS mount operations.
Specifically, there are the following issues (and maybe more..):

1. security_sb_mount suffers from the TOCTOU bug for bind mount and
    move mount [1];
2. There is not sufficient coverage for new mount syscalls (open_tree, fspick,
    etc.) [2].

A key consideration of this refactor is to minimize lock contention, especially
around namespace_sem.

I also want to discuss what features in the kernel side (kfuncs,
iterators, etc.)
are needed to enable reliable monitoring of mount operations in BPF LSM.

Thanks,
Song

PS: I am not sure whether other folks are already working on it. I will prepare
some RFC patches before the conference if I don't see other proposals.

[1] https://lore.kernel.org/bpf/20251130064609.GR3538@ZenIV/
[2] https://lore.kernel.org/linux-security-module/20250711-pfirsich-worum-c408f9a14b13@brauner/

