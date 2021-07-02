Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE11B3B9F4D
	for <lists+linux-security-module@lfdr.de>; Fri,  2 Jul 2021 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhGBKye (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 2 Jul 2021 06:54:34 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3347 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhGBKye (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 2 Jul 2021 06:54:34 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GGWkl4DM9z6F8Jf;
        Fri,  2 Jul 2021 18:38:07 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 12:51:59 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2176.012;
 Fri, 2 Jul 2021 12:51:59 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>
CC:     "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "prsriva02@gmail.com" <prsriva02@gmail.com>,
        "tusharsu@linux.microsoft.com" <tusharsu@linux.microsoft.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] ima: Return int in the functions to measure a
 buffer
Thread-Topic: [PATCH v2 2/3] ima: Return int in the functions to measure a
 buffer
Thread-Index: AQHXbnh4Ap4ZB9WfW0KrxIa1iCu5SasuKjoAgAFYg1A=
Date:   Fri, 2 Jul 2021 10:51:59 +0000
Message-ID: <c0b442636e4440a0830358e1cf12da57@huawei.com>
References: <20210701125552.2958008-1-roberto.sassu@huawei.com>
 <20210701125552.2958008-3-roberto.sassu@huawei.com>
 <75bf7a3f-fd0e-177b-5725-e5f8b1f68966@linux.microsoft.com>
In-Reply-To: <75bf7a3f-fd0e-177b-5725-e5f8b1f68966@linux.microsoft.com>
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

PiBGcm9tOiBMYWtzaG1pIFJhbWFzdWJyYW1hbmlhbiBbbWFpbHRvOm5yYW1hc0BsaW51eC5taWNy
b3NvZnQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAxLCAyMDIxIDY6MTYgUE0NCj4gT24g
Ny8xLzIwMjEgNTo1NSBBTSwgUm9iZXJ0byBTYXNzdSB3cm90ZToNCj4gPiBpbWFfbWVhc3VyZV9j
cml0aWNhbF9kYXRhKCkgYW5kIHByb2Nlc3NfYnVmZmVyX21lYXN1cmVtZW50KCkgY3VycmVudGx5
DQo+ID4gZG9uJ3QgcmV0dXJuIGEgcmVzdWx0LiBBIGNhbGxlciB3b3VsZG4ndCBiZSBhYmxlIHRv
IGtub3cgd2hldGhlciB0aG9zZQ0KPiA+IGZ1bmN0aW9ucyB3ZXJlIGV4ZWN1dGVkIHN1Y2Nlc3Nm
dWxseS4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggbW9kaWZpZXMgdGhlIHJldHVybiB0eXBlIGZyb20g
dm9pZCB0byBpbnQsIGFuZCByZXR1cm5zIDAgaWYgdGhlDQo+ID4gYnVmZmVyIGhhcyBiZWVuIHN1
Y2Nlc3NmdWxseSBtZWFzdXJlZCwgYSBuZWdhdGl2ZSB2YWx1ZSBvdGhlcndpc2UuDQo+ID4NCj4g
PiBBbHNvLCB0aGlzIHBhdGNoIGRvZXMgbm90IG1vZGlmeSB0aGUgYmVoYXZpb3Igb2YgZXhpc3Rp
bmcgY2FsbGVycyBieQ0KPiA+IHByb2Nlc3NpbmcgdGhlIHJldHVybmVkIHZhbHVlLiBJbnN0ZWFk
LCB0aGUgdmFsdWUgaXMgc3RvcmVkIGluIGEgdmFyaWFibGUNCj4gPiBtYXJrZWQgYXMgX19tYXli
ZV91bnVzZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnRvIFNhc3N1IDxyb2JlcnRv
LnNhc3N1QGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2xpbnV4L2ltYS5oICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrKy0tLQ0KPiA+ICAgc2VjdXJpdHkvaW50ZWdy
aXR5L2ltYS9pbWEuaCAgICAgICAgICAgICAgICAgfCAxMCArKy0tDQo+ID4gICBzZWN1cml0eS9p
bnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlzZS5jICAgICAgICB8ICA0ICstDQo+ID4gICBzZWN1cml0
eS9pbnRlZ3JpdHkvaW1hL2ltYV9hc3ltbWV0cmljX2tleXMuYyB8ICA0ICstDQo+ID4gICBzZWN1
cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9pbml0LmMgICAgICAgICAgICB8ICA2ICsrLQ0KPiA+ICAg
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfbWFpbi5jICAgICAgICAgICAgfCA0OCArKysrKysr
KysrKystLS0tLS0tLQ0KPiA+ICAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcXVldWVfa2V5
cy5jICAgICAgfCAxNSArKystLS0NCj4gPiAgIHNlY3VyaXR5L3NlbGludXgvaW1hLmMgICAgICAg
ICAgICAgICAgICAgICAgIHwgMTAgKystLQ0KPiA+ICAgOCBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNl
cnRpb25zKCspLCA0NiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2ltYS5oIGIvaW5jbHVkZS9saW51eC9pbWEuaA0KPiA+IGluZGV4IDgxZTgzMGQwMWNl
ZC4uNjA0OTIyNjNhYTY0IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvaW1hLmgNCj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L2ltYS5oDQo+ID4gQEAgLTM1LDEwICszNSwxMCBAQCBleHRl
cm4gdm9pZCBpbWFfcG9zdF9wYXRoX21rbm9kKHN0cnVjdA0KPiB1c2VyX25hbWVzcGFjZSAqbW50
X3VzZXJucywNCj4gPiAgIGV4dGVybiBpbnQgaW1hX2ZpbGVfaGFzaChzdHJ1Y3QgZmlsZSAqZmls
ZSwgY2hhciAqYnVmLCBzaXplX3QgYnVmX3NpemUpOw0KPiA+ICAgZXh0ZXJuIGludCBpbWFfaW5v
ZGVfaGFzaChzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjaGFyICpidWYsIHNpemVfdCBidWZfc2l6ZSk7
DQo+ID4gICBleHRlcm4gdm9pZCBpbWFfa2V4ZWNfY21kbGluZShpbnQga2VybmVsX2ZkLCBjb25z
dCB2b2lkICpidWYsIGludCBzaXplKTsNCj4gPiAtZXh0ZXJuIHZvaWQgaW1hX21lYXN1cmVfY3Jp
dGljYWxfZGF0YShjb25zdCBjaGFyICpldmVudF9sYWJlbCwNCj4gPiAtCQkJCSAgICAgIGNvbnN0
IGNoYXIgKmV2ZW50X25hbWUsDQo+ID4gLQkJCQkgICAgICBjb25zdCB2b2lkICpidWYsIHNpemVf
dCBidWZfbGVuLA0KPiA+IC0JCQkJICAgICAgYm9vbCBoYXNoKTsNCj4gPiArZXh0ZXJuIGludCBp
bWFfbWVhc3VyZV9jcml0aWNhbF9kYXRhKGNvbnN0IGNoYXIgKmV2ZW50X2xhYmVsLA0KPiA+ICsJ
CQkJICAgICBjb25zdCBjaGFyICpldmVudF9uYW1lLA0KPiA+ICsJCQkJICAgICBjb25zdCB2b2lk
ICpidWYsIHNpemVfdCBidWZfbGVuLA0KPiA+ICsJCQkJICAgICBib29sIGhhc2gpOw0KPiA+DQo+
ID4gICAjaWZkZWYgQ09ORklHX0lNQV9BUFBSQUlTRV9CT09UUEFSQU0NCj4gPiAgIGV4dGVybiB2
b2lkIGltYV9hcHByYWlzZV9wYXJzZV9jbWRsaW5lKHZvaWQpOw0KPiA+IEBAIC0xNDQsMTAgKzE0
NCwxMyBAQCBzdGF0aWMgaW5saW5lIGludCBpbWFfaW5vZGVfaGFzaChzdHJ1Y3QgaW5vZGUNCj4g
Kmlub2RlLCBjaGFyICpidWYsIHNpemVfdCBidWZfc2l6ZQ0KPiA+DQo+ID4gICBzdGF0aWMgaW5s
aW5lIHZvaWQgaW1hX2tleGVjX2NtZGxpbmUoaW50IGtlcm5lbF9mZCwgY29uc3Qgdm9pZCAqYnVm
LCBpbnQgc2l6ZSkNCj4ge30NCj4gPg0KPiA+IC1zdGF0aWMgaW5saW5lIHZvaWQgaW1hX21lYXN1
cmVfY3JpdGljYWxfZGF0YShjb25zdCBjaGFyICpldmVudF9sYWJlbCwNCj4gPiArc3RhdGljIGlu
bGluZSBpbnQgaW1hX21lYXN1cmVfY3JpdGljYWxfZGF0YShjb25zdCBjaGFyICpldmVudF9sYWJl
bCwNCj4gPiAgIAkJCQkJICAgICBjb25zdCBjaGFyICpldmVudF9uYW1lLA0KPiA+ICAgCQkJCQkg
ICAgIGNvbnN0IHZvaWQgKmJ1Ziwgc2l6ZV90IGJ1Zl9sZW4sDQo+ID4gLQkJCQkJICAgICBib29s
IGhhc2gpIHt9DQo+ID4gKwkJCQkJICAgICBib29sIGhhc2gpDQo+ID4gK3sNCj4gPiArCXJldHVy
biAtRU5PRU5UOw0KPiA+ICt9DQo+ID4NCj4gPiAgICNlbmRpZiAvKiBDT05GSUdfSU1BICovDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaCBiL3NlY3Vy
aXR5L2ludGVncml0eS9pbWEvaW1hLmgNCj4gPiBpbmRleCBmMGU0NDhlZDFmOWYuLjAzZGIyMjEz
MjRjMyAxMDA2NDQNCj4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYS5oDQo+ID4g
KysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWEuaA0KPiA+IEBAIC0yNjQsMTEgKzI2NCwx
MSBAQCB2b2lkIGltYV9zdG9yZV9tZWFzdXJlbWVudChzdHJ1Y3QNCj4gaW50ZWdyaXR5X2lpbnRf
Y2FjaGUgKmlpbnQsIHN0cnVjdCBmaWxlICpmaWxlLA0KPiA+ICAgCQkJICAgc3RydWN0IGV2bV9p
bWFfeGF0dHJfZGF0YSAqeGF0dHJfdmFsdWUsDQo+ID4gICAJCQkgICBpbnQgeGF0dHJfbGVuLCBj
b25zdCBzdHJ1Y3QgbW9kc2lnICptb2RzaWcsIGludCBwY3IsDQo+ID4gICAJCQkgICBzdHJ1Y3Qg
aW1hX3RlbXBsYXRlX2Rlc2MgKnRlbXBsYXRlX2Rlc2MpOw0KPiA+IC12b2lkIHByb2Nlc3NfYnVm
ZmVyX21lYXN1cmVtZW50KHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywNCj4gPiAt
CQkJCXN0cnVjdCBpbm9kZSAqaW5vZGUsIGNvbnN0IHZvaWQgKmJ1ZiwgaW50IHNpemUsDQo+ID4g
LQkJCQljb25zdCBjaGFyICpldmVudG5hbWUsIGVudW0gaW1hX2hvb2tzDQo+IGZ1bmMsDQo+ID4g
LQkJCQlpbnQgcGNyLCBjb25zdCBjaGFyICpmdW5jX2RhdGEsDQo+ID4gLQkJCQlib29sIGJ1Zl9o
YXNoKTsNCj4gPiAraW50IHByb2Nlc3NfYnVmZmVyX21lYXN1cmVtZW50KHN0cnVjdCB1c2VyX25h
bWVzcGFjZSAqbW50X3VzZXJucywNCj4gPiArCQkJICAgICAgIHN0cnVjdCBpbm9kZSAqaW5vZGUs
IGNvbnN0IHZvaWQgKmJ1ZiwgaW50IHNpemUsDQo+ID4gKwkJCSAgICAgICBjb25zdCBjaGFyICpl
dmVudG5hbWUsIGVudW0gaW1hX2hvb2tzIGZ1bmMsDQo+ID4gKwkJCSAgICAgICBpbnQgcGNyLCBj
b25zdCBjaGFyICpmdW5jX2RhdGEsDQo+ID4gKwkJCSAgICAgICBib29sIGJ1Zl9oYXNoKTsNCj4g
PiAgIHZvaWQgaW1hX2F1ZGl0X21lYXN1cmVtZW50KHN0cnVjdCBpbnRlZ3JpdHlfaWludF9jYWNo
ZSAqaWludCwNCj4gPiAgIAkJCSAgIGNvbnN0IHVuc2lnbmVkIGNoYXIgKmZpbGVuYW1lKTsNCj4g
PiAgIGludCBpbWFfYWxsb2NfaW5pdF90ZW1wbGF0ZShzdHJ1Y3QgaW1hX2V2ZW50X2RhdGEgKmV2
ZW50X2RhdGEsDQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2Fw
cHJhaXNlLmMNCj4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hcHByYWlzZS5jDQo+ID4g
aW5kZXggZWY5ZGNmY2U0NWQ0Li4yNzVhMjM3Nzc0M2YgMTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJp
dHkvaW50ZWdyaXR5L2ltYS9pbWFfYXBwcmFpc2UuYw0KPiA+ICsrKyBiL3NlY3VyaXR5L2ludGVn
cml0eS9pbWEvaW1hX2FwcHJhaXNlLmMNCj4gPiBAQCAtMzQ1LDYgKzM0NSw3IEBAIGludCBpbWFf
Y2hlY2tfYmxhY2tsaXN0KHN0cnVjdCBpbnRlZ3JpdHlfaWludF9jYWNoZQ0KPiAqaWludCwNCj4g
PiAgIAllbnVtIGhhc2hfYWxnbyBoYXNoX2FsZ287DQo+ID4gICAJY29uc3QgdTggKmRpZ2VzdCA9
IE5VTEw7DQo+ID4gICAJdTMyIGRpZ2VzdHNpemUgPSAwOw0KPiA+ICsJaW50IHByb2Nlc3NfcmMg
X19tYXliZV91bnVzZWQ7DQo+ID4gICAJaW50IHJjID0gMDsNCj4gPg0KPiA+ICAgCWlmICghKGlp
bnQtPmZsYWdzICYgSU1BX0NIRUNLX0JMQUNLTElTVCkpDQo+ID4gQEAgLTM1NSw3ICszNTYsOCBA
QCBpbnQgaW1hX2NoZWNrX2JsYWNrbGlzdChzdHJ1Y3QgaW50ZWdyaXR5X2lpbnRfY2FjaGUNCj4g
KmlpbnQsDQo+ID4NCj4gPiAgIAkJcmMgPSBpc19iaW5hcnlfYmxhY2tsaXN0ZWQoZGlnZXN0LCBk
aWdlc3RzaXplKTsNCj4gPiAgIAkJaWYgKChyYyA9PSAtRVBFUk0pICYmIChpaW50LT5mbGFncyAm
IElNQV9NRUFTVVJFKSkNCj4gPiAtCQkJcHJvY2Vzc19idWZmZXJfbWVhc3VyZW1lbnQoJmluaXRf
dXNlcl9ucywgTlVMTCwNCj4gZGlnZXN0LCBkaWdlc3RzaXplLA0KPiA+ICsJCQlwcm9jZXNzX3Jj
ID0NCj4gcHJvY2Vzc19idWZmZXJfbWVhc3VyZW1lbnQoJmluaXRfdXNlcl9ucywNCj4gSSB0aGlu
ayB0aGVyZSBpcyBubyBuZWVkIHRvIG1ha2UgdGhpcyBjaGFuZ2Ugbm93LiBJZiBhbmQgd2hlbg0K
PiBpbWFfY2hlY2tfYmxhY2tsaXN0KCkgbmVlZHMgdG8gbG9vayBhdCB0aGUgcmV0dXJuIHZhbHVl
IG9mIHBfYl9tKCksIHRoaXMNCj4gY2hhbmdlIGNhbiBiZSBtYWRlLg0KDQpIaSBMYWtzaG1pDQoN
Cm9rLiBJIHdhcyB3b3JyaWVkIGFib3V0IHBvc3NpYmxlIHdhcm5pbmdzLiBJZiBpdCBpcyBub3Qg
YW4gaXNzdWUsDQpJIHdpbGwgcmVtb3ZlIHRoZSBhc3NpZ25tZW50Lg0KDQpUaGFua3MNCg0KUm9i
ZXJ0bw0KDQpIVUFXRUkgVEVDSE5PTE9HSUVTIER1ZXNzZWxkb3JmIEdtYkgsIEhSQiA1NjA2Mw0K
TWFuYWdpbmcgRGlyZWN0b3I6IExpIFBlbmcsIExpIEppYW4sIFNoaSBZYW5saQ0KDQo+ID4gKwkJ
CQkJCSAgIE5VTEwsIGRpZ2VzdCwgZGlnZXN0c2l6ZSwNCj4gPiAgIAkJCQkJCSAgICJibGFja2xp
c3RlZC1oYXNoIiwgTk9ORSwNCj4gPiAgIAkJCQkJCSAgIHBjciwgTlVMTCwgZmFsc2UpOw0KPiA+
ICAgCX0NCj4gPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXN5bW1l
dHJpY19rZXlzLmMNCj4gYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9hc3ltbWV0cmljX2tl
eXMuYw0KPiA+IGluZGV4IGM5ODU0MTg2OThhNC4uOTEwMzY3Y2RkOTIwIDEwMDY0NA0KPiA+IC0t
LSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2FzeW1tZXRyaWNfa2V5cy5jDQo+ID4gKysr
IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfYXN5bW1ldHJpY19rZXlzLmMNCj4gPiBAQCAt
MzEsNiArMzEsNyBAQCB2b2lkIGltYV9wb3N0X2tleV9jcmVhdGVfb3JfdXBkYXRlKHN0cnVjdCBr
ZXkNCj4gKmtleXJpbmcsIHN0cnVjdCBrZXkgKmtleSwNCj4gPiAgIAkJCQkgICB1bnNpZ25lZCBs
b25nIGZsYWdzLCBib29sIGNyZWF0ZSkNCj4gPiAgIHsNCj4gPiAgIAlib29sIHF1ZXVlZCA9IGZh
bHNlOw0KPiA+ICsJaW50IHJldCBfX21heWJlX3VudXNlZDsNCj4gPg0KPiA+ICAgCS8qIE9ubHkg
YXN5bW1ldHJpYyBrZXlzIGFyZSBoYW5kbGVkIGJ5IHRoaXMgaG9vay4gKi8NCj4gPiAgIAlpZiAo
a2V5LT50eXBlICE9ICZrZXlfdHlwZV9hc3ltbWV0cmljKQ0KPiA+IEBAIC02MCw3ICs2MSw4IEBA
IHZvaWQgaW1hX3Bvc3Rfa2V5X2NyZWF0ZV9vcl91cGRhdGUoc3RydWN0IGtleQ0KPiAqa2V5cmlu
Zywgc3RydWN0IGtleSAqa2V5LA0KPiA+ICAgCSAqIGlmIHRoZSBJTUEgcG9saWN5IGlzIGNvbmZp
Z3VyZWQgdG8gbWVhc3VyZSBhIGtleSBsaW5rZWQNCj4gPiAgIAkgKiB0byB0aGUgZ2l2ZW4ga2V5
cmluZy4NCj4gPiAgIAkgKi8NCj4gPiAtCXByb2Nlc3NfYnVmZmVyX21lYXN1cmVtZW50KCZpbml0
X3VzZXJfbnMsIE5VTEwsIHBheWxvYWQsDQo+IHBheWxvYWRfbGVuLA0KPiA+ICsJcmV0ID0gcHJv
Y2Vzc19idWZmZXJfbWVhc3VyZW1lbnQoJmluaXRfdXNlcl9ucywgTlVMTCwNCj4gPiArCQkJCSAg
IHBheWxvYWQsIHBheWxvYWRfbGVuLA0KPiBTYW1lIGNvbW1lbnQgYXMgaW4gaW1hX2NoZWNrX2Js
YWNrbGlzdCgpIC0gdGhpcyBjaGFuZ2UgYmUgbWFkZSB3aGVuDQo+IG5lZWRlZC4NCj4gDQo+ID4g
ICAJCQkJICAga2V5cmluZy0+ZGVzY3JpcHRpb24sIEtFWV9DSEVDSywgMCwNCj4gPiAgIAkJCQkg
ICBrZXlyaW5nLT5kZXNjcmlwdGlvbiwgZmFsc2UpOw0KPiA+ICAgfQ0KPiA+IGRpZmYgLS1naXQg
YS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9pbml0LmMNCj4gYi9zZWN1cml0eS9pbnRlZ3Jp
dHkvaW1hL2ltYV9pbml0LmMNCj4gPiBpbmRleCA1MDc2YTdkOWQyM2UuLjY3OTBlZWE4OGRiOCAx
MDA2NDQNCj4gPiAtLS0gYS9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9pbml0LmMNCj4gPiAr
KysgYi9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9pbml0LmMNCj4gPiBAQCAtMTE4LDYgKzEx
OCw3IEBAIHZvaWQgX19pbml0IGltYV9sb2FkX3g1MDkodm9pZCkNCj4gPg0KPiA+ICAgaW50IF9f
aW5pdCBpbWFfaW5pdCh2b2lkKQ0KPiA+ICAgew0KPiA+ICsJaW50IG1lYXN1cmVfcmMgX19tYXli
ZV91bnVzZWQ7DQo+ID4gICAJaW50IHJjOw0KPiA+DQo+ID4gICAJaW1hX3RwbV9jaGlwID0gdHBt
X2RlZmF1bHRfY2hpcCgpOw0KPiA+IEBAIC0xNTMsOCArMTU0LDkgQEAgaW50IF9faW5pdCBpbWFf
aW5pdCh2b2lkKQ0KPiA+DQo+ID4gICAJaW1hX2luaXRfa2V5X3F1ZXVlKCk7DQo+ID4NCj4gPiAt
CWltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoImtlcm5lbF9pbmZvIiwgImtlcm5lbF92ZXJzaW9u
IiwNCj4gPiAtCQkJCSAgVVRTX1JFTEVBU0UsIHN0cmxlbihVVFNfUkVMRUFTRSksIGZhbHNlKTsN
Cj4gPiArCW1lYXN1cmVfcmMgPSBpbWFfbWVhc3VyZV9jcml0aWNhbF9kYXRhKCJrZXJuZWxfaW5m
byIsDQo+ICJrZXJuZWxfdmVyc2lvbiIsDQo+ID4gKwkJCQkJICAgICAgIFVUU19SRUxFQVNFLA0K
PiBzdHJsZW4oVVRTX1JFTEVBU0UpLA0KPiA+ICsJCQkJCSAgICAgICBmYWxzZSk7DQo+IFNhbWUg
Y29tbWVudCBhcyBpbiBpbWFfY2hlY2tfYmxhY2tsaXN0KCkgLSB0aGlzIGNoYW5nZSBiZSBtYWRl
IHdoZW4NCj4gbmVlZGVkLg0KPiANCj4gPg0KPiA+ICAgCXJldHVybiByYzsNCj4gPiAgIH0NCj4g
PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfbWFpbi5jDQo+IGIvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfbWFpbi5jDQo+ID4gaW5kZXggOGVmMWZhMzU3ZTBjLi4z
Mzg2ZTc0MzY0NDAgMTAwNjQ0DQo+ID4gLS0tIGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFf
bWFpbi5jDQo+ID4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfbWFpbi5jDQo+ID4g
QEAgLTgyNyw3ICs4MjcsNyBAQCBpbnQgaW1hX3Bvc3RfbG9hZF9kYXRhKGNoYXIgKmJ1ZiwgbG9m
Zl90IHNpemUsDQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiAtLyoNCj4gPiAr
LyoqDQo+ID4gICAgKiBwcm9jZXNzX2J1ZmZlcl9tZWFzdXJlbWVudCAtIE1lYXN1cmUgdGhlIGJ1
ZmZlciBvciB0aGUgYnVmZmVyIGRhdGENCj4gaGFzaA0KPiA+ICAgICogQG1udF91c2VybnM6CXVz
ZXIgbmFtZXNwYWNlIG9mIHRoZSBtb3VudCB0aGUgaW5vZGUgd2FzIGZvdW5kDQo+IGZyb20NCj4g
PiAgICAqIEBpbm9kZTogaW5vZGUgYXNzb2NpYXRlZCB3aXRoIHRoZSBvYmplY3QgYmVpbmcgbWVh
c3VyZWQgKE5VTEwgZm9yDQo+IEtFWV9DSEVDSykNCj4gPiBAQCAtODQwLDEyICs4NDAsMTUgQEAg
aW50IGltYV9wb3N0X2xvYWRfZGF0YShjaGFyICpidWYsIGxvZmZfdCBzaXplLA0KPiA+ICAgICog
QGJ1Zl9oYXNoOiBtZWFzdXJlIGJ1ZmZlciBkYXRhIGhhc2gNCj4gPiAgICAqDQo+ID4gICAgKiBC
YXNlZCBvbiBwb2xpY3ksIGVpdGhlciB0aGUgYnVmZmVyIGRhdGEgb3IgYnVmZmVyIGRhdGEgaGFz
aCBpcyBtZWFzdXJlZA0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IDAgaWYgdGhlIGJ1ZmZlciBo
YXMgYmVlbiBzdWNjZXNzZnVsbHkgbWVhc3VyZWQsIGEgbmVnYXRpdmUgdmFsdWUNCj4gPiArICog
b3RoZXJ3aXNlLg0KPiA+ICAgICovDQo+ID4gLXZvaWQgcHJvY2Vzc19idWZmZXJfbWVhc3VyZW1l
bnQoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLA0KPiA+IC0JCQkJc3RydWN0IGlu
b2RlICppbm9kZSwgY29uc3Qgdm9pZCAqYnVmLCBpbnQgc2l6ZSwNCj4gPiAtCQkJCWNvbnN0IGNo
YXIgKmV2ZW50bmFtZSwgZW51bSBpbWFfaG9va3MNCj4gZnVuYywNCj4gPiAtCQkJCWludCBwY3Is
IGNvbnN0IGNoYXIgKmZ1bmNfZGF0YSwNCj4gPiAtCQkJCWJvb2wgYnVmX2hhc2gpDQo+ID4gK2lu
dCBwcm9jZXNzX2J1ZmZlcl9tZWFzdXJlbWVudChzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91
c2VybnMsDQo+ID4gKwkJCSAgICAgICBzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCB2b2lkICpi
dWYsIGludCBzaXplLA0KPiA+ICsJCQkgICAgICAgY29uc3QgY2hhciAqZXZlbnRuYW1lLCBlbnVt
IGltYV9ob29rcyBmdW5jLA0KPiA+ICsJCQkgICAgICAgaW50IHBjciwgY29uc3QgY2hhciAqZnVu
Y19kYXRhLA0KPiA+ICsJCQkgICAgICAgYm9vbCBidWZfaGFzaCkNCj4gPiAgIHsNCj4gPiAgIAlp
bnQgcmV0ID0gMDsNCj4gPiAgIAljb25zdCBjaGFyICphdWRpdF9jYXVzZSA9ICJFTk9NRU0iOw0K
PiA+IEBAIC04NjcsNyArODcwLDcgQEAgdm9pZCBwcm9jZXNzX2J1ZmZlcl9tZWFzdXJlbWVudChz
dHJ1Y3QNCj4gdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsDQo+ID4gICAJdTMyIHNlY2lkOw0K
PiA+DQo+ID4gICAJaWYgKCFpbWFfcG9saWN5X2ZsYWcpDQo+ID4gLQkJcmV0dXJuOw0KPiA+ICsJ
CXJldHVybiAtRU5PRU5UOw0KPiA+DQo+ID4gICAJdGVtcGxhdGUgPSBpbWFfdGVtcGxhdGVfZGVz
Y19idWYoKTsNCj4gPiAgIAlpZiAoIXRlbXBsYXRlKSB7DQo+ID4gQEAgLTg4OSw3ICs4OTIsNyBA
QCB2b2lkIHByb2Nlc3NfYnVmZmVyX21lYXN1cmVtZW50KHN0cnVjdA0KPiB1c2VyX25hbWVzcGFj
ZSAqbW50X3VzZXJucywNCj4gPiAgIAkJCQkJc2VjaWQsIDAsIGZ1bmMsICZwY3IsICZ0ZW1wbGF0
ZSwNCj4gPiAgIAkJCQkJZnVuY19kYXRhKTsNCj4gPiAgIAkJaWYgKCEoYWN0aW9uICYgSU1BX01F
QVNVUkUpKQ0KPiA+IC0JCQlyZXR1cm47DQo+ID4gKwkJCXJldHVybiAtRU5PRU5UOw0KPiA+ICAg
CX0NCj4gPg0KPiA+ICAgCWlmICghcGNyKQ0KPiA+IEBAIC05MzcsNyArOTQwLDcgQEAgdm9pZCBw
cm9jZXNzX2J1ZmZlcl9tZWFzdXJlbWVudChzdHJ1Y3QNCj4gdXNlcl9uYW1lc3BhY2UgKm1udF91
c2VybnMsDQo+ID4gICAJCQkJCWZ1bmNfbWVhc3VyZV9zdHIoZnVuYyksDQo+ID4gICAJCQkJCWF1
ZGl0X2NhdXNlLCByZXQsIDAsIHJldCk7DQo+ID4NCj4gPiAtCXJldHVybjsNCj4gPiArCXJldHVy
biByZXQ7DQo+ID4gICB9DQo+ID4NCj4gPiAgIC8qKg0KPiA+IEBAIC05NTEsNiArOTU0LDcgQEAg
dm9pZCBwcm9jZXNzX2J1ZmZlcl9tZWFzdXJlbWVudChzdHJ1Y3QNCj4gdXNlcl9uYW1lc3BhY2Ug
Km1udF91c2VybnMsDQo+ID4gICB2b2lkIGltYV9rZXhlY19jbWRsaW5lKGludCBrZXJuZWxfZmQs
IGNvbnN0IHZvaWQgKmJ1ZiwgaW50IHNpemUpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGZkIGY7
DQo+ID4gKwlpbnQgcmV0IF9fbWF5YmVfdW51c2VkOw0KPiA+DQo+ID4gICAJaWYgKCFidWYgfHwg
IXNpemUpDQo+ID4gICAJCXJldHVybjsNCj4gPiBAQCAtOTU5LDkgKzk2MywxMCBAQCB2b2lkIGlt
YV9rZXhlY19jbWRsaW5lKGludCBrZXJuZWxfZmQsIGNvbnN0IHZvaWQNCj4gKmJ1ZiwgaW50IHNp
emUpDQo+ID4gICAJaWYgKCFmLmZpbGUpDQo+ID4gICAJCXJldHVybjsNCj4gPg0KPiA+IC0JcHJv
Y2Vzc19idWZmZXJfbWVhc3VyZW1lbnQoZmlsZV9tbnRfdXNlcl9ucyhmLmZpbGUpLA0KPiBmaWxl
X2lub2RlKGYuZmlsZSksDQo+ID4gLQkJCQkgICBidWYsIHNpemUsICJrZXhlYy1jbWRsaW5lIiwg
S0VYRUNfQ01ETElORSwNCj4gMCwNCj4gPiAtCQkJCSAgIE5VTEwsIGZhbHNlKTsNCj4gPiArCXJl
dCA9IHByb2Nlc3NfYnVmZmVyX21lYXN1cmVtZW50KGZpbGVfbW50X3VzZXJfbnMoZi5maWxlKSwN
Cj4gPiArCQkJCQkgZmlsZV9pbm9kZShmLmZpbGUpLCBidWYsIHNpemUsDQo+ID4gKwkJCQkJICJr
ZXhlYy1jbWRsaW5lIiwgS0VYRUNfQ01ETElORSwgMCwNCj4gPiArCQkJCQkgTlVMTCwgZmFsc2Up
Ow0KPiBTaW5jZSB0aGUgcmV0dXJuIHZhbHVlIG9mIHBfYl9tKCkgaXMgbm90IHVzZWQgaGVyZSwg
dGhpcyBjaGFuZ2UgY2FuIGJlDQo+IG1hZGUgd2hlbiBuZWVkZWQuDQo+IA0KPiA+ICAgCWZkcHV0
KGYpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gQEAgLTk3NywxOCArOTgyLDIxIEBAIHZvaWQgaW1hX2tl
eGVjX2NtZGxpbmUoaW50IGtlcm5lbF9mZCwgY29uc3Qgdm9pZA0KPiAqYnVmLCBpbnQgc2l6ZSkN
Cj4gPiAgICAqIGFuZCBleHRlbmQgdGhlIHBjci4gIEV4YW1wbGVzIG9mIGNyaXRpY2FsIGRhdGEg
Y291bGQgYmUgdmFyaW91cyBkYXRhDQo+ID4gICAgKiBzdHJ1Y3R1cmVzLCBwb2xpY2llcywgYW5k
IHN0YXRlcyBzdG9yZWQgaW4ga2VybmVsIG1lbW9yeSB0aGF0IGNhbg0KPiA+ICAgICogaW1wYWN0
IHRoZSBpbnRlZ3JpdHkgb2YgdGhlIHN5c3RlbS4NCj4gPiArICoNCj4gPiArICogUmV0dXJuOiAw
IGlmIHRoZSBidWZmZXIgaGFzIGJlZW4gc3VjY2Vzc2Z1bGx5IG1lYXN1cmVkLCBhIG5lZ2F0aXZl
IHZhbHVlDQo+ID4gKyAqIG90aGVyd2lzZS4NCj4gPiAgICAqLw0KPiA+IC12b2lkIGltYV9tZWFz
dXJlX2NyaXRpY2FsX2RhdGEoY29uc3QgY2hhciAqZXZlbnRfbGFiZWwsDQo+ID4gLQkJCSAgICAg
ICBjb25zdCBjaGFyICpldmVudF9uYW1lLA0KPiA+IC0JCQkgICAgICAgY29uc3Qgdm9pZCAqYnVm
LCBzaXplX3QgYnVmX2xlbiwNCj4gPiAtCQkJICAgICAgIGJvb2wgaGFzaCkNCj4gPiAraW50IGlt
YV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoY29uc3QgY2hhciAqZXZlbnRfbGFiZWwsDQo+ID4gKwkJ
CSAgICAgIGNvbnN0IGNoYXIgKmV2ZW50X25hbWUsDQo+ID4gKwkJCSAgICAgIGNvbnN0IHZvaWQg
KmJ1Ziwgc2l6ZV90IGJ1Zl9sZW4sDQo+ID4gKwkJCSAgICAgIGJvb2wgaGFzaCkNCj4gPiAgIHsN
Cj4gPiAgIAlpZiAoIWV2ZW50X25hbWUgfHwgIWV2ZW50X2xhYmVsIHx8ICFidWYgfHwgIWJ1Zl9s
ZW4pDQo+ID4gLQkJcmV0dXJuOw0KPiA+ICsJCXJldHVybiAtRU5PUEFSQU07DQo+ID4NCj4gPiAt
CXByb2Nlc3NfYnVmZmVyX21lYXN1cmVtZW50KCZpbml0X3VzZXJfbnMsIE5VTEwsIGJ1ZiwgYnVm
X2xlbiwNCj4gZXZlbnRfbmFtZSwNCj4gPiAtCQkJCSAgIENSSVRJQ0FMX0RBVEEsIDAsIGV2ZW50
X2xhYmVsLA0KPiA+IC0JCQkJICAgaGFzaCk7DQo+ID4gKwlyZXR1cm4gcHJvY2Vzc19idWZmZXJf
bWVhc3VyZW1lbnQoJmluaXRfdXNlcl9ucywgTlVMTCwgYnVmLA0KPiBidWZfbGVuLA0KPiA+ICsJ
CQkJCSAgZXZlbnRfbmFtZSwgQ1JJVElDQUxfREFUQSwgMCwNCj4gPiArCQkJCQkgIGV2ZW50X2xh
YmVsLCBoYXNoKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGludCBfX2luaXQgaW5pdF9p
bWEodm9pZCkNCj4gPiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcXVl
dWVfa2V5cy5jDQo+IGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcXVldWVfa2V5cy5jDQo+
ID4gaW5kZXggOTc5ZWY2YzcxZjNkLi5lMzA0N2NlNjRmMzkgMTAwNjQ0DQo+ID4gLS0tIGEvc2Vj
dXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfcXVldWVfa2V5cy5jDQo+ID4gKysrIGIvc2VjdXJpdHkv
aW50ZWdyaXR5L2ltYS9pbWFfcXVldWVfa2V5cy5jDQo+ID4gQEAgLTEzNCw2ICsxMzQsNyBAQCB2
b2lkIGltYV9wcm9jZXNzX3F1ZXVlZF9rZXlzKHZvaWQpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0
IGltYV9rZXlfZW50cnkgKmVudHJ5LCAqdG1wOw0KPiA+ICAgCWJvb2wgcHJvY2VzcyA9IGZhbHNl
Ow0KPiA+ICsJaW50IHJldCBfX21heWJlX3VudXNlZDsNCj4gPg0KPiA+ICAgCWlmIChpbWFfcHJv
Y2Vzc19rZXlzKQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4gQEAgLTE1OSwxMyArMTYwLDEzIEBAIHZv
aWQgaW1hX3Byb2Nlc3NfcXVldWVkX2tleXModm9pZCkNCj4gPg0KPiA+ICAgCWxpc3RfZm9yX2Vh
Y2hfZW50cnlfc2FmZShlbnRyeSwgdG1wLCAmaW1hX2tleXMsIGxpc3QpIHsNCj4gPiAgIAkJaWYg
KCF0aW1lcl9leHBpcmVkKQ0KPiA+IC0JCQlwcm9jZXNzX2J1ZmZlcl9tZWFzdXJlbWVudCgmaW5p
dF91c2VyX25zLCBOVUxMLA0KPiA+IC0JCQkJCQkgICBlbnRyeS0+cGF5bG9hZCwNCj4gPiAtCQkJ
CQkJICAgZW50cnktPnBheWxvYWRfbGVuLA0KPiA+IC0JCQkJCQkgICBlbnRyeS0+a2V5cmluZ19u
YW1lLA0KPiA+IC0JCQkJCQkgICBLRVlfQ0hFQ0ssIDAsDQo+ID4gLQkJCQkJCSAgIGVudHJ5LT5r
ZXlyaW5nX25hbWUsDQo+ID4gLQkJCQkJCSAgIGZhbHNlKTsNCj4gPiArCQkJcmV0ID0gcHJvY2Vz
c19idWZmZXJfbWVhc3VyZW1lbnQoJmluaXRfdXNlcl9ucywNCj4gTlVMTCwNCj4gPiArCQkJCQkJ
CSBlbnRyeS0+cGF5bG9hZCwNCj4gPiArCQkJCQkJCSBlbnRyeS0+cGF5bG9hZF9sZW4sDQo+ID4g
KwkJCQkJCQkgZW50cnktDQo+ID5rZXlyaW5nX25hbWUsDQo+ID4gKwkJCQkJCQkgS0VZX0NIRUNL
LCAwLA0KPiA+ICsJCQkJCQkJIGVudHJ5LQ0KPiA+a2V5cmluZ19uYW1lLA0KPiA+ICsJCQkJCQkJ
IGZhbHNlKTsNCj4gU2FtZSBjb21tZW50IGFzIGFib3ZlLg0KPiANCj4gPiAgIAkJbGlzdF9kZWwo
JmVudHJ5LT5saXN0KTsNCj4gPiAgIAkJaW1hX2ZyZWVfa2V5X2VudHJ5KGVudHJ5KTsNCj4gPiAg
IAl9DQo+ID4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlbGludXgvaW1hLmMgYi9zZWN1cml0eS9z
ZWxpbnV4L2ltYS5jDQo+ID4gaW5kZXggMzRkNDIxODYxYmZjLi40ZGI5ZmEyMTE2MzggMTAwNjQ0
DQo+ID4gLS0tIGEvc2VjdXJpdHkvc2VsaW51eC9pbWEuYw0KPiA+ICsrKyBiL3NlY3VyaXR5L3Nl
bGludXgvaW1hLmMNCj4gPiBAQCAtNzUsNiArNzUsNyBAQCB2b2lkIHNlbGludXhfaW1hX21lYXN1
cmVfc3RhdGVfbG9ja2VkKHN0cnVjdA0KPiBzZWxpbnV4X3N0YXRlICpzdGF0ZSkNCj4gPiAgIAlj
aGFyICpzdGF0ZV9zdHIgPSBOVUxMOw0KPiA+ICAgCXZvaWQgKnBvbGljeSA9IE5VTEw7DQo+ID4g
ICAJc2l6ZV90IHBvbGljeV9sZW47DQo+ID4gKwlpbnQgbWVhc3VyZV9yYyBfX21heWJlX3VudXNl
ZDsNCj4gPiAgIAlpbnQgcmMgPSAwOw0KPiA+DQo+ID4gICAJV0FSTl9PTighbXV0ZXhfaXNfbG9j
a2VkKCZzdGF0ZS0+cG9saWN5X211dGV4KSk7DQo+ID4gQEAgLTg1LDggKzg2LDkgQEAgdm9pZCBz
ZWxpbnV4X2ltYV9tZWFzdXJlX3N0YXRlX2xvY2tlZChzdHJ1Y3QNCj4gc2VsaW51eF9zdGF0ZSAq
c3RhdGUpDQo+ID4gICAJCXJldHVybjsNCj4gPiAgIAl9DQo+ID4NCj4gPiAtCWltYV9tZWFzdXJl
X2NyaXRpY2FsX2RhdGEoInNlbGludXgiLCAic2VsaW51eC1zdGF0ZSIsDQo+ID4gLQkJCQkgIHN0
YXRlX3N0ciwgc3RybGVuKHN0YXRlX3N0ciksIGZhbHNlKTsNCj4gPiArCW1lYXN1cmVfcmMgPSBp
bWFfbWVhc3VyZV9jcml0aWNhbF9kYXRhKCJzZWxpbnV4IiwgInNlbGludXgtc3RhdGUiLA0KPiA+
ICsJCQkJCSAgICAgICBzdGF0ZV9zdHIsIHN0cmxlbihzdGF0ZV9zdHIpLA0KPiA+ICsJCQkJCSAg
ICAgICBmYWxzZSk7DQo+IFNpbmNlIHRoZSByZXR1cm4gdmFsdWUgb2YgaW1hX21lYXN1cmVfY3Jp
dGljYWxfZGF0YSgpIGlzIG5vdCB1c2VkIGhlcmUsDQo+IHRoaXMgY2hhbmdlIGNhbiBiZSBtYWRl
IHdoZW4gbmVlZGVkLg0KPiANCj4gPg0KPiA+ICAgCWtmcmVlKHN0YXRlX3N0cik7DQo+ID4NCj4g
PiBAQCAtMTAyLDggKzEwNCw4IEBAIHZvaWQgc2VsaW51eF9pbWFfbWVhc3VyZV9zdGF0ZV9sb2Nr
ZWQoc3RydWN0DQo+IHNlbGludXhfc3RhdGUgKnN0YXRlKQ0KPiA+ICAgCQlyZXR1cm47DQo+ID4g
ICAJfQ0KPiA+DQo+ID4gLQlpbWFfbWVhc3VyZV9jcml0aWNhbF9kYXRhKCJzZWxpbnV4IiwgInNl
bGludXgtcG9saWN5LWhhc2giLA0KPiA+IC0JCQkJICBwb2xpY3ksIHBvbGljeV9sZW4sIHRydWUp
Ow0KPiA+ICsJbWVhc3VyZV9yYyA9IGltYV9tZWFzdXJlX2NyaXRpY2FsX2RhdGEoInNlbGludXgi
LCAic2VsaW51eC1wb2xpY3ktDQo+IGhhc2giLA0KPiA+ICsJCQkJCSAgICAgICBwb2xpY3ksIHBv
bGljeV9sZW4sIHRydWUpOw0KPiBTYW1lIGNvbW1lbnQgYXMgYWJvdmUuDQo+IA0KPiAgIC1sYWtz
aG1pDQo+IA0KPiA+DQo+ID4gICAJdmZyZWUocG9saWN5KTsNCj4gPiAgIH0NCj4gPg0K
