Return-Path: <linux-security-module+bounces-12021-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1C1B86A1A
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 21:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1053BC210
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A80527FB3E;
	Thu, 18 Sep 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHPTIXfd"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483201B424F;
	Thu, 18 Sep 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222744; cv=none; b=iKusaAiyycK6zoNGmYaxaYWgEbPOgJwtvmAHiSaZoAe/UM2FK+ELxOd87MG90ZPS+uUQoqiddMzhndvJ5DmqY7pNVmHZ/LD55uyacI8tGbXR8K+nNBOmLMJeTIUSLD3iHG/k63sQOaFu7DM3YTTc8ti+iYHv20rv+XiUiHthczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222744; c=relaxed/simple;
	bh=cfSxFeOZ7TUFMJX4uEqs6rixJVEq5s1tymOGTLEzzE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtC4EeGBN52qjENYNgz8cGcnPNsPG9Af1/BfE1jrrxY5YgNxfFY6ju0eYokl2REcxje8WLqINglll0PNhaFm3hBQd1rpq4rav2ouiIvDOk1qrvHV84IpBW/OXFAcSr9gtEouQcf0+hMM9WAkoYx2PbmmSb9QuLJlZCudN5/vzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHPTIXfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4A4C4CEE7;
	Thu, 18 Sep 2025 19:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758222744;
	bh=cfSxFeOZ7TUFMJX4uEqs6rixJVEq5s1tymOGTLEzzE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHPTIXfd8SrUeBjMtSG9qsiEmebTANKxU48LEHt2BoSSUPqGs91zW2zaA7nizId6R
	 +iGpuCcVczCz0pOpPZsxnWm7quE4f13s+ffm+tihd4eS93Aau1kE4kNkMXNBianAUI
	 eEPV1bROPP1BchGCGPKeRXs+4RhWIA+k61iQtE8hzD5KDmUrIkKUbBd6J0lYsxgI2m
	 gADT6n1D9eWxKb1CTibwKxGTfTzeHpGCV9rdogc/5fUqG+sDVnHTer+VUpvUpcSKgp
	 Zrl2hANonriKrxGNNZaOZKOuxPu3lirnZoMwZU82RWq8hagG+e0CQMVGeze2lbFOy8
	 NJvP2HBAyUHdg==
Date: Thu, 18 Sep 2025 22:12:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.or,
	Chris Fenner <cfenn@google.com>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Disable TPM2_TCG_HMAC by default
Message-ID: <aMxZlHn9bfa5LGEU@kernel.org>
References: <20250825203223.629515-1-jarkko@kernel.org>
 <aMxV9fB0E72QQY2G@earth.li>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMxV9fB0E72QQY2G@earth.li>

On Thu, Sep 18, 2025 at 07:56:53PM +0100, Jonathan McDowell wrote:
> On Mon, Aug 25, 2025 at 11:32:23PM +0300, Jarkko Sakkinen wrote:
> > After reading all the feedback, right now disabling the TPM2_TCG_HMAC
> > is the right call.
> > 
> > Other views discussed:
> > 
> > A. Having a kernel command-line parameter or refining the feature
> >   otherwise. This goes to the area of improvements.  E.g., one
> >   example is my own idea where the null key specific code would be
> >   replaced with a persistent handle parameter (which can be
> >   *unambigously* defined as part of attestation process when
> >   done correctly).
> > 
> > B. Removing the code. I don't buy this because that is same as saying
> >   that HMAC encryption cannot work at all (if really nitpicking) in
> >   any form. Also I disagree on the view that the feature could not
> >   be refined to something more reasoable.
> > 
> > Also, both A and B are worst options in terms of backporting.
> > 
> > Thus, this is the best possible choice.
> 
> I think this is reasonable; it's adding runtime overhead and not adding
> enough benefit to be the default upstream.

Yes, I think this is a balanced change. I agree what you say and at the
same time this gives more space to refine it something usable. Right now
it is much harder to tackle those issue, as it is part of the default
config. By looking at things from this angle, the change is also
benefical for the feature itself (in the long run).

> Reviewed-By: Jonathan McDowell <noodles@earth.li>

Thank you! I appreciate this and will append this to the commit.

BR, Jarkko

