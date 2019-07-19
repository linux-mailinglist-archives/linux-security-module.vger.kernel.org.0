Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18E16ECCA
	for <lists+linux-security-module@lfdr.de>; Sat, 20 Jul 2019 01:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbfGSXiP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 19 Jul 2019 19:38:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47127 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfGSXiP (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Jul 2019 19:38:15 -0400
Received: from static-50-53-33-191.bvtn.or.frontiernet.net ([50.53.33.191] helo=[192.168.192.153])
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <john.johansen@canonical.com>)
        id 1hocRt-0007pH-J2; Fri, 19 Jul 2019 23:38:01 +0000
Subject: Re: [PATCH v5 15/23] LSM: Specify which LSM to display
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     keescook@chromium.org, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com,
        "linux-audit@redhat.com" <linux-audit@redhat.com>
References: <20190703212538.7383-1-casey@schaufler-ca.com>
 <20190703212538.7383-16-casey@schaufler-ca.com>
 <6f593ae9-4c79-7a04-41a3-c04ebd689658@tycho.nsa.gov>
 <a3537a96-84d7-ad82-f76e-af0f44331c1b@schaufler-ca.com>
 <dbdcfb3d-a88a-67eb-a100-848f3335e9a3@tycho.nsa.gov>
 <1d62a67c-2096-5d8b-dad4-2e1c1c0ebc06@schaufler-ca.com>
 <c592f686-e026-642e-b8b3-bca08d0a0f05@tycho.nsa.gov>
From:   John Johansen <john.johansen@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=john.johansen@canonical.com; prefer-encrypt=mutual; keydata=
 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
