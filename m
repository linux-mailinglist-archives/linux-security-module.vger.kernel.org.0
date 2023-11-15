Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1227EB673
	for <lists+linux-security-module@lfdr.de>; Tue, 14 Nov 2023 19:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbjKNSgm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 14 Nov 2023 13:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjKNSgl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 Nov 2023 13:36:41 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C78111D;
        Tue, 14 Nov 2023 10:36:38 -0800 (PST)
Received: from [10.137.114.52] (unknown [131.107.159.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id DDE2F20B74C1;
        Tue, 14 Nov 2023 10:36:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDE2F20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1699986997;
        bh=ip5SH1zQ+t2HatDE3wRWZbocUBe8AkIri1k+HYGCJUA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nOOO8ywMLG/MkBJKtNIGNNBLu2+deC/41Hr8pT7oH3iuEgMaPpC0ODrhIwmj73U1O
         rW6MHW1axc7IZssrKgXtR1tEAyFVGbaqoPJqFFlDZmY1WMACPoUPktfmQKtdCy6U6T
         imiMLsrLn3s+lNqydjAFiDY5h+up7LxDCPX40PLg=
Message-ID: <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
Date:   Tue, 14 Nov 2023 10:36:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>,
        jgg@ziepe.ca, Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com,
        vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
Content-Language: en-US
From:   Sush Shringarputale <sushring@linux.microsoft.com>
In-Reply-To: <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 11/13/2023 10:59 AM, Stefan Berger wrote:
>
>
> On 10/19/23 14:49, Tushar Sugandhi wrote:
>> =======================================================================
>> | Introduction |
>> =======================================================================
>> This document provides a detailed overview of the proposed Kernel
>> feature IMA log snapshotting.  It describes the motivation behind the
>> proposal, the problem to be solved, a detailed solution design with
>> examples, and describes the changes to be made in the clients/services
>> which are part of remote-attestation system.  This is the 2nd version
>> of the proposal.  The first version is present here[1].
>>
>> Table of Contents:
>> ------------------
>> A. Motivation and Background
>> B. Goals and Non-Goals
>>      B.1 Goals
>>      B.2 Non-Goals
>> C. Proposed Solution
>>      C.1 Solution Summary
>>      C.2 High-level Work-flow
>> D. Detailed Design
>>      D.1 Snapshot Aggregate Event
>>      D.2 Snapshot Triggering Mechanism
>>      D.3 Choosing A Persistent Storage Location For Snapshots
>>      D.4 Remote-Attestation Client/Service-side Changes
>>          D.4.a Client-side Changes
>>          D.4.b Service-side Changes
>> E. Example Walk-through
>> F. Other Design Considerations
>> G. References
>>
>
> Userspace applications will have to know
> a) where are the shard files?
We describe the file storage location choices in section D.3, but user
applications will have to query the well-known location described there.
> b) how do I read the shard files while locking out the producer of the 
> shard files?
>
> IMO, this will require a well known config file and a locking method 
> (flock) so that user space applications can work together in this new 
> environment. The lock could be defined in the config file or just be 
> the config file itself.
The flock is a good idea for co-ordination between UM clients. While
the Kernel cannot enforce any access in this way, any UM process that
is planning on triggering the snapshot mechanism should follow that
protocol.  We will ensure we document that as the best-practices in
the patch series.
- Sush
