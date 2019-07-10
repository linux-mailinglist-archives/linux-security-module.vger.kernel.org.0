Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDEC61EA2
	for <lists+linux-security-module@lfdr.de>; Mon,  8 Jul 2019 14:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfGHMmT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 8 Jul 2019 08:42:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50850 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbfGHMmT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jul 2019 08:42:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-230-dcsia1rtNYyT8xw3SipVDQ-1; Mon, 08 Jul 2019 13:42:16 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 8 Jul 2019 13:42:15 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Jul 2019 13:42:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Salvatore Mesoraca' <s.mesoraca16@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        "Casey Schaufler" <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        "Kees Cook" <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v5 06/12] S.A.R.A.: WX protection
Thread-Topic: [PATCH v5 06/12] S.A.R.A.: WX protection
Thread-Index: AQHVM+lhx/3G+gwH+UeGA1TJk0kwgabAq9yQ
Date:   Mon, 8 Jul 2019 12:42:15 +0000
Message-ID: <b946dd861874401a910740a9adea8e8e@AcuMS.aculab.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-7-git-send-email-s.mesoraca16@gmail.com>
In-Reply-To: <1562410493-8661-7-git-send-email-s.mesoraca16@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: dcsia1rtNYyT8xw3SipVDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

From: Salvatore Mesoraca
> Sent: 06 July 2019 11:55
...
> Executable MMAP prevention works by preventing any new executable
> allocation after the dynamic libraries have been loaded. It works under the
> assumption that, when the dynamic libraries have been finished loading, the
> RELRO section will be marked read only.

What about writing to the file of a dynamic library after it is loaded
but before it is faulted it (or after evicting it from the I$).

...
> +#define find_relro_section(ELFH, ELFP, FILE, RELRO, FOUND) do {		\
> +	unsigned long i;						\
> +	int _tmp;							\
> +	loff_t _pos = 0;						\
> +	if (ELFH.e_type == ET_DYN || ELFH.e_type == ET_EXEC) {		\
> +		for (i = 0; i < ELFH.e_phnum; ++i) {			\
> +			_pos = ELFH.e_phoff + i*sizeof(ELFP);		\
> +			_tmp = kernel_read(FILE, &ELFP, sizeof(ELFP),	\
> +					   &_pos);			\
> +			if (_tmp != sizeof(ELFP))			\
> +				break;					\
> +			if (ELFP.p_type == PT_GNU_RELRO) {		\
> +				RELRO = ELFP.p_offset >> PAGE_SHIFT;	\
> +				FOUND = true;				\
> +				break;					\
> +			}						\
> +		}							\
> +	}								\
> +} while (0)

This is big for a #define.
Since it contains kernel_read() it can't really matter if it is
a real function.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

