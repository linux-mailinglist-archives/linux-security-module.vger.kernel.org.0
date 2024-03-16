Return-Path: <linux-security-module+bounces-2185-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8227587D9D2
	for <lists+linux-security-module@lfdr.de>; Sat, 16 Mar 2024 12:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13E5B1F21914
	for <lists+linux-security-module@lfdr.de>; Sat, 16 Mar 2024 11:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546DE28EA;
	Sat, 16 Mar 2024 11:06:29 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095C012B77
	for <linux-security-module@vger.kernel.org>; Sat, 16 Mar 2024 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587189; cv=none; b=Z+Q/lpgLpG/z+VTWJKLHlhWECex1Vt+LKAafkeGBDuBSrLObQG1z97uQTQxR5IDFWO+wI2D9zi3RwbeCkKmyy/FcAtGT7WEgHOdrxFtyFGBwCQGexA/wRETiIqvRKmptOeQM+GFh0qhB4zxFrN85iw74VmptzTqqV88pvfOv8Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587189; c=relaxed/simple;
	bh=dtx8V8z0Yd4BaN4O1t6mK+JQqlvG4HxxuR5EoDvbdTs=;
	h=Date:From:To:Cc:Subject:Message-ID:Mime-Version:Content-Type:
	 Content-Disposition; b=dngQPV3lxAiGVcYx+jL435a5isu32s/HVazI06AodadHdU2OVyHXJAURBVkDRz92CGtbmZXceVn4PCuERHrsJeCoU5YmFoOtGqKD9UC0u3X6mZ8ujbrAuxwi8b+3r3DjlB0XlLzDjHb3ZgV+PMVH5j3CITeZ0xrLZ97CAC1nxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 42GAlGa2022841;
	Sat, 16 Mar 2024 05:47:16 -0500
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 42GAlELv022840;
	Sat, 16 Mar 2024 05:47:14 -0500
Date: Sat, 16 Mar 2024 05:47:14 -0500
From: "Dr. Greg" <greg@enjellic.com>
To: paul@paul-moore.com
Cc: linux-security-module@vger.kernel.org
Subject: TSEM code organization.
Message-ID: <20240316104714.GA22794@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Sat, 16 Mar 2024 05:47:16 -0500 (CDT)

Good morning Paul, I hope your weekend is going well or your week is
starting well, whenever this e-mail finds you.

We've been waiting for the release of 6.8 for the V3 release of TSEM.
TSEM seems to be co-habitating with it reasonably well, modulo some
atomic structure magazine refill issues we are sorting out that appear
to be caused by workqueue scheduling latency differences between this
kernel and older kernels, so we are getting ready to push the V3
release.

Casey has previously raised an issue with the fact that we used a
single include file, tsem.h, for all of the entities that are global
to the various compilation units.  We placed that file first in the
patch series so that it could be referenced for review as the
individual compilation units were added.

Everything in that file has a 'tsem_' prefix on it, in one way or
another, so that anyone looking at the code knows that if that prefix
is seen the definition for whatever it is can be found in the global
include file.

Casey advocates that we break the global file into individual include
files that pair with the compilation units and we do appreciate the
concern behind that.  However, given that all of the compilation units
reference these global values in one way or another, we will then have
a model where we are introducing code that is using definitions of
things that are not yet available.

You are the final judge and jury on this so we would look to your
advice on how we should proceed.  We maintain TSEM across multiple LTS
branches so if we are going to go through the code churn this requires
we only want to do it once and get it over with.

We will look forward to your recommendations on this.

Have a good week/end.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

