Return-Path: <linux-security-module+bounces-15335-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJD5NgZhqWnj6QAAu9opvQ
	(envelope-from <linux-security-module+bounces-15335-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Thu, 05 Mar 2026 11:55:02 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 870CE2101D7
	for <lists+linux-security-module@lfdr.de>; Thu, 05 Mar 2026 11:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CC5D3054141
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Mar 2026 10:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AF037FF70;
	Thu,  5 Mar 2026 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bio7EmUO"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F75376BD6
	for <linux-security-module@vger.kernel.org>; Thu,  5 Mar 2026 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707995; cv=none; b=LFuiK4lDm9RyVO4c5JHPfBT5jIthqMzqfRl8abwH+gJ4KV7h5kzVM4o0hQMCFx7BqQ3QAiytW9sVKP/RhdaT3Ey9OWWRk5xUSPEN8mqbkm6z2InubHJbajKAFWwlw6Y9umtDqcVsx3/rzZ46svXTjaXza5yHib0XZ2NwWhE8JlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707995; c=relaxed/simple;
	bh=mPbvlwWoHj85GU1f61A/6Cc0J7NgRVi2gqMqeKSpzeo=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:Date:
	 Message-ID:Content-Type; b=WQdvzOdw3/S3nDmCNA+qnYabzR63x8fwtnTPBn2XUYWvLCOMIQ/PR9BgTjADZthFRQsCup5OWBq9jZMnbtYt8QeY8Pk8tDNgDKMqRAKZj30wYG6z1Vo1qkkG8eJCtPVLF34PxJuCofssDuNpgawA+YXHd2DBiM8HKd2oY51BwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bio7EmUO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772707992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNDCNkMCVOkvdHpTSgzP1GUBuRyBR5Q0ZRMeQkfNaBU=;
	b=Bio7EmUOQEYdNMgtVe8NdtIdQ+JSxPpz3u5RLOFbU5h2heooN3Z6GxkRF3AYoI+ZZ6hyec
	8jTtn0eEQKZmjSZG2bZAVRxuSgFH/v4CdctkqjN6Z9W0fJQxzUe2RXykz5N3jtWDApmwAg
	Yjfmpk/H75DhC/2688Tp0HidZPQqTPM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-G2eoyCM-MW29ZhCAlPKaPA-1; Thu,
 05 Mar 2026 05:53:08 -0500
X-MC-Unique: G2eoyCM-MW29ZhCAlPKaPA-1
X-Mimecast-MFC-AGG-ID: G2eoyCM-MW29ZhCAlPKaPA_1772707983
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C35A1956089;
	Thu,  5 Mar 2026 10:53:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.194])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63BBD1800671;
	Thu,  5 Mar 2026 10:52:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260305-module-signature-uapi-v3-3-92f45ea6028c@linutronix.de>
References: <20260305-module-signature-uapi-v3-3-92f45ea6028c@linutronix.de> <20260305-module-signature-uapi-v3-0-92f45ea6028c@linutronix.de>
To: =?us-ascii?Q?=3D=3Futf-8=3Fq=3FThomas=5FWei=3DC3=3D9Fschuh=3F=3D?= <thomas.weissschuh@linutronix.de>
Cc: David Howells <dhowells@redhat.com>,
    David Woodhouse <dwmw2@infradead.org>,
    Luis Chamberlain <mcgrof@kernel.org>,
    Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
    Sami Tolvanen <samitolvanen@google.com>,
    Aaron Tomlin <atomlin@atomlin.com>,
    Heiko Carstens <hca@linux.ibm.com>,
    Vasily Gorbik <gor@linux.ibm.com>,
    Alexander Gordeev <agordeev@linux.ibm.com>,
    Christian Borntraeger <borntraeger@linux.ibm.com>,
    Sven Schnelle <svens@linux.ibm.com>,
    Mimi Zohar <zohar@linux.ibm.com>,
    Roberto Sassu <roberto.sassu@huawei.com>,
    Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
    Eric Snowberg <eric.snowberg@oracle.com>,
    Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
    "Serge E.
 Hallyn" <serge@hallyn.com>,
    Nathan Chancellor <nathan@kernel.org>,
    Nicolas Schier <nsc@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Andrii Nakryiko <andrii@kernel.org>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
    Yonghong Song <yonghong.song@linux.dev>,
    John Fastabend <john.fastabend@gmail.com>,
    KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
    Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
    Shuah Khan <shuah@kernel.org>, keyrings@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
    linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
    linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
    bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/8] module: Give 'enum pkey_id_type' a more specific name
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 05 Mar 2026 10:52:47 +0000
Message-ID: <287135.1772707967@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: cHPV5tD0lvbYd9d2k64z1Wffp2Od42hi1HYUqdm58Iw_1772707983
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 870CE2101D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	TO_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15335-lists,linux-security-module=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[44];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,kernel.org,suse.com,google.com,atomlin.com,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,iogearbox.net,linux.dev,fomichev.me,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-security-module@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-security-module];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,warthog.procyon.org.uk:mid]
X-Rspamd-Action: no action


Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:

> -enum pkey_id_type {
> -=09PKEY_ID_PKCS7 =3D 2,=09/* Signature in PKCS#7 message */
> +enum module_signature_type {
> +=09MODULE_SIGNATURE_TYPE_PKCS7 =3D 2,=09/* Signature in PKCS#7 message *=
/
>  };

It might be best to just kill the enum and replace it with a single #define=
.

David


