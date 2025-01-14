Return-Path: <linux-security-module+bounces-7676-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF9EA0FE19
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Jan 2025 02:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5443A6F28
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Jan 2025 01:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3F224024E;
	Tue, 14 Jan 2025 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="az58ijE3"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EBA2253FC
	for <linux-security-module@vger.kernel.org>; Tue, 14 Jan 2025 01:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736818194; cv=none; b=afbZqq8MZPNjOdtBw0TJ19ZZV3g2jRNqewhT5VIMSH6UnMGNAlpdc7or8NEAD6LHW8sfWsFQw1cednPrYeLTpzENyiUav2qnAkqmCi4yQ/U9gDLx6Pbhjp0JsEVacysY/PkraBnpmS38OKdjzZ64toU/k7jeDDPvmnV/pSp1TPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736818194; c=relaxed/simple;
	bh=Q0WsIi/bfEBm2Z/c1W36FezBQ+ejAr7gVm8AqjD5OM8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=o8XVNL+nDMvrz9uSmSRpRcrGuB7kQEF3Fu74J5dH6BflS87FV138cnwCuKX1VAql1UDJR4BAXL1RZN48DdUp9IHaKd0wWjS8qRTH/49CWmLY4Nd82/s13D/YObYMH/zYOA4hgQsFVOWk49EF3wYTEiR/xOu6EcE48gw9v6cwABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=az58ijE3; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4679eacf2c5so47201551cf.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Jan 2025 17:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736818190; x=1737422990; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNFOEExrrB++rGqrJnsPNDzPQGt2G4n16y7BRIyXp/U=;
        b=az58ijE3cLXtkWao8uA9q7GBQF9k/bRw86Fq9uBq286ciB+yTPghAPbpBrf2nfE47l
         zvirH92UzkcwpYrpOTcN5lYQALC22NpcNwgQQuh9xwQztkUxfrD5xuUwXuVBK2Dgu7RO
         LwD9RsejW/ZuqBJ5ZggH7GpS/AhHcjabOsIWMTApFU6rw9WsoZcNwH+GAUMVaCL3yufk
         iQ/AId3pKrsSEcsaCZAM8bcLfpjCNS/ChJI8BAWRxxZ9rQN0ruo3prHVmoCggCxEbs5O
         UvtsDA9HqshwSB41TveAVCec7H/PqqRXE39rgsF6O9MoTYZWLaU7BYPewi1O33qwoLJp
         ovBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736818190; x=1737422990;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bNFOEExrrB++rGqrJnsPNDzPQGt2G4n16y7BRIyXp/U=;
        b=Mba7Cn7SvEKqqJo2Vob39yGaWuHCUfZJElu+MgShzuO7KHyZxAYMSOZnY3oX7FHy8h
         Llacze5fNxgqXtW2gcRaOObCmxAIeA27g569SB1YxxCxCuzMh95SpuqbcuUN2lNskYPI
         wIqgpWFUbvqLIo7XKQ4SKmx9QXbnehS8k/GtA4w93r1j7uwFe/ou5IzCI04WP/VRfPGv
         9SBeDcjFnXrQvzrneFjQ/y8w+iv9C/qu32wof0TM5MVSd9CnCpNB9fOEOOMHiVQ4bq76
         ffLsmzg6++ZNdZKgTJhP+V8KWP6fDB34yzeU+KqJaH/T+1E2e8xV15yLVJ2f4haYLkuq
         zTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUklDwfR2EzVfO6y8VkUACq+055a02uInK+R7hXav08M40FMdZs6vYzhU54GC96sqHu7RGPEJvoBY7/z9IR2N5F9mT5I+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHbrffEhtueBZ++gPgb/RLgqzSruR9tq+IlI6qjQ6NO/qjL3w
	wsHmspq6g+FJCQbVAAcB6jAHSWQjA6fZvq7v8mYurUHVOYjpe5tUSIMN0pqe7Q==
X-Gm-Gg: ASbGncu1zVZoHK58jzJaco7zmkOWZBYYWyqhm1bhpnmwxg6yr8WmrY+03B5Ifu73o0u
	HfSVlExybxAbyzvJd/60Npr68JaLZ3w6VZR3KueFF/RnRwjDSDMUr+53aNdJih2MJG3j0o/zn4H
	X1lVrN6ZkyXcF/QhhocpJLOTCUDiPJSgbdzFqQBsmFzAImqO5JZiZnrNSJp3FQjhBLQdCrMBssg
	NbEigbS4e0oqheuw3aehDLHuJzDf6/7nw/KGLJY586hVRfxcXc=
X-Google-Smtp-Source: AGHT+IEaspBTWJOhjDyVx0RjGxpcGSFV0u71RMtFQyg8mI+1OgYKn1C3xOstICAKVVEss2u31POEHw==
X-Received: by 2002:a05:622a:2cc:b0:46c:79a4:5574 with SMTP id d75a77b69052e-46c79a45701mr320769271cf.4.1736818188873;
        Mon, 13 Jan 2025 17:29:48 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfad85fe81sm47674516d6.6.2025.01.13.17.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 17:29:48 -0800 (PST)
Date: Mon, 13 Jan 2025 20:29:47 -0500
Message-ID: <8642afa96650e02f50709aa3361b62c4@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250113_1550/pstg-lib:20250113_1550/pstg-pwork:20250113_1550
From: Paul Moore <paul@paul-moore.com>
To: Greg Wettstein <greg@enjellic.com>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: Re: [PATCH v4 2/14] Add TSEM specific documentation.
References: <20240826103728.3378-3-greg@enjellic.com>
In-Reply-To: <20240826103728.3378-3-greg@enjellic.com>

