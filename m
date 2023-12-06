Return-Path: <linux-security-module+bounces-329-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5A38069EA
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Dec 2023 09:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1415F280A65
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Dec 2023 08:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE35319BBB
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Dec 2023 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="JQDI7AsF"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFED18F;
	Tue,  5 Dec 2023 23:24:27 -0800 (PST)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id E3CE110DD0FD;
	Wed,  6 Dec 2023 10:24:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru E3CE110DD0FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1701847464; bh=KfvchKOA/sLbhIOxU2hiXLBZ5RE8gliVQJO2gD/Rrhk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=JQDI7AsFk0YKwiWEka8I3czWWmXJY4i0G27Xu0QcZKnyidvY1VeNj7k83BfO06zcp
	 nwzH9pM1ZecF05BIKM6rLiKFtGVgoSa03mHO4Pbi0Ek/ZBTjbZ0oL6FRehvMp0fnjs
	 QRssQk8v5Z3j5qTUKtOvsOgDRcwO6JfCNNsUz3BE=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id DFF7031605BA;
	Wed,  6 Dec 2023 10:24:23 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Paul Moore <paul@paul-moore.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Huw Davies <huw@codeweavers.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v2] calipso: Fix memory leak in
 netlbl_calipso_add_pass()
Thread-Topic: [PATCH net v2] calipso: Fix memory leak in
 netlbl_calipso_add_pass()
Thread-Index: AQHaKBU85mJ5ws8RUEuBSAQjhk4+cw==
Date: Wed, 6 Dec 2023 07:24:23 +0000
Message-ID: <b6410a50-df16-4087-94b9-3a6270287ae2@infotecs.ru>
References: <20231123092314.91299-1-Ilia.Gavrilov@infotecs.ru>
 <CAHC9VhQGX_22WTdZG4+K8WYQK-G21j8NM9Wy0TodgPAZk57TCQ@mail.gmail.com>
 <CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com>
In-Reply-To: <CAHC9VhTEREuTymgMW8zmQcRZCOpW8M0MZPcKto17ve5Aw1_2gg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <98E32942F6D9DF409EA1DB9C12C248B3@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2023/12/06 06:09:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/12/06 03:32:00 #22616787
X-KLMS-AntiVirus-Status: Clean, skipped

