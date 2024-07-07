Return-Path: <linux-security-module+bounces-4115-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31199929765
	for <lists+linux-security-module@lfdr.de>; Sun,  7 Jul 2024 12:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9CA1F213BD
	for <lists+linux-security-module@lfdr.de>; Sun,  7 Jul 2024 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298FC17C64;
	Sun,  7 Jul 2024 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdOQbuts"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72912B95;
	Sun,  7 Jul 2024 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720347298; cv=none; b=nfjFZSCKrt0FSOf5u4b51K4CaBTlqpXnbeQtDksKX0XjCRmGq43X4iCJBgjyvsURyWTjuKtvvSvMmEk0+ng4tNpoDrVCznsEMMaQV4d5WRVuDILs/GroKbaxkro5cGhDYfeGHraix2aUc6Jlw0DUdQYHoOZa4BRR1R0WnBHpVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720347298; c=relaxed/simple;
	bh=wOI/PV2B2NCFRujee1gfOuB52t1+xSVFJndNRK6TyJw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sTNDE87Qsh0oyb05Tq2q0IRIFimEgtNACUG2xtA/oJXaKEfOY9lfUGcw6OMzddlG2CCJuMG7roMFxPTozp12N1AcmObf7PkjIXSEJLbhwYZBYYlhnUjW8aluNNoHBYRSTgCAkhX7lZkUei4Zmlzd6MGY5I1ub3OkdRYuCSLzdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdOQbuts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B07C3277B;
	Sun,  7 Jul 2024 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720347297;
	bh=wOI/PV2B2NCFRujee1gfOuB52t1+xSVFJndNRK6TyJw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CdOQbutsU7XjAQzNHH1C81tJcATaFspOHZLYVEHk/xMb63jPAXhrLQ6atHmZNZ9zs
	 R8JJS6kjs8UQfUo8gDkjqDqOFqYOXHAg79hCWXio1Z5+r5328ZYbnv2WmuWL411rdn
	 KyeU8OD14A/YbSWaGaEHRv8NY4bv1S4+DhUUzxKJH94wac2otGhaa/pe0ll/JUlRSZ
	 5xpngbfUZuUj+KUgaT2HcZj/EdCXhwiyeoNqGqC8tEw60R6YjK++yJO5sZKTBPgLsm
	 hSdfJjCY/Ft74vXVptWQNYWroVBwXltl/sCZ7sgSLMvmF8yJaYz1Ssw8Tu7IeC1q/D
	 4TgiR4PNo8w9g==
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jul 2024 13:14:53 +0300
Message-Id: <D2J87W3IAN9S.2IDDGG803SS58@kernel.org>
Cc: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, <keyrings@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: validate object type in tpm2_handle_mso()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240707010916.78918-1-jarkko@kernel.org>
In-Reply-To: <20240707010916.78918-1-jarkko@kernel.org>

On Sun Jul 7, 2024 at 4:09 AM EEST, Jarkko Sakkinen wrote:
> tpm2_handle_mso() lacks validation for the object type. Validate that
> value is one of the allowed values in order to detect errors.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

Just something I spotted while fixing the other bug.

If an API that claims to return enum, the results would
better *only* be values from that enum.

Also this API is using alien acronym "MSO" for the enum
fields while the spec uses "HT".

BR, Jarkko