On Aug 26, 2024 Greg Wettstein <greg@enjellic.com> wrote:
> 
> An entry was added to the ABI testing documentation to document the API
> definitions for the TSEM ontrol plane.
> 
> The file documenting the kernel command-line parameters was
> updated to document the TSEM specific parameters that are
> implemented.
> 
> The primary TSEM documentation file was added to the LSM
> administration guide and the file was linked to the index of LSM
> documentation.
> 
> ---
>  Documentation/ABI/testing/tsem                | 2420 +++++++++++++++++
>  Documentation/admin-guide/LSM/index.rst       |    1 +
>  Documentation/admin-guide/LSM/tsem.rst        | 1680 ++++++++++++
>  .../admin-guide/kernel-parameters.txt         |   29 +
>  4 files changed, 4130 insertions(+)
>  create mode 100644 Documentation/ABI/testing/tsem
>  create mode 100644 Documentation/admin-guide/LSM/tsem.rst
> 
> diff --git a/Documentation/ABI/testing/tsem b/Documentation/ABI/testing/tsem
> new file mode 100644
> index 000000000000..0e0e3201edf4
> --- /dev/null
> +++ b/Documentation/ABI/testing/tsem
> @@ -0,0 +1,2420 @@
> +This file contains descriptions of output generated by the TSEM
> +control plane files and the role of the only write-only file in the
> +control plane.
> +
> +It is highly recommended that the following document be read in order
> +to fully understand the rationale and functioning of these files:
> +
> +Documentation/admin-guide/LSM/tsem.rst

Will do ...

> diff --git a/Documentation/admin-guide/LSM/tsem.rst b/Documentation/admin-guide/LSM/tsem.rst
> new file mode 100644
> index 000000000000..1c69a5cb7517
> --- /dev/null
> +++ b/Documentation/admin-guide/LSM/tsem.rst
> @@ -0,0 +1,1680 @@
> +====
> +TSEM
> +====
> +
> +	"This is the story of the wine of Brule, and it shows what
> +	 men love is never money itself but their own way, and
> +	 that human beings love sympathy and pageant above all
> +	 things."
> +				- Hilaire Belloc
> +				  The Path to Rome
> +
> +TSEM is the Trusted Security Event Modeling system.  TSEM is the
> +kernel LSM based infrastructure that provides a platform for
> +implementing model based mandatory access controls.  TSEM is model
> +agnostic and is designed to support deterministic, quasi-deterministic
> +and machine learning models.

...

> +Security Event Modeling
> +=======================
> +
> +	"We can no longer speak of the behavior of the particle
> +	 independently of the process of observation. As a final
> +	 consequence, the natural laws formulated mathematically in
> +	 quantum theory no longer deal with the elementary particles
> +	 themselves but with our knowledge of them. Nor is it any
> +	 longer possible to ask whether or not these particles exist in
> +	 space and time objectively ... When we speak of the picture of
> +	 nature in the exact science of our age, we do not mean a
> +	 picture of nature so much as a picture of our relationships
> +	 with nature.  ...Science no longer confronts nature as an
> +	 objective observer, but sees itself as an actor in this
> +	 interplay between man and nature. The scientific method of
> +	 analysing, explaining and classifying has become conscious of
> +	 its limitations, which arise out of the fact that by its
> +	 intervention science alters and refashions the object of
> +	 investigation. In other words, method and object can no longer
> +	 be separated."
> +				- Werner Karl Heisenberg
> +
> +Security Event Modeling (SEM), is an alternative strategy to implement
> +the security guarantees of mandatory access and integrity controls, in
> +a manner that is consistent with emerging application development
> +strategies such as namespaces and CI/CD workflows.
> +
> +As was noted at the start of this document, the premise for SEM is
> +that the security behavior of a platform, or alternatively a workload,
> +can be modeled like any other physical phenomenon in science and
> +engineering.
> +
> +Inspiration for this came from the primary TSEM author/architect
> +having trained as a quantum chemist, conducting very early research in
> +the development of multi-scale modeling strategies for molecules of
> +size to be of interest to pharmaceutical intents.
> +
> +SEM is premised on the theory that kernel security architects have
> +instrumented the LSM security event hooks to be called in locations
> +before security sensitive operations are conducted, with appropriate
> +descriptive parameters, that are considered relevant to the security
> +posture of the kernel.  With respect to modeling, the security event
> +hooks are conceptualized as representing the independent variables of
> +a basis set that yields a functional definition for the security state
> +of an execution trajectory.
> +
> +SEM can be framed in the context of classic subject/object mandatory
> +access controls, by the notion that a unique identity can be generated
> +for each element of an access vector matrix, rather than a boolean
> +value.  In SEM, a security execution trajectory is defined by the set
> +of security state coefficients that a process hierarchy (workload)
> +generates.  This execution trajectory produces a vector of identities,
> +whose sum in an appropriate form, yields a functional definition of
> +the security state of the system.
> +
> +Two subordinate identities are combined to yield a security event
> +state coefficient.  These subordinate identities are referred to as
> +the Context Of Execution (COE) and the CELL, which are conceptually

Please define the CELL acronym here as I believe it is the first use of
"CELL" in this document.

> +similar to the subject and object in mandatory access control.  The
> +COE identity is derived from the parameters that describe the security
> +relevant characteristics (ie. credentials) of a process, while the
> +CELL value is derived from the parameters used by a security event
> +hook to describe the characteristics of the event.
> +
> +A security policy is implemented by a modeling algorithm that
> +translates COE and CELL event parameters into their respective
> +identities.  The COE and CELL are combined to yield a security state
> +coefficient that uniquely describes the security event in the security
> +model.  Different security policies and criteria can be developed by
> +modifying how the modeling algorithm utilizes the COE and CELL
> +characteristics.
> +
> +Since the security policy is implemented with a modeling algorithm, a
> +single platform can support multiple and arbitrary security policies.
> +The equivalent of a resource namespace in SEM is referred to as a
> +security modeling namespace.
> +
> +The formation of the security state coefficients from existing kernel
> +parameters eliminates the need for the use of extended attributes to
> +hold security label definitions.  In SEM, a cryptographically signed
> +security model definition, designed to be interpreted by a modeling
> +algorithm, becomes the bearer's token for the security of the modeled
> +workload, rather than information encoded in filesystem security
> +attributes.

...

