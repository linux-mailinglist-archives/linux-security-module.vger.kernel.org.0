Return-Path: <linux-security-module+bounces-14112-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIiyNl/QcGkOaAAAu9opvQ
	(envelope-from <linux-security-module+bounces-14112-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Jan 2026 14:10:55 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F157B575C9
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Jan 2026 14:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014146013D6
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Jan 2026 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE274218AB;
	Wed, 21 Jan 2026 12:57:29 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from sub0000529476.hmk-temp.com (mail.btob-mail.work [180.222.184.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B571C48122E
	for <linux-security-module@vger.kernel.org>; Wed, 21 Jan 2026 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.222.184.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000249; cv=none; b=rDmGaOZqXtUMSGSVsTieMPGvD9PHWQtEHht/Sa97ILHbj7nkzXEtiMigDtXLMK7NQmFHUYmEOSUuuBkuuJA9SXRcT/Z4y3FV9DOwg8a0NpHlU9Z5kLJ9JpeJmeF8GdzDDRDGAvm06pIVL2l12n0/6VfXCnggnrN8kFGIsiK30es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000249; c=relaxed/simple;
	bh=XWhwz5XfX6dcp6E8MvIbZWFetA2FciHeSNylbn60qUY=;
	h=From:To:Subject:Content-Type:Date:Message-ID; b=Bno85DNZVY5REyPLmG3dl+G/cuBgcuFBW8YSLJQVAMH28T5+/SGQihFXNh2wGy+diKtHpzYqOe+Gb0FK4aVHHsO51vtU0okIemqWn5Zo804TEnLkTkQkDkVV61dxiFsJlcK+FBrHvSVmGFuIbhXv3LaGk4Ykf1KL/+MgMoGRSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=headmint.biz; spf=fail smtp.mailfrom=headmint.biz; arc=none smtp.client-ip=180.222.184.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=headmint.biz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=headmint.biz
Received: (qmail 17371 invoked from network); 21 Jan 2026 17:32:03 +0900
Received: from ai126170209163.41.access-internet.ne.jp (HELO DESKTOP-17GBPQK) (126.170.209.163)
  by mail.btob-mail.work with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 21 Jan 2026 17:32:03 +0900
From: =?iso-2022-jp?B?GyRCJVglQyVJJV8lcyVIGyhC?= <info@headmint.biz>
To: linux-security-module@vger.kernel.org
Subject: =?iso-2022-jp?B?GyRCJCIkPyReQGxMZyROJGIkXyRbJDAkN0U5GyhCIA==?==?iso-2022-jp?B?GyRCPH0xV0AtRXkhPzM1TVc7cU5BGyhC?=
X-Mailer: Mail Magic Professional Version 16
Content-Type: text/plain;
	charset=iso-2022-jp
Date: Wed, 21 Jan 2026 18:38:27 +0900
Message-ID: <202601211838270354.12EEEDB0602C4CDF87E3F6D39281BD7E@btob-mail.work>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [6.84 / 15.00];
	ABUSE_SURBL(5.00)[dryheadspa-hm.biz:url];
	MISSING_MIME_VERSION(2.00)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[headmint.biz];
	TAGGED_FROM(0.00)[bounces-14112-lists,linux-security-module=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[info@headmint.biz,linux-security-module@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-security-module];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,dryheadspa-hm.biz:url]
X-Rspamd-Queue-Id: F157B575C9
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

お世話になります。


コンパクトにスタートできて手堅く収益をあげることのできる
フランチャイズビジネスの事業概要資料をご案内申し上げます。


　　　 小資本／小スペース／少人数の
　　　　コンパクト・フランチャイズ

　　　　　ドライヘッドスパ専門店
　　　　　　 “ヘッドミント”

　　　　　　　・収益モデル
　　　　　　　・開業に必要な資金
　　　　　　　・ロイヤリティ
　　　　　　　・スケジュール　etc
　　 　　 ↓　 FC事業概要資料 　↓
  　 　 https://dryheadspa-hm.biz/fc/


ドライヘッドスパとは　―――　水を使わないヘッドスパです。


足つぼや耳つぼなど、専門のもみほぐし店がありますが
ご紹介するサロンは「　頭に特化したもみほぐし店　」です。


ドライヘッドスパというジャンルの認知度は、
現時点ではそれほど高くありません。


にも関わらず、私どもがフランチャイズ展開する“ヘッドミント”の
店舗には月間450人以上の新規客が来店し、満席が続いています。


これから先、認知度が高まることで
爆発的に伸びるポテンシャルを秘めています。


フランチャイズによる事業を展開していますので、
新たな収益づくりをお考えの方は、まずは概要資料をご覧ください。


　　　　　ドライヘッドスパ専門店
　　　　　　　　ヘッドミント
　　　
　　 　　 ↓　 FC事業概要資料 　↓
  　 　 https://dryheadspa-hm.biz/fc/


よろしくお願いします。


------------------------------------------
　株式会社じむや
　愛知県名古屋市中区大須3-26-41堀田ビル
　TEL：052-263-4688
------------------------------------------
　本情報がご不要な方にはご迷惑をおかけし申し訳ございません。
　メールマガジンの解除は、下記URLにて承っております。
　 https://dryheadspa-hm.biz/mail/
　お手数お掛けしますがよろしくお願いします。

