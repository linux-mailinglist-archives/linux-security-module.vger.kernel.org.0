Return-Path: <linux-security-module+bounces-14690-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GJIE280k2mV2gEAu9opvQ
	(envelope-from <linux-security-module+bounces-14690-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Mon, 16 Feb 2026 16:14:55 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF0E145470
	for <lists+linux-security-module@lfdr.de>; Mon, 16 Feb 2026 16:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B635E302AF16
	for <lists+linux-security-module@lfdr.de>; Mon, 16 Feb 2026 15:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F05C30CD91;
	Mon, 16 Feb 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zw76SYik"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CE2459DD
	for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254394; cv=none; b=CgPhWbRg/JYYHQia9cgEfTu3pvstsVVacYJePxYo0n7yM54SY+NyYkQdRvf9588c1RRcQh4g8X1Mq6JcMKWVLH+Az//Y9rqLc/mT1FkG4rYxBdoh5r0PsLNeVaTveGoeDYkw56y8VfM99t1DhtHrG4foGaPpTfQZaDOav8CSq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254394; c=relaxed/simple;
	bh=lNDowtUHSkw+k/WpEDgGge0SfGDSJL247zcNQSwuyB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=YYV6nwL5rKW1FVN73dD9TG3L3fogAESnvL8dChtyd6Cb48YmBpCVUihCUvG3WEz9puJpCnavqh21ngZPvdyPSAsE6GFogTIsbBWNTVKaRb/Wk3GbBbi58G6Kz2nMYg/hQqfh21U71xNrxtNcIV9CH4YZzYeMarp8SCgi2gcVxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zw76SYik; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771254391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8u7jdAWRJewFqAbMnC4XSsYdyNIzBSqiconhEF9G/OU=;
	b=Zw76SYikZ4I1Kd89J269xs+e/t36d9zpTwu38aa3uz5jmCWK3/WFNBRgp9qEDAunXxs4Uz
	EtTeYEazW9yMH+Z+zmRI33WT6/w7t7lceACfqQayi4/WOtyPFlfklFpQx3qsWDO+3BL753
	rlXxKIJBZ/WsTTgMeK+eAdQ6pSCZBHk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-qEzxi4g6MXmbpWv_vRuWIQ-1; Mon, 16 Feb 2026 10:06:30 -0500
X-MC-Unique: qEzxi4g6MXmbpWv_vRuWIQ-1
X-Mimecast-MFC-AGG-ID: qEzxi4g6MXmbpWv_vRuWIQ_1771254389
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-436267b01c4so3061416f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 16 Feb 2026 07:06:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254389; x=1771859189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u7jdAWRJewFqAbMnC4XSsYdyNIzBSqiconhEF9G/OU=;
        b=qGp43rX8DwaidCjm8Kd2AJJwJt0dg5KeLAL7eVbfPb342eR7xh+biKSl3zewYlichw
         5NF1SF32mPM23xUil+3nRl9oqkiVwYOOxL0ejBHDZKqhVxMOzrT/vq/lunftxXbnncu6
         JvPpey0Wx2Q6xWE/mOzXXIdI4Q0+AjtNSRtLI9tqsfN02vAp3f1zvqPTAn2MFHeSry7q
         lX+kubTLxc0dcxr+PKt3fGMOSrfdwiThVgtuYp6SwMvrGxAdKFySjgdjI5OwMcshPeJa
         okQEZdZZjVkuGcnYYLmioCISKksLNSnHe8zRd/AlJ6LrzTKIETuubHy07dIFjSqCMwxK
         GzjA==
X-Forwarded-Encrypted: i=1; AJvYcCVskVBJtfTs6KfWG8PaA+qT61Zu+PMwMos/OUy0XfyhUjqe1yxUQzlKnnUL7xbuV2JF4TrEfGxcS8K+zpbiTwZnagMXRJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKMCGAtvIEwxxTgTnsi6pfKATvnxOOM50e7ZRi/EI0EG7n1Rz
	Zu6i9P/9XfqnNl3K+MTrNwbylFLMXcKvsxqGH+cPq8n7EhPTb+f5OY+RWXoDWGYCnFJMMgOnPKT
	Igc6b6+6m1MLz2zwL1oV5BYJ/hhLehAWLdx7GtvMOVHAC2PzFvdydc8e86Lh+cjjWrA1MwK2CCW
	ToDA==
X-Gm-Gg: AZuq6aKN/dkbPvYMl2RvRB1OUjVqfOX8jvJ7BkZDwSFG3+dJp+6bN7fbVcS/q5JiTnH
	ADLMxgx1qrtFvpjTqdPFPxYHjrFTDcAAau1wlfDKi3kkjQBzXgsDC0b5AhILBKP2b4aYYDVqit9
	IHFukidPUJ24bRSN+AmSUz5JGeENOu5aP4cj7FxddUu4Frii1NcbK/iqZ7q3ZxgmL5Ayyu+hksn
	y4nn46/CBKkwgn5cplCFvmUHpPZyl8iSnQ3z6RGe2DwjDK1k+KpLIMWMCR7v7uyVK3LHmhvRgnI
	xo3wglNS+2ZnRKL9H9SRzHZ1/l2o37rL+KfXMGzqUUZnkkJ/Jn5QU9sKmo8jRJ8A7vANuaWoEyU
	fvvLCz49yheHu+g+SkpbfS+Nqr3qOIgvC33JuWZYgC5b2yW3C
X-Received: by 2002:a05:6000:178b:b0:435:a2f8:1533 with SMTP id ffacd0b85a97d-4379793d97fmr18660419f8f.52.1771254388667;
        Mon, 16 Feb 2026 07:06:28 -0800 (PST)
X-Received: by 2002:a05:6000:178b:b0:435:a2f8:1533 with SMTP id ffacd0b85a97d-4379793d97fmr18660369f8f.52.1771254388191;
        Mon, 16 Feb 2026 07:06:28 -0800 (PST)
Received: from fedora.redhat.com (109-81-17-58.rct.o2.cz. [109.81.17.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc9b2sm25631899f8f.21.2026.02.16.07.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 07:06:27 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matthew Bobrowski <repnop@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fanotify: avid some premature LSM checks
Date: Mon, 16 Feb 2026 16:06:23 +0100
Message-ID: <20260216150625.793013-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j6klmLEooNiLyXUVNbGztC6wTyOJZGbH1my_H3SYez4_1771254389
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14690-lists,linux-security-module=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[omosnace@redhat.com,linux-security-module@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDF0E145470
X-Rspamd-Action: no action

Restructure some of the validity and security checks in
fs/notify/fanotify/fanotify_user.c to avoid generating LSM access
denials in the audit log where hey shouldn't be.

Ondrej Mosnacek (2):
  fanotify: avoid/silence premature LSM capability checks
  fanotify: call fanotify_events_supported() before path_permission()
    and security_path_notify()

 fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++----------------
 1 file changed, 23 insertions(+), 27 deletions(-)

-- 
2.53.0


