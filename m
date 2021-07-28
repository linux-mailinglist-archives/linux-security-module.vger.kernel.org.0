Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889543D8FBA
	for <lists+linux-security-module@lfdr.de>; Wed, 28 Jul 2021 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbhG1Nxj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 28 Jul 2021 09:53:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3516 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbhG1Nrk (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 28 Jul 2021 09:47:40 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GZZMy2nnbz6GDBX;
        Wed, 28 Jul 2021 21:32:30 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Jul 2021 15:47:36 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Wed, 28 Jul 2021 15:47:36 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC][PATCH v2 02/12] diglim: Basic definitions
Thread-Topic: [RFC][PATCH v2 02/12] diglim: Basic definitions
Thread-Index: AQHXgjyicwJtnSjv/UmZEg8zsJLYTqtYIhYAgAAkorD///aRgIAAKWmw
Date:   Wed, 28 Jul 2021 13:47:36 +0000
Message-ID: <caa43f36ce764f16ba56bc38cbd43319@huawei.com>
References: <20210726163700.2092768-1-roberto.sassu@huawei.com>
        <20210726163700.2092768-3-roberto.sassu@huawei.com>
        <20210728133102.339c7b8e@coco.lan>
        <eb3b025820574f0d901a38a4ad088018@huawei.com>
 <20210728150823.705623ad@sal.lan>
In-Reply-To: <20210728150823.705623ad@sal.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> From: Mauro Carvalho Chehab [mailto:mchehab+huawei@kernel.org]
> Sent: Wednesday, July 28, 2021 3:08 PM
> Em Wed, 28 Jul 2021 11:45:02 +0000
> Roberto Sassu <roberto.sassu@huawei.com> escreveu:
> 
> > > From: Mauro Carvalho Chehab [mailto:mchehab+huawei@kernel.org]
> > > Sent: Wednesday, July 28, 2021 1:31 PM
> > > Em Mon, 26 Jul 2021 18:36:50 +0200
> > > Roberto Sassu <roberto.sassu@huawei.com> escreveu:
> > >
> 
> > > > +struct compact_list_hdr {
> > > > +	__u8 version;
> > > > +	__u8 _reserved;
> > > > +	__le16 type;
> > > > +	__le16 modifiers;
> > > > +	__le16 algo;
> > > > +	__le32 count;
> > > > +	__le32 datalen;
> > > > +} __packed;
> > > > +#endif /*_UAPI__LINUX_DIGLIM_H*/
> > >
> > > Besides Greg's notes, I'm wondering why to enforce a particular
> > > endness here. I mean, this is uAPI. I would expect it to use the
> > > CPU endianness instead, in order to avoid uneeded conversions.
> >
> > Also Greg had the same concern. I hoped the Lifecycle section clarified
> > the fact that digest lists are generated by software vendors not the
> > local system. Should I add something more in the documentation?
> 
> It shouldn't matter what kind of endness software vendors use on
> userspace (either CPU or a fixed endiannes - either LE or BE).
> 
> I mean, I won't doubt that some package tools use LE while others
> would use BE. At some point, this needs to be converted to
> CPU endiannes.

If you let digest list generators decide the endianness, probably
it is necessary to also add the endianness information in the
structure. Otherwise, the kernel wouldn't know what to do.

If the kernel knows that the digest list is always in little endian,
it simply calls le32_to_cpu().

> IMO, the best would be to isolate whatever RPM/DEB/... endianness
> is used on userspace from what the Kernel will use internally.

This is a different case. The conversion happens if the digest list
is not in native format. The kernel can also parse an untouched
digest list if it is in native format.

Thanks

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli

> Just my 2 cents.
> 
> Regards,
> Mauro
