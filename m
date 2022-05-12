Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF93652421B
	for <lists+linux-security-module@lfdr.de>; Thu, 12 May 2022 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiELBef (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 11 May 2022 21:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiELBef (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 11 May 2022 21:34:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA6163F52;
        Wed, 11 May 2022 18:34:34 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C10qWi007812;
        Thu, 12 May 2022 01:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UKpb/O5tAGRbc/8/27SzriP9fD5S6Pn2HVidREwISr0=;
 b=e93goE2MQGqJE1pJHJ3CSTu0bR/1MlKmXBo8W49lnVryqQuMlWypFr6m+y7pmgZE4M4h
 aJY0fJixKPbMfBvzyvDgiK/1eJ5g58TvRf+9YzJD0LaX6Hxc624ZcaNFvgIwv4kskUwG
 VHqTEjTg3qY4iJs3vODfv3/H8eUD3Grg3E140JstdffaShwGGL7lndqqy8JoIvynCKob
 MV02W9rSP9YSTod1xMocPX+uuvfBzzY7Ob+litHtfdmbBTuX13ma0anlNMYLJH+mPNFz
 HvaCoDPY9CVmRIUdXCRJQxewsW+Nzmc/mVYyy0adSAefPTu3XMzoltp4pbbiZ9IQRfVY Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0cme6upv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 01:34:11 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24C1Rvhc008924;
        Thu, 12 May 2022 01:34:10 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g0cme6up7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 01:34:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24C1OUaC007319;
        Thu, 12 May 2022 01:34:08 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3fwg1hvtgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 01:34:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24C1Y5lt37683554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 01:34:05 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AD2E5204F;
        Thu, 12 May 2022 01:34:05 +0000 (GMT)
Received: from sig-9-65-89-202.ibm.com (unknown [9.65.89.202])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2D6A15204E;
        Thu, 12 May 2022 01:34:04 +0000 (GMT)
Message-ID: <11153650a1c4a70bb83ce67724280313120d07d5.camel@linux.ibm.com>
Subject: Re: [PATCH v3] x86/kexec: Carry forward IMA measurement log on kexec
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jonathan McDowell <noodles@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Wed, 11 May 2022 21:34:03 -0400
In-Reply-To: <67f0fe5874638241bc2f2401dc2bc12c51becc0b.camel@linux.ibm.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
         <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
         <YnuJCH75GrhVm0Tp@noodles-fedora.dhcp.thefacebook.com>
         <67f0fe5874638241bc2f2401dc2bc12c51becc0b.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QH3eQL91NtugomYoPs1JIfWyjlJK7qD1
X-Proofpoint-GUID: zmEDd7AYErMVBKvORzeN3hlYM9h8WHNa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205120006
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 2022-05-11 at 13:53 -0400, Mimi Zohar wrote:
> Hi Jonathan,
> 
> On Wed, 2022-05-11 at 09:59 +0000, Jonathan McDowell wrote:
> > On kexec file load Integrity Measurement Architecture (IMA) subsystem
> > may verify the IMA signature of the kernel and initramfs, and measure
> > it. The command line parameters passed to the kernel in the kexec call
> > may also be measured by IMA. A remote attestation service can verify
> > a TPM quote based on the TPM event log, the IMA measurement list, and
> > the TPM PCR data. This can be achieved only if the IMA measurement log
> > is carried over from the current kernel to the next kernel across
> > the kexec call.
> > 
> > powerpc and ARM64 both achieve this using device tree with a
> > "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> > device tree, so use the setup_data mechanism to pass the IMA buffer to
> > the new kernel.
> > 
> > Signed-off-by: Jonathan McDowell <noodles@fb.com>

Thanks, Jonathan.  The measurement list is now properly being restored
independently of CONFIG_IMA_KEXEC being configured.

> > +++ b/include/linux/ima.h
> > @@ -140,6 +140,9 @@ static inline int ima_measure_critical_data(const char *event_label,
> >  
> >  #endif /* CONFIG_IMA */
> > 

#ifdef CONFIG_HAVE_IMA_KEXEC

> > +int ima_free_kexec_buffer(void);
> > +int ima_get_kexec_buffer(void **addr, size_t *size);

#endif
> 
> Wouldn't moving these function definitions here imply they are
> implemented on all architectures or are using the version in
> drivers/of/kexec.c.

Adding the ifdef around these functions should resolve any issues.

thanks,

Mimi

