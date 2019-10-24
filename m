Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40390E2253
	for <lists+linux-security-module@lfdr.de>; Wed, 23 Oct 2019 20:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388377AbfJWSJ0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 23 Oct 2019 14:09:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388266AbfJWSJZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 Oct 2019 14:09:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NI815m124878
        for <linux-security-module@vger.kernel.org>; Wed, 23 Oct 2019 14:09:24 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtuver1q7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Wed, 23 Oct 2019 14:09:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 23 Oct 2019 19:09:22 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 19:09:18 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9NI8jC941681354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 18:08:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0DE842047;
        Wed, 23 Oct 2019 18:09:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B0B74203F;
        Wed, 23 Oct 2019 18:09:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.174])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 18:09:16 +0000 (GMT)
Subject: Re: [PATCH v1 6/6] KEYS: measure keys when they are created or
 updated
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Wed, 23 Oct 2019 14:09:15 -0400
In-Reply-To: <20191023001818.3684-7-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
         <20191023001818.3684-7-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102318-0028-0000-0000-000003AE3EC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102318-0029-0000-0000-000024706E31
Message-Id: <1571854155.5104.157.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230169
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2019-10-22 at 17:18 -0700, Lakshmi Ramasubramanian wrote:
> diff --git a/security/security.c b/security/security.c
> index 250ee2d76406..707a9e7fa94d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2303,6 +2303,16 @@ int security_key_getsecurity(struct key *key, char **_buffer)
>  	return call_int_hook(key_getsecurity, 0, key, _buffer);
>  }
>  
> +int security_key_create_or_update(struct key *keyring,
> +				  struct key *key,
> +				  const struct cred *cred,
> +				  unsigned long flags,
> +				  bool create)
> +{
> +	return ima_post_key_create_or_update(keyring, key, cred,
> +					     flags, create);
> +}
> +
>  #endif	/* CONFIG_KEYS */

Either the new hook is an LSM and IMA hook, or it is just an IMA hook.
 We don't define a security_ function, if it is just an IMA hook.

Mimi

