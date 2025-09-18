Return-Path: <linux-security-module+bounces-11899-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5845B58D86
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Sep 2025 06:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DA57A8CC6
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Sep 2025 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C8324BBEB;
	Tue, 16 Sep 2025 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JL+Xia8W"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF812F1FDF
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998191; cv=none; b=ePFf/IFTXX8Gd8+KR+TPuMF1wyJbGYz9wmpjNshCEebsRWmYO933spPcXpZaENeeYFJn+pP79ZTOZ4mTfrFisJ0bjbXQ7atiyQPRbY48PBsNpY5+CH4LUFTv6qWwDYF2oIbWmEfVkSpJuEPjpOQgaWjTyhxD/wYzqaKKEZnh1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998191; c=relaxed/simple;
	bh=slyVnZPzDDOXEcpF4QZOR3I7YB3yd3f7Gxtzb+FU87Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpbSRmJ8LwMjm8SZE21makvqfyPvPI+9De98y9uyzxSJZJFllAIGcYrKcsDfivTtMmtPSHjOmy3q8aLVjxBKM/U/kU/3Ii/vpb/wZ5++DVQTwySLW5c4M0cT3X8/KxqG3FxFVejXhwf41cjslcQHBdOxfa19cysfQn5PHhMijT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JL+Xia8W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-266fa7a0552so15568335ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998187; x=1758602987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=JL+Xia8W4uyroTDLgoFXQGcvga86g7+1VEKz2roIDSxQwxKuGGI1kJw0E5mRvO2QSO
         m/1WcvkXEpAacTm9jy5S7c5V4Dczrr3meBJOyddNip27HVCCCOgthvtb5FLtkxbvF41s
         iGlUzzPGymDg3T5amMQJm6PDCBR7n+L0ahtyEay0NJYWIu7m2vFg6tr2ajT32yaanfBd
         xDtJu+c4X/3CeTjTCyDCOh+jJ9IMVyUrOd4EWhGGuGTa3TWSp3+no8CtHQqAuwI3rWWA
         BuIdQSsCM/Xgm1YsJeGbAazZkNWV/RcrZ3PBFtpntXLtYH4Vrd8FCoda8o0sXcMxI94o
         +OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998187; x=1758602987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlYXyo2uZuFo7JhGyy9UUCXJlKeDR2CbpPIjqr5RgpE=;
        b=DOma0ZfqG3l3XXjI7uuAazXX6DCFaJF4P6ryP+yc6gs0ts04kovQ0/dxpL3zA5lB+/
         TfA2XoRTyJGpG1zFjjUTBYrEdAZKUum5cZZcsPfsoP1iMTSoxa0RQKbftC8t4u27G1gX
         hU1HC5EkSyJ//IPOs/5OvZsVrEkeoE8JllX/SZ7/3+WDxq6MzZIEn26IAi9PdF0JUis0
         4xuhHnlvCTsTsEMNYEwIC0GnvXENn7zzImg5LOeNUavIbF2Q0bBdz1n0dZEhxMBfdweX
         SY4/UQo7RusiKfxf6ljAs0WvLYV3n2abTJKi5xzymqa/faP+FxtrD+VKROmdh5Udkob6
         Ig7w==
X-Forwarded-Encrypted: i=1; AJvYcCUBU+NXiVxmEFv7tICV5T+lc7EjRDOFnhwjyitVG7seHTxEDzCw/DM52ZD83a1gyYKF0rcONGuwbngvt8QkL+uO86PXb6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFxRpEJgUJmLBt55WhyISF4tbwxTG5RYdrVuiyC/FfO12ylfs0
	3RTnogsfbZCsQkS/WyKktPpcfTR1GWAlcdhpFUdlX2QxOniA1Xlzl0ud
X-Gm-Gg: ASbGncvuSOkSZo9gwi7O2W5RDeKsGohSWRXq8an6duQ6nx2N0NCC3gw2pp0LHbdlA8B
	hEY3/9BcR/0pRD/T50ZF/S3ueH8MSWGtJRkriuLfPwwl1FipvW8g2mzjKIrsGyuJZXp59paubeQ
	cPfM+5xhuMjmVQh00vxJLHYupF0rRXX4d0RyNP7XsdqIJA1T84acXEfCMXzhIB0VhoXv0wBEIeB
	ytvcXqEN68uimCNeSRadQ0jlfJKEjhM4RlPTn2HGmtV3S+yyZ8tF6c3F8cB8PuQMbaMB3QLH7bE
	dV6c/5HZWkr5ox6uPXDa2dKrtSB3XInqXYhBnHMkUL8Fji1LD+zVWfnZJrn/ZCL+87odurxFMPY
	P8IAnEMQT+GyUaYpuia8m5CyFv6RQAUEuM5gX99LekEfWCVT2Ng==
X-Google-Smtp-Source: AGHT+IFV4zbzh4iycIfH4WDU92suC0bCanMglT0Ogl2GwpwL8kM68NHrYSygkh1AIkIcAzvJhqwslA==
X-Received: by 2002:a17:903:2f4f:b0:24c:99bd:52bb with SMTP id d9443c01a7336-25d267641camr179941415ad.30.1757998187203;
        Mon, 15 Sep 2025 21:49:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:46 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	"Toke" <toke@toke.dk>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 14/14] wifi: ath9k: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:35 +0800
Message-Id: <20250916044735.2316171-15-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: "Toke" <toke@toke.dk>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/wireless/ath/ath9k/xmit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 0ac9212e42f7..4a0f465aa2fe 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -1993,7 +1993,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 
 	ieee80211_txq_schedule_start(hw, txq->mac80211_qnum);
 	spin_lock_bh(&sc->chan_lock);
-	rcu_read_lock();
 
 	if (sc->cur_chan->stopped)
 		goto out;
@@ -2011,7 +2010,6 @@ void ath_txq_schedule(struct ath_softc *sc, struct ath_txq *txq)
 	}
 
 out:
-	rcu_read_unlock();
 	spin_unlock_bh(&sc->chan_lock);
 	ieee80211_txq_schedule_end(hw, txq->mac80211_qnum);
 }
-- 
2.34.1


