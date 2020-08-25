Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D41251ECF
	for <lists+linux-security-module@lfdr.de>; Tue, 25 Aug 2020 20:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHYSDm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 25 Aug 2020 14:03:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55292 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgHYSDk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 25 Aug 2020 14:03:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PI3Pjf103829;
        Tue, 25 Aug 2020 14:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Hs076pX2aK6wzze+PIeuf0RDs5T+N0cQZA1ds0Itdhg=;
 b=cozskm404t3Tsbtq5wokadL5/wRj/uyoAEOIt4qpCW9Hthj5F0fD9bQ8aAZtfKWr9tWi
 1+ocQ1UuCFzbj6GGf/l9azqq778U5IFY6M2cMLY3DhMSaTDjLO82CH+sNRtswPitDoc7
 ez4FOzPOjF3NXV9j/RHJmTyWiw0Tx0bGB3Y3RM8jZw/BSs8yEyFNyECIpH24hZGbKzRN
 t3lReeNb1nAw4Yz9EHYMeG57oDndZYwWs0b7VP7yadPGq6El6z8bdiGKuARPPTPJh+vc
 CG3t33hBa2AxW58FyfLM/13HTyhT2155TvaHCejTkGY6L3DqqoJF9w0yGH+u/3ux2ISY /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3356kmsw36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 14:03:34 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07PI3Xp4104556;
        Tue, 25 Aug 2020 14:03:33 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3356kmsw24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 14:03:33 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07PI2lXw023213;
        Tue, 25 Aug 2020 18:03:31 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 332ujrt8sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 18:03:31 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07PI3Tbn29360414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 18:03:29 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D206A404D;
        Tue, 25 Aug 2020 18:03:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84319A4040;
        Tue, 25 Aug 2020 18:03:27 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.103.4])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 18:03:27 +0000 (GMT)
Message-ID: <805e35d6835df219b5836e8159742bed086e0554.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: Handle early boot data measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 25 Aug 2020 14:03:26 -0400
In-Reply-To: <52d2204b-5b6e-e13f-d0dd-192a776812bc@linux.microsoft.com>
References: <20200821231230.20212-1-nramas@linux.microsoft.com>
         <a7ea2da1f895ee3db4697c00804160acb6db656e.camel@linux.ibm.com>
         <307617de-b42d-ac52-6e9e-9e0d16bbc20e@linux.microsoft.com>
         <49f8a616d80344c539b512f8b83590ea281ee54d.camel@linux.ibm.com>
         <52d2204b-5b6e-e13f-d0dd-192a776812bc@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_08:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250136
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2020-08-25 at 10:55 -0700, Lakshmi Ramasubramanian wrote:
> On 8/25/20 10:42 AM, Mimi Zohar wrote:
> 
> > > > Please limit the changes in this patch to renaming the functions and/or
> > > > files.  For example, adding "measure_payload_hash" should be a separate
> > > > patch, not hidden here.
> > > > 
> > > 
> > > Thanks for the feedback Mimi.
> > > 
> > > I'll split this into 2 patches:
> > > 
> > > PATCH 1: Rename files + rename CONFIG
> > > PATCH 2: Update IMA hook to utilize early boot data measurement.
> > 
> > I'm referring to introducing the "measure_payload_hash" flag.  I assume
> > this is to indicate whether the buffer should be hashed or not.
> > 
> > Example 1: ima_alloc_key_entry() and ima_alloc_data_entry(0 comparison
> > > -static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
> > > -                                                const void *payload,
> > > -                                                size_t payload_len)
> > > -{
> > > +static struct ima_data_entry *ima_alloc_data_entry(const char *event_name,
> > > +                                                  const void *payload,
> > > +                                                  size_t payload_len,
> > > +                                                  const char *event_data,
> > > +                                                  enum ima_hooks func,
> > > +                                                  bool measure_payload_hash)  <====
> > > +{
> > 
> > Example 2:
> > diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
> > index a74095793936..65423754765f 100644
> > --- a/security/integrity/ima/ima_asymmetric_keys.c
> > +++ b/security/integrity/ima/ima_asymmetric_keys.c
> > @@ -37,9 +37,10 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> >          if (!payload || (payload_len == 0))
> >                  return;
> >   
> > -       if (ima_should_queue_key())
> > -               queued = ima_queue_key(keyring, payload, payload_len);
> > -
> > +       if (ima_should_queue_data())
> > +               queued = ima_queue_data(keyring->description, payload,
> > +                                       payload_len, keyring->description,
> > +                                       KEY_CHECK, false);   <===
> >          if (queued)
> >                  return;
> > 
> > But in general, as much as possible function and file name changes
> > should be done independently of other changes.
> > 
> > thanks,
> 
> I agree - but in this case, Tushar's patch series on adding support for 
> "Critical Data" measurement has already introduced 
> "measure_payload_hash" flag. His patch updates 
> "process_buffer_measurement()" to take this new flag and measure hash of 
> the given data.
> 
> My patches extend that to queuing the early boot requests and processing 
> them after a custom IMA policy is loaded.
> 
> If you still think "measure_payload_hash" flag should be introduced in 
> the queuing change as a separate patch I'll split the patches further. 
> Please let me know.

There's a major problem if his changes add new function arguments
without modifying all the callers of the function.  I assume the kernel
would fail to compile properly.

Changing the function parameters to include "measure_payload_hash"
needs to be a separate patch, whether it is part of his patch set or
yours.

Mimi

