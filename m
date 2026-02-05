Return-Path: <linux-security-module+bounces-14459-lists+linux-security-module=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-security-module@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI9LLzpnhGlK2wMAu9opvQ
	(envelope-from <linux-security-module+bounces-14459-lists+linux-security-module=lfdr.de@vger.kernel.org>)
	for <lists+linux-security-module@lfdr.de>; Thu, 05 Feb 2026 10:47:38 +0100
X-Original-To: lists+linux-security-module@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A58F104B
	for <lists+linux-security-module@lfdr.de>; Thu, 05 Feb 2026 10:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F1473002B73
	for <lists+linux-security-module@lfdr.de>; Thu,  5 Feb 2026 09:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7863A1E69;
	Thu,  5 Feb 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7wZYF6o"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E739E6CA
	for <linux-security-module@vger.kernel.org>; Thu,  5 Feb 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284753; cv=pass; b=WrM2N5nzcNfmj1TU425fD3Qzx+KWMkTOjoZfJ+cYpQMGw8mSQbzJ4/E/4+W2fvGThkG/Y/NJD/oMpsgrBgRPh/cthmmtWx++S0C/ldfuTp6XaPJeNw4+U+QEsB0ILgiwwmPwjVqsLeL0fr5GoKRFMPr6WUnMZcOGrW3Z8fB9Onk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284753; c=relaxed/simple;
	bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFsENoh4XI4q5jBQB3HDvxKMotvDVBnRiGnS1zUobp1DuSCw0VvclCKrtNQfvKhPqum2EBHzL61M40Tcz3spUbMPAlgLnmQmrB3RFlrWyRW+vggM7oiuz2w9BRARRDxaotMcHAizqeb0Ib1D5O8YcpWJOSJx0yCHIzT/bdkidu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7wZYF6o; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65807298140so1132787a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 05 Feb 2026 01:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284751; cv=none;
        d=google.com; s=arc-20240605;
        b=F+krnOvs+sbprhlu1k1+Bn0qrRCwOUaM9GO4x7zyEb9saRA9PFW2KauFDnMqLPCIa4
         7yOfhBRChOq9BQld0exmqU9s+ZHMB9Y88lxmwZ7noXkGPVdmQkGGfDXUVfw8cHuuT3F5
         wmSYZi3EaH6jEmooA4kqhfa1ThlImPVcXlD7pK86Dq+K1DqTfwhOxjDyBFrEN17VTBAk
         D7w8qvMDS3KdcEePrllOrBu9Ec2dNbMUPMUngUXy0peerhEFSjQVk4XVOsDoaUgHPwRN
         J2JD0FW9+mxpGDt37PI9WcEtof/uhriYiR0yH5vFDlER247aq4Dh2r9d+tSAGa1FZlhS
         TMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        fh=wfYQEe//H/ZOyNjeJ/KhfnYyChv2t98lDe6s8b/VmoE=;
        b=IFlEApVaTAYSqwRWrx2jo6xVizMlBOj3ayhRPda9U6/FTIgIxUhWiwwU8VrHAbSbVw
         ydUfSX6jyxCmeKy/Rt5gfyrKCUD1cqNLbpuI5/ULpuSIGAHZj8LhxhaJ/tSjxyOHdWF3
         LJI7lAEkER0N8vxp04JRFC3Yt58hjp6HUe8yG4L3FW4sDXvDVjlHDdn77nM9oZbBF5be
         4/O8Dh91iSoIxeNpgL4rlHXVh7i+iDSf7+BvsHW+bTL13YsOUo8w1PppEXBsFXurEJ8k
         FpR2S2tVQa6xdSsllyEMvXa1R6WjS8qxUWUUdxK8ylrgQeV+SOWBmeEHGoADj5Kh9O3j
         LfQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284751; x=1770889551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=X7wZYF6oGkxVE+gLTBtcX28o4eYBAX3e3P5/p1DkotCtFvnSm+dNdGmggiKQnap9HF
         uJoR8Y/7jQwtGKgtwXZNQtMOcaDouskzI9DbFRdinBwM2G8kpSDc+wVOPd9ayKvPaZtX
         qDZsWavmVfL8txVAZaxKDRyNO2gl3nDKYj6Y08WRzZFoXlLH4OBDdd4dCHPmAv9LaYhV
         aYyqyMoVjKFMXFsylm9qYTAL0LLdTNasCpSpfzLfkc3XzkPNORx9OBQJnvhWeWVvJgyV
         IFPElSh1GAM0WngNDgAYeJbIEwtbP3kxmdE1hnqP1mOoFVug/wkO0WrOFsaHCyIytL65
         aJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284751; x=1770889551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=iU5bmCpyAFFm/oqIkNVEp7Ku/moVR9VY9nn/oXcvekvX+tQVKja9rNxpUT/6qsKMmA
         qq218B+S/kbbdNR6O+ynMpKF+vH7zTWkCPS9M4ZqneAy3cwssTDSXFH54AemcOmDLVOp
         8MKFfFv4mpipTzl1DCV3niQp+IRjOiURTJgaz5eY7jDWBmEdIpoiPoThbm3RKEJiqRaU
         ZZkeYaTrWBrZgQenPLWxn9UJYzqyePGLA+ORXdijFHUA2IsCkM8qm8osUV6M5mfYQie/
         p7wFgOco8f97ptKmOQSo0wchxzufQfeUriIxfPQroXnxapH00ObqihcwiiUsNjEUDi0q
         Ro+g==
