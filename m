Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4ED154137
	for <lists+linux-security-module@lfdr.de>; Thu,  6 Feb 2020 10:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgBFJdo (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 6 Feb 2020 04:33:44 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2383 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727976AbgBFJdn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 6 Feb 2020 04:33:43 -0500
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 78DB1232C0D94DCA3EA5;
        Thu,  6 Feb 2020 09:33:41 +0000 (GMT)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 6 Feb 2020 09:33:41 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 6 Feb 2020 10:33:40 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Thu, 6 Feb 2020 10:33:40 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/8] ima: Switch to ima_hash_algo for boot aggregate
Thread-Topic: [PATCH v2 2/8] ima: Switch to ima_hash_algo for boot aggregate
Thread-Index: AQHV3A/jJwoPNNxgYk6BJdeHa69IC6gNAGCAgADoNmA=
Date:   Thu, 6 Feb 2020 09:33:40 +0000
Message-ID: <0560eb4c2d804e4b826a9f1bb96c8553@huawei.com>
References: <20200205103317.29356-1-roberto.sassu@huawei.com>
         <20200205103317.29356-3-roberto.sassu@huawei.com>
 <1580935285.5585.297.camel@linux.ibm.com>
In-Reply-To: <1580935285.5585.297.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaW1pIFpvaGFyIFttYWlsdG86
em9oYXJAbGludXguaWJtLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA1LCAyMDIw
IDk6NDEgUE0NCj4gVG86IFJvYmVydG8gU2Fzc3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT47
DQo+IEphbWVzLkJvdHRvbWxleUBIYW5zZW5QYXJ0bmVyc2hpcC5jb207DQo+IGphcmtrby5zYWtr
aW5lbkBsaW51eC5pbnRlbC5jb20NCj4gQ2M6IGxpbnV4LWludGVncml0eUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LXNlY3VyaXR5LW1vZHVsZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IFNpbHZpdSBWbGFzY2VhbnUNCj4gPFNpbHZpdS5WbGFzY2VhbnVA
aHVhd2VpLmNvbT47IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiAyLzhdIGltYTogU3dpdGNoIHRvIGltYV9oYXNoX2FsZ28gZm9yIGJvb3QNCj4gYWdncmVn
YXRlDQo+IA0KPiBPbiBXZWQsIDIwMjAtMDItMDUgYXQgMTE6MzMgKzAxMDAsIFJvYmVydG8gU2Fz
c3Ugd3JvdGU6DQo+ID4gYm9vdF9hZ2dyZWdhdGUgaXMgdGhlIGZpcnN0IGVudHJ5IG9mIElNQSBt
ZWFzdXJlbWVudCBsaXN0LiBJdHMgcHVycG9zZSBpcw0KPiA+IHRvIGxpbmsgcHJlLWJvb3QgbWVh
c3VyZW1lbnRzIHRvIElNQSBtZWFzdXJlbWVudHMuIEFzIElNQSB3YXMNCj4gZGVzaWduZWQgdG8N
Cj4gPiB3b3JrIHdpdGggYSBUUE0gMS4yLCB0aGUgU0hBMSBQQ1IgYmFuayB3YXMgYWx3YXlzIHNl
bGVjdGVkLg0KPiA+DQo+ID4gQ3VycmVudGx5LCBldmVuIGlmIGEgVFBNIDIuMCBpcyB1c2VkLCB0
aGUgU0hBMSBQQ1IgYmFuayBpcyBzZWxlY3RlZC4NCj4gPiBIb3dldmVyLCB0aGUgYXNzdW1wdGlv
biB0aGF0IHRoZSBTSEExIFBDUiBiYW5rIGlzIGFsd2F5cyBhdmFpbGFibGUgaXMgbm90DQo+ID4g
Y29ycmVjdCwgYXMgUENSIGJhbmtzIGNhbiBiZSBzZWxlY3RlZCB3aXRoIHRoZSBQQ1JfQWxsb2Nh
dGUoKSBUUE0NCj4gY29tbWFuZC4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggdHJpZXMgdG8gdXNlIGlt
YV9oYXNoX2FsZ28gYXMgaGFzaCBhbGdvcml0aG0gZm9yDQo+IGJvb3RfYWdncmVnYXRlLg0KPiA+
IElmIG5vIFBDUiBiYW5rIHVzZXMgdGhhdCBhbGdvcml0aG0sIHRoZSBwYXRjaCB0cmllcyB0byBm
aW5kIHRoZSBTSEEyNTYgUENSDQo+ID4gYmFuayAod2hpY2ggaXMgbWFuZGF0b3J5IGluIHRoZSBU
Q0cgUEMgQ2xpZW50IHNwZWNpZmljYXRpb24pLiBJZiBhbHNvIHRoaXMNCj4gPiBiYW5rIGlzIG5v
dCBmb3VuZCwgdGhlIHBhdGNoIHNlbGVjdHMgdGhlIGZpcnN0IG9uZS4gSWYgdGhlIFRQTSBhbGdv
cml0aG0NCj4gPiBvZiB0aGF0IGJhbmsgaXMgbm90IG1hcHBlZCB0byBhIGNyeXB0byBJRCwgYm9v
dF9hZ2dyZWdhdGUgaXMgc2V0IHRvIHplcm8uDQo+ID4NCj4gPiBDaGFuZ2Vsb2cNCj4gPg0KPiA+
IHYxOg0KPiA+IC0gYWRkIE1pbWkncyBjb21tZW50cw0KPiA+IC0gaWYgdGhlcmUgaXMgbm8gUENS
IGJhbmsgZm9yIHRoZSBJTUEgZGVmYXVsdCBhbGdvcml0aG0gdXNlIFNIQTI1NiBvciB0aGUNCj4g
PiAgIGZpcnN0IGJhbmsgKHN1Z2dlc3RlZCBieSBKYW1lcyBCb3R0b21sZXkpDQo+IA0KPiBJZiB0
aGUgSU1BIGRlZmF1bHQgaGFzaCBhbGdvcml0aG0gaXMgbm90IGVuYWJsZWQsIEphbWVzJyBjb21t
ZW50IHdhcw0KPiB0byB1c2UgU0hBMjU2IGZvciBUUE0gMi4wIGFuZCBTSEExIGZvciBUUE0gMS4y
LiDCoEkgZG9uJ3QgcmVtZW1iZXIgaGltDQo+IHNheWluZyBhbnl0aGluZyBhYm91dCB1c2luZyB0
aGUgZmlyc3QgYmFuaywgdGhhdCB3YXMgaW4gdjEgb2YgbXkNCj4gcGF0Y2guIMKgUGxlYXNlIHJl
ZmVyIHRvIHYyIG9mIG15IHBhdGNoLCBiYXNlZCBvbiBKYW1lcycgY29tbWVudHMuDQoNClJpZ2h0
LiBXaWxsIGZpeCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MNCg0KUm9iZXJ0bw0KDQog
PiBSZXBvcnRlZC1ieTogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVkaGF0LmNvbT4NCj4g
PiBTdWdnZXN0ZWQtYnk6IEphbWVzIEJvdHRvbWxleQ0KPiA8SmFtZXMuQm90dG9tbGV5QEhhbnNl
blBhcnRuZXJzaGlwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnRvIFNhc3N1IDxyb2Jl
cnRvLnNhc3N1QGh1YXdlaS5jb20+DQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4g
PiAtLS0NCj4gPiAgc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfY3J5cHRvLmMgfCA0NQ0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICBzZWN1cml0eS9pbnRlZ3JpdHkvaW1h
L2ltYV9pbml0LmMgICB8IDIyICsrKysrKysrKystLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NTYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfY3J5cHRvLmMNCj4gYi9zZWN1cml0eS9pbnRlZ3Jp
dHkvaW1hL2ltYV9jcnlwdG8uYw0KPiA+IGluZGV4IDczMDQ0ZmM2YTk1Mi4uZjJmNDFhMmJjM2Q0
IDEwMDY0NA0KPiA+IC0tLSBhL3NlY3VyaXR5L2ludGVncml0eS9pbWEvaW1hX2NyeXB0by5jDQo+
ID4gKysrIGIvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfY3J5cHRvLmMNCj4gPiBAQCAtNjU1
LDE4ICs2NTUsMjkgQEAgc3RhdGljIHZvaWQgX19pbml0IGltYV9wY3JyZWFkKHUzMiBpZHgsIHN0
cnVjdA0KPiB0cG1fZGlnZXN0ICpkKQ0KPiA+ICB9DQo+ID4NCj4gPiAgLyoNCj4gPiAtICogQ2Fs
Y3VsYXRlIHRoZSBib290IGFnZ3JlZ2F0ZSBoYXNoDQo+ID4gKyAqIFRoZSBib290X2FnZ3JlZ2F0
ZSBpcyBhIGN1bXVsYXRpdmUgaGFzaCBvdmVyIFRQTSByZWdpc3RlcnMgMCAtIDcuDQo+IFdpdGgN
Cj4gPiArICogVFBNIDEuMiB0aGUgYm9vdF9hZ2dyZWdhdGUgd2FzIGJhc2VkIG9uIHJlYWRpbmcg
dGhlIFNIQTEgUENScywgYnV0DQo+IHdpdGgNCj4gPiArICogVFBNIDIuMCBoYXNoIGFnaWxpdHks
IFRQTSBjaGlwcyBjb3VsZCBzdXBwb3J0IG11bHRpcGxlIFRQTSBQQ1IgYmFua3MsDQo+ID4gKyAq
IGFsbG93aW5nIGZpcm13YXJlIHRvIGNvbmZpZ3VyZSBhbmQgZW5hYmxlIGRpZmZlcmVudCBiYW5r
cy4NCj4gPiArICoNCj4gPiArICogS25vd2luZyB3aGljaCBUUE0gYmFuayBpcyByZWFkIHRvIGNh
bGN1bGF0ZSB0aGUgYm9vdF9hZ2dyZWdhdGUNCj4gZGlnZXN0DQo+ID4gKyAqIG5lZWRzIHRvIGJl
IGNvbnZleWVkIHRvIGEgdmVyaWZpZXIuICBGb3IgdGhpcyByZWFzb24sIHVzZSB0aGUgc2FtZQ0K
PiA+ICsgKiBoYXNoIGFsZ29yaXRobSBmb3IgcmVhZGluZyB0aGUgVFBNIFBDUnMgYXMgZm9yIGNh
bGN1bGF0aW5nIHRoZSBib290DQo+ID4gKyAqIGFnZ3JlZ2F0ZSBkaWdlc3QgYXMgc3RvcmVkIGlu
IHRoZSBtZWFzdXJlbWVudCBsaXN0Lg0KPiA+ICAgKi8NCj4gPiAtc3RhdGljIGludCBfX2luaXQg
aW1hX2NhbGNfYm9vdF9hZ2dyZWdhdGVfdGZtKGNoYXIgKmRpZ2VzdCwNCj4gPiArc3RhdGljIGlu
dCBfX2luaXQgaW1hX2NhbGNfYm9vdF9hZ2dyZWdhdGVfdGZtKGNoYXIgKmRpZ2VzdCwgdTE2IGFs
Z19pZCwNCj4gPiAgCQkJCQkgICAgICBzdHJ1Y3QgY3J5cHRvX3NoYXNoICp0Zm0pDQo+ID4gIHsN
Cj4gPiAtCXN0cnVjdCB0cG1fZGlnZXN0IGQgPSB7IC5hbGdfaWQgPSBUUE1fQUxHX1NIQTEsIC5k
aWdlc3QgPSB7MH0gfTsNCj4gPiArCXN0cnVjdCB0cG1fZGlnZXN0IGQgPSB7IC5hbGdfaWQgPSBh
bGdfaWQsIC5kaWdlc3QgPSB7MH0gfTsNCj4gPiAgCWludCByYzsNCj4gPiAgCXUzMiBpOw0KPiA+
ICAJU0hBU0hfREVTQ19PTl9TVEFDSyhzaGFzaCwgdGZtKTsNCj4gPg0KPiA+ICAJc2hhc2gtPnRm
bSA9IHRmbTsNCj4gPg0KPiA+ICsJcHJfZGV2ZWwoImNhbGN1bGF0aW5nIHRoZSBib290LWFnZ3Jl
Z2F0ZSBiYXNlZCBvbiBUUE0NCj4gYmFuazogJTA0eFxuIiwNCj4gPiArCQkgZC5hbGdfaWQpOw0K
PiA+ICsNCj4gDQo+IEdvb2QNCj4gDQo+ID4gIAlyYyA9IGNyeXB0b19zaGFzaF9pbml0KHNoYXNo
KTsNCj4gPiAgCWlmIChyYyAhPSAwKQ0KPiA+ICAJCXJldHVybiByYzsNCj4gPiBAQCAtNjc1LDcg
KzY4Niw4IEBAIHN0YXRpYyBpbnQgX19pbml0IGltYV9jYWxjX2Jvb3RfYWdncmVnYXRlX3RmbShj
aGFyDQo+ICpkaWdlc3QsDQo+ID4gIAlmb3IgKGkgPSBUUE1fUENSMDsgaSA8IFRQTV9QQ1I4OyBp
KyspIHsNCj4gPiAgCQlpbWFfcGNycmVhZChpLCAmZCk7DQo+ID4gIAkJLyogbm93IGFjY3VtdWxh
dGUgd2l0aCBjdXJyZW50IGFnZ3JlZ2F0ZSAqLw0KPiA+IC0JCXJjID0gY3J5cHRvX3NoYXNoX3Vw
ZGF0ZShzaGFzaCwgZC5kaWdlc3QsDQo+IFRQTV9ESUdFU1RfU0laRSk7DQo+ID4gKwkJcmMgPSBj
cnlwdG9fc2hhc2hfdXBkYXRlKHNoYXNoLCBkLmRpZ2VzdCwNCj4gPiArCQkJCQkgY3J5cHRvX3No
YXNoX2RpZ2VzdHNpemUodGZtKSk7DQo+ID4gIAl9DQo+ID4gIAlpZiAoIXJjKQ0KPiA+ICAJCWNy
eXB0b19zaGFzaF9maW5hbChzaGFzaCwgZGlnZXN0KTsNCj4gPiBAQCAtNjg1LDE0ICs2OTcsMzUg
QEAgc3RhdGljIGludCBfX2luaXQNCj4gaW1hX2NhbGNfYm9vdF9hZ2dyZWdhdGVfdGZtKGNoYXIg
KmRpZ2VzdCwNCj4gPiAgaW50IF9faW5pdCBpbWFfY2FsY19ib290X2FnZ3JlZ2F0ZShzdHJ1Y3Qg
aW1hX2RpZ2VzdF9kYXRhICpoYXNoKQ0KPiA+ICB7DQo+ID4NCj4gPCBzbmlwID4NCj4gPg0KPiA+
ICAJaGFzaC0+bGVuZ3RoID0gY3J5cHRvX3NoYXNoX2RpZ2VzdHNpemUodGZtKTsNCj4gPiAtCXJj
ID0gaW1hX2NhbGNfYm9vdF9hZ2dyZWdhdGVfdGZtKGhhc2gtPmRpZ2VzdCwgdGZtKTsNCj4gPiAr
CWFsZ19pZCA9IGltYV90cG1fY2hpcC0+YWxsb2NhdGVkX2JhbmtzW2JhbmtfaWR4XS5hbGdfaWQ7
DQo+ID4gKwlyYyA9IGltYV9jYWxjX2Jvb3RfYWdncmVnYXRlX3RmbShoYXNoLT5kaWdlc3QsIGFs
Z19pZCwgdGZtKTsNCj4gDQo+IFN1cmUsIGJhY2twb3J0aW5nIHRoaXMgY2hhbmdlIHRvIGltYV9j
YWxjX2Jvb3RfYWdncmVnYXRlX3RmbSgpIHNob3VsZA0KPiBiZSBmaW5lLg0KPiANCj4gTWltaQ0K
PiANCj4gPiAgCWltYV9mcmVlX3RmbSh0Zm0pOw0KPiA+DQoNCg==