> +Process and Platform Trust Status
> +=================================
> +
> +A fundamental concept in TSEM is the notion of providing a precise
> +definition for what it means for a platform or workload to be trusted.
> +A trusted platform or workload is one where there has not been an
> +attempt by a process to execute a security relevant event that does
> +not map into a known security state coefficient.
> +
> +The process trust status is a characteristic of the process that is
> +passed to any subordinate processes that are descendants of that
> +process.  Once a process is tagged as untrusted, that characteristic
> +cannot be removed from the process.  In a 'fruit from the poisoned
> +vine' paradigm, all subordinate processes created by an untrusted
> +process are untrusted as well.
> +
> +On entry into each TSEM security event handler, the trust status of a
> +process is checked before an attempt to model the event is made.  An
> +attempt to execute a security event by an untrusted process will cause
> +the event, and its characteristics, to be logged.  The return status
> +of the hook will be determined by the enforcement state of the model.
> +A permission denial is only returned if the TMA is running in
> +enforcing mode.
> +
> +If the platform running the TSEM LSM has a TPM, the hardware aggregate
> +value is computed at the time that TSEM is initialized.  This hardware
> +aggregate value is the linear extension sum over Platform
> +Configuration Registers (PCR's) 0 through 7.  This is the same
> +aggregate value that is computed by the Integrity Measurement
> +Architecture (IMA) and is the industry standard method of providing an
> +evaluation measurement of the hardware platform state.
> +
> +Internally modeled namespaces have the hardware aggregate measurement
> +included as the first event in the security model.  Externally modeled
> +namespaces export the hardware aggregate value to the TMA for
> +inclusion as the first event of the model maintained by the external
> +TMA.
> +
> +The root security model extends each security state coefficient into a
> +PCR.  The default PCR is 11 but is configurable through the kernel
> +compilation configuration process.

Presented here simply as a FYI:

https://uapi-group.org/specifications/specs/linux_tpm_pcr_registry

I'm not going to recommend any one particular PCR, but I thought the
"registry" info above might be useful when trying to avoid PCR
collisions.

> +The use of a separate PCR from IMA
> +allows hardware based TSEM measurements to coexist with IMA
> +measurement values.  This hardware measurement value is designed to
> +allow attestation to the hardware state that the root model is running
> +in.
> +
> +TSEM is designed to support a philosophy where the root security
> +modeling namespace will be a minimum Trusted Computing Base
> +implementation that will only be running trust orchestrators and any
> +other infrastructure needed to support running workloads in
> +subordinate security namespaces.
> +
> +The subordinate security modeling namespaces are designed to decrease
> +model complexity in order to support a single functional value
> +describing the 'known good' security state of a subordinate security
> +workload.  Subordinate security modeling namespaces are
> +non-hierarchical, ie. a security modeling namespace cannot itself
> +parent an additional security modeling namespace.
> +
> +The Linux TSEM Implementation
> +=============================
> +
> +	"Sometimes the questions are complicated and the answers are
> +	 simple."
> +				- Dr. Seuss
> +
> +The Linux TSEM implementation is deliberately simplistic and consists
> +of the following two generic components:
> +
> +- Security modeling namespace and security event export functionality.
> +
> +- Internal trusted modeling agent implementation.
> +
> +The security modeling namespace and export functionality is designed
> +to be generic infrastructure that allows security namespaces to be
> +created that are either internally or externally modeled.  The TSEM
> +implementation does not pose any constraints on what type of modeling
> +can or should be implemented in these namespaces.
> +
> +On the theory that security event handlers represent all of the
> +security relevant action points in the kernel, any security or
> +integrity model can be implemented using the TSEM infrastructure.  For
> +example, basic IMA functionality could be implemented by a TMA that
> +maps the digests of files accessed, or mapped executable, by the root
> +user as the security state coefficients.

In order to keep the peace among different LSMs, we try very hard to
avoid language along the lines of "LSM A could be implemented by LSM B".
Please refrain from such language, especially in documentation that
lives within the kernel.

> +A primary intent of the Linux TSEM implementation is to provide a
> +generic method for implementing security policy in userspace rather
> +than the kernel.  This is consistent with what has been the historic
> +understanding in Linux architecture, that policy decisions should be
> +delegated, when possible, to userspace rather than to kernel based
> +implementations.

[NOTE: Feel free to ignore the paragraph below, you addressed the issue
 of non-blocking access control hooks in externally modeled namespaces
 later in this document.]

If I recall correctly, previous reviews that looked briefly at the TSEM
implementation brought up an issue where several LSM/TSEM decision
points in the kernel were non-blocking, which presents a problem for
TSEM, or any LSM that wishes to call out to userspace for an access
control decision.  At the time of the review, I believe the TSEM answer
was, in broad terms, "TODO".  Has this been resolved yet through some
change to TSEM, or am I simply remembering things incorrectly and TSEM
has always handled this case properly?

> +The model is extremely simplistic; a TMA interprets a security event
> +and its characteristics and advises whether or not the kernel should
> +designate the process as trusted or untrusted after event processing
> +is complete.
> +
> +The following sections discuss various aspects of the infrastructure
> +used to implement this architecture.
> +
> +Internal vs external modeling
> +-----------------------------
> +
> +When a TSEM security modeling namespace is created, a designation is
> +made as to whether the namespace is to be internally or externally
> +modeled.
> +
> +In an internally modeled namespace, the security event handlers pass the
> +event type and its characteristics to the designated internal trusted
> +modeling agent.  The agent provides the permission value for the
> +security event handler to return as the result of the event and sets
> +the trust status of the process executing the event.
> +
> +In an externally modeled namespace, the event type and parameters are
> +exported to userspace for processing by a trust orchestrator with an
> +associated TMA.  The trust orchestrator communicates the result of the
> +modeling back to the kernel to support the setting of the process
> +trust status.
> +
> +The exception to this model are for security event handlers that are
> +called in atomic, ie. non-sleeping context.  The export of these
> +security event descriptions are done asynchronously in order to avoid
> +having the TSEM implementation attempt to sleep in atomic context
> +while the userspace trust orchestrator is scheduled for execution.
> +
> +It is up to the trust orchestrator and its security policy to
> +determine how it handles events that violate the security model being
> +enforced in this model.  The Quixote trust orchestrators shut down the
> +entire workload running in the security namespace if an asynchronously
> +modeled event violates the security model being enforced and the model
> +is running in enforcing mode.

I understand your desire to simply pass off the non-blocking/async access
control hole as a security policy issue, but it seems to me that this is
a fundamental flaw with an externally modeled TSEM namespace.  If an
externally modeled namespace was configured with an enforcing policy, it
doesn't appear that there is a mechanism for TSEM to properly enforce
that policy as there is an unbounded delay between the undesired access
and a denial verdict being processed by the kernel.

Unless you can resolve this somehow, and I'm not sure how, I would
suggest dropping external/userspace trust orchestrators.  They simply
don't seem able to reliably implement their security policies.

> +Internally modeled domains are able to provide immediate interception
> +and modification of the trust status of a process that is violating
> +the security model.  This has implications for the root security
> +namespace that is running on a system with a TPM, since the security
> +event coefficients are logged to the Platform Configuration Register
> +that is being used by TSEM.
> +
> +Issuing the TPM transaction would cause the process to attempt to
> +sleep while it waits for the TPM command to complete.  In order to
> +address this issue, the TPM transactions are deferred to an ordered
> +workqueue for execution.  The use of an ordered workqueue maintains
> +the time dependency of the security coefficients being registered.

I would suggest removing the "time dependency" phrase and focus on the
workqueue preserving the ordering of the TPM transactions.

> +In order to handle modeling of security events in atomic context, the
> +TSEM implementation maintains caches (magazines) of structures that
> +are needed to implement the modeling and export of events.  The size
> +of this cache can be configured independently for each individual
> +security modeling namespace that is created.  The default
> +implementation is for a cache size of 32 for internally modeled
> +namespaces and 128 for externally modeled namespaces.
> +
> +By default the root security namespace uses a cache size of 128.  This
> +value can be configured by the 'tsem_cache' kernel command-line
> +parameter to an alternate value.

I haven't looked at the implementation yet, but I don't understand
both why a kmem_cache couldn't be used here as well as why this
implementation detail is deemed significant enough to be mentioned in
this high level design document.

> +Trust Orchestrator/Process authentication
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The process identifier values (PID's) that are exported in the
> +security event descriptions are the unique global PID values, not the
> +value as seen through the lens of a PID namespace.
> +
> +PID values are, by default, not considered to be a stable identifier
> +between the kernel and userspace.  In the case of TSEM external
> +modeling, the threat model for a namespace is whether or not an
> +adversarial process, running in either the root security modeling
> +namespace or another subordinate security modeling namespace, can kill
> +a process that is being orchestrated and substitute an alternate
> +process with an identical PID value.

We've talked about this previously, but given my current understanding
of TSEM, one of my concerns is the presence of user controlled data
in a TSEM security event.  This could include PIDs, task->comm values,
and potentially others (I haven't gone through the full CELL list yet).

> +The suggested threat model would be that the orchestrator would set
> +the trust status of the adversarial process rather than the one that
> +had emitted the security event characteristics.  The threat interval
> +is the latency time required for the processing of the security event
> +description by the trust orchestrator and its associated TMA.
> +
> +Exploiting this theoretical race is extremely complex and requires an
> +in depth understanding of the TSEM architecture.

I don't believe we want to accept a LSM with race conditions, even
theoretical ones.  One can argue how likely such a race condition would
be in practice, but the audeience here is too samll, the future too
unpredictable, and the adversaries too clever for such a debate to be
very meaningful.

At this point in the development process, there is an opportunity to
design away all race conditions, even the theoretical ones, let's do
that while we can.

> +Rather than discuss
> +the conditions that must be met and their implications, this
> +discussion will first focus on the generic threat model and its
> +generic utility to an adversary followed by a treatment of the
> +mechanisms that TSEM implements in order to mitigate this threat.
> +
> +In short, a process in an adversarial security modeling namespace
> +would want to execute security events that are barred from its
> +security model with the hope of having them approved by an alternate
> +namespace.
> +
> +A process waiting for the external modeling of a security event
> +description can only be placed back into run state by two methods:
> +reception of a fatal signal or the TRUST_PENDING status bit being
> +cleared from its TSEM specific task control structure by a trust
> +orchestrator.
> +
> +If a process being evaluated receives a fatal signal, its trust status
> +will be set to untrusted and an error will be returned to the trust
> +orchestrator.  The error would cause a trust violation to be
> +registered for the workload.  In addition, the evaluation of the event
> +would be terminated, so a replacement process would not receive an
> +incorrect trust assessment for an event that was initiated by its
> +predecessor.
> +
> +The second issue that limits the utility of a PID substitution attack
> +is that from the point of substitution forward it would place the
> +replacement process in the context of the security model that the
> +trust orchestrator is enforcing.  As a result, a substituted process
> +would not be allowed to exhibit any security behaviors inconsistent
> +with the model being enforced.
> +
> +If an attempt to exploit this race would be considered, an adversarial
> +process would have to force the termination of a process in the target
> +namespace and then fork and exit a process a sufficient number of
> +times in order to have a process under its control match the PID value
> +of the process that was waiting for an orchestration response.
> +
> +Measured modeling latency times for a trust orchestrator running the
> +deterministic Quixote TMA in userspace, on current generation x86_64
> +hardware, averages 170 micro-seconds.  In a worst case scenario from
> +the perspective of an adversary, there would be a need to force the
> +termination of the target process and then fork and execute a
> +sufficient number of times to force the PID collision during this time
> +interval.

It is best not to rely on hardware performance to mitigate security
concerns, at some point or with some configuration, you will be wrong.

> +As a generic protection, TSEM in the tsem_task_kill() handler, blocks
> +the notion of 'cross-model' signals, ie. a signal originating from an
> +external security modeling namespace.  This would require the
> +adversary to reliably force a process termination through a mechanism
> +other than signaling, for example, through the OOM killer whose signal
> +transmission would not be blocked by this policy control.
> +
> +When a subordinate security modeling namespace is created, the id
> +number of the namespace is registered in the tsem_task structure of
> +the trust orchestrator that is creating the namespace.  The TSEM
> +driver will refuse to honor control plane requests affecting the trust
> +status of a process whose trust orchestrator security namespace id
> +does not match the namespace identifier of the process that it is
> +being asked to act on.
> +
> +As an additional protection, TSEM uses an authentication strategy that
> +allows a process running in a security modeling namespace to verify
> +that a control request is coming from the trust orchestrator that
> +initiated the namespace the process is running in.  As part of the
> +setup of a security modeling namespace, a trust orchestrator is
> +required to provide an ASCII hexadecimally encoded authentication key
> +that matches the length of a digest value of cryptographic hash
> +function being used to generate security state coefficient in the
> +security modeling namespace.  This authentication key must be provided
> +by the trust orchestrator for every subsequent control plane request.
> +
> +The process that is being transferred to a subordinate security
> +modeling namespace generates a second random key that is hashed with
> +the authentication key provided by the trust orchestrator, using the
> +hash function that has been defined for the security namespace.  The
> +resultant digest value is compared to a list of authentication keys
> +for all currently executing namespaces.  The selection of the second
> +random key is repeated until a globally unique key is generated.
> +
> +This randomly generated authentication key is stored in the tsem_task
> +structure of the process and propagated to any subsequent processes
> +that are created in the namespace.  The hash product of this key and
> +the orchestration authentication key, ie. the globally unique key, is
> +placed in the tsem_task control structure of the orchestration
> +process.
> +
> +When a control plane request is received, the authentication key
> +provided by the trust orchestrator is used to re-generate an
> +authentication key based on the randomly generated namespace key held
> +by the process whose trust status is being updated.  The generated
> +authentication key is compared to the key in the tsem_task structure
> +of the process issuing the orchestration call.  The control plane will
> +refuse to honor a control plane request if the call specific key that
> +is generated does not match the key generated at the time the security
> +namespace was created.
> +
> +Event modeling
> +--------------
> +
> +The generation of security state coefficients is a functional process
> +that uses a cryptographic hash function for the creation of the
> +individual identity mappings that contribute to the generation of the
> +security state coefficient.
> +
> +TSEM can use any cryptographic hash function available to the Linux
> +kernel for this purpose.  The hash function to be used for a security
> +modeling namespace is specified as a parameter to the namespace
> +creation process.
> +
> +By default, the root security namespace uses sha256.  This value can
> +be modified through the tsem_digest kernel command-line parameter.
> +
> +Since TSEM is active before the kernel has the ability to load
> +modules, the root modeling domain must be a cryptographic hash
> +function that is statically compiled into the kernel.  By default the
> +TSEM configuration selects for the presence of the sha256 hash
> +function.
> +
> +TSEM security event modeling is based on the following functional
> +definition for a security event coefficient:
> +
> +Coeff = HF(HF(EVENT_ID) || PTASK_ID || TASK_ID || HF(COE) || HF(CELL))
> +
> +	Where:
> +		Coeff	 = A security state coefficient that is equal
> +			   in length to the digest value of the
> +			   cryptographic hash function in use for the
> +			   security modeling namespace.
> +
> +		HF	 = Security namespace specific hash function.
> +
> +		||       = Concatenation operator.
> +
> +		EVENT_ID = The ASCII name of event.
> +
> +		PTASK_ID = The TASK_ID of the parent process of the
> +			   process represented by TASK_ID.
> +
> +		TASK_ID  = The process specific identity of the
> +			   executable code that is calling the security
> +			   event handler.
> +
> +		COE      = Characteristics of the context of execution
> +			   of the event.
> +
> +		CELL	 = Characteristics of the LSM event that is being
> +			   modeled.
> +
> +Workload or platform specific security state coefficient definitions
> +are generated by a TMA, using the COE or CELL characteristics that are
> +considered relevant for the model being implemented.  These
> +coefficients are used to determine whether or not an event should lead
> +to the process being considered trusted or untrusted.
> +
> +The TASK_ID component of the function above is important with respect
> +to the generation of the security state coefficients.  The notion of a
> +task identity serves to link the concepts of system integrity and
> +security access control.
> +
> +The TASK_ID is defined by the following function:
> +
> +TASK_ID = HF(HF(EVENT) || PTASK_ID || NULL_ID || HF(COE) || HF(CELL))
> +
> +	Where:
> +		TASK_ID	  = The executable identity of the process
> +			    expressed as a digest value of length
> +			    equal to the cryptographic hash function
> +			    the security modeling namespace is using.
> +
> +		HF	  = Security namespace specific hash function.
> +
> +		||        = Concatenation operator.
> +
> +		EVENT	  = The string "bprm_committed_creds".
> +
> +		PTASK_ID  = The TASK_ID of the parent process of the
> +			    process whose TASK_ID is being generated.
> +
> +		NULL_ID	  = A buffer of null bytes equal to the digest
> +			    size of the hash function being used for
> +			    the namespace.
> +
> +		COE	  = Characteristics of the context of execution
> +			    calling the bprm_committed_creds LSM hook.
> +
> +		CELL	  = The characteristics of the file provided
> +			    by the linux_binprm structure passed to
> +			    the security_bprm_committed_creds handler.
> +
> +An attentive reader will quickly conclude, correctly, that the TASK_ID
> +function generates an executable specific security coefficient for the
> +bprm_committed_creds security hook.  The generative function for the
> +TASK_ID is the same as the standard security state coefficient; with
> +the exception that the task identity is replaced with a 'null id',
> +consisting of the number of null bytes in the digest size of the
> +namespace specific hash function.
> +
> +One of the CELL characteristics used in the computation of the task
> +identity is the digest of the executable file.  Modifying an
> +executable, or attempting to execute a binary not considered in the
> +security model, will result in an alteration of the task identity that
> +propagates to the generation of invalid state coefficients.

Presumably an attacker could craft a malicious executable (or influence
the CELL value if it incorporates user controlled values) that collides
with the digest of a known and trusted application.

> +The task identity is saved in the TSEM specific task structure and is
> +used to compute the state coefficients for any security events that
> +the task subsequently executes.  As noted in the previous paragraph,
> +incorporating the TASK_ID into the computation of security state
> +coefficients results in the security state coefficient values becoming
> +specific to the corpus of executable code that initiated a process.
> +This affords a very high degree of specificity with respect to the
> +security models that can be implemented.
> +
> +As was demonstrated in the TBDHTTRAD section, in contrast to standard
> +digest based controls, TSEM will discriminate the following commands
> +as different events/coefficients in a security model:
> +
> +cat /etc/shadow
> +
> +grep something /etc/shadow
> +
> +while read input
> +do
> +	echo $input;
> +done < /etc/shadow
> +
> +An important, and perhaps subtle issue to note, is how these events
> +result in the change of process trust status.  In the first two cases,
> +if access to the /etc/shadow file is not permitted by the operative
> +security model, the cat and grep process will become untrusted.
> +
> +In the third example, the shell process itself would become untrusted.
> +This would cause any subsequent attempts to execute a binary to be
> +considered untrusted events, even if access to the binary is a
> +permitted coefficient in the model.
> +
> +The integration of the PTASK_ID in the generation of the security
> +state coefficients causes the coefficients to be dependent on the
> +chain of execution of executable code.  This concept generates
> +extremely specific security coefficients that yield the high
> +sensitivity of TSEM based security models.
> +
> +For example, consider the following chain of execution:
> +
> +init/systemd -> sshd -> bash
> +
> +init/systemd -> getty -> bash
> +
> +Even if the COE characteristics (credentials) of the two bash
> +processes are identical, the security coefficients generated by the
> +two bash shells will be different.  This is secondary to the fact that
> +the TASK_ID of the two bash processes will be different by virtue of
> +the fact that the first bash process will have a PTASK_ID that
> +represents the TASK_ID of the ssh process, while the second process
> +will have a PTASK_ID that represents the TASK_ID of the getty process.
> +
> +This generative functions provides a framework for modeling that
> +yields very precise tracking of security relevant events.  This is
> +significant with respect to detecting and addressing adversarial
> +techniques such as Living Off The Land (LOTL).
> +
> +Since the modeling operates at the level of a mandatory security
> +control, these permission denials would occur even if the process is
> +running with classic root privilege levels.  This is secondary to the
> +notion that security and trust status are invested in the trust
> +orchestrator and ultimately the TMA.
> +
> +From a hardware perspective, this is important with respect to the
> +notion of a TMA being a model for a successor to the TPM.  From a
> +system trust or integrity perspective, a TPM is designed to provide a
> +retrospective assessment of the actions that have occurred on a
> +platform.  A verifying party uses the TPM event log and a PCR based
> +summary measurement, to verify what actions have occurred on the host,
> +in order to allow a determination of whether or not the platform
> +should be 'trusted'.
> +
> +In contrast, a TSEM/TMA based system enforces, on a real time basis,
> +that a platform or workload remains in a trusted state.  Security
> +relevant actions cannot be conducted unless the TMA authorizes the
> +actions as being trusted.
> +
> +This is particularly important with respect to embedded systems.  A
> +TPM based architecture would not prevent a system from having its
> +trust status altered.  Maintaining the system in a trusted state would
> +require attestation polling of the system, and presumably, executing
> +actions if the platform has engaged in untrusted behavior.
> +
> +Conversely, a trust orchestrated software implementation enforces that
> +a system or workload remain in a security/trust state that it's
> +security model was unit tested to.
> +
> +Security model functional definitions
> +-------------------------------------
> +
> +Previously, classic trusted system implementations supported the
> +notion of the 'measurement' of the system.  The measurement is the
> +value of a linear extension function of all the security relevant
> +actions recorded by a trust measurement system such as IMA.
> +
> +In TPM based trust architectures, this measurement is maintained in a
> +PCR.  A measurement value is submitted to the TPM that extends the
> +current measurement using the following formula:
> +
> +MEASUREMENT = HF(CURRENT || NEW)
> +
> +	Where:
> +		MEASUREMENT = The new measurement value to be maintained
> +			      in the register for the system.
> +
> +		HF	    = A cryptographic hash function supported
> +			      by the TPM device.
> +
> +		||	    = Concatenation operator.
> +
> +		CURRENT     = The current measurement value.
> +
> +		NEW	    = A new measurement value to be added to
> +			      the current measurement.
> +
> +The use of a cryptographic function produces a non-commutative sum
> +that can be used to verify the integrity of a series of measurements.
> +With respect to security modeling theory, this can be thought of as a
> +'time-dependent' measurement of the system.  Stated more simply, the
> +measurement value is sensitive to the order in which the measurements
> +were made.
> +
> +In systems such as IMA, the measurement value reflects the sum of
> +digest values of what are considered to be security critical entities,
> +most principally, files that are accessed or memory that is mapped
> +executable, based on various policies.
> +
> +In TSEM based TMA's, the measurement of a security modeling namespace
> +is the sum of the unique security state coefficients generated by the
> +security model being enforced.  As previously noted, on systems with a
> +TPM, the root security modeling namespace measurement is maintained by
> +default in PCR 11 or the PCR that was selected at kernel configuration
> +time.
> +
> +The challenge associated with classic integrity measurements is the
> +time dependent nature of using a non-commutative summing function.
> +The almost universal embrace of SMP based hardware architectures, in
> +addition to standard kernel task scheduling issues, makes the
> +measurement values non-deterministic.  This requires a verifying party
> +to evaluate an event log, verified by a measurement value, to
> +determine whether or not the system is in a security appropriate or
> +trusted state.
> +
> +TSEM addresses this issue by implementing a strategy designed to
> +produce a single functional value that represents the functional
> +security state of a model.  This allows a TMA to attest to the
> +trust/security status of a platform or workload by signing this
> +singular value and presenting it to a verifying party.
> +
> +In TSEM nomenclature, this functional value is referred to as the
> +'state' of the model.  The attestation model is to use trust
> +orchestrators to generate the state value of a workload by unit
> +testing.  This state value can be packaged with a utility or container
> +to represent a summary trust characteristic that can be attested by a
> +TMA, eliminating the need for a verifying partner to review and verify
> +an event log.
> +
> +TMA's implement this architecture by maintaining a single instance
> +vector of the set of unique security state coefficients that have been
> +experienced in a security modeling namespace.  The state measurement
> +is generated by sorting the security state coefficient vector in
> +big-endian hash format and then generating a standard linear extension
> +measurement over this new vector.

There are cases where ordering of events is important when assessing the
security state of the system, e.g. disabling/enabling security features.
In these cases where ordering is necessary to attest the security state
of the system, is there some middle ground, or does an admin need to
revert to a "classic" orderered measurement?

> +Any security event that generates an associated state coefficient that
> +is not in the model will resulted in a perturbed state function value.
> +That perturbed value would be interpreted by a verifying party as an
> +indication of an untrusted system.
> +
> +Since the TMA maintains the security event descriptions in time
> +ordered form, the option to provide a classic event log and
> +measurement are preserved and available.  Extensive experience in the
> +development of TSEM modeled systems has demonstrated the superiority
> +of state value interpretation over classic measurement schemes.

I don't disagree that working with the pre-sorted measurement is far
easier, I just wonder how many systems would be able to give up on the
event ordering to have the simplified modeling.  Surely we will all
have different experiences here, but I'm not sure the pre-sorted
measurement approach would have been acceptable in many of the projects
I've worked on over the years.

> +A TMA may choose to incorporate a 'base nonce' into a security model
> +that it is implementing, this base nonce is designed to serve in a
> +manner similar to an attestation nonce.  If used, the trust
> +orchestrator is responsible for negotiating a random base nonce with a
> +verifying party at the time of initialization of a security modeling
> +namespace and providing it to the TMA.
> +
> +The TMA uses the base nonce to extend each security event coefficient
> +that is generated by the model.  This causes the state and measurement
> +values of the model to become dependent on this base nonce, a process
> +that can be used to defeat a replay attack against the security model.
> +
> +Control plane
> +-------------
> +
> +Both primary functions of TSEM: security modeling namespace management
> +and the internal TMA modeling implementation, are controlled by
> +pseudo-files in the securityfs filesystem.  The following directory
> +is the top level implementation directory for the TSEM control plane:
> +
> +/sys/kernel/security/tsem
> +
> +The following file in the kernel source tree documents, in detail,
> +the interfaces provided by the filesystem:
> +
> +Documentation/ABI/testing/tsem
> +
> +This filesystem is primarily intended for use by trust orchestrators
> +to create and manage security modeling namespaces.
> +
> +The files are process context sensitive.  Writing to the control file,
> +or reading from the informational files, will act on or reference the
> +security modeling namespace that the accessing process is assigned to.
> +
> +The following files are provided in the root directory of the TSEM
> +control plane and implement global controls for the TSEM LSM:
> +
> +	aggregate
> +	id
> +	control
> +
> +The 'aggregate' file is used by trust orchestrators for internally
> +modeled namespaces to obtain the hardware measurement value for
> +inclusion in a security model.

So I'm clear on this, internally modeled namespaces still access the
hardware measurement directly from inside the kernel, yes?  In the
interally modeled case this is simply available as a reference, and
the in-kernel TMA doesn't call out to userspace to access this value,
yes?

> +A trust orchestrator for an externally
> +modeled namespace capture this value as the first event generated by a
> +security modeling namespace.
> +
> +The 'id' file is used to determine the security modeling namespace
> +that the process is running in.  The namespace id value of 0 is
> +reserved for the root security modeling namespace, a non-zero value
> +indicates that the process is running in a subordinate security
> +modeling namespace.
> +
> +The TSEM implementation is controlled by the only writable file, which
> +is the 'control' file.
> +
> +The following keywords are used by trust orchestrators to place the
> +process writing to the file in an internally or externally modeled
> +security namespace:
> +
> +	internal
> +	external
> +
> +Each argument accepts key=value pairs that configure the namespace.
> +The following key values are currently accepted:
> +
> +	model
> +	nsref
> +	digest
> +	cache
> +	key
> +
> +The 'model' keyword takes as an argument the name of a loadable module
> +that will be used to implement the event processing for a security
> +modeling namespace.  If the module has not already been loaded, TSEM
> +will attempt to dynamically load the module.

I'm still sorting out the stuff in the docs and haven't gotten to the
implementation yet, but just so we're clear on the details about TSEM
modules, TSEM shouldn't attempt to sidestep the LSM framework as TOMOYO
did recently and we later had to revert.

Considering that TSEM is likely to want to be active before enough of
a userspace exists to load a module (see the previous sections on hash
functions), it seems like the best option is to simply include all of
the desired internal TMAs in the kernel at build time.

> +If the standard practice
> +is followed of using the KBUILD_MODNAME CPP define to set the name of
> +the security model, the argument to the model keyword will be that
> +name, a value that will match the name that is displayed by the lsmod
> +command.  It should be noted that there is no requirement that the
> +security model name match the name of the module generated by the
> +build process.
> +
> +The 'nsref' keyword takes one of the following two values:
> +
> +	initial
> +	current
> +
> +The initial argument indicates that the UID/GID values for the COE and
> +CELL characteristics are derived from the initial user namespace.
> +This is the default characteristic if the nsref key is not specified.
> +
> +The current argument indicates that the UID/GID values are derived
> +from the user namespace that the process is running in, when the
> +request is made to model an event.
> +
> +The 'digest' keyword is used to specify the cryptographic hash
> +function that is to be used to create the functional values for the
> +security state coefficients for the namespace.  The value to this
> +keyword is the name by which the hash function is defined by the
> +cryptographic API in the kernel.
> +
> +Examples of suitable strings are as follows:
> +
> +	sha256
> +	sha3-256
> +	sm3
> +
> +Definitions for the names of the cryptographic hashes can be found in
> +the source files for the various cryptographic hash functions in the
> +'crypto' directory of the Linux source tree.
> +
> +The 'cache' keyword is used to specify the size of the caches used to
> +hold pointers to data structures used for the internal modeling of
> +security events or the export of the security event to external trust
> +orchestrators.  These pre-allocated structures are used to service
> +security event hooks that are called while the process is running in
> +atomic context and thus cannot sleep in order to allocate memory.
> +
> +The argument to this keyword is a numeric value specifying the number
> +of structures that are to be held in reserve for the namespace.
> +
> +By default the root security modeling namespace and externally modeled
> +namespaces have a default value of 128 entries.  An internally modeled
> +namespace has a default value of 32 entries.  The size requirements of
> +these caches can be highly dependent on the characteristics of the
> +modeled workload and may require tuning to the needs of the platform
> +or workload.

Presumably TSEM provides usage statistics somewhere so admins can monitor
and tune as desired?  If so, it seems like it would be a good idea to
add a reference here.

> +The structures that are used by security events generated in atomic
> +context are replenished by work requests submitted to the high
> +priority system workqueue.  The refill latency will also affect the
> +magazine sizes that are needed.

Once again, it seems like a kmem_cache could be useful.

> +The 'key' keyword is used to specify the authentication key that is to
> +be used to support the authentication of trust control requests from a
> +trust orchestrator to processes running in a security modeling
> +namespace.  The argument to this keyword is the ASCII base16
> +representation of the key that is to be used.  The length of the key
> +must be equal to the length of the ASCII base16 representation of the
> +digest value of the cryptographic digest function defined for the
> +security modeling namespace.
> +
> +The following keywords and arguments are used by trust orchestrators
> +to set the trust status of a process after the processing of a
> +security event by an external TMA:
> +
> +	trusted pid=PID key=HEXID
> +	untrusted pid=PID key=HEXID
> +
> +	PID is the process identifier that is provided to the TMA in
> +	the security event description.  HEXID is the base16 ASCII
> +	representation of the authentication key that the security
> +	modeling namespace was configured with when the namespace was
> +	created.

This is something that will likely have to wait until the review
progresses further down into the implementation as it raises a fair
number of red flags.  To be fair, it is possible they are false
warnings, but judgement on this will have to wait until the other
major concerns from the doc review have been addressed in some way.

> +     The length of the ASCII representation of HEXID must
> +	equal the size of the base16 ASCII representation of a digest
> +	value for the cryptographic hash function selected for the
> +	security modeling namespace.
> +
> +By default a security modeling namespace runs in free modeling mode.
> +The modeling mode is changed by writing the following keywords to the
> +control file:
> +
> +	seal
> +	enforce
> +
> +The seal value is used to specify that any further security state
> +coefficients are to be considered outside the bounds of a desired
> +security model.  The security event descriptions that generate these
> +coefficients will be considered forensics events for the model.
> +
> +The enforce key is used to specify that invalid security events
> +generate permission denials as the return value for the LSM security
> +event handler that generates the invalid events.
> +
> +The following keyword and argument are used to load a security model
> +into an internal TMA modeling implementation:
> +
> +	state value=HEXID
> +
> +	Where HEXID is the ASCII base 16 representation of a security
> +	state coefficient that represents a valid security event in
> +	the model.  The length of the HEXID string must be equal to
> +	the size of the ASCII base 16 representation of the digest
> +	value of the cryptographic hash function defined for the
> +	security modeling namespace.
> +
> +	After writing a series of state values the trust orchestrator
> +	writes the 'seal' keyword to the control file to complete
> +	creation of a security model.
> +
> +	Writing the 'enforce' keyword to the control file will place
> +	the defined model in enforcing mode.
> +
> +	Defining a security model to be enforced will affect the
> +	output of the 'trajectory' file.  The 'trajectory' file will
> +	have no event descriptions for a sealed model, since the event
> +	description list is only populated when a new state
> +	coefficient is added to the model.
> +
> +	In a sealed model the security event descriptions will be
> +	surfaced in the 'forensics' file instead to indicate they are
> +	violations against the security model being enforced.
> +
> +	Since the state state coefficients are generated with a
> +	cryptographic hash function, the first pre-image resistance
> +	characteristics of the function prevents a security model
> +	description from disclosing information, a-priori, about the
> +	desired characteristics of the workload.
> +
> +The following keyword and argument is used to set a base nonce for the
> +internal TMA:
> +
> +	base value=HEXID
> +
> +	Where HEXID is the ASCII base 16 representation of a value
> +	that each security state event mapping is to be extended with
> +	before being committed as a security state coefficient value
> +	for the model.  The size of the HEXID string must equal the
> +	size of the ASCII base 16 representation of a digest value of
> +	the cryptographic hash function defined for the security
> +	modeling namespace.
> +
> +The following keyword and argument is used to create a file digest
> +pseudonym for the internal TMA:
> +
> +	pseudonym value=HEXID
> +
> +	Where HEXID is the ASCII base 16 representation of a file
> +	digest pseudonym that is to be maintained by the model.  See
> +	the ABI documentation for how the argument to this verb is
> +	generated.
> +	
> +	The size of the HEXID string must equal the size of the ASCII
> +	base 16 representation of a digest value of the cryptographic
> +	hash function defined for the security modeling namespace.
> +
> +The following keyword is used to lock the current TSEM modeling
> +configuration:
> +
> +	lock
> +
> +This command is only valid when loadable module support is available
> +in the kernel.  When executed this command blocks any further TSEM
> +models from being registered.  In addition the reference count on all
> +currently registgered modeling modules is increased so that it is not
> +possible to remove currently loaded modules.
> +
> +The following two directories are implemented in the top level TSEM
> +control directory in order to support interfaces to internally and
> +externally modeled namespaces:
> +
> +	external_tma
> +	internal_tma
> +
> +The external_tma directory holds a file, that is created when the
> +request to create an externally modeled namespace is made.  The filename
> +is the ASCII base 10 representation of the id number of the security
> +modeling namespace.  The descriptions for security events that occur
> +in the context of the namespace are exported in JSON format through
> +this file to the external trust orchestrator that is controlling the
> +security modeling namespace.
> +
> +The internal_tma directory is a container directory that holds
> +directories for the control of each internal TMA that is implemented
> +in the kernel.
> +
> +There is currently only a single kernel based TMA that is managed
> +through the following directory:
> +
> +/sys/kernel/security/tsem/internal_tma/model0
> +
> +The following files are implemented for this model:
> +
> +	measurement
> +	state
> +
> +	trajectory
> +	trajectory_coefficients
> +	trajectory_counts
> +
> +	forensics
> +	forensics_coefficient
> +	forensics_counts
> +
> +The 'measurement' file outputs the classic linear extension value of
> +the security state coefficients that are generated in the context of
> +the security modeling namespace.  This value is time dependent and can
> +be used to verify the order of the security events that occurred in
> +the model.
> +
> +The 'state' file outputs the time independent functional value of
> +security state of the security modeling namespace.  This value and its
> +generation and motivation are discussed in the 'Security model
> +functional definitions' section of this document.
> +
> +The 'trajectory' file outputs the description of each security event
> +recorded by the model in time dependent form.  The ABI documentation
> +file contains a complete description of the output that is generated
> +by this file and the 'forensics' file described below.
> +
> +The 'trajectory_coefficients' file outputs the set of security state
> +coefficients in the model.  These coefficients match the entries of
> +the event descriptions that are output in the 'trajectory' file.
> +
> +The security state coefficients can be paired with the security state
> +descriptions with the following shell command, where DIR is the path
> +to the individual files:
> +
> +paste DIR/trajectory_coefficients DIR/trajectory
> +
> +The 'trajectory_counts" file outputs the number of times that each
> +security state coefficient, output by the 'trajectory_coefficients'
> +file, has been experienced in the security modeling namespace.  This
> +value can be used to verify that a security sensitive event has
> +occurred or for statistical inference as to the anomaly status of an
> +event.
> +
> +The 'forensics' file outputs the description of security events that
> +have occurred when the namespace security model is running in a sealed
> +state.  These events are useful for characterizing a security
> +intrusion that has occurred or for refinement of a security model.
> +
> +The 'forensics_coefficients' file outputs the security state
> +coefficients that are generated by the forensics events that have
> +been captured by the model and available through the 'forensics' file.
> +
> +The 'forensics_counts" file outputs the number of times that each
> +security state coefficient output by the 'forensics_coefficients' file
> +has been experienced in the security namespace.  This value can can be
> +used for statistical inference as to the anomaly status of the
> +namespace.

--
paul-moore.com