T24gMTIvNi8yMyAwMDozMSwgUGF1bCBNb29yZSB3cm90ZToNCj4gT24gU2F0LCBOb3YgMjUsIDIw
MjMgYXQgOTo0N+KAr0FNIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+IHdyb3RlOg0K
Pj4NCj4+IE9uIFRodSwgTm92IDIzLCAyMDIzIGF0IDQ6MjXigK9BTSBHYXZyaWxvdiBJbGlhIDxJ
bGlhLkdhdnJpbG92QGluZm90ZWNzLnJ1PiB3cm90ZToNCj4+Pg0KPj4+IElmIElQdjYgc3VwcG9y
dCBpcyBkaXNhYmxlZCBhdCBib290IChpcHY2LmRpc2FibGU9MSksDQo+Pj4gdGhlIGNhbGlwc29f
aW5pdCgpIC0+IG5ldGxibF9jYWxpcHNvX29wc19yZWdpc3RlcigpIGZ1bmN0aW9uIGlzbid0IGNh
bGxlZCwNCj4+PiBhbmQgdGhlIG5ldGxibF9jYWxpcHNvX29wc19nZXQoKSBmdW5jdGlvbiBhbHdh
eXMgcmV0dXJucyBOVUxMLg0KPj4+IEluIHRoaXMgY2FzZSwgdGhlIG5ldGxibF9jYWxpcHNvX2Fk
ZF9wYXNzKCkgZnVuY3Rpb24gYWxsb2NhdGVzIG1lbW9yeQ0KPj4+IGZvciB0aGUgZG9pX2RlZiB2
YXJpYWJsZSBidXQgZG9lc24ndCBmcmVlIGl0IHdpdGggdGhlIGNhbGlwc29fZG9pX2ZyZWUoKS4N
Cj4+Pg0KPj4+IEJVRzogbWVtb3J5IGxlYWsNCj4+PiB1bnJlZmVyZW5jZWQgb2JqZWN0IDB4ZmZm
Zjg4ODAxMWQ2ODE4MCAoc2l6ZSA2NCk6DQo+Pj4gICAgY29tbSAic3l6LWV4ZWN1dG9yLjEiLCBw
aWQgMTA3NDYsIGppZmZpZXMgNDI5NTQxMDk4NiAoYWdlIDE3LjkyOHMpDQo+Pj4gICAgaGV4IGR1
bXAgKGZpcnN0IDMyIGJ5dGVzKToNCj4+PiAgICAgIDAwIDAwIDAwIDAwIDAyIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uDQo+Pj4gICAgICAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4u
Lg0KPj4+ICAgIGJhY2t0cmFjZToNCj4+PiAgICAgIFs8MDAwMDAwMDA3MzBkODc3MD5dIGttYWxs
b2MgaW5jbHVkZS9saW51eC9zbGFiLmg6NTUyIFtpbmxpbmVdDQo+Pj4gICAgICBbPDAwMDAwMDAw
NzMwZDg3NzA+XSBuZXRsYmxfY2FsaXBzb19hZGRfcGFzcyBuZXQvbmV0bGFiZWwvbmV0bGFiZWxf
Y2FsaXBzby5jOjc2IFtpbmxpbmVdDQo+Pj4gICAgICBbPDAwMDAwMDAwNzMwZDg3NzA+XSBuZXRs
YmxfY2FsaXBzb19hZGQrMHgyMmUvMHg0ZjAgbmV0L25ldGxhYmVsL25ldGxhYmVsX2NhbGlwc28u
YzoxMTENCj4+PiAgICAgIFs8MDAwMDAwMDAwMmU2NjJjMD5dIGdlbmxfZmFtaWx5X3Jjdl9tc2df
ZG9pdCsweDIyZi8weDMzMCBuZXQvbmV0bGluay9nZW5ldGxpbmsuYzo3MzkNCj4+PiAgICAgIFs8
MDAwMDAwMDBhMDhkNmQ3ND5dIGdlbmxfZmFtaWx5X3Jjdl9tc2cgbmV0L25ldGxpbmsvZ2VuZXRs
aW5rLmM6NzgzIFtpbmxpbmVdDQo+Pj4gICAgICBbPDAwMDAwMDAwYTA4ZDZkNzQ+XSBnZW5sX3Jj
dl9tc2crMHgzNDEvMHg1YTAgbmV0L25ldGxpbmsvZ2VuZXRsaW5rLmM6ODAwDQo+Pj4gICAgICBb
PDAwMDAwMDAwOTgzOTlhOTc+XSBuZXRsaW5rX3Jjdl9za2IrMHgxNGQvMHg0NDAgbmV0L25ldGxp
bmsvYWZfbmV0bGluay5jOjI1MTUNCj4+PiAgICAgIFs8MDAwMDAwMDBmZjdkYjgzYj5dIGdlbmxf
cmN2KzB4MjkvMHg0MCBuZXQvbmV0bGluay9nZW5ldGxpbmsuYzo4MTENCj4+PiAgICAgIFs8MDAw
MDAwMDAwY2Y1M2I4Yz5dIG5ldGxpbmtfdW5pY2FzdF9rZXJuZWwgbmV0L25ldGxpbmsvYWZfbmV0
bGluay5jOjEzMTMgW2lubGluZV0NCj4+PiAgICAgIFs8MDAwMDAwMDAwY2Y1M2I4Yz5dIG5ldGxp
bmtfdW5pY2FzdCsweDU0Yi8weDgwMCBuZXQvbmV0bGluay9hZl9uZXRsaW5rLmM6MTMzOQ0KPj4+
ICAgICAgWzwwMDAwMDAwMGQ3OGNkMzhiPl0gbmV0bGlua19zZW5kbXNnKzB4OTBhLzB4ZGYwIG5l
dC9uZXRsaW5rL2FmX25ldGxpbmsuYzoxOTM0DQo+Pj4gICAgICBbPDAwMDAwMDAwODMyOGE1N2Y+
XSBzb2NrX3NlbmRtc2dfbm9zZWMgbmV0L3NvY2tldC5jOjY1MSBbaW5saW5lXQ0KPj4+ICAgICAg
WzwwMDAwMDAwMDgzMjhhNTdmPl0gc29ja19zZW5kbXNnKzB4MTU3LzB4MTkwIG5ldC9zb2NrZXQu
Yzo2NzENCj4+PiAgICAgIFs8MDAwMDAwMDA3YjY1YTFiNT5dIF9fX19zeXNfc2VuZG1zZysweDcx
Mi8weDg3MCBuZXQvc29ja2V0LmM6MjM0Mg0KPj4+ICAgICAgWzwwMDAwMDAwMDgzZGE4MDBlPl0g
X19fc3lzX3NlbmRtc2crMHhmOC8weDE3MCBuZXQvc29ja2V0LmM6MjM5Ng0KPj4+ICAgICAgWzww
MDAwMDAwMDRhOWI4MjdmPl0gX19zeXNfc2VuZG1zZysweGVhLzB4MWIwIG5ldC9zb2NrZXQuYzoy
NDI5DQo+Pj4gICAgICBbPDAwMDAwMDAwNjFiNjRkM2E+XSBkb19zeXNjYWxsXzY0KzB4MzAvMHg0
MCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzo0Ng0KPj4+ICAgICAgWzwwMDAwMDAwMGExMjY1MzQ3
Pl0gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NjEvMHhjNg0KPj4+DQo+Pj4gRm91
bmQgYnkgSW5mb1RlQ1Mgb24gYmVoYWxmIG9mIExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXINCj4+
PiAobGludXh0ZXN0aW5nLm9yZykgd2l0aCBTeXprYWxsZXINCj4+Pg0KPj4+IEZpeGVzOiBjYjcy
ZDM4MjExZWEgKCJuZXRsYWJlbDogSW5pdGlhbCBzdXBwb3J0IGZvciB0aGUgQ0FMSVBTTyBuZXRs
aW5rIHByb3RvY29sLiIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogR2F2cmlsb3YgSWxpYSA8SWxpYS5H
YXZyaWxvdkBpbmZvdGVjcy5ydT4NCj4+PiAtLS0NCj4+PiB2MjoNCj4+PiAgICAtIHJldHVybiB0
aGUgZXJyb3IgY29kZSBpbiBuZXRsYmxfY2FsaXBzb19hZGQoKSBpZiB0aGUgdmFyaWFibGUgY2Fs
aXBzb19ob3BzIGlzIE5VTEwNCj4+PiB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjMxMTIyMTM1MjQyLjI3NzkwNTgtMS1JbGlhLkdhdnJpbG92QGluZm90ZWNzLnJ1Lw0KPj4+DQo+
Pj4gICBuZXQvbmV0bGFiZWwvbmV0bGFiZWxfY2FsaXBzby5jIHwgNDkgKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygr
KSwgMjMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gVGhpcyBsb29rcyBnb29kIHRvIG1lLCB0aGFua3Mh
DQo+Pg0KPj4gQWNrZWQtYnk6IFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1tb29yZS5jb20+DQo+IA0K
PiBBIHF1aWNrIGZvbGxvdy11cCB0byBzZWUgaWYgdGhpcyBwYXRjaCB3YXMgcGlja2VkIHVwIGJ5
IHRoZSBuZXR3b3JraW5nDQo+IGZvbGtzPyAgSSBkaWRuJ3QgZ2V0IGEgcGF0Y2h3b3JrIG5vdGlm
aWNhdGlvbiwgYW5kIEkgZG9uJ3Qgc2VlIGl0IGluDQo+IExpbnVzJyB0cmVlLCBidXQgcGVyaGFw
cyBJIG1pc3NlZCBzb21ldGhpbmc/DQo+IA0KDQpJIG9ubHkgc2VlIHRoYW4gdGhlIHBhdGNoIGlz
IGluIHRoZSAiTm90IEFwcGxpY2FibGUiIHN0YXRlIGluIHBhdGNod29yay4NCg0K

