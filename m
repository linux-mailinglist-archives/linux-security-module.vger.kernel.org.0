Return-Path: <linux-security-module+bounces-14226-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLtdCiTwd2lQmgEAu9opvQ
	(envelope-from <linux-security-module+bounces-14226-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Jan 2026 23:52:20 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 977E28E0DC
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Jan 2026 23:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D91C301585F
	for <lists+linux-security-module@lfdr.de>; Mon, 26 Jan 2026 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1690B274658;
	Mon, 26 Jan 2026 22:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MzTc5uC2"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86B723D2A1
	for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769467937; cv=pass; b=YsW/kMyXuDST+xDbgv56tkQhMZX82BjV2wdpRv01lMaWmDsg5rmS2VgZn/mmMw6632vi5ZNfyDyUP8AK4sEk89QdN6GdEd+9M+0a1WPnXHwpDSDiPzaHMREtr//WxrcMZEP2tgj3gVSJGkzBUrPyk7f3hOlMv0ztbWAtcTKbEjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769467937; c=relaxed/simple;
	bh=KLLQdANoINV1odBBaAJlZcMzDaqXaeKbQ8WV4WhXJ/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxDktd0FGSfhPWkzg8yi+q8KdfbmG+JD0+W4XMYJnNSGrIoblBIiRzZYruGrhyzqbOFoEk29HMuYWTpt8pPCT1d9bHYtGdrwcGtNAdvAdnn9/zUZasuZ6J4GhSB1pm7TFqgAbWKOuly3M9ow9ZKctDu4ztiV1Y+XoabYazUWJno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MzTc5uC2; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7d98c1879so27167295ad.3
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 14:52:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769467935; cv=none;
        d=google.com; s=arc-20240605;
        b=N+iv+na/SmgK2aDxyrFi8bql3FJrxQwWqe6Qn1TK5E2oOK2f+ueKxZmurjQ3HKg+vb
         Piv/ByUm61Ibz1XccV3ElF0U5w2Fj2CKkzSHIrjbLCGePnWewd6jhi3+5LDLNexXsC2Q
         hMrcXJsztZPQF8de+UsgWcFAmgZTYWFrwl3aZwTeH8bIPOF0L7SBl93gLim20F25jpYv
         d3QmHQr3qfCRihIfhamIyDu08/VeAUPJhI41IkqWwL1tdVoG4YhkJyHd7vwDvg18tno6
         Pe/NRCnm/6xESHiLpwAH+M0kA9TYS4Arua+G5E5J/NOZMqgz5iNksUj6dU36xAfUeQR9
         Tkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4gCQ0xkA7by7eZFmx/8B6OueuRxMv1D7GSRo725dNz0=;
        fh=L9uebrW6iqIFPwJKFwRBEgV8Cs2BvjrJxhv0BaFxlXI=;
        b=XC5Q7W2jHnIlYyHTyGZVWdsf+5u3g/zeui8Iw/+g5XMb00k4TfzkbY+RgzI5F++ZPt
         Wl3EPy8SLR3JcZTyrGrs5rxgv8wTH6n4RYBAcosNHB+72g/92ULqHVvtKw5zxFvl/br4
         iRq9fzRkzzysuq0vQ0RaqHiGRJj13vqsul9e8ToNn/P4RqWJIwXDTECUzW4KDxObTEcd
         kO+LkmfHsEair+wjfGS1Q+7UyqKLWA+C6435cFEg7cJGc6Det4pkE+OCbTsZfE3p39oZ
         8wPAV9EWpdeOgMfcorbDSatUmVK49ayfUrO72GeOiIel23QKk791SznfXDLTe7Etdfgh
         /iIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769467935; x=1770072735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gCQ0xkA7by7eZFmx/8B6OueuRxMv1D7GSRo725dNz0=;
        b=MzTc5uC2IdT/SNfysEhiNyxYz8WsIBFeddI+uCBPLdDSdnj9MokR76vPpGD86S05Dd
         2xmc5smr9WxxRvD5+fbIZJ+PKJGChM6fY7KKi83alCM+BdSVlRh2mrdMGU5Chkt3aSzB
         nmK2kCxp5fsJBhonNCWEbZ4IqRlQphh2zI/A2BaxriUJAAhq6aTPAhcRkPkKwOJFKB9q
         FrXhdG91fe1unFPSwQhIQ6lo01JhrYTtwmmbu+11DJy3k97IF5Qwp4o+zZ707gmDGsiX
         V+nftD/5MVV2rC2fg+7jJuee5zsKLN0VdT/qZVqKleMQtr8y8MFjdKZKLBBfmCIOjDRy
         IZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769467935; x=1770072735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4gCQ0xkA7by7eZFmx/8B6OueuRxMv1D7GSRo725dNz0=;
        b=nJXy2sqihMsSeMD7GKzLF1c076tNletaJhGGqT8zGS2TMoARlRS8WT8ltmMIHd/mH0
         C+Y1ZTsnoOaUVU5fwvl1DIbr0iKK+oeQO6qzUyqPVgS6Ay37EMWXCO349EPdSPDk737T
         9iJoaJP2h1NjPdoB9IZ09G7SVOzhNMQT+rWGuT14u28k/m1WgpmW80iuIVlgoWoBNU3q
         8BCz2Xarom2fabi3+GqVlbSDNyPU27iy4ep+ErCobo+tBu3JeQo7kw7ZdJLRjy9LzCV6
         +wtPZF3s56ZxA14IAUxkdZEtu8iUq64XPTmgNlTkgTs4NRm0x4Dj4cnfjZ2xJJOMqBTP
         0e2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXL5AokiWMKe0oOYhgIw2d1W7N2bu0YZ5xW2JBnOgyWCCxb63XEmxbH+aSsA23XGohxXPXn1VJxSyh7lxLtOsGKoJkUl9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnAmRpDRfj8UyMRAms1qF526MNjoxKB+laUDGuNYum9quxnVM
	8PAi8VQrZ4qLG8uWANpSmGj5Xc3H3nlLulWjIpq4ze4QGjthoNoiv+KIxnhDD19uYohA0DhX6Hd
	zmYVobyrgt9pR1E+7uA+uD3b1qHzZT0XtU83FOiAE
X-Gm-Gg: AZuq6aIOZ/BYcEYBe/Ca6GTf3lg8pTRF8PuLXHHFMy+tZYEowN0JXebo/KqzTPZ0/tL
	Kq0sOlskes6RIEuZDLYXK+f7Kw0r2lL5W4od/9mqbkyEZ/kpxB/7pq9tjGGdgGFq/9+/vrBQpUY
	Ql9YSpkVErabRn7/9GINV4NdS4OBNgWEdO0yH3LJMzoaL5bKBlJSActbLQn/4iAvgTXKJcPMkvK
	Xo9bxExv4pU/A7cs//blEVR1Djchc7ut0NgzlY6ktZ/MEUaVN9LyM95OOaitkoNn4aHgAc=
X-Received: by 2002:a17:903:3583:b0:2a7:9da7:d21d with SMTP id
 d9443c01a7336-2a8453287d9mr54528365ad.56.1769467935279; Mon, 26 Jan 2026
 14:52:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122140745.239428-1-omosnace@redhat.com>
In-Reply-To: <20260122140745.239428-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Jan 2026 17:52:03 -0500
X-Gm-Features: AZwV_QhZWJJjIz5nrzYMHWCchd4vw4_Kq_gvEnZtehjGVzYkeu1Rp5h6APCx8-A
Message-ID: <CAHC9VhSgbHx4NcMVjMMk0D332b0DTEQi6dD_wO1fvQne-JVisw@mail.gmail.com>
Subject: Re: [PATCH] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14226-lists,linux-security-module=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-security-module@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-security-module];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paul-moore.com:email,paul-moore.com:url,paul-moore.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 977E28E0DC
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 9:25=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The user.* sysctls implement the ctl_table_root::permissions hook and
> they override the file access mode based on the CAP_SYS_RESOURCE
> capability (at most rwx if capable, at most r-- if not). The capability
> is being checked unconditionally, so if an LSM denies the capability, an
> audit record may be logged even when access is in fact granted.
>
> Given the logic in the set_permissions() function in kernel/ucount.c and
> the unfortunate way the permission checking is implemented, it doesn't
> seem viable to avoid false positive denials by deferring the capability
> check. Thus, do the same as in net_ctl_permissions() (net/sysctl_net.c)
> - switch from ns_capable() to ns_capable_noaudit(), so that the check
> never logs an audit record.
>
> Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  kernel/ucount.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

