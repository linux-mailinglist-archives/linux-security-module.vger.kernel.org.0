Return-Path: <linux-security-module+bounces-8164-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290BA2D90E
	for <lists+linux-security-module@lfdr.de>; Sat,  8 Feb 2025 22:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008903A4793
	for <lists+linux-security-module@lfdr.de>; Sat,  8 Feb 2025 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E31F3BB3;
	Sat,  8 Feb 2025 21:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b="Oh1bbw0t"
X-Original-To: linux-security-module@vger.kernel.org
Received: from server-598995.kolorio.com (server-598995.kolorio.com [162.241.152.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551661F3BB2
	for <linux-security-module@vger.kernel.org>; Sat,  8 Feb 2025 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.241.152.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739051807; cv=none; b=FDCjZb4r5GUQJNlsRkYxGrS7JNenISA7IpRXX4DI8ijVXnBadVlc0vULnefq+KQmJegH4US2r90GdeH6WdL0ANPwVq20FasdF78GwAMUMpeQZCKzYSUEyxVi6JinAmkV0Y68x/tBUulvWEXQEcbgWvdLvd7YUlRrU6tpUz8ZFcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739051807; c=relaxed/simple;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FUyUMmXpcrhmC+9hY3d94gzblzjMDrDRiOSEnhJ/KHmmFwsFt8xPDzRgmASSCDcgoAff020Lvoik9BSDlGMEmJ8YjGLQDB1I9d6L96/tllJ7XK9rhI8dUUTnckibxt2w9o1S5dBMEFdeMipswGdD0dCvaSfBVH1aqHcB4Kjh01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz; spf=pass smtp.mailfrom=truemaisha.co.tz; dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b=Oh1bbw0t; arc=none smtp.client-ip=162.241.152.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truemaisha.co.tz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=truemaisha.co.tz; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=; b=Oh1bbw0tHs1Ra4Q+GUFSlEXXII
	KH6PW0CW39qzCmZ7EjsV7rucw7f679mLCqYPTgmgOoOhweDWfAUwqixTCOcel5Tt8v9378KysI8K3
	y5sFsdpNMgd47h61r0acCvZTMZBX8AISTupzJ/ttjnjpGy9QC3DVs9hDAwbrYQDVXnKFcslgnanLm
	tx09YgQS0kr/YplfBjTzpi/UBdRKJgLTmE8NOsTPAeHfZK9QcyG1jzsJzr2p2oIqW/4Jg8T7ELz3o
	efaWtZ0/O36vTkFWkLU0I8eLUKQnk2vB04LzUVdJYUE+gSWBvmF/zCdhSY/JwdwTebp8W5AZrIU5y
	sGEiXuuQ==;
Received: from [74.208.124.33] (port=59291 helo=truemaisha.co.tz)
	by server-598995.kolorio.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <chrispinerick@truemaisha.co.tz>)
	id 1tgsob-0004Al-0N
	for linux-security-module@vger.kernel.org;
	Sat, 08 Feb 2025 15:56:42 -0600
Reply-To: dsong@aa4financialservice.com
From: David Song <chrispinerick@truemaisha.co.tz>
To: linux-security-module@vger.kernel.org
Subject: Re: The business loan- 
Date: 08 Feb 2025 21:56:43 +0000
Message-ID: <20250208210541.EC30CE116734A41B@truemaisha.co.tz>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server-598995.kolorio.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - truemaisha.co.tz
X-Get-Message-Sender-Via: server-598995.kolorio.com: authenticated_id: chrispinerick@truemaisha.co.tz
X-Authenticated-Sender: server-598995.kolorio.com: chrispinerick@truemaisha.co.tz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

My name is David Song, at AA4 FS, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
David Song
Senior Broker

AA4 Financial Services
13 Wonersh Way, Cheam,
Sutton, Surrey, SM2 7LX
Email: dsong@aa4financialservice.com