Organization: Canonical
Message-ID: <5ead4c47-fd0e-6e8e-b58c-eec5b2a67ddc@canonical.com>
Date:   Fri, 19 Jul 2019 16:37:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c592f686-e026-642e-b8b3-bca08d0a0f05@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: base64
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gNy85LzE5IDI6MzQgUE0sIFN0ZXBoZW4gU21hbGxleSB3cm90ZToNCj4gT24gNy85LzE5
IDU6MTggUE0sIENhc2V5IFNjaGF1ZmxlciB3cm90ZToNCj4+IE9uIDcvOS8yMDE5IDExOjEy
IEFNLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6DQo+Pj4gT24gNy85LzE5IDE6NTEgUE0sIENh
c2V5IFNjaGF1ZmxlciB3cm90ZToNCj4+Pj4gT24gNy85LzIwMTkgMTA6MTMgQU0sIFN0ZXBo
ZW4gU21hbGxleSB3cm90ZToNCj4+Pj4+IE9uIDcvMy8xOSA1OjI1IFBNLCBDYXNleSBTY2hh
dWZsZXIgd3JvdGU6DQo+Pj4+Pj4gQ3JlYXRlIGEgbmV3IGVudHJ5ICJkaXNwbGF5IiBpbiAv
cHJvYy8uLi4vYXR0ciBmb3IgY29udHJvbGxpbmcNCj4+Pj4+PiB3aGljaCBMU00gc2VjdXJp
dHkgaW5mb3JtYXRpb24gaXMgZGlzcGxheWVkIGZvciBhIHByb2Nlc3MuDQo+Pj4+Pj4gVGhl
IG5hbWUgb2YgYW4gYWN0aXZlIExTTSB0aGF0IHN1cHBsaWVzIGhvb2tzIGZvciBodW1hbiBy
ZWFkYWJsZQ0KPj4+Pj4+IGRhdGEgbWF5IGJlIHdyaXR0ZW4gdG8gImRpc3BsYXkiIHRvIHNl
dCB0aGUgdmFsdWUuIFRoZSBuYW1lIG9mDQo+Pj4+Pj4gdGhlIExTTSBjdXJyZW50bHkgaW4g
dXNlIGNhbiBiZSByZWFkIGZyb20gImRpc3BsYXkiLg0KPj4+Pj4+IEF0IHRoaXMgcG9pbnQg
dGhlcmUgY2FuIG9ubHkgYmUgb25lIExTTSBjYXBhYmxlIG9mIGRpc3BsYXkNCj4+Pj4+PiBh
Y3RpdmUuIEEgaGVscGVyIGZ1bmN0aW9uIGxzbV90YXNrX2Rpc3BsYXkoKSB0byBnZXQgdGhl
IGRpc3BsYXkNCj4+Pj4+PiBzbG90IGZvciBhIHRhc2tfc3RydWN0Lg0KPj4+Pj4NCj4+Pj4+
IEFzIEkgZXhwbGFpbmVkIHByZXZpb3VzbHksIHRoaXMgaXMgYSBzZWN1cml0eSBob2xlIHdh
aXRpbmcgdG8gaGFwcGVuLiBJdCBzdGlsbCBwZXJtaXRzIGEgcHJvY2VzcyB0byBhZmZlY3Qg
dGhlIG91dHB1dCBvZiBhdWRpdCwgYWx0ZXIgdGhlIHJlc3VsdCBvZiByZWFkaW5nIG9yIHdy
aXRpbmcgL3Byb2Mvc2VsZi9hdHRyIG5vZGVzIGV2ZW4gYnkgc2V0dWlkL3NldGdpZC9maWxl
LWNhcHMvY29udGV4dC1jaGFuZ2luZyBwcm9ncmFtcywgYWx0ZXIgdGhlIGNvbnRleHRzIGdl
bmVyYXRlZCBpbiBuZXRsaW5rIG1lc3NhZ2VzIGRlbGl2ZXJlZCB0byBvdGhlciBwcm9jZXNz
ZXMgKEkgdGhpbms/KSwgYW5kIHBvc3NpYmx5IG90aGVyIGVmZmVjdHMgYmV5b25kIGFmZmVj
dGluZyB0aGUgcHJvY2Vzcycgb3duIHZpZXcgb2YgdGhpbmdzLg0KPj4+Pg0KPj4+PiBJIHdv
dWxkIHZlcnkgbXVjaCBsaWtlIHNvbWUgZmVlZGJhY2sgcmVnYXJkaW5nIHdoaWNoIG9mIHRo
ZQ0KPj4+PiBwb3NzaWJsZSBmb3JtYXRzIGZvciBwdXR0aW5nIG11bHRpcGxlIHN1YmplY3Qg
Y29udGV4dHMgaW4NCj4+Pj4gYXVkaXQgcmVjb3JkcyB3b3VsZCBiZSBwcmVmZXJyZWQ6DQo+
Pj4+DQo+Pj4+IMKgwqDCoMKgwqBsc209c2VsaW51eCxzdWJqPXh5enp5X3QgbHNtPXNtYWNr
LHN1Ymo9WHl6enkNCj4+Pj4gwqDCoMKgwqDCoGxzbT1zZWxpbnV4LHNtYWNrIHN1Ymo9eHl6
enlfdCxYeXp6eQ0KPj4+PiDCoMKgwqDCoMKgc3Viaj0ic2VsaW51eD0neHl6enlfdCcsc21h
Y2s9J1h5enp5JyINCj4+Pg0KPj4+IChjYydkIGxpbnV4LWF1ZGl0IG1haWxpbmcgbGlzdCkN
Cj4+Pg0KPj4+Pg0KPj4+PiBPciBzb21ldGhpbmcgZWxzZS4gRnJlZSBiaWtlc2hlZGRpbmch
DQo+Pj4+DQo+Pj4+IEkgZG9uJ3Qgc2VlIGhvdyB5b3UgaGF2ZSBhIHByb2JsZW0gd2l0aCBu
ZXRsaW5rLiBNeSBsb29rDQo+Pj4+IGF0IHdoYXQncyBpbiB0aGUga2VybmVsIGRpZG4ndCBl
eHBvc2UgYW55dGhpbmcsIGJ1dCBJIGFtDQo+Pj4+IHdpbGxpbmcgdG8gYmUgZWR1Y2F0ZWQu
DQo+Pj4NCj4+PiBJIGhhdmVuJ3QgdHJhY2VkIHRocm91Z2ggaXQgaW4gZGV0YWlsLCBidXQg
aXQgd2Fzbid0IGNsZWFyIHRvIG1lIHRoYXQgdGhlIHNlY3VyaXR5X3NlY2lkX3RvX3NlY2N0
eCgpIGNhbGwgYWx3YXlzIG9jY3VycyBpbiB0aGUgY29udGV4dCBvZiB0aGUgcmVjZWl2aW5n
IHByb2Nlc3MgKGFuZCBoZW5jZSB1c2UgaXRzIGRpc3BsYXkgdmFsdWUpLsKgIElmIG5vdCwg
dGhlbiB0aGUgZGlzcGxheSBvZiB0aGUgc2VuZGVyIGNhbiBhZmZlY3Qgd2hhdCBpcyByZXBv
cnRlZCB0byB0aGUgcmVjZWl2ZXI7IGhlbmNlLCB0aGVyZSBpcyBhIGZvcmdlcnkgY29uY2Vy
biBzaW1pbGFyIHRvIHRoZSBiaW5kZXIgaXNzdWUuwqAgSXQgd291bGQgYmUgY2xlYW5lciBp
ZiB3ZSBkaWRuJ3QgYWx0ZXIgdGhlIGRlZmF1bHQgYmVoYXZpb3Igb2Ygc2VjdXJpdHlfc2Vj
aWRfdG9fc2VjY3R4KCkgYW5kIHNlY3VyaXR5X3NlY2N0eF90b19zZWNpZCgpIGFuZCBpbnN0
ZWFkIGludHJvZHVjZWQgbmV3IGhvb2tzIGZvciBhbnkgY2FzZSB3aGVyZSB3ZSB0cnVseSB3
YW50IHRoZSBkaXNwbGF5IHRvIHRha2UgZWZmZWN0Lg0KPj4NCj4+IElmIHRoZSBjb250ZXh0
IGlzIGdlbmVyYXRlZCBieSBzZWN1cml0eV9zZWNpZF90b19zZWNjdHgoKSB3ZQ0KPj4gcmV0
YWluIHRoZSBzbG90IG51bWJlciBvZiB0aGUgbW9kdWxlIHRoYXQgY3JlYXRlZCBpdCBpbiBs
c21jb250ZXh0Lg0KPj4gV2UgaGF2ZSB0byB0byBlbnN1cmUgaXQgaXMgcmVsZWFzZWQgY29y
cmVjdGx5LiBJZiB0aGUgcG90ZW50aWFsDQo+PiBpc3N1ZSB5b3UncmUgZGVzY3JpYmluZyBm
b3IgbmV0bGluayBkb2VzIGluIGZhY3Qgb2NjdXIsIHdlIGNhbiBjaGVjaw0KPj4gdGhlIHNs
b3QgaW4gbHNtY29udGV4dCB0byB2ZXJpZnkgdGhhdCBpdCBpcyB0aGUgc2FtZS4NCj4+DQo+
PiBzZWN1cml0eV9zZWNpZF90b19zZWNjdHgoKSBpcyBjYWxsZWQgbm93aGVyZSBpbiBuZXQv
bmV0bGluaywNCj4+IGF0IGxlYXN0IG5vdCB0aGF0IGdyZXAgZmluZHMuIFdoZXJlIGFyZSB5
b3Ugc2VlaW5nIHRoaXMgcG90ZW50aWFsDQo+PiBwcm9ibGVtPw0KPiANCj4gTG9vayB1bmRl
ciBuZXQvbmV0ZmlsdGVyLg0KPiANCj4+DQo+Pj4NCj4+Pj4NCj4+Pj4+IEJlZm9yZToNCj4+
Pj4+ICQgaWQNCj4+Pj4+IHVpZD0xMDAyKHNkczIpIGdpZD0xMDAyKHNkczIpIGdyb3Vwcz0x
MDAyKHNkczIpIGNvbnRleHQ9c3RhZmZfdTpzdGFmZl9yOnN0YWZmX3Q6czAtczA6YzAuYzEw
MjMNCj4+Pj4+ICQgc3UNCj4+Pj4+IFBhc3N3b3JkOg0KPj4+Pj4gc3U6IEF1dGhlbnRpY2F0
aW9uIGZhaWx1cmUNCj4+Pj4+DQo+Pj4+PiBzeXNjYWxsIGF1ZGl0IHJlY29yZDoNCj4+Pj4+
IHR5cGU9U1lTQ0FMTCBtc2c9YXVkaXQoMDcvMDkvMjAxOSAxMTo1Mjo0OS43ODQ6MzY1KSA6
IGFyY2g9eDg2XzY0IHN5c2NhbGw9b3BlbmF0DQo+Pj4+PiDCoMKgwqBzdWNjZXNzPW5vIGV4
aXQ9RUFDQ0VTKFBlcm1pc3Npb24gZGVuaWVkKSBhMD0weGZmZmZmZjljIGExPTB4NTYwODk3
ZTU4ZTAwIGEyPU9fDQo+Pj4+PiBXUk9OTFkgYTM9MHgwIGl0ZW1zPTEgcHBpZD0zMjU4IHBp
ZD0zNzgxIGF1aWQ9c2RzMiB1aWQ9c2RzMiBnaWQ9c2RzMiBldWlkPXJvb3Qgcw0KPj4+Pj4g
dWlkPXJvb3QgZnN1aWQ9cm9vdCBlZ2lkPXNkczIgc2dpZD1zZHMyIGZzZ2lkPXNkczIgdHR5
PXB0czIgc2VzPTYgY29tbT1zdSBleGU9L3Vzci9iaW4vc3Ugc3Viaj1zdGFmZl91OnN0YWZm
X3I6c3RhZmZfdDpzMC1zMDpjMC5jMTAyMyBrZXk9KG51bGwpDQo+Pj4+Pg0KPj4+Pj4gQWZ0
ZXI6DQo+Pj4+PiAkIGlkDQo+Pj4+PiB1aWQ9MTAwMihzZHMyKSBnaWQ9MTAwMihzZHMyKSBn
cm91cHM9MTAwMihzZHMyKSBjb250ZXh0PXN0YWZmX3U6c3RhZmZfcjpzdGFmZl90OnMwLXMw
OmMwLmMxMDIzDQo+Pj4+PiAkIGVjaG8gYXBwYXJtb3IgPiAvcHJvYy9zZWxmL2F0dHIvZGlz
cGxheQ0KPj4+Pj4gJCBzdQ0KPj4+Pj4gUGFzc3dvcmQ6DQo+Pj4+PiBzdTogQXV0aGVudGlj
YXRpb24gZmFpbHVyZQ0KPj4+Pj4NCj4+Pj4+IGF1ZGl0IHJlY29yZDoNCj4+Pj4+IHR5cGU9
U1lTQ0FMTCBtc2c9YXVkaXQoMDcvMDkvMjAxOSAxMjowNTozMi40MDI6NDA2KSA6IGFyY2g9
eDg2XzY0IHN5c2NhbGw9b3BlbmF0IHN1Y2Nlc3M9bm8gZXhpdD1FQUNDRVMoUGVybWlzc2lv
biBkZW5pZWQpIGEwPTB4ZmZmZmZmOWMgYTE9MHg1NTZiNDFlMWFlMDAgYTI9T19XUk9OTFkg
YTM9MHgwIGl0ZW1zPTEgcHBpZD0zMjU4IHBpZD05NDI2IGF1aWQ9c2RzMiB1aWQ9c2RzMiBn
aWQ9c2RzMiBldWlkPXJvb3Qgc3VpZD1yb290IGZzdWlkPXJvb3QgZWdpZD1zZHMyIHNnaWQ9
c2RzMiBmc2dpZD1zZHMyIHR0eT1wdHMyIHNlcz02IGNvbW09c3UgZXhlPS91c3IvYmluL3N1
IHN1Ymo9PXVuY29uZmluZWQga2V5PShudWxsKQ0KPj4+Pj4NCj4+Pj4+IE5CIFRoZSBzdWJq
PSBmaWVsZCBvZiB0aGUgU1lTQ0FMTCBhdWRpdCByZWNvcmQgaXMgbG9uZ2VyIGFjY3VyYXRl
IGFuZCBpcyBwb3RlbnRpYWxseSB1bmRlciB0aGUgY29udHJvbCBvZiBhIHByb2Nlc3MgdGhh
dCB3b3VsZCBub3QgYmUgYXV0aG9yaXplZCB0byBzZXQgaXRzIHN1YmplY3QgbGFiZWwgdG8g
dGhhdCB2YWx1ZSBieSBTRUxpbnV4Lg0KPj4+Pg0KPj4+PiBJdCdzIHN0aWxsIGFjY3VyYXRl
LCBpdCdzIGp1c3Qgbm90IGNvbXBsZXRlLiBJdCdzIGEgbWF0dGVyDQo+Pj4+IG9mIGhvdyBi
ZXN0IHRvIGNvbXBsZXRlIGl0Lg0KPj4+Pg0KPj4+Pj4NCj4+Pj4+IE5vdywgbGV0J3MgcGxh
eSB3aXRoIHVzZXJzcGFjZS4NCj4+Pj4+DQo+Pj4+PiBCZWZvcmU6DQo+Pj4+PiAjIGlkDQo+
Pj4+PiB1aWQ9MChyb290KSBnaWQ9MChyb290KSBncm91cHM9MChyb290KSBjb250ZXh0PXN0
YWZmX3U6c3RhZmZfcjpzdGFmZl90OnMwLXMwOmMwLmMxMDIzDQo+Pj4+PiAjIHBhc3N3ZCBy
b290DQo+Pj4+PiBwYXNzd2Q6IFNFTGludXggZGVueSBhY2Nlc3MgZHVlIHRvIHNlY3VyaXR5
IHBvbGljeS4NCj4+Pj4+DQo+Pj4+PiBhdWRpdCByZWNvcmQ6DQo+Pj4+PiB0eXBlPVVTRVJf
QVZDIG1zZz1hdWRpdCgwNy8wOS8yMDE5IDEyOjI0OjM1LjEzNTo4MTIpIDogcGlkPTEyNjkz
IHVpZD1yb290IGF1aWQ9c2RzMiBzZXM9NyBzdWJqPXN0YWZmX3U6c3RhZmZfcjpwYXNzd2Rf
dDpzMC1zMDpjMC5jMTAyMyBtc2c9J2F2YzrCoCBkZW5pZWTCoCB7IHBhc3N3ZCB9IGZvciBz
Y29udGV4dD1zdGFmZl91OnN0YWZmX3I6c3RhZmZfdDpzMC1zMDpjMC5jMTAyMyB0Y29udGV4
dD1zdGFmZl91OnN0YWZmX3I6c3RhZmZfdDpzMC1zMDpjMC5jMTAyMyB0Y2xhc3M9cGFzc3dk
IHBlcm1pc3NpdmU9MMKgIGV4ZT0vdXNyL2Jpbi9wYXNzd2Qgc2F1aWQ9cm9vdCBob3N0bmFt
ZT0/IGFkZHI9PyB0ZXJtaW5hbD1wdHMvMicNCj4+Pj4+IHR5cGU9VVNFUl9DSEFVVEhUT0sg
bXNnPWF1ZGl0KDA3LzA5LzIwMTkgMTI6MjQ6MzUuMTM1OjgxMykgOiBwaWQ9MTI2OTMgdWlk
PXJvb3QgYXVpZD1zZHMyIHNlcz03IHN1Ymo9c3RhZmZfdTpzdGFmZl9yOnBhc3N3ZF90OnMw
LXMwOmMwLmMxMDIzIG1zZz0nb3A9YXR0ZW1wdGVkLXRvLWNoYW5nZS1wYXNzd29yZCBpZD1y
b290IGV4ZT0vdXNyL2Jpbi9wYXNzd2QgaG9zdG5hbWU9bW9zcy1wbHV0by5pbmZvc2VjLnR5
Y2hvLm5jc2MubWlsIGFkZHI9PyB0ZXJtaW5hbD1wdHMvMiByZXM9ZmFpbGVkJw0KPj4+Pj4N
Cj4+Pj4+IEFmdGVyOg0KPj4+Pj4gIyBpZA0KPj4+Pj4gdWlkPTAocm9vdCkgZ2lkPTAocm9v
dCkgZ3JvdXBzPTAocm9vdCkgY29udGV4dD1zdGFmZl91OnN0YWZmX3I6c3RhZmZfdDpzMC1z
MDpjMC5jMTAyMw0KPj4+Pj4gIyBlY2hvIGFwcGFybW9yID4gL3Byb2Mvc2VsZi9hdHRyL2Rp
c3BsYXkNCj4+Pj4+ICMgcGFzc3dkIHJvb3QNCj4+Pj4+IHBhc3N3ZDogU0VMaW51eCBkZW55
IGFjY2VzcyBkdWUgdG8gc2VjdXJpdHkgcG9saWN5Lg0KPj4+Pj4NCj4+Pj4+IGF1ZGl0IHJl
Y29yZDoNCj4+Pj4+IHR5cGU9VVNFUl9DSEFVVEhUT0sgbXNnPWF1ZGl0KDA3LzA5LzIwMTkg
MTI6Mjg6NDEuMzQ5OjgzMikgOiBwaWQ9MTMwODMgdWlkPXJvb3QgYXVpZD1zZHMyIHNlcz03
IHN1Ymo9PXVuY29uZmluZWQgbXNnPSdvcD1hdHRlbXB0ZWQtdG8tY2hhbmdlLXBhc3N3b3Jk
IGlkPXJvb3QgZXhlPS91c3IvYmluL3Bhc3N3ZCBob3N0bmFtZT1tb3NzLXBsdXRvLmluZm9z
ZWMudHljaG8ubmNzYy5taWwgYWRkcj0/IHRlcm1pbmFsPXB0cy8yIHJlcz1mYWlsZWQnDQo+
Pj4+Pg0KPj4+Pj4gSGVyZSB3ZSBhZ2FpbiBnZXQgdGhlIHdyb25nIHZhbHVlIGZvciBzdWJq
PSBpbiB0aGUgVVNFUl9DSEFVVEhUT0sgYXVkaXQgcmVjb3JkLCBhbmQgd2UgZnVydGhlciBs
b3NlIHRoZSBVU0VSX0FWQyByZWNvcmQgZW50aXJlbHkgYmVjYXVzZSBpdCBkaWRuJ3QgZXZl
biByZWFjaCB0aGUgcG9pbnQgb2YgdGhlIHBlcm1pc3Npb24gY2hlY2sgZHVlIHRvIG5vdCBi
ZWluZyBhYmxlIHRvIGdldCB0aGUgY2FsbGVyIGNvbnRleHQuDQo+Pj4+Pg0KPj4+Pj4gVGhl
IHNpdHVhdGlvbiBnZXRzIHdvcnNlIGlmIHRoZSBjYWxsZXIgY2FuIHNldCB0aGluZ3MgdXAg
c3VjaCB0aGF0IGl0IGNhbiBzZXQgYW4gYXR0cmlidXRlIHZhbHVlIGZvciBvbmUgc2VjdXJp
dHkgbW9kdWxlIHRoYXQgaXMgdmFsaWQgYW5kIHByaXZpbGVnZWQgd2l0aCByZXNwZWN0IHRv
IGFub3RoZXIgc2VjdXJpdHkgbW9kdWxlLsKgIFRoaXMgaXNuJ3QgYSBmYXItZmV0Y2hlZCBz
Y2VuYXJpbzsgQXBwQXJtb3Igd2lsbCBkZWZhdWx0IHRvIHJ1bm5pbmcgZXZlcnl0aGluZyB1
bmNvbmZpbmVkLCBzbyBhcyBzb29uIGFzIHlvdSBlbmFibGUgaXQsIGFueSByb290IHByb2Nl
c3MgY2FuIHBvdGVudGlhbGx5IGxvYWQgYSBwb2xpY3kgdGhhdCBkZWZpbmVzIGNvbnRleHRz
IHRoYXQgbG9vayBleGFjdGx5IGxpa2UgU0VMaW51eCBjb250ZXh0cy4gU21hY2sgaXMgZXZl
biBzaW1wbGVyOyB5b3UgY2FuIHNldCBhbnkgYXJiaXRyYXJ5IHN0cmluZyB5b3Ugd2FudCBh
cyBsb25nIGFzIHlvdSBhcmUgcm9vdCAoYnkgZGVmYXVsdCk7IG5vIHBvbGljeSByZXF1aXJl
ZC7CoCBTbyBhIHJvb3QgcHJvY2VzcyB0aGF0IGlzIGNvbmZpbmVkIGJ5IFNFTGludXggKG9y
IGJ5IEFwcEFtb3IpIGNhbiBzdWRkZW5seSBmb3JnZSBhcmJpdHJhcnkgY29udGV4dHMgaW4g
YXVkaXQgcmVjb3JkcyBvciByZWFkcyBvZiAvcHJvYy9zZWxmL2F0dHIgbm9kZXMgb3IgbmV0
bGluayBtZXNzYWdlcyBvciAuLi4sIGp1c3QgYnkgdmlydHVlIG9mIGFwcGx5aW5nIHRoZXNl
IHBhdGNoZXMgYW5kIGVuYWJsaW5nIGFub3RoZXIgc2VjdXJpdHkgbW9kdWxlIGxpa2UgU21h
Y2suIE9yIGNvbnNpZGVyIGlmIHB0YWdzIHdlcmUgZXZlciBtYWRlIHJlYWwgYW5kIG1lcmdl
ZCAtIGJ5IGRlc2lnbiwgdGhhdCdzIGFsbCBhYm91dCBzZXR0aW5nIGFyYml0cmFyeSB0YWdz
IGZyb20gdXNlcnNwYWNlLsKgIFRoZW4gdGhlcmUgaXMgdGhlIHNlcGFyYXRlIGlzc3VlIG9m
IHN3aXRjaGluZw0KPj4+Pj4gZGlzcGxheSB0byBwcmV2ZW50IGF0dGVtcHRzIGJ5IGEgbW9y
ZSBwcml2aWxlZ2VkIHByb2dyYW0gdG8gc2V0IG9uZSBvZiBpdHMgYXR0cmlidXRlcyBmcm9t
IHRha2luZyBlZmZlY3QuIFdoZXJlIGhhdmUgd2Ugc2VlbiB0aGF0IGJlZm9yZSAtIHNlbmRt
YWlsIGNhcGFiaWxpdGllcyBidWcgYW55b25lP8KgIEFuZCBpdCBpcyBhY3R1YWxseSB3b3Jz
ZSB0aGFuIHRoYXQgYnVnLCBiZWNhdXNlIHdpdGggdGhlIGFzc2lzdGFuY2Ugb2YgYSBmcmll
bmRseSBzZWN1cml0eSBtb2R1bGUsIHRoZSB3cml0ZSBtYXkgYWN0dWFsbHkgc3VjY2VlZDsg
aXQganVzdCB3b24ndCBhbHRlciB0aGUgU0VMaW51eCBjb250ZXh0IG9mIHRoZSBwcm9ncmFt
IG9yIGFueXRoaW5nIGl0IGNyZWF0ZXMhDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBnZXRzIGEgTkFL
IGZyb20gbWUgc28gbG9uZyBhcyBpdCBoYXMgdGhlc2UgaXNzdWVzIGFuZCBzZXR0aW5nIHRo
ZSBkaXNwbGF5IHJlbWFpbnMgb3V0c2lkZSB0aGUgY29udHJvbCBvZiBhbnkgc2VjdXJpdHkg
bW9kdWxlLg0KPj4+Pg0KPj4+PiBUaGUgaXNzdWVzIHlvdSd2ZSByYWlzZWQgYXJvdW5kIGF1
ZGl0IGFyZSBtZXJpdG9yaW91cy4NCj4+Pj4gQW55IHN1Z2dlc3Rpb25zIHJlZ2FyZGluZyBo
b3cgdG8gYWRkcmVzcyB0aGVtIHdvdWxkIGJlDQo+Pj4+IHF1aXRlIHdlbGNvbWUuDQo+Pj4+
DQo+Pj4+IEFzIGZhciBhcyB0aGUgZ2VuZXJhbCBvYmplY3Rpb24gdG8gdGhlIGRpc3BsYXkg
bWVjaGFuaXNtLA0KPj4+PiBJIGFtIGVhZ2VyIHRvIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWln
aHQgcHJvcG9zZSBhcyBhbg0KPj4+PiBhbHRlcm5hdGl2ZS4gV2UgY2FuJ3QgZGlzbWlzcyBi
YWNrd2FyZCBjb21wYXRpYmlsaXR5IGZvcg0KPj4+PiBhbnkgb2YgdGhlIG1vZHVsZXMuIFdl
IGNhbid0IHByZWNsdWRlIGFueSBtb2R1bGUgY29tYmluYXRpb24uDQo+Pj4+DQo+Pj4+IFdl
IGNhbiByZXF1aXJlIHVzZXIgc3BhY2UgY2hhbmdlcyBmb3IgY29uZmlndXJhdGlvbnMgdGhh
dA0KPj4+PiB3ZXJlIGltcG9zc2libGUgYmVmb3JlLCBqdXN0IGFzIHRoZSBhZGRpdGlvbiBv
ZiBTRUxpbnV4IHRvDQo+Pj4+IGEgc3lzdGVtIHJlcXVpcmVkIHVzZXIgc3BhY2UgY2hhbmdl
cy4gVXBkYXRlIGxpYnNlbGludXgNCj4+Pj4gdG8gY2hlY2sgdGhlIGRpc3BsYXkgYmVmb3Jl
IHVzaW5nIHRoZSBhdHRyIGludGVyZmFjZXMgYW5kDQo+Pj4+IHlvdSd2ZSBhZGRyZXNzZWQg
bW9zdCBvZiB0aGUgaXNzdWVzLg0KPj4+DQo+Pj4gRWl0aGVyIHdlIGVuc3VyZSB0aGF0IHNl
dHRpbmcgb2YgdGhlIGRpc3BsYXkgY2FuIG9ubHkgYWZmZWN0IHByb2Nlc3NlcyBpbiB0aGUg
c2FtZSBzZWN1cml0eSBlcXVpdmFsZW5jZSBjbGFzcyAoc2FtZSBjcmVkZW50aWFscykNCj4+
DQo+PiBJbiB0aGUgcHJvY2VzcyBvZiB0cnlpbmcgdG8gYXJndWUgYWdhaW5zdCB5b3VyIHBv
aW50IEkNCj4+IG1heSBoYXZlIGNvbWUgYXJvdW5kIHRvIHlvdXIgdGhpbmtpbmcuIFRoZXJl
IHdvdWxkIHN0aWxsDQo+PiBiZSB0aGUgY2FzZSB3aGVyZSBhIHByaXZpbGVnZWQgcHJvZ3Jh
bSBzZXRzIHRoZSBkaXNwbGF5DQo+PiBhbmQgaW52b2tlcyBhbiBlcXVhbGx5IHByaXZpbGVn
ZWQgcHJvZ3JhbSB3aGljaCBpcyAidHJpY2tlZCINCj4+IGludG8gc2V0dGluZyB0aGUgd3Jv
bmcgYXR0cmlidXRlLCBidXQgeW91IGhhdmUgdG8gcHV0IHRoZQ0KPj4gcmVzcG9uc2liaWxp
dHkgZm9yIHVzZSBvZiBwcml2aWxlZ2Ugb24gc29tZW9uZSwgc29tZXdoZXJlLg0KPj4NCj4+
IEkgd2lsbCBwcm9wb3NlIGEgc29sdXRpb24gaW4gdGhlIG5leHQgcm91bmQuDQo+Pg0KPj4+
IG9yIHRoZSBzZWN1cml0eSBtb2R1bGVzIG5lZWQgdG8gYmUgYWJsZSB0byBjb250cm9sIHdo
byBjYW4gc2V0IHRoZSBkaXNwbGF5Lg0KPj4NCj4+IFRoYXQncyBhIG1lY2hhbmlzbSBmb3Ig
YSBtb2R1bGUgdG8gb3B0LW91dCBvZiBzdGFja2luZywNCj4+IGFuZCBQYXVsIGhhcyBiZWVu
IHByZXR0eSBjbGVhciB0aGF0IGhlIHdvbid0IGdvIGZvciB0aGF0Lg0KPiANCj4gSXQgZG9l
c24ndCBoYXZlIHRvIGJlIHVzZWQgdGhhdCB3YXk7IGl0IGNhbiBqdXN0IGJlIHVzZWQgdG8g
bGltaXQgdGhlIHNldCBvZiBhdXRob3JpemVkIHByb2Nlc3NlcyB0aGF0IGNhbiBzZXQgdGhl
IGRpc3BsYXkgdG8gZS5nLiB0cnVzdGVkIGNvbnRhaW5lciBydW50aW1lcy4NCg0KV2UgbmVl
ZCBzb21ldGhpbmcgbW9yZSB0aGFuIGp1c3QgY29udHJvbGxpbmcgd2hpY2ggcHJvY2Vzc2Vz
IGNhbiBzZXQgdGhlIGRpc3BsYXkgTFNNLiBXZSBuZWVkcyB0byBiZSBhYmxlIHRvIGNvbnNp
ZGVyIHRoZSBkaXNwbGF5IExTTSBmcm9tIGJvb3QgYW5kIHRoZSBMU00gaXMgZ29pbmcgdG8g
aGF2ZSB0byBiZSBtb3JlIGludm9sdmVkLiBBdCBhIG1pbmltdW0gd2UgbmVlZCB0byBzb21l
IGNvb3BlcmF0aW9uIGFuZCBtYXliZSB2aXJ0dWFsaXphdGlvbiB0byBwcm9wZXJseSBzdXBw
b3J0IGV4aXN0aW5nIHVzZXJzcGFjZSBjb2RlLg0KDQpUaGUgY3VycmVudCBhcHByb2FjaCBp
cyBzdWZmaWNpZW50IGZvciBhcHBsaWNhdGlvbnMgdGhhdCBhcmUganVzdCBkdW1waW5nIHRo
ZSBvdXRwdXQgKHRvcCwgcHN0cmVlLCAuLi4pLiBUaGUgc2V0IG9mIHByaXZpbGVnZWQgcHJv
Z3JhbXMgaXMgbW9yZSBwcm9ibGVtYXRpYy4gTFNNIHNwZWNpZmljIHByaXZpbGVnZWQgcHJv
Z3JhbXMgY2FuIGJlIGRlYWx0IHdpdGggYnkgbWVkaWF0aW9uIGJ1dCBub24tTFNNIHNwZWNp
ZmljIHByb2dyYW1zIG5lZWQgc29tZXRoaW5nIG1vcmUuICBUaGUgY3VycmVudCBMU01zIChz
ZWxpbnV4LCBzbWFjaywgYXBwYXJtb3IpIHRoYXQgdXNlIHRoZSBpbnRlcmZhY2VzIGJlaW5n
IHZpcnR1YWxpemVkIGJ5IHRoZSBkaXNwbGF5IExTTSBhcmUgZ29pbmcgdG8gd2FudCB0byBj
b250cm9sIHRoZSBkaXNwbGF5IGZvciBhbiBhcHBsaWNhdGlvbnMgaGFzIHN1cHBvcnQgZm9y
IHRoZSByZXNwZWN0aXZlIExTTXMuIElmIHRoZSBMU01zIGRvbid0IGNvb3BlcmF0ZSBpbiBz
b21lIHdheSB3ZSBtYXkgZW5kIHVwIGluIGEgc2l0dWF0aW9uIHdoZXJlIHRoZSBkaXNwbGF5
IExTTSBjYW4gbmV2ZXIgYmUgc3dpdGNoZWQsIGFuZCBldmVuIHdvcnNlIHVzZXJzcGFjZSBt
aWdodCBzdGlsbCB0cnkgdG8gYWNjZXNzIHRoZSBsYWJlbCB3aXRob3V0IHRoZSBkaXNwbGF5
IExTTSBiZWluZyBzd2l0Y2hlZC4gU28gYXJlIHRoZXJlIGN1cnJlbnRseSBhbnkgcHJvZ3Jh
bXMgd2hlcmUgd2UgaGF2ZSB0aGlzIHByb2JsZW0uIEF0IGxlYXN0IG9uZSwgREJ1cy4NCg0K
U28gbGV0cyBsb29rIGF0IGRidXMuDQoNCkl0IGhhcyBjb2RlIHRvIHN1cHBvcnQgc2VsaW51
eCwgYXBwYXJtb3IsIGFuZCBJIGhhdmUgc2VlbiBvdXQtb2YtdHJlZSBzbWFjayBjb2RlIGFz
IHdlbGwuIEl0IGNhbiBiZSBidWlsdCB3aXRoIHN1cHBvcnQgZm9yIGFsbCBvZiB0aGVtIGVu
YWJsZWQgKHVidW50dSBkb2VzIHRoaXMpLCBhbmQgd2hldGhlciBhIHBhcnRpY3VsYXIgTFNN
IGlzIGVuYWJsZWQgaXMgZGV0ZXJtaW5lZCBieSB0aGUgTFNNLiBFYWNoIExTTSBoYXMgaXRz
IG93biB3YXkgb2YgZGV0ZXJtaW5pbmcgaWYgaXQgaXMgZW5hYmxlZCBhbmQgdGhhdCBjaGVj
ayBpcyBub3QgaW5mb3JtYXRpb24gbm90IHVuZGVyIGNvbnRyb2wgb2YgdGhlIExTTSAoaXNf
c2VsaW51eF9lbmFibGVkKCkgdGVzdHMgd2hldGhlciBpdHMgZnMgaXMgbW91bnRlZCwgYW5k
IGFhX2lzX2VuYWJsZWQoKSBpcyBpdHMgZnMgYW5kICBrZXJuZWwgcGFyYW1ldGVyKS4gVGhp
cyBtZWFuIGJvb3RpbmcgdGhlIFVidW50dSBkZXNrb3Agd2l0aCBib3RoIGFwcGFybW9yIGFu
ZCBzZWxpbnV4IGVuYWJsZWQgZ2V0cyBpbnRlcmVzdGluZy4gWW91IGNhbiB0cnkgdGhpcyBp
biB1YnVudHUgMTkuMTAsIGl0IGhhcyBhIHByZXZpb3VzIHZlcnNpb24gb2YgdGhlIHN0YWNr
aW5nIHBhdGNoc2V0IHNvIHlvdSBkb24ndCBldmVuIG5lZWQgdG8gYnVpbGQgdGhpcyBwYXJ0
aWN1bGFyIHBhdGNoc2V0IHRvIHRlc3QgaXQuDQoNCklmIHlvdSB0YWtlIGEgZGVmYXVsdCBV
YnVudHUgMTkuMDQgaW5zdGFsbCB5b3UgY2FuIGRvDQogIGxzbT1jYXBhYmlsaXR5LHlhbWEs
YXBwYXJtb3Isc2VsaW51eA0KDQp0aGlzIHdpbGwgZGVmYXVsdCB0aGUgZGlzcGxheSBsc20g
dG8NCiAgYXBwYXJtb3INCg0KYW5kIHNlbGludXggd2lsbCBjb21lIHVwIGluIHBlcm1pc3Np
dmUgbW9kZSAobm8gcG9saWN5KSB0aGUgZGVza3RvcCBib290cyBzdWNjZXNzZnVsbHkuDQoN
Ckhvd2V2ZXIgc2V0dGluZyB0aGUgZGlzcGxheSBsc20gdG8gc2VsaW51eA0KICBsc209Y2Fw
YWJpbGl0eSx5YW1hLHNlbGludXgsYXBwYXJtb3INCg0Kd2lsbCByZXN1bHQgaW4gZGJ1cyBh
cHBhcm1vciBmYWlsdXJlcyBkdWUgdG8gc2VsaW51eCBiZWluZyB0aGUgZGlzcGxheSBsc20g
YW5kIGFwcGFybW9yIHBvbGljeSBiZWluZyBsb2FkZWQgYW5kIGVuZm9yY2luZy4gQWRkIHNl
bGludXggcG9saWN5IGludG8gdGhlIG1peCBhbmQgeW91IGRvdWJsZSB0aGUgZnVuIGFzIGl0
IHdpbGwgZmFpbCB0byBib290IGVpdGhlciB3YXkuDQoNCk5ldyB1c2Vyc3BhY2VzIGNhbiBi
ZSB1cGRhdGVkIHRvIHVzZSBuZXcgaW50ZXJmYWNlcyBidXQgdG8gc3VjY2Vzc2Z1bGx5IGJv
b3QgZXhpc3RpbmcgdXNlcnNwYWNlcyB0aGUgbm9uZSBkaXNwbGF5IExTTXMgYXJlIGdvaW5n
IHRvIGhhdmUgdG8gbGllIHRvIHVzZXJzcGFjZSBhYm91dCBiZWluZyBlbmFibGVkLg0KDQpJ
IHNob3VsZCBub3RlIHRoYXQgSSBoYXZlIHRyaWVkIHRoaXMgaW4gRmVkb3JhIHRvbyB3aXRo
IHNlbGludXggcG9saWN5IGVuYWJsZWQsIGEgc3RhY2tpbmcga2VybmVsIGFuZCBhcHBhcm1v
ciBhcyB0aGUgZGlzcGxheSBMU00uIFRoaXMgZmFpbHMgYXMgZXhwZWN0ZWQgKHRob3VnaCBJ
IGhhdmVuJ3QgZHVnIGludG8gd2hldGhlciBpdHMgZGJ1cyBvciBhbm90aGVyIHBpZWNlIG9m
IGNvZGUgdGhhdCBpcyB0aGUgY3VscHJpdCkuIEJvb3Rpbmcgd2l0aCBzZWxpbnV4IGFzIHRo
ZSBkaXNwbGF5LCB3aXRoIGFwcGFybW9yIGVuYWJsZWQgd2l0aCBubyBwb2xpY3kgYm9vdHMg
ZmluZS4NCg0K