X-Forwarded-Encrypted: i=1; AJvYcCV6xQz0w+0FiWd8JnNn96qBPIynMNWrwltMvvcVeSmIV+p04ZHMsEj2pBrLjYaFPaXkmhVBZVtKnhbX94PbVO6k8iVIBKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWBVGA9qKWi6MyOyECpbQpx2dtT2huv73wAGsci0hdzk3LXQo
	n+VnknZL/8MWiQLscsMieoZETwwsrhikrCch8GAvJiuegsITkOosyUOPsZqoV+3GW1wKLwxhy/P
	D6imxpzQDdGxUAEfhJ5uDCQz0Z1KL/Qg=
X-Gm-Gg: AZuq6aIsPwKiKsS/GGUJhufLzs+FK7NxY36r55EHL9ZkgoYrPM/7F6ig2MX277rekkC
	ZNI4wngs72pP7PXz3HUhIqp8Y3LOIIX/hqZdQAFIQYClLwl/YZErOs/TbQJqbnA/diD44StD7aI
	F/LYNyoUzWfEIgxETUxUyl9KHwWXAmqbHo+ageP3xfNebtZOvKnMjWE/meZKvmRoXp8MC0ppBye
	qYwnxEnA95MXjQnesFUYNfdwI3lzQX0SU078qeQiuCxeX+86hLBtrdtKOXgnXf0UW52qnDSctz1
	CIyXWMUanhmnL6UhmYXg7H0wXen0Ew==
X-Received: by 2002:a17:907:7f92:b0:b87:31d1:4131 with SMTP id
 a640c23a62f3a-b8e9f64603cmr435430866b.60.1770284751163; Thu, 05 Feb 2026
 01:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-13-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-13-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:45:38 +0100
X-Gm-Features: AZwV_Qg7CM-kXxjB2Qin-euJkaOUd7ni190R_n_ZLhun34eHr5T-i9uF6CbqXdo
Message-ID: <CAOQ4uxi3bNYq1b4=qL-JLi19hRwurntfLZXhUMVL003NarBdGg@mail.gmail.com>
Subject: Re: [PATCH 12/13] ovl: remove ovl_lock_rename_workdir()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14459-lists,linux-security-module=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,canonical.com,paul-moore.com,namei.org,hallyn.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-security-module@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-security-module];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,mail.gmail.com:mid,ownmail.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1A58F104B
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> This function is unused.
>

I am confused.
What was this "fix" fixing an unused function:

e9c70084a64e5 ovl: fail ovl_lock_rename_workdir() if either target is unhas=
hed

What am I missing?

Otherwise, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

