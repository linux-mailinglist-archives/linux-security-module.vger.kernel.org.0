Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F6743C5BD
	for <lists+linux-security-module@lfdr.de>; Wed, 27 Oct 2021 10:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbhJ0I6u (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 27 Oct 2021 04:58:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4032 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbhJ0I6q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 27 Oct 2021 04:58:46 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HfMsW49s4z67lnr;
        Wed, 27 Oct 2021 16:53:03 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 27 Oct 2021 10:56:17 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2308.015;
 Wed, 27 Oct 2021 10:56:17 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Deven Bowers <deven.desai@linux.microsoft.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>
CC:     "jannh@google.com" <jannh@google.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: RE: [RFC PATCH v7 05/16] ipe: add LSM hooks on execution and kernel
 read
Thread-Topic: [RFC PATCH v7 05/16] ipe: add LSM hooks on execution and kernel
 read
Thread-Index: AQHXwGWOuRcjToK/XkWwstEqYzOChavjssvQgAHjQYCAAQnVkA==
Date:   Wed, 27 Oct 2021 08:56:17 +0000
Message-ID: <150763b55a6f48b78e73d91442a9aa7e@huawei.com>
References: <1634151995-16266-1-git-send-email-deven.desai@linux.microsoft.com>
 <1634151995-16266-6-git-send-email-deven.desai@linux.microsoft.com>
 <d4f1875866f649fe9e24915159a71361@huawei.com>
 <1bc16f72-6793-2383-1874-a98f4e2b2691@linux.microsoft.com>
In-Reply-To: <1bc16f72-6793-2383-1874-a98f4e2b2691@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiBGcm9tOiBEZXZlbiBCb3dlcnMgW21haWx0bzpkZXZlbi5kZXNhaUBsaW51eC5taWNyb3NvZnQu
Y29tXQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI2LCAyMDIxIDk6MDQgUE0NCj4gT24gMTAv
MjUvMjAyMSA1OjIyIEFNLCBSb2JlcnRvIFNhc3N1IHdyb3RlOg0KPiA+PiBGcm9tOmRldmVuLmRl
c2FpQGxpbnV4Lm1pY3Jvc29mdC5jb20NCj4gPj4gW21haWx0bzpkZXZlbi5kZXNhaUBsaW51eC5t
aWNyb3NvZnQuY29tXQ0KPiA+PiBGcm9tOiBEZXZlbiBCb3dlcnM8ZGV2ZW4uZGVzYWlAbGludXgu
bWljcm9zb2Z0LmNvbT4NCj4gPj4NCj4gPj4gSVBFJ3MgaW5pdGlhbCBnb2FsIGlzIHRvIGNvbnRy
b2wgYm90aCBleGVjdXRpb24gYW5kIHRoZSBsb2FkaW5nIG9mDQo+ID4+IGtlcm5lbCBtb2R1bGVz
IGJhc2VkIG9uIHRoZSBzeXN0ZW0ncyBkZWZpbml0aW9uIG9mIHRydXN0LiBJdA0KPiA+PiBhY2Nv
bXBsaXNoZXMgdGhpcyBieSBwbHVnZ2luZyBpbnRvIHRoZSBzZWN1cml0eSBob29rcyBmb3IgZXhl
Y3ZlLA0KPiA+PiBtcHJvdGVjdCwgbW1hcCwga2VybmVsX2xvYWRfZGF0YSBhbmQga2VybmVsX3Jl
YWRfZGF0YS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogRGV2ZW4gQm93ZXJzPGRldmVuLmRl
c2FpQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+ID4+IC0tLQ0KPiA+Pg0KPiA+PiBSZWxldmFudCBj
aGFuZ2VzIHNpbmNlIHY2Og0KPiA+PiAgICAqIFNwbGl0IHVwIHBhdGNoIDAyLzEyIGludG8gZm91
ciBwYXJ0czoNCj4gPj4gICAgICAgIDEuIGNvbnRleHQgY3JlYXRpb24gWzAxLzE2XQ0KPiA+PiAg
ICAgICAgMi4gYXVkaXQgWzA3LzE2XQ0KPiA+PiAgICAgICAgMy4gZXZhbHVhdGlvbiBsb29wIFsw
My8xNl0NCj4gPj4gICAgICAgIDQuIGFjY2VzcyBjb250cm9sIGhvb2tzIFswNS8xNl0gKHRoaXMg
cGF0Y2gpDQo+ID4+DQo+ID4+IC0tLQ0KPiA+PiAgIHNlY3VyaXR5L2lwZS9ob29rcy5jICB8IDE0
OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPj4gICBz
ZWN1cml0eS9pcGUvaG9va3MuaCAgfCAgMjMgKysrKysrLQ0KPiA+PiAgIHNlY3VyaXR5L2lwZS9p
cGUuYyAgICB8ICAgNSArKw0KPiA+PiAgIHNlY3VyaXR5L2lwZS9wb2xpY3kuYyB8ICAyMyArKysr
KysrDQo+ID4+ICAgc2VjdXJpdHkvaXBlL3BvbGljeS5oIHwgIDEyICsrKy0NCj4gPj4gICA1IGZp
bGVzIGNoYW5nZWQsIDIwOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+
PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaXBlL2hvb2tzLmMgYi9zZWN1cml0eS9pcGUvaG9va3Mu
Yw0KPiA+PiBpbmRleCBlZDBjODg2ZWFhNWEuLjIxNjI0MjQwOGE4MCAxMDA2NDQNCj4gPj4gLS0t
IGEvc2VjdXJpdHkvaXBlL2hvb2tzLmMNCj4gPj4gKysrIGIvc2VjdXJpdHkvaXBlL2hvb2tzLmMN
Cj4gPj4gQEAgLTYsMTEgKzYsMTUgQEANCj4gPj4gICAjaW5jbHVkZSAiaXBlLmgiDQo+ID4+ICAg
I2luY2x1ZGUgImN0eC5oIg0KPiA+PiAgICNpbmNsdWRlICJob29rcy5oIg0KPiA+PiArI2luY2x1
ZGUgImV2YWwuaCINCj4gPj4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9mcy5oPg0KPiA+PiAgICNp
bmNsdWRlIDxsaW51eC9zY2hlZC5oPg0KPiA+PiAgICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0K
PiA+PiAgICNpbmNsdWRlIDxsaW51eC9yZWZjb3VudC5oPg0KPiA+PiAgICNpbmNsdWRlIDxsaW51
eC9yY3VwZGF0ZS5oPg0KPiA+PiArI2luY2x1ZGUgPGxpbnV4L2JpbmZtdHMuaD4NCj4gPj4gKyNp
bmNsdWRlIDxsaW51eC9tbWFuLmg+DQo+ID4+DQo+ID4+ICAgLyoqDQo+ID4+ICAgICogaXBlX3Rh
c2tfYWxsb2M6IEFzc2lnbiBhIG5ldyBjb250ZXh0IGZvciBhbiBhc3NvY2lhdGVkIHRhc2sgc3Ry
dWN0dXJlLg0KPiA+PiBAQCAtNTYsMyArNjAsMTQ4IEBAIHZvaWQgaXBlX3Rhc2tfZnJlZShzdHJ1
Y3QgdGFza19zdHJ1Y3QgKnRhc2spDQo+ID4+ICAgCWlwZV9wdXRfY3R4KGN0eCk7DQo+ID4+ICAg
CXJjdV9yZWFkX3VubG9jaygpOw0KPiA+PiAgIH0NCj4gPj4gKw0KPiA+PiArLyoqDQo+ID4+ICsg
KiBpcGVfb25fZXhlYzogTFNNIGhvb2sgY2FsbGVkIHdoZW4gYSBwcm9jZXNzIGlzIGxvYWRlZCB0
aHJvdWdoIHRoZSBleGVjDQo+ID4+ICsgKgkJZmFtaWx5IG9mIHN5c3RlbSBjYWxscy4NCj4gPj4g
KyAqIEBicHJtOiBTdXBwbGllcyBhIHBvaW50ZXIgdG8gYSBsaW51eF9iaW5wcm0gc3RydWN0dXJl
IHRvIHNvdXJjZSB0aGUgZmlsZQ0KPiA+PiArICoJICBiZWluZyBldmFsdWF0ZWQuDQo+ID4+ICsg
Kg0KPiA+PiArICogUmV0dXJuOg0KPiA+PiArICogMCAtIE9LDQo+ID4+ICsgKiAhMCAtIEVycm9y
DQo+ID4+ICsgKi8NCj4gPj4gK2ludCBpcGVfb25fZXhlYyhzdHJ1Y3QgbGludXhfYmlucHJtICpi
cHJtKQ0KPiA+PiArew0KPiA+PiArCXJldHVybiBpcGVfcHJvY2Vzc19ldmVudChicHJtLT5maWxl
LCBpcGVfb3BlcmF0aW9uX2V4ZWMsDQo+ID4+IGlwZV9ob29rX2V4ZWMpOw0KPiA+PiArfQ0KPiA+
PiArDQo+ID4+ICsvKioNCj4gPj4gKyAqIGlwZV9vbl9tbWFwOiBMU00gaG9vayBjYWxsZWQgd2hl
biBhIGZpbGUgaXMgbG9hZGVkIHRocm91Z2ggdGhlIG1tYXANCj4gPj4gKyAqCQlmYW1pbHkgb2Yg
c3lzdGVtIGNhbGxzLg0KPiA+PiArICogQGY6IEZpbGUgYmVpbmcgbW1hcCdkLiBDYW4gYmUgTlVM
TCBpbiB0aGUgY2FzZSBvZiBhbm9ueW1vdXMgbWVtb3J5Lg0KPiA+PiArICogQHJlcXByb3Q6IFRo
ZSByZXF1ZXN0ZWQgcHJvdGVjdGlvbiBvbiB0aGUgbW1hcCwgcGFzc2VkIGZyb20NCj4gdXNlcm1v
ZGUuDQo+ID4+ICsgKiBAcHJvdDogVGhlIGVmZmVjdGl2ZSBwcm90ZWN0aW9uIG9uIHRoZSBtbWFw
LCByZXNvbHZlZCBmcm9tIHJlcXByb3QgYW5kDQo+ID4+ICsgKgkgIHN5c3RlbSBjb25maWd1cmF0
aW9uLg0KPiA+PiArICogQGZsYWdzOiBVbnVzZWQuDQo+ID4+ICsgKg0KPiA+PiArICogUmV0dXJu
Og0KPiA+PiArICogMCAtIE9LDQo+ID4+ICsgKiAhMCAtIEVycm9yDQo+ID4+ICsgKi8NCj4gPj4g
K2ludCBpcGVfb25fbW1hcChzdHJ1Y3QgZmlsZSAqZiwgdW5zaWduZWQgbG9uZyByZXFwcm90LCB1
bnNpZ25lZCBsb25nIHByb3QsDQo+ID4+ICsJCXVuc2lnbmVkIGxvbmcgZmxhZ3MpDQo+ID4+ICt7
DQo+ID4+ICsJaWYgKHByb3QgJiBQUk9UX0VYRUMgfHwgcmVxcHJvdCAmIFBST1RfRVhFQykNCj4g
Pj4gKwkJcmV0dXJuIGlwZV9wcm9jZXNzX2V2ZW50KGYsIGlwZV9vcGVyYXRpb25fZXhlYywNCj4g
Pj4gaXBlX2hvb2tfbW1hcCk7DQo+ID4+ICsNCj4gPj4gKwlyZXR1cm4gMDsNCj4gPj4gK30NCj4g
Pj4gKw0KPiA+PiArLyoqDQo+ID4+ICsgKiBpcGVfb25fbXByb3RlY3Q6IExTTSBob29rIGNhbGxl
ZCB3aGVuIGEgbW1hcCdkIHJlZ2lvbiBvZiBtZW1vcnkgaXMNCj4gPj4gY2hhbmdpbmcNCj4gPj4g
KyAqCQkgICAgaXRzIHByb3RlY3Rpb25zIHZpYSBtcHJvdGVjdC4NCj4gPj4gKyAqIEB2bWE6IEV4
aXN0aW5nIHZpcnR1YWwgbWVtb3J5IGFyZWEgY3JlYXRlZCBieSBtbWFwIG9yIHNpbWlsYXINCj4g
Pj4gKyAqIEByZXFwcm90OiBUaGUgcmVxdWVzdGVkIHByb3RlY3Rpb24gb24gdGhlIG1tYXAsIHBh
c3NlZCBmcm9tDQo+IHVzZXJtb2RlLg0KPiA+PiArICogQHByb3Q6IFRoZSBlZmZlY3RpdmUgcHJv
dGVjdGlvbiBvbiB0aGUgbW1hcCwgcmVzb2x2ZWQgZnJvbSByZXFwcm90IGFuZA0KPiA+PiArICoJ
ICBzeXN0ZW0gY29uZmlndXJhdGlvbi4NCj4gPj4gKyAqDQo+ID4+ICsgKiBSZXR1cm46DQo+ID4+
ICsgKiAwIC0gT0sNCj4gPj4gKyAqICEwIC0gRXJyb3INCj4gPj4gKyAqLw0KPiA+PiAraW50IGlw
ZV9vbl9tcHJvdGVjdChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyBy
ZXFwcm90LA0KPiA+PiArCQkgICAgdW5zaWduZWQgbG9uZyBwcm90KQ0KPiA+PiArew0KPiA+PiAr
CS8qIEFscmVhZHkgRXhlY3V0YWJsZSAqLw0KPiA+PiArCWlmICh2bWEtPnZtX2ZsYWdzICYgVk1f
RVhFQykNCj4gPj4gKwkJcmV0dXJuIDA7DQo+ID4+ICsNCj4gPj4gKwlpZiAoKChwcm90ICYgUFJP
VF9FWEVDKSB8fCByZXFwcm90ICYgUFJPVF9FWEVDKSkNCj4gPj4gKwkJcmV0dXJuIGlwZV9wcm9j
ZXNzX2V2ZW50KHZtYS0+dm1fZmlsZSwgaXBlX29wZXJhdGlvbl9leGVjLA0KPiA+PiArCQkJCQkg
aXBlX2hvb2tfbXByb3RlY3QpOw0KPiA+PiArDQo+ID4+ICsJcmV0dXJuIDA7DQo+ID4+ICt9DQo+
ID4+ICsNCj4gPj4gKy8qKg0KPiA+PiArICogaXBlX29uX2tlcm5lbF9yZWFkOiBMU00gaG9vayBj
YWxsZWQgd2hlbiBhIGZpbGUgaXMgYmVpbmcgcmVhZCBpbiBmcm9tDQo+ID4+ICsgKgkJICAgICAg
IGRpc2suDQo+ID4+ICsgKiBAZmlsZTogU3VwcGxpZXMgYSBwb2ludGVyIHRvIHRoZSBmaWxlIHN0
cnVjdHVyZSBiZWluZyByZWFkIGluIGZyb20gZGlzaw0KPiA+PiArICogQGlkOiBTdXBwbGllcyB0
aGUgZW51bWVyYXRpb24gaWRlbnRpZnlpbmcgdGhlIHB1cnBvc2Ugb2YgdGhlIHJlYWQuDQo+ID4+
ICsgKiBAY29udGVudHM6IFVudXNlZC4NCj4gPj4gKyAqDQo+ID4+ICsgKiBSZXR1cm46DQo+ID4+
ICsgKiAwIC0gT0sNCj4gPj4gKyAqICEwIC0gRXJyb3INCj4gPj4gKyAqLw0KPiA+PiAraW50IGlw
ZV9vbl9rZXJuZWxfcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwgZW51bSBrZXJuZWxfcmVhZF9maWxl
X2lkIGlkLA0KPiA+PiArCQkgICAgICAgYm9vbCBjb250ZW50cykNCj4gPj4gK3sNCj4gPj4gKwll
bnVtIGlwZV9vcGVyYXRpb24gb3A7DQo+ID4+ICsNCj4gPj4gKwlzd2l0Y2ggKGlkKSB7DQo+ID4+
ICsJY2FzZSBSRUFESU5HX0ZJUk1XQVJFOg0KPiA+PiArCQlvcCA9IGlwZV9vcGVyYXRpb25fZmly
bXdhcmU7DQo+ID4+ICsJCWJyZWFrOw0KPiA+PiArCWNhc2UgUkVBRElOR19NT0RVTEU6DQo+ID4+
ICsJCW9wID0gaXBlX29wZXJhdGlvbl9rZXJuZWxfbW9kdWxlOw0KPiA+PiArCQlicmVhazsNCj4g
Pj4gKwljYXNlIFJFQURJTkdfS0VYRUNfSU5JVFJBTUZTOg0KPiA+PiArCQlvcCA9IGlwZV9vcGVy
YXRpb25fa2V4ZWNfaW5pdHJhbWZzOw0KPiA+PiArCQlicmVhazsNCj4gPj4gKwljYXNlIFJFQURJ
TkdfS0VYRUNfSU1BR0U6DQo+ID4+ICsJCW9wID0gaXBlX29wZXJhdGlvbl9rZXhlY19pbWFnZTsN
Cj4gPj4gKwkJYnJlYWs7DQo+ID4+ICsJY2FzZSBSRUFESU5HX1BPTElDWToNCj4gPj4gKwkJb3Ag
PSBpcGVfb3BlcmF0aW9uX2ltYV9wb2xpY3k7DQo+ID4+ICsJCWJyZWFrOw0KPiA+PiArCWNhc2Ug
UkVBRElOR19YNTA5X0NFUlRJRklDQVRFOg0KPiA+PiArCQlvcCA9IGlwZV9vcGVyYXRpb25faW1h
X3g1MDk7DQo+ID4+ICsJCWJyZWFrOw0KPiA+PiArCWRlZmF1bHQ6DQo+ID4+ICsJCW9wID0gaXBl
X29wZXJhdGlvbl9tYXg7DQo+ID4gUG9zc2libGUgcHJvYmxlbSBoZXJlLiBJZiBzb21lb25lIChs
aWtlIG1lKSBhZGRzIGEgbmV3IGZpbGUgdHlwZQ0KPiA+IGFuZCBmb3JnZXRzIHRvIGFkZCBhIGNh
c2UsIHRoZXJlIHdpbGwgYmUgYW4gb3V0IG9mIGJvdW5kIGFjY2Vzcw0KPiA+IGluIGV2YWx1YXRl
KCk6DQo+ID4NCj4gPiAgICAgICAgICBydWxlcyA9ICZwb2wtPnBhcnNlZC0+cnVsZXNbY3R4LT5v
cF07DQo+ID4NCj4gPiBkdWUgdG8gdGhlIHN0YXRpYyBkZWZpbml0aW9uIG9mIHRoZSBydWxlcyBh
cnJheSBpbiB0aGUgaXBlX3BhcnNlZF9wb2xpY3kNCj4gPiBzdHJ1Y3R1cmUgKGFycmF5IGxlbmd0
aDogaXBlX29wZXJhdGlvbl9tYXgpLg0KPiANCj4gWWVhaCwgdGhhdCdzIGEgcHJvYmxlbS4gSSBj
YW4gZml4IHRoaXMgZG93biBpbiB0aGUgZXZhbCBsb29wIGJ5IG1hdGNoaW5nDQo+IHRoZSBnbG9i
YWwgZGVmYXVsdCBhbmQgZW1pdHRpbmcgYSBXQVJOIGhlcmUuDQoNCk9rLCB3aWxsIGRvIGEgdGVz
dCB3aXRoIHlvdXIgbmV3IHZlcnNpb24gb2YgdGhlIHBhdGNoIHNldC4NCg0KVGhhbmtzDQoNClJv
YmVydG8NCg0KSFVBV0VJIFRFQ0hOT0xPR0lFUyBEdWVzc2VsZG9yZiBHbWJILCBIUkIgNTYwNjMN
Ck1hbmFnaW5nIERpcmVjdG9yOiBMaSBQZW5nLCBaaG9uZyBSb25naHVhDQoNCj4gPiBSb2JlcnRv
DQo+ID4NCj4gPiBIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2
Mw0KPiA+IE1hbmFnaW5nIERpcmVjdG9yOiBMaSBQZW5nLCBaaG9uZyBSb25naHVhDQo+ID4NCj4g
Pj4gKwl9DQo+ID4+ICsNCj4gPj4gKwlyZXR1cm4gaXBlX3Byb2Nlc3NfZXZlbnQoZmlsZSwgb3As
IGlwZV9ob29rX2tlcm5lbF9yZWFkKTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiArLyoqDQo+ID4+
ICsgKiBpcGVfb25fa2VybmVsX2xvYWRfZGF0YTogTFNNIGhvb2sgY2FsbGVkIHdoZW4gYSBidWZm
ZXIgaXMgYmVpbmcgcmVhZCBpbg0KPiA+PiBmcm9tDQo+ID4+ICsgKgkJCSAgICBkaXNrLg0KPiA+
PiArICogQGlkOiBTdXBwbGllcyB0aGUgZW51bWVyYXRpb24gaWRlbnRpZnlpbmcgdGhlIHB1cnBv
c2Ugb2YgdGhlIHJlYWQuDQo+ID4+ICsgKiBAY29udGVudHM6IFVudXNlZC4NCj4gPj4gKyAqDQo+
ID4+ICsgKiBSZXR1cm46DQo+ID4+ICsgKiAwIC0gT0sNCj4gPj4gKyAqICEwIC0gRXJyb3INCj4g
Pj4gKyAqLw0KPiA+PiAraW50IGlwZV9vbl9rZXJuZWxfbG9hZF9kYXRhKGVudW0ga2VybmVsX2xv
YWRfZGF0YV9pZCBpZCwgYm9vbCBjb250ZW50cykNCj4gPj4gK3sNCj4gPj4gKwllbnVtIGlwZV9v
cGVyYXRpb24gb3A7DQo+ID4+ICsNCj4gPj4gKwlzd2l0Y2ggKGlkKSB7DQo+ID4+ICsJY2FzZSBM
T0FESU5HX0ZJUk1XQVJFOg0KPiA+PiArCQlvcCA9IGlwZV9vcGVyYXRpb25fZmlybXdhcmU7DQo+
ID4+ICsJCWJyZWFrOw0KPiA+PiArCWNhc2UgTE9BRElOR19NT0RVTEU6DQo+ID4+ICsJCW9wID0g
aXBlX29wZXJhdGlvbl9rZXJuZWxfbW9kdWxlOw0KPiA+PiArCQlicmVhazsNCj4gPj4gKwljYXNl
IExPQURJTkdfS0VYRUNfSU5JVFJBTUZTOg0KPiA+PiArCQlvcCA9IGlwZV9vcGVyYXRpb25fa2V4
ZWNfaW5pdHJhbWZzOw0KPiA+PiArCQlicmVhazsNCj4gPj4gKwljYXNlIExPQURJTkdfS0VYRUNf
SU1BR0U6DQo+ID4+ICsJCW9wID0gaXBlX29wZXJhdGlvbl9rZXhlY19pbWFnZTsNCj4gPj4gKwkJ
YnJlYWs7DQo+ID4+ICsJY2FzZSBMT0FESU5HX1BPTElDWToNCj4gPj4gKwkJb3AgPSBpcGVfb3Bl
cmF0aW9uX2ltYV9wb2xpY3k7DQo+ID4+ICsJCWJyZWFrOw0KPiA+PiArCWNhc2UgTE9BRElOR19Y
NTA5X0NFUlRJRklDQVRFOg0KPiA+PiArCQlvcCA9IGlwZV9vcGVyYXRpb25faW1hX3g1MDk7DQo+
ID4+ICsJCWJyZWFrOw0KPiA+PiArCWRlZmF1bHQ6DQo+ID4+ICsJCW9wID0gaXBlX29wZXJhdGlv
bl9tYXg7DQo+ID4+ICsJfQ0KPiA+PiArDQo+ID4+ICsJcmV0dXJuIGlwZV9wcm9jZXNzX2V2ZW50
KE5VTEwsIG9wLCBpcGVfaG9va19rZXJuZWxfbG9hZCk7DQo+ID4+ICt9DQo+ID4+IGRpZmYgLS1n
aXQgYS9zZWN1cml0eS9pcGUvaG9va3MuaCBiL3NlY3VyaXR5L2lwZS9ob29rcy5oDQo+ID4+IGlu
ZGV4IDU4ZWQ0YTYxMmUyNi4uYzk5YTBiN2Y0NWY3IDEwMDY0NA0KPiA+PiAtLS0gYS9zZWN1cml0
eS9pcGUvaG9va3MuaA0KPiA+PiArKysgYi9zZWN1cml0eS9pcGUvaG9va3MuaA0KPiA+PiBAQCAt
NSwxMSArNSwxOSBAQA0KPiA+PiAgICNpZm5kZWYgSVBFX0hPT0tTX0gNCj4gPj4gICAjZGVmaW5l
IElQRV9IT09LU19IDQo+ID4+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvZnMuaD4NCj4gPj4gICAj
aW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gPj4gICAjaW5jbHVkZSA8bGludXgvc2NoZWQuaD4N
Cj4gPj4gKyNpbmNsdWRlIDxsaW51eC9iaW5mbXRzLmg+DQo+ID4+ICsjaW5jbHVkZSA8bGludXgv
c2VjdXJpdHkuaD4NCj4gPj4NCj4gPj4gICBlbnVtIGlwZV9ob29rIHsNCj4gPj4gLQlpcGVfaG9v
a19tYXggPSAwDQo+ID4+ICsJaXBlX2hvb2tfZXhlYyA9IDAsDQo+ID4+ICsJaXBlX2hvb2tfbW1h
cCwNCj4gPj4gKwlpcGVfaG9va19tcHJvdGVjdCwNCj4gPj4gKwlpcGVfaG9va19rZXJuZWxfcmVh
ZCwNCj4gPj4gKwlpcGVfaG9va19rZXJuZWxfbG9hZCwNCj4gPj4gKwlpcGVfaG9va19tYXgNCj4g
Pj4gICB9Ow0KPiA+Pg0KPiA+PiAgIGludCBpcGVfdGFza19hbGxvYyhzdHJ1Y3QgdGFza19zdHJ1
Y3QgKnRhc2ssDQo+ID4+IEBAIC0xNyw0ICsyNSwxNyBAQCBpbnQgaXBlX3Rhc2tfYWxsb2Moc3Ry
dWN0IHRhc2tfc3RydWN0ICp0YXNrLA0KPiA+Pg0KPiA+PiAgIHZvaWQgaXBlX3Rhc2tfZnJlZShz
dHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2spOw0KPiA+Pg0KPiA+PiAraW50IGlwZV9vbl9leGVjKHN0
cnVjdCBsaW51eF9iaW5wcm0gKmJwcm0pOw0KPiA+PiArDQo+ID4+ICtpbnQgaXBlX29uX21tYXAo
c3RydWN0IGZpbGUgKmYsIHVuc2lnbmVkIGxvbmcgcmVxcHJvdCwgdW5zaWduZWQgbG9uZyBwcm90
LA0KPiA+PiArCQl1bnNpZ25lZCBsb25nIGZsYWdzKTsNCj4gPj4gKw0KPiA+PiAraW50IGlwZV9v
bl9tcHJvdGVjdChzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgbG9uZyByZXFw
cm90LA0KPiA+PiArCQkgICAgdW5zaWduZWQgbG9uZyBwcm90KTsNCj4gPj4gKw0KPiA+PiAraW50
IGlwZV9vbl9rZXJuZWxfcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwgZW51bSBrZXJuZWxfcmVhZF9m
aWxlX2lkIGlkLA0KPiA+PiArCQkgICAgICAgYm9vbCBjb250ZW50cyk7DQo+ID4+ICsNCj4gPj4g
K2ludCBpcGVfb25fa2VybmVsX2xvYWRfZGF0YShlbnVtIGtlcm5lbF9sb2FkX2RhdGFfaWQgaWQs
IGJvb2wgY29udGVudHMpOw0KPiA+PiArDQo+ID4+ICAgI2VuZGlmIC8qIElQRV9IT09LU19IICov
DQo+ID4+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pcGUvaXBlLmMgYi9zZWN1cml0eS9pcGUvaXBl
LmMNCj4gPj4gaW5kZXggYjU4YjM3MjMyN2ExLi4zZjlkNDM3ODMyOTMgMTAwNjQ0DQo+ID4+IC0t
LSBhL3NlY3VyaXR5L2lwZS9pcGUuYw0KPiA+PiArKysgYi9zZWN1cml0eS9pcGUvaXBlLmMNCj4g
Pj4gQEAgLTI1LDYgKzI1LDExIEBAIHN0cnVjdCBsc21fYmxvYl9zaXplcyBpcGVfYmxvYnMgX19s
c21fcm9fYWZ0ZXJfaW5pdCA9DQo+IHsNCj4gPj4gICBzdGF0aWMgc3RydWN0IHNlY3VyaXR5X2hv
b2tfbGlzdCBpcGVfaG9va3NbXSBfX2xzbV9yb19hZnRlcl9pbml0ID0gew0KPiA+PiAgIAlMU01f
SE9PS19JTklUKHRhc2tfYWxsb2MsIGlwZV90YXNrX2FsbG9jKSwNCj4gPj4gICAJTFNNX0hPT0tf
SU5JVCh0YXNrX2ZyZWUsIGlwZV90YXNrX2ZyZWUpLA0KPiA+PiArCUxTTV9IT09LX0lOSVQoYnBy
bV9jaGVja19zZWN1cml0eSwgaXBlX29uX2V4ZWMpLA0KPiA+PiArCUxTTV9IT09LX0lOSVQobW1h
cF9maWxlLCBpcGVfb25fbW1hcCksDQo+ID4+ICsJTFNNX0hPT0tfSU5JVChmaWxlX21wcm90ZWN0
LCBpcGVfb25fbXByb3RlY3QpLA0KPiA+PiArCUxTTV9IT09LX0lOSVQoa2VybmVsX3JlYWRfZmls
ZSwgaXBlX29uX2tlcm5lbF9yZWFkKSwNCj4gPj4gKwlMU01fSE9PS19JTklUKGtlcm5lbF9sb2Fk
X2RhdGEsIGlwZV9vbl9rZXJuZWxfbG9hZF9kYXRhKSwNCj4gPj4gICB9Ow0KPiA+Pg0KPiA+PiAg
IC8qKg0KPiA+PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaXBlL3BvbGljeS5jIGIvc2VjdXJpdHkv
aXBlL3BvbGljeS5jDQo+ID4+IGluZGV4IGI3NjY4MjRjYzA4Zi4uMDQ4NTAwMjI5MzY1IDEwMDY0
NA0KPiA+PiAtLS0gYS9zZWN1cml0eS9pcGUvcG9saWN5LmMNCj4gPj4gKysrIGIvc2VjdXJpdHkv
aXBlL3BvbGljeS5jDQo+ID4+IEBAIC00ODMsNiArNDgzLDE0IEBAIGludCBpcGVfcGFyc2Vfb3Ao
Y29uc3Qgc3RydWN0IGlwZV9wb2xpY3lfdG9rZW4NCj4gKnRvaywNCj4gPj4gICB7DQo+ID4+ICAg
CXN1YnN0cmluZ190IG1hdGNoW01BWF9PUFRfQVJHU10gPSB7IDAgfTsNCj4gPj4gICAJY29uc3Qg
bWF0Y2hfdGFibGVfdCBvcHMgPSB7DQo+ID4+ICsJCXsgaXBlX29wZXJhdGlvbl9leGVjLAkJICJF
WEVDVVRFIiB9LA0KPiA+PiArCQl7IGlwZV9vcGVyYXRpb25fZmlybXdhcmUsCSAiRklSTVdBUkUi
IH0sDQo+ID4+ICsJCXsgaXBlX29wZXJhdGlvbl9rZXJuZWxfbW9kdWxlLAkgIktNT0RVTEUiIH0s
DQo+ID4+ICsJCXsgaXBlX29wZXJhdGlvbl9rZXhlY19pbWFnZSwJICJLRVhFQ19JTUFHRSIgfSwN
Cj4gPj4gKwkJeyBpcGVfb3BlcmF0aW9uX2tleGVjX2luaXRyYW1mcywgIktFWEVDX0lOSVRSQU1G
UyJ9LA0KPiA+PiArCQl7IGlwZV9vcGVyYXRpb25faW1hX3BvbGljeSwJICJJTUFfUE9MSUNZIiB9
LA0KPiA+PiArCQl7IGlwZV9vcGVyYXRpb25faW1hX3g1MDksCSAiSU1BX1g1MDlfQ0VSVCIgfSwN
Cj4gPj4gKwkJeyBpcGVfb3BfYWxpYXNfa2VybmVsX3JlYWQsCSAiS0VSTkVMX1JFQUQiIH0sDQo+
ID4+ICAgCQl7IGlwZV9vcF9hbGlhc19tYXgsIE5VTEwgfSwNCj4gPj4gICAJfTsNCj4gPj4NCj4g
Pj4gQEAgLTgzOCw2ICs4NDYsMTUgQEAgc3RhdGljIGludCBwYXJzZV9wb2xpY3koc3RydWN0IGlw
ZV9wb2xpY3kgKnApDQo+ID4+ICAgCXJldHVybiByYzsNCj4gPj4gICB9DQo+ID4+DQo+ID4+ICtz
dGF0aWMgY29uc3QgZW51bSBpcGVfb3BlcmF0aW9uIGFsaWFzX2tyZWFkW10gPSB7DQo+ID4+ICsJ
aXBlX29wZXJhdGlvbl9maXJtd2FyZSwNCj4gPj4gKwlpcGVfb3BlcmF0aW9uX2tlcm5lbF9tb2R1
bGUsDQo+ID4+ICsJaXBlX29wZXJhdGlvbl9pbWFfcG9saWN5LA0KPiA+PiArCWlwZV9vcGVyYXRp
b25faW1hX3g1MDksDQo+ID4+ICsJaXBlX29wZXJhdGlvbl9rZXhlY19pbWFnZSwNCj4gPj4gKwlp
cGVfb3BlcmF0aW9uX2tleGVjX2luaXRyYW1mcywNCj4gPj4gK307DQo+ID4+ICsNCj4gPj4gICAv
KioNCj4gPj4gICAgKiBpcGVfaXNfb3BfYWxpYXM6IERldGVybWluZSBpZiBAb3AgaXMgYW4gYWxp
YXMgZm9yIG9uZSBvciBtb3JlIG9wZXJhdGlvbnMNCj4gPj4gICAgKiBAb3A6IFN1cHBsaWVzIHRo
ZSBvcGVyYXRpb24gdG8gY2hlY2suIFNob3VsZCBiZSBlaXRoZXIgaXBlX29wZXJhdGlvbiBvcg0K
PiA+PiBAQCAtODUyLDkgKzg2OSwxNSBAQCBzdGF0aWMgaW50IHBhcnNlX3BvbGljeShzdHJ1Y3Qg
aXBlX3BvbGljeSAqcCkNCj4gPj4gICBib29sIGlwZV9pc19vcF9hbGlhcyhpbnQgb3AsIGNvbnN0
IGVudW0gaXBlX29wZXJhdGlvbiAqKm1hcCwgc2l6ZV90ICpzaXplKQ0KPiA+PiAgIHsNCj4gPj4g
ICAJc3dpdGNoIChvcCkgew0KPiA+PiArCWNhc2UgaXBlX29wX2FsaWFzX2tlcm5lbF9yZWFkOg0K
PiA+PiArCQkqbWFwID0gYWxpYXNfa3JlYWQ7DQo+ID4+ICsJCSpzaXplID0gQVJSQVlfU0laRShh
bGlhc19rcmVhZCk7DQo+ID4+ICsJCWJyZWFrOw0KPiA+PiAgIAlkZWZhdWx0Og0KPiA+PiAgIAkJ
cmV0dXJuIGZhbHNlOw0KPiA+PiAgIAl9DQo+ID4+ICsNCj4gPj4gKwlyZXR1cm4gdHJ1ZTsNCj4g
Pj4gICB9DQo+ID4+DQo+ID4+ICAgLyoqDQo+ID4+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9pcGUv
cG9saWN5LmggYi9zZWN1cml0eS9pcGUvcG9saWN5LmgNCj4gPj4gaW5kZXggNjgxOGY2NDA1ZGQw
Li5jYTM3YWY0NmU1YWYgMTAwNjQ0DQo+ID4+IC0tLSBhL3NlY3VyaXR5L2lwZS9wb2xpY3kuaA0K
PiA+PiArKysgYi9zZWN1cml0eS9pcGUvcG9saWN5LmgNCj4gPj4gQEAgLTI2LDcgKzI2LDE0IEBA
IHN0cnVjdCBpcGVfcG9saWN5X2xpbmUgew0KPiA+PiAgIHN0cnVjdCBpcGVfbW9kdWxlOw0KPiA+
Pg0KPiA+PiAgIGVudW0gaXBlX29wZXJhdGlvbiB7DQo+ID4+IC0JaXBlX29wZXJhdGlvbl9tYXgg
PSAwLA0KPiA+PiArCWlwZV9vcGVyYXRpb25fZXhlYyA9IDAsDQo+ID4+ICsJaXBlX29wZXJhdGlv
bl9maXJtd2FyZSwNCj4gPj4gKwlpcGVfb3BlcmF0aW9uX2tlcm5lbF9tb2R1bGUsDQo+ID4+ICsJ
aXBlX29wZXJhdGlvbl9rZXhlY19pbWFnZSwNCj4gPj4gKwlpcGVfb3BlcmF0aW9uX2tleGVjX2lu
aXRyYW1mcywNCj4gPj4gKwlpcGVfb3BlcmF0aW9uX2ltYV9wb2xpY3ksDQo+ID4+ICsJaXBlX29w
ZXJhdGlvbl9pbWFfeDUwOSwNCj4gPj4gKwlpcGVfb3BlcmF0aW9uX21heA0KPiA+PiAgIH07DQo+
ID4+DQo+ID4+ICAgLyoNCj4gPj4gQEAgLTM0LDcgKzQxLDggQEAgZW51bSBpcGVfb3BlcmF0aW9u
IHsNCj4gPj4gICAgKiB0aGF0IGFyZSBqdXN0IG9uZSBvciBtb3JlIG9wZXJhdGlvbnMgdW5kZXIg
dGhlIGhvb2QNCj4gPj4gICAgKi8NCj4gPj4gICBlbnVtIGlwZV9vcF9hbGlhcyB7DQo+ID4+IC0J
aXBlX29wX2FsaWFzX21heCA9IGlwZV9vcGVyYXRpb25fbWF4LA0KPiA+PiArCWlwZV9vcF9hbGlh
c19rZXJuZWxfcmVhZCA9IGlwZV9vcGVyYXRpb25fbWF4LA0KPiA+PiArCWlwZV9vcF9hbGlhc19t
YXgsDQo+ID4+ICAgfTsNCj4gPj4NCj4gPj4gICBlbnVtIGlwZV9hY3Rpb24gew0KPiA+PiAtLQ0K
PiA+PiAyLjMzLjANCg==
