Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4E1C833
	for <lists+linux-security-module@lfdr.de>; Tue, 14 May 2019 14:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbfENMJt (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 14 May 2019 08:09:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbfENMJs (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 14 May 2019 08:09:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4EC3nrc033736
        for <linux-security-module@vger.kernel.org>; Tue, 14 May 2019 08:09:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sftyh6kv4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-security-module@vger.kernel.org>; Tue, 14 May 2019 08:09:47 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-security-module@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 14 May 2019 13:09:44 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 13:09:39 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4EC9c1l55050322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 12:09:38 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3DD0C42052;
        Tue, 14 May 2019 12:09:38 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 175C14204B;
        Tue, 14 May 2019 12:09:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.80.29])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 May 2019 12:09:35 +0000 (GMT)
Subject: Re: [PATCH v10 09/12] ima: Implement support for module-style
 appended signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date:   Tue, 14 May 2019 08:09:25 -0400
In-Reply-To: <20190418035120.2354-10-bauerman@linux.ibm.com>
References: <20190418035120.2354-1-bauerman@linux.ibm.com>
         <20190418035120.2354-10-bauerman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051412-0020-0000-0000-0000033C871A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051412-0021-0000-0000-0000218F42B3
Message-Id: <1557835765.4139.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=976 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140089
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Thiago,

On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
> 
> @@ -326,6 +356,10 @@ int ima_appraise_measurement(enum ima_hooks func,
>         case INTEGRITY_UNKNOWN:
>                 break;
>         case INTEGRITY_NOXATTRS:        /* No EVM protected xattrs. */
> +               /* It's fine not to have xattrs when using a modsig. */
> +               if (try_modsig)
> +                       break;
> +               /* fall through */
>         case INTEGRITY_NOLABEL:         /* No security.evm xattr. */
>                 cause = "missing-HMAC";
>                 goto out;
> @@ -340,6 +374,14 @@ int ima_appraise_measurement(enum ima_hooks func,
>                 rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
>                                   &cause);
>  
> +       /*
> +        * If we have a modsig and either no imasig or the imasig's key isn't
> +        * known, then try verifying the modsig.
> +        */
> +       if (status != INTEGRITY_PASS && try_modsig &&
> +           (!xattr_value || rc == -ENOKEY))
> +               rc = modsig_verify(func, modsig, &status, &cause);

EVM protects other security xattrs, not just security.ima, if they
exist.  As a result, evm_verifyxattr() could pass based on the other
security xattrs.

Mimi

> +
>  out:
>         /*
>          * File signatures on some filesystems can not be properly verified.

