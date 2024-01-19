Return-Path: <linux-security-module+bounces-1037-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575A2832D32
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Jan 2024 17:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D762839E9
	for <lists+linux-security-module@lfdr.de>; Fri, 19 Jan 2024 16:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D811433A1;
	Fri, 19 Jan 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Od5SyaRM"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BEA5467E
	for <linux-security-module@vger.kernel.org>; Fri, 19 Jan 2024 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682030; cv=none; b=NrUXZEDRIdDiWX1Wj+MNEJTTpR0SB4xpCWvERXntRX7VPom6DTDFqbWZ9Ch9vttKL06B1tzZwwU65rCrlKi3IhhIEFvkFnclWz87EON5j3uki2S+ULChHC0vXKDMb4LHzk1GabiSjhF+QS4awAX5jfvaDaOoZ606eFOVV+SJkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682030; c=relaxed/simple;
	bh=rH2cnrTenI/ovUuxdgm8ztyVBIo++YyJ/oUzTgwGS6o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZZqLo/IKuKg6nF6oSEKxAPmyNO0GIyDNdv819cczu67QhWmvvhvpAqbn8/gDtfR0fzmhruxQARIkwyR2cZ5aKpZfrfNqT9u30yhOZL4TuOhFWyRJTincTB77/CfKDEV+xmP9il5Faus2ZXb1gcRu0/KDCNJwpG6l1gSdTkx2kZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Od5SyaRM; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso1096572276.3
        for <linux-security-module@vger.kernel.org>; Fri, 19 Jan 2024 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1705682028; x=1706286828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nrJHSioKHAnyTv1OPCyZuc+rZyrkHjI3ktv0C6hnyOU=;
        b=Od5SyaRMAonO17qer5aZaXvQCR/OfmCSYTkEuzF0UR/k4vXny5m8i1yNU+GOjNMCmF
         nNGNACTZ6QWtAr3eyE7LhCJhv9z+yOKo0roeZc/iACyX7B+DoUeQXAems8V4czsecshj
         FvAI9dq9nsHH8W5AK9qx2rBUcF9KWfyUEh6XXS3Ipn3lTwr3mhKmPmkaJYqsmn4B6ltH
         EJRZj6b3yyK8PHpNWc+TuvZRGIX5OEwwN74e/bZXZ98fqMwX7GCaTYtwTiERlKh2OnhU
         uoRQPTHYErVDt9M29wzL5MqrdA3Dd2Rswua6wHZky7A6xpyeibkqoV/8+AJNeKWtswAf
         YU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705682028; x=1706286828;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nrJHSioKHAnyTv1OPCyZuc+rZyrkHjI3ktv0C6hnyOU=;
        b=wtX6lFKePrhH1nyaUz05yfPRJ7ZO034tSu0FedDExOd08nDRX0IoAj8sRf9BqIu910
         6IS8clUq+6VfEb/JCFB5T7F2N3yYVmwZd77AAu4v1hPksTVsnNoIgxAc//DhCH7om1CC
         f7mu3F3MWoesUV2L3Nr17c/rgJCOtfGtUaIHPRqQxJoPOoxJBeqklzXEixMzglZAn2Ge
         RnA5z4RTXQ5Sz+Z8rTJt/0cGUtXhYmHANjZNwHaQRdTwgUE+OBaXhmQqB4p18hS+jMJH
         wJnJ+KV6qe6qqFeRLKpR57EZ3tvWgzmip9LAC+ho2SVPI/R6YDkLxESBZSf3I4OZdcKT
         K/nw==
X-Gm-Message-State: AOJu0YyJEDxdP9GXvFev4+KD5yZLaF52fFzw/djsiAJ6r/RcqF5jrw9/
	NkCXARNY65lcASMM4vf+eh68TKYgEnvBAceslB89s9zIaheDOopUNK9orYoRkIMVy5iWl/bW1d/
	u4pkAvSjarSVu8dgA8vHOxas3w+/NQWZ4TLMe
X-Google-Smtp-Source: AGHT+IEH1cn/9O9lR6VO5+PB4kXdW/p6syEQjEKnEBK6vJuIhvjLAhx1VffIqvthuNA7/gUwUuNi7fAT2XiiJ16SA8Y=
X-Received: by 2002:a5b:b4a:0:b0:dbd:4eff:3981 with SMTP id
 b10-20020a5b0b4a000000b00dbd4eff3981mr156149ybr.69.1705682027861; Fri, 19 Jan
 2024 08:33:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 19 Jan 2024 11:33:37 -0500
Message-ID: <CAHC9VhRBkW4bH0K_-PeQ5HA=5yMHSimFboiQgG9iDcwYVZcSFQ@mail.gmail.com>
Subject: IORING_OP_FIXED_FD_INSTALL and audit/LSM interactions
To: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>
Cc: io-uring@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello all,

I just noticed the recent addition of IORING_OP_FIXED_FD_INSTALL and I
see that it is currently written to skip the io_uring auditing.
Assuming I'm understanding the patch correctly, and I'll admit that
I've only looked at it for a short time today, my gut feeling is that
we want to audit the FIXED_FD_INSTALL opcode as it could make a
previously io_uring-only fd generally accessible to userspace.

I'm also trying to determine how worried we should be about
io_install_fixed_fd() potentially happening with the current task's
credentials overridden by the io_uring's personality.  Given that this
io_uring operation inserts a fd into the current process, I believe
that we should be checking to see if the current task's credentials,
and not the io_uring's credentials/personality, are allowed to receive
the fd in receive_fd()/security_file_receive().  I don't see an
obvious way to filter/block credential overrides on a per-opcode
basis, but if we don't want to add a mask for io_kiocb::flags in
io_issue_defs (or something similar), perhaps we can forcibly mask out
REQ_F_CREDS in io_install_fixed_fd_prep()?  I'm very interested to
hear what others think about this.

Of course if I'm reading the commit or misunderstanding the
IORING_OP_FIXED_FD_INSTALL operation, corrections are welcome :)

-- 
paul-moore.com

