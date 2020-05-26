Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000DA1CF4A2
	for <lists+linux-security-module@lfdr.de>; Tue, 12 May 2020 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgELMpK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 12 May 2020 08:45:10 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbgELMpJ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 12 May 2020 08:45:09 -0400
Received: from lhreml711-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 676DB625046369E08C65;
        Tue, 12 May 2020 13:45:07 +0100 (IST)
Received: from fraeml703-chm.china.huawei.com (10.206.15.52) by
 lhreml711-chm.china.huawei.com (10.201.108.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Tue, 12 May 2020 13:45:06 +0100
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 12 May 2020 14:45:06 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1913.007;
 Tue, 12 May 2020 14:45:06 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [bug report] evm: Check also if *tfm is an error pointer in
 init_desc()
Thread-Topic: [bug report] evm: Check also if *tfm is an error pointer in
 init_desc()
Thread-Index: AQHWKEtaMY8eDHenCUWhAoTwHpVMaaikTD1Q///07wCAACLLgA==
Date:   Tue, 12 May 2020 12:45:06 +0000
Message-ID: <7fbab163eb76459a82ebe94c577a4954@huawei.com>
References: <20200512104809.GA262740@mwanda>
 <267804d00f2e457186509a6ae40c9c7f@huawei.com> <20200512123414.GA2056@kadam>
In-Reply-To: <20200512123414.GA2056@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.12.77]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> From: owner-linux-security-module@vger.kernel.org [mailto:owner-linux-
> security-module@vger.kernel.org] On Behalf Of Dan Carpenter
> Sent: Tuesday, May 12, 2020 2:34 PM
> On Tue, May 12, 2020 at 11:31:53AM +0000, Roberto Sassu wrote:
> > > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > > Sent: Tuesday, May 12, 2020 12:48 PM
> > >
> > > Hello Roberto Sassu,
> > >
> > > The patch 53de3b080d5e: "evm: Check also if *tfm is an error pointer
> > > in init_desc()" from Apr 27, 2020, leads to the following static
> > > checker warning:
> > >
> > > 	security/integrity/evm/evm_crypto.c:119 init_desc()
> > > 	error: '*tfm' dereferencing possible ERR_PTR()
> > >
> > > security/integrity/evm/evm_crypto.c
> > >     89
> > >     90                  tfm = &evm_tfm[hash_algo];
> > >     91                  algo = hash_algo_name[hash_algo];
> > >     92          }
> > >     93
> > >     94          if (IS_ERR_OR_NULL(*tfm)) {
> > >
> > > This used to be a "if (!*tfm)" check.
> > >
> > >     95                  mutex_lock(&mutex);
> > >     96                  if (*tfm)
> > >     97                          goto out;
> > >
> > > Then we test again with the lock held.  But in the new code if "*tfm"
> > > is an error pointer then we jump directly to the unlock and crash on the
> > > next line.  I can't see how the commit would fix anything.
> >
> > Hello Dan
> >
> > you are right. The fix should be applied in both places.
> >
> > if (!IS_ERR_OR_NULL(*tfm))
> > 	goto out;
> 
> No.  I was wrong.
> 
> >
> > >     98                  *tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
> > >     99                  if (IS_ERR(*tfm)) {
> > >    100                          rc = PTR_ERR(*tfm);
> > >    101                          pr_err("Can not allocate %s (reason: %ld)\n", algo, rc);
> > >    102                          *tfm = NULL;
> > >    103                          mutex_unlock(&mutex);
> > >    104                          return ERR_PTR(rc);
> > >    105                  }
> > >    106                  if (type == EVM_XATTR_HMAC) {
> > >    107                          rc = crypto_shash_setkey(*tfm, evmkey,
> evmkey_len);
> > >    108                          if (rc) {
> > >    109                                  crypto_free_shash(*tfm);
> > >    110                                  *tfm = NULL;
> > >    111                                  mutex_unlock(&mutex);
> > >    112                                  return ERR_PTR(rc);
> > >    113                          }
> > >    114                  }
> > >    115  out:
> > >    116                  mutex_unlock(&mutex);
> > >    117          }
> > >    118
> > >    119          desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
> > >                                                                      ^^^^
> > > I don't understand how using *tfm outside of a lock is safe at all
> > > anyway.
> >
> > I think the purpose of the mutex is just to  prevent two concurrent
> > allocations. Later, it should not be a problem, as *tfm is never freed.
> >
> 
> Actually by the time we take the lock then *tfm is either valid or NULL
> so this code works.  It's confusing though.

static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
{
        return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
}

CPU#1			CPU#2
			*tfm = crypto_alloc_shash(algo, 0, CRYPTO_NOLOAD);
unlikely(!ptr)
			*tfm = NULL;
IS_ERR_VALUE((unsigned long)ptr);

desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),

Could this happen?

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
