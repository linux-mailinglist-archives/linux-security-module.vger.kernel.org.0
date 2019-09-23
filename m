Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16375BB8BB
	for <lists+linux-security-module@lfdr.de>; Mon, 23 Sep 2019 17:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfIWP4d (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Sep 2019 11:56:33 -0400
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:43141
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728464AbfIWP4c (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 11:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1569254186; bh=n3knHcwJ7flDz7Af9vEnU+dL9gJ7Z/2Tv2vZO7Sb55Q=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=r2YSAhIjWEhhpbf0rGka09yMSFmoqYrS448gdABPC3CuaF/SKvNh5rTj4FW68c882ryDI1xx4WC3JFMbc6Vbs0McP5Cn5fvRrr5jHJomc6wIjJmFkGXeQWpbgZG1AQjXk5J7WbLLNenvw0d1twWGctiAozR+CJW82hZJWCiMctzSkqb5tVS7yNne34lIFDGySxCNr2gkZb+pzvd65ui6GqmIUUNdVtQnSd+TKXa39/WSr0N/WH/9XBxR9xlxwfZqGZfGd4eOBt+ZONDhJ/n20VlfUT/ZCAJy2twSaATnNiEOF3f73NKk5K8vgaK5Nza6u5bdRJiAJuGMwTg82NY25Q==
X-YMail-OSG: Kf0x_qEVM1n3tlVvXN4G2inHozcDBOBUzgN5PT.g_JXDCVC2OD1kzLyZF5HoTOa
 YH3ErTMjQE6OtjRnoy4CnnoLSWwgoDsncmwZqVoiKj0NQY9a7QhyPLR2f234W3WNjVTQUiuN5.hB
 k0tFR7HM2oS1IWOvw5j97NniXwzSeulZ24m.LaP3xJMBkDN3inAp7wLVEximPDq5H4ToC5IE8z53
 6_ChKSUVBnJ3bBRPePV6OR4x6kwMWgULkXYmL.CqCosL.p5xVE3g8LxNXqA5UE4._O0jLQK9J2oS
 F6mkFFQJkXXroKCF7UZmmAicKUHxgOSGeGlEw.H3_pAZenVOXkWylc_a5wK1SCPkyrUksVelk7wy
 HgAJnHpTubv2Bj.yN.n4TqT_9EDjKM_3BDIWULkyQmsmP_GwFrD_fGeJD91KocdiR4sCkIQduwcc
 xDVwLFG.CbkA3KTSNRW5Vdyq23DNNT6RVkv5QRb_Ei9MZYffl.j3JATk3HfNKQ1mkJbjATfMMU2w
 NvyCDSpOQ88d1l5y3TcNlGw_Glp6wMeXs0HjS_NMYYyFNM7rEEvhr4bzPs06D5pyqHpO2.Gf5T7x
 WZkmxmxpfIh6uAsWjEL5xXscaWVzdargnzeDFeQBO.iBGpVPUYxQuwnuS8cv.btO0fnKarcF.HDj
 AqVmPPoVDFq.Xr9jPXLtnpU9IkV5hj.d6pFzmevg0tftS4W0rlTyASJg5Rq9MGOxonijDUmPaNLA
 xP125xgny3k6f7ARMXx8xG8gDNsWXcsR2DZynubHgtHbE80oB0yU0eK4OVzd2iWiXg5sqaz87y42
 n0VnJaSKhyTr9L1v5UU9XHVWv6zhiz.JtXKEyq9dxv4DmMOeOFwQtajC6dyu8qsRqWxio_gTMTgA
 XKQLTVW2Fm90nm3Sjyapezjvyze0r6EWgfBBtijzumnbwEGg8iG2093G2OjdL5kgLqIE6ItpzWiM
 iCQiVW6YpbS9JhroABidnY7cvenMCxeCdoFDDeTxjRiAHzlHugT5mz.DlO3hngSv73.eVJgJOGpj
 ne0NXZ8FPrsyiY5gW.hXn6bmdQEe7PgvDdZ9dO28MiaHiiRAR9gM1_zd.wYSZcerUdwdttP0qCrs
 0liCUK887U6WrkxXERHNw3mEa7g2MPdCzF8yXS3q5hf1EmpqiMKxALWRqBtRf_5oy9RHb3JzEG25
 5.KjjYyJJHePuSNYLrprqkYCuFu.j2s3h1CynAdC5Jy1Eu_p1EUir_4GQ2qKzJr2xzBI4y2E5v6H
 5qCZyeP7a.R3NypE6KwAxma9YFyKuFjkAUVQIeKBmW5fMc88Mdo22n7Pu.nHAfJap_PBfMnD5OVT
 CI5igYM7apLEh_C6milWwqeyF2Njx6bGDKnGhBBSJozYO7s9xytHHGAOFMm44wXTi1CKbEewwVGe
 E733E9IxgtPfQ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Sep 2019 15:56:26 +0000
Received: by smtp416.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 036ef50ff8743007d5f8f516bf89c1a8;
          Mon, 23 Sep 2019 15:56:21 +0000 (UTC)
Subject: Re: [PATCH v8 04/28] LSM: Create and manage the lsmblob data
 structure.
To:     Stephen Smalley <sds@tycho.nsa.gov>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        casey@schaufler-ca.com
References: <20190829232935.7099-1-casey@schaufler-ca.com>
 <20190829232935.7099-5-casey@schaufler-ca.com>
 <a95a0c6a-1410-471a-8397-fdcc45a8c77e@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <7abc1c70-adce-30f8-4086-41c153704c78@schaufler-ca.com>
Date:   Mon, 23 Sep 2019 08:56:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a95a0c6a-1410-471a-8397-fdcc45a8c77e@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
X-Mailer: WebService/1.1.14367 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gOS8xNi8yMDE5IDEyOjE1IFBNLCBTdGVwaGVuIFNtYWxsZXkgd3JvdGU6DQo+IE9uIDgv
MjkvMTkgNzoyOSBQTSwgQ2FzZXkgU2NoYXVmbGVyIHdyb3RlOg0KPj4gV2hlbiBtb3JlIHRo
YW4gb25lIHNlY3VyaXR5IG1vZHVsZSBpcyBleHBvcnRpbmcgZGF0YSB0bw0KPj4gYXVkaXQg
YW5kIG5ldHdvcmtpbmcgc3ViLXN5c3RlbXMgYSBzaW5nbGUgMzIgYml0IGludGVnZXINCj4+
IGlzIG5vIGxvbmdlciBzdWZmaWNpZW50IHRvIHJlcHJlc2VudCB0aGUgZGF0YS4gQWRkIGEN
Cj4+IHN0cnVjdHVyZSB0byBiZSB1c2VkIGluc3RlYWQuDQo+Pg0KPj4gVGhlIGxzbWJsb2Ig
c3RydWN0dXJlIGlzIGN1cnJlbnRseSBhbiBhcnJheSBvZg0KPj4gdTMyICJzZWNpZHMiLiBU
aGVyZSBpcyBhbiBlbnRyeSBmb3IgZWFjaCBvZiB0aGUNCj4+IHNlY3VyaXR5IG1vZHVsZXMg
YnVpbHQgaW50byB0aGUgc3lzdGVtIHRoYXQgd291bGQNCj4+IHVzZSBzZWNpZHMgaWYgYWN0
aXZlLiBUaGUgc3lzdGVtIGFzc2lnbnMgdGhlIG1vZHVsZQ0KPj4gYSAic2xvdCIgd2hlbiBp
dCByZWdpc3RlcnMgaG9va3MuIElmIG1vZHVsZXMgYXJlDQo+PiBjb21waWxlZCBpbiBidXQg
bm90IHJlZ2lzdGVyZWQgdGhlcmUgd2lsbCBiZSB1bnVzZWQNCj4+IHNsb3RzLg0KPg0KPiBJ
IHdvbid0IG9ic3RydWN0IHRoZSBwYXRjaCBvbiBuYW1pbmcgYnV0IEkgZG8gaGF2ZSB0byB3
b25kZXIgYWJvdXQgdGhlIHVzZSBvZiBsc21ibG9iIGhlcmUgZ2l2ZW4gdGhhdCB3ZSB1c2Ug
dGhlIHRlcm0gInNlY3VyaXR5IGJsb2JzIiBlbHNld2hlcmUgdG8gcmVmZXIgdG8gd2hhdCB0
aGUgLT5zZWN1cml0eSBmaWVsZHMgcmVmZXJlbmNlIGFuZCB0aGlzIGlzIG5vdCB0aGUgc2Ft
ZSB0aGluZy7CoCBOb3Qgc3VyZSB3aHkgaXQgd2Fzbid0IGp1c3QgbHNtc2VjaWRzIG9yIHNp
bWlsYXIsIGJ1dCB3aGF0ZXZlci4NCg0KSW4gZWFybGllciB2ZXJzaW9ucyBvZiB0aGUgcGF0
Y2ggSSB1c2VkICJzdHJ1Y3Qgc2VjaWRzIiBhbmQgZm91bmQNCml0IGluY3JlZGlibHkgZGlm
ZmljdWx0IHRvIHJlY29nbml6ZSB0aGUgZGlmZmVyZW5jZSBiZXR3ZWVuIHVzZXMNCm9mIGEg
c2VjaWQgYW5kIGEgc3RydWN0IHNlY2lkcy4gQnJhaW5zIHRyYWluZWQgaW4gdGhlIEVuZ2xp
c2ggbGFuZ3VhZ2UNCnRlbmQgdG8gdHJlYXQgYW4gZW5kaW5nICdzJyBhcyBhIG1vZGlmaWVy
LCBtYWtpbmcgdGhlIGRpc3RpbmN0aW9uDQpkaWZmaWN1bHQgdG8gc2VlLiBJIGFsc28gaGF2
ZSBub3QgZ2l2ZW4gdXAgb24gdGhlIHBvc3NpYmlsaXR5IG9mDQptb3ZpbmcgdGhlIGludGVy
ZmFjZXMgYXdheSBmcm9tIHVzaW5nIHNlY2lkcyBhdCBzb21lIHBvaW50IGluIHRoZQ0KZnV0
dXJlLg0KDQo+DQo+Pg0KPj4gQSBuZXcgbHNtX2lkIHN0cnVjdHVyZSwgd2hpY2ggY29udGFp
bnMgdGhlIG5hbWUNCj4+IG9mIHRoZSBMU00gYW5kIGl0cyBzbG90IG51bWJlciwgaXMgY3Jl
YXRlZC4gVGhlcmUNCj4+IGlzIGFuIGluc3RhbmNlIGZvciBlYWNoIExTTSwgd2hpY2ggYXNz
aWducyB0aGUgbmFtZQ0KPj4gYW5kIHBhc3NlcyBpdCB0byB0aGUgaW5mcmFzdHJ1Y3R1cmUg
dG8gc2V0IHRoZSBzbG90Lg0KPg0KPiBJcyBpdCByZWFsbHkgZGVzaXJhYmxlL25lY2Vzc2Fy
eSB0byBkdXBsaWNhdGUgdGhlIG1vZHVsZSBuYW1lLCBvbmNlIGluIHRoZSBsc21faWQgYW5k
IG9uY2UgaW4gdGhlIGxzbV9pbmZvP8KgIEFnYWluLCBub3QgYSBibG9ja2VyIGZvciBtZSBi
dXQgc2VlbXMgdW5mb3J0dW5hdGUuDQoNClBvc3NpYmx5IG5vdCwgYnV0IHdpdGggb25lIG9m
IHRoZW0gYmVpbmcgX19pbml0IGRhdGEgaXQncw0KcmVhbGx5IGhhcmQgdG8ganVzdGlmeSBw
dXR0aW5nIGEgbG90IG9mIGVmZm9ydCBpbnRvIGF2b2lkaW5nDQp0aGUgZHVwbGljYXRpb24u
DQoNCj4NCj4+DQo+PiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1
bS5vcmc+DQo+PiBSZXZpZXdlZC1ieTogSm9obiBKb2hhbnNlbiA8am9obi5qb2hhbnNlbkBj
YW5vbmljYWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2FzZXkgU2NoYXVmbGVyIDxjYXNl
eUBzY2hhdWZsZXItY2EuY29tPg0KPj4gLS0tDQo+PiDCoCBpbmNsdWRlL2xpbnV4L2xzbV9o
b29rcy5owqAgfCAxMiArKysrKy0tDQo+PiDCoCBpbmNsdWRlL2xpbnV4L3NlY3VyaXR5LmjC
oMKgIHwgNjYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+IMKg
IHNlY3VyaXR5L2FwcGFybW9yL2xzbS5jwqDCoMKgIHzCoCA3ICsrKy0NCj4+IMKgIHNlY3Vy
aXR5L2NvbW1vbmNhcC5jwqDCoMKgwqDCoMKgIHzCoCA3ICsrKy0NCj4+IMKgIHNlY3VyaXR5
L2xvYWRwaW4vbG9hZHBpbi5jIHzCoCA4ICsrKystDQo+PiDCoCBzZWN1cml0eS9zYWZlc2V0
aWQvbHNtLmPCoMKgIHzCoCA4ICsrKystDQo+PiDCoCBzZWN1cml0eS9zZWN1cml0eS5jwqDC
oMKgwqDCoMKgwqAgfCAzMSArKysrKysrKysrKysrKy0tLS0NCj4+IMKgIHNlY3VyaXR5L3Nl
bGludXgvaG9va3MuY8KgwqAgfMKgIDggKysrKy0NCj4+IMKgIHNlY3VyaXR5L3NtYWNrL3Nt
YWNrX2xzbS5jIHzCoCA3ICsrKy0NCj4+IMKgIHNlY3VyaXR5L3RvbW95by90b21veW8uY8Kg
wqAgfMKgIDggKysrKy0NCj4+IMKgIHNlY3VyaXR5L3lhbWEveWFtYV9sc20uY8KgwqAgfMKg
IDcgKysrLQ0KPj4gwqAgMTEgZmlsZXMgY2hhbmdlZCwgMTUyIGluc2VydGlvbnMoKyksIDE3
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2xzbV9o
b29rcy5oIGIvaW5jbHVkZS9saW51eC9sc21faG9va3MuaA0KPj4gaW5kZXggM2ZlMzlhYmNj
YzhmLi5mZTFmYjdhNjllZTUgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2xzbV9o
b29rcy5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2xzbV9ob29rcy5oDQo+PiBAQCAtMjAy
OSw2ICsyMDI5LDE0IEBAIHN0cnVjdCBzZWN1cml0eV9ob29rX2hlYWRzIHsNCj4+IMKgICNl
bmRpZiAvKiBDT05GSUdfQlBGX1NZU0NBTEwgKi8NCj4+IMKgIH0gX19yYW5kb21pemVfbGF5
b3V0Ow0KPj4gwqAgKy8qDQo+PiArICogSW5mb3JtYXRpb24gdGhhdCBpZGVudGlmaWVzIGEg
c2VjdXJpdHkgbW9kdWxlLg0KPj4gKyAqLw0KPj4gK3N0cnVjdCBsc21faWQgew0KPj4gK8Kg
wqDCoCBjb25zdCBjaGFywqDCoMKgICpsc207wqDCoMKgIC8qIE5hbWUgb2YgdGhlIExTTSAq
Lw0KPj4gK8KgwqDCoCBpbnTCoMKgwqDCoMKgwqDCoCBzbG90O8KgwqDCoCAvKiBTbG90IGlu
IGxzbWJsb2IgaWYgb25lIGlzIGFsbG9jYXRlZCAqLw0KPj4gK307DQo+PiArDQo+PiDCoCAv
Kg0KPj4gwqDCoCAqIFNlY3VyaXR5IG1vZHVsZSBob29rIGxpc3Qgc3RydWN0dXJlLg0KPj4g
wqDCoCAqIEZvciB1c2Ugd2l0aCBnZW5lcmljIGxpc3QgbWFjcm9zIGZvciBjb21tb24gb3Bl
cmF0aW9ucy4NCj4+IEBAIC0yMDM3LDcgKzIwNDUsNyBAQCBzdHJ1Y3Qgc2VjdXJpdHlfaG9v
a19saXN0IHsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IGhsaXN0X25vZGXCoMKgwqDCoMKgwqDC
oCBsaXN0Ow0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaGxpc3RfaGVhZMKgwqDCoMKgwqDCoMKg
ICpoZWFkOw0KPj4gwqDCoMKgwqDCoCB1bmlvbiBzZWN1cml0eV9saXN0X29wdGlvbnPCoMKg
wqAgaG9vazsNCj4+IC3CoMKgwqAgY2hhcsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqbHNtOw0KPj4gK8KgwqDCoCBzdHJ1Y3QgbHNtX2lkwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqbHNtaWQ7DQo+PiDCoCB9IF9fcmFuZG9taXplX2xheW91dDsNCj4+IMKgIMKgIC8qDQo+
PiBAQCAtMjA2OCw3ICsyMDc2LDcgQEAgZXh0ZXJuIHN0cnVjdCBzZWN1cml0eV9ob29rX2hl
YWRzIHNlY3VyaXR5X2hvb2tfaGVhZHM7DQo+PiDCoCBleHRlcm4gY2hhciAqbHNtX25hbWVz
Ow0KPj4gwqAgwqAgZXh0ZXJuIHZvaWQgc2VjdXJpdHlfYWRkX2hvb2tzKHN0cnVjdCBzZWN1
cml0eV9ob29rX2xpc3QgKmhvb2tzLCBpbnQgY291bnQsDQo+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNoYXIgKmxzbSk7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBsc21faWQgKmxzbWlkKTsNCj4+IMKgIMKgICNkZWZp
bmUgTFNNX0ZMQUdfTEVHQUNZX01BSk9SwqDCoMKgIEJJVCgwKQ0KPj4gwqAgI2RlZmluZSBM
U01fRkxBR19FWENMVVNJVkXCoMKgwqAgQklUKDEpDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9zZWN1cml0eS5oIGIvaW5jbHVkZS9saW51eC9zZWN1cml0eS5oDQo+PiBpbmRl
eCA0OWYyNjg1MzI0YjAuLjViYjhiOWE2ZmE4NCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUv
bGludXgvc2VjdXJpdHkuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9zZWN1cml0eS5oDQo+
PiBAQCAtNzYsNiArNzYsNzIgQEAgZW51bSBsc21fZXZlbnQgew0KPj4gwqDCoMKgwqDCoCBM
U01fUE9MSUNZX0NIQU5HRSwNCj4+IMKgIH07DQo+PiDCoCArLyoNCj4+ICsgKiBEYXRhIGV4
cG9ydGVkIGJ5IHRoZSBzZWN1cml0eSBtb2R1bGVzDQo+PiArICoNCj4+ICsgKiBBbnkgTFNN
IHRoYXQgcHJvdmlkZXMgc2VjaWQgb3Igc2VjY3R4IGJhc2VkIGhvb2tzIG11c3QgYmUgaW5j
bHVkZWQuDQo+PiArICovDQo+PiArI2RlZmluZSBMU01CTE9CX0VOVFJJRVMgKCBcDQo+PiAr
wqDCoMKgIChJU19FTkFCTEVEKENPTkZJR19TRUNVUklUWV9TRUxJTlVYKSA/IDEgOiAwKSAr
IFwNCj4+ICvCoMKgwqAgKElTX0VOQUJMRUQoQ09ORklHX1NFQ1VSSVRZX1NNQUNLKSA/IDEg
OiAwKSArIFwNCj4+ICvCoMKgwqAgKElTX0VOQUJMRUQoQ09ORklHX1NFQ1VSSVRZX0FQUEFS
TU9SKSA/IDEgOiAwKSkNCj4+ICsNCj4+ICtzdHJ1Y3QgbHNtYmxvYiB7DQo+PiArwqDCoMKg
IHUzMsKgwqDCoMKgIHNlY2lkW0xTTUJMT0JfRU5UUklFU107DQo+PiArfTsNCj4+ICsNCj4+
ICsjZGVmaW5lIExTTUJMT0JfSU5WQUxJRMKgwqDCoMKgwqDCoMKgIC0xwqDCoMKgIC8qIE5v
dCBhIHZhbGlkIExTTSBzbG90IG51bWJlciAqLw0KPj4gKyNkZWZpbmUgTFNNQkxPQl9ORUVE
RUTCoMKgwqDCoMKgwqDCoCAtMsKgwqDCoCAvKiBTbG90IHJlcXVlc3RlZCBvbiBpbml0aWFs
aXphdGlvbiAqLw0KPj4gKyNkZWZpbmUgTFNNQkxPQl9OT1RfTkVFREVEwqDCoMKgIC0zwqDC
oMKgIC8qIFNsb3Qgbm90IHJlcXVlc3RlZCAqLw0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIGxz
bWJsb2JfaW5pdCAtIGluaXRpYWxpemUgYW4gbHNtYmxvYiBzdHJ1Y3R1cmUuDQo+PiArICog
QGJsb2I6IFBvaW50ZXIgdG8gdGhlIGRhdGEgdG8gaW5pdGlhbGl6ZQ0KPj4gKyAqIEBzZWNp
ZDogVGhlIGluaXRpYWwgc2VjaWQgdmFsdWUNCj4+ICsgKg0KPj4gKyAqIFNldCBhbGwgc2Vj
aWQgZm9yIGFsbCBtb2R1bGVzIHRvIHRoZSBzcGVjaWZpZWQgdmFsdWUuDQo+PiArICovDQo+
PiArc3RhdGljIGlubGluZSB2b2lkIGxzbWJsb2JfaW5pdChzdHJ1Y3QgbHNtYmxvYiAqYmxv
YiwgdTMyIHNlY2lkKQ0KPj4gK3sNCj4+ICvCoMKgwqAgaW50IGk7DQo+PiArDQo+PiArwqDC
oMKgIGZvciAoaSA9IDA7IGkgPCBMU01CTE9CX0VOVFJJRVM7IGkrKykNCj4+ICvCoMKgwqDC
oMKgwqDCoCBibG9iLT5zZWNpZFtpXSA9IHNlY2lkOw0KPj4gK30NCj4NCj4gVGhpcyBzZWVt
cyBub25zZW5zaWNhbCBmb3IgYW55IHZhbHVlIG90aGVyIHRoYW4gMC7CoCBPdGhlcndpc2Us
IHdlIHNob3VsZCBvbmx5IHNldCBpdCBmb3IgdGhlIG1vZHVsZSB0aGF0IHByb2R1Y2VkIHRo
ZSBzZWNpZCBvcmlnaW5hbGx5P8KgIEFuZCBpZiBzZXR0aW5nIHRoZW0gYWxsIHRvIHplcm8s
IHlvdSBjb3VsZCBqdXN0IGRvIGEgbWVtc2V0Lg0KDQpZZXMsIGl0IGRvZXMsIGJ1dCBpdCBp
c24ndC4gVGhlcmUgYXJlIGNhc2VzIHdoZXJlIHNldHRpbmcgYWxsIG9mIHRoZQ0Kc2VjaWRz
IHRvIGEgdmFsdWUgb3RoZXIgdGhhbiB6ZXJvIG1ha2VzIHNlbnNlLCBhdCBsZWFzdCB3aGVu
IHRoZXJlJ3MNCnNjYWZmb2xkaW5nIGludm9sdmVkLiBPbmUgZXhhbXBsZSBpcyB3aXRoIHNl
Y21hcmtzLCB3aGVyZSB3ZSBrbm93IHRoZQ0Kc2VjaWQgdmFsdWUsIGJ1dCBub3QgbmVjZXNz
YXJpbHkgd2hpY2ggc2VjdXJpdHkgbW9kdWxlIGlzIHJlc3BvbnNpYmxlDQpmb3IgaXQuIFdl
IGtub3cgdGhhdCBpdCB3aWxsIGJlIHNldCBhbmQgY29uc3VtZWQgYnkgdGhlIHNhbWUgbW9k
dWxlLA0KYnV0IG5vdCB3aGljaCBpdCBpcyBhdCB0aGF0IHBvaW50LiBZb3UgY2FuIGFyZ3Vl
IHRoaXMgc2hvdWxkIGJlDQpsc21ibG9iX3NldCgpIGluc3RlYWQgb2YgbHNtYmxvYl9pbml0
KCksIGJ1dCB0aGF0J3MgY29uZnVzaW5nLCB0b28uDQoNCj4NCj4+ICsNCj4+ICsvKioNCj4+
ICsgKiBsc21ibG9iX2lzX3NldCAtIHJlcG9ydCBpZiB0aGVyZSBpcyBhbiB2YWx1ZSBpbiB0
aGUgbHNtYmxvYg0KPj4gKyAqIEBibG9iOiBQb2ludGVyIHRvIHRoZSBleHBvcnRlZCBMU00g
ZGF0YQ0KPj4gKyAqDQo+PiArICogUmV0dXJucyB0cnVlIGlmIHRoZXJlIGlzIGEgc2VjaWQg
c2V0LCBmYWxzZSBvdGhlcndpc2UNCj4+ICsgKi8NCj4+ICtzdGF0aWMgaW5saW5lIGJvb2wg
bHNtYmxvYl9pc19zZXQoc3RydWN0IGxzbWJsb2IgKmJsb2IpDQo+PiArew0KPj4gK8KgwqDC
oCBpbnQgaTsNCj4+ICsNCj4+ICvCoMKgwqAgZm9yIChpID0gMDsgaSA8IExTTUJMT0JfRU5U
UklFUzsgaSsrKQ0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChibG9iLT5zZWNpZFtpXSAhPSAw
KQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+PiArwqDCoMKg
IHJldHVybiBmYWxzZTsNCj4NCj4gbWVtY21wIGFnYWluc3QgdGhlIGFsbC16ZXJvZXMgbHNt
YmxvYj8NCg0KU3VyZS4NCg0KPg0KPj4gK30NCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBsc21i
bG9iX2VxdWFsIC0gcmVwb3J0IGlmIHRoZSB0d28gbHNtYmxvYidzIGFyZSBlcXVhbA0KPj4g
KyAqIEBibG9iYTogUG9pbnRlciB0byBvbmUgTFNNIGRhdGENCj4+ICsgKiBAYmxvYmI6IFBv
aW50ZXIgdG8gdGhlIG90aGVyIExTTSBkYXRhDQo+PiArICoNCj4+ICsgKiBSZXR1cm5zIHRy
dWUgaWYgYWxsIGVudHJpZXMgaW4gdGhlIHR3byBhcmUgZXF1YWwsIGZhbHNlIG90aGVyd2lz
ZQ0KPj4gKyAqLw0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBsc21ibG9iX2VxdWFsKHN0cnVj
dCBsc21ibG9iICpibG9iYSwgc3RydWN0IGxzbWJsb2IgKmJsb2JiKQ0KPj4gK3sNCj4+ICvC
oMKgwqAgaW50IGk7DQo+PiArDQo+PiArwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBMU01CTE9C
X0VOVFJJRVM7IGkrKykNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoYmxvYmEtPnNlY2lkW2ld
ICE9IGJsb2JiLT5zZWNpZFtpXSkNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBmYWxzZTsNCj4+ICvCoMKgwqAgcmV0dXJuIHRydWU7DQo+DQo+IG1lbWNtcCBvZiB0aGUg
dHdvIGJsb2JzPw0KDQpTdXJlLg0KDQo+DQo+PiArfQ0KPj4gKw0KPj4gwqAgLyogVGhlc2Ug
ZnVuY3Rpb25zIGFyZSBpbiBzZWN1cml0eS9jb21tb25jYXAuYyAqLw0KPj4gwqAgZXh0ZXJu
IGludCBjYXBfY2FwYWJsZShjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZCwgc3RydWN0IHVzZXJf
bmFtZXNwYWNlICpucywNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlu
dCBjYXAsIHVuc2lnbmVkIGludCBvcHRzKTsNCj4+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9h
cHBhcm1vci9sc20uYyBiL3NlY3VyaXR5L2FwcGFybW9yL2xzbS5jDQo+PiBpbmRleCAyNzE2
ZTc3MzEyNzkuLmVjMmUzOWFhOWE4NCAxMDA2NDQNCj4+IC0tLSBhL3NlY3VyaXR5L2FwcGFy
bW9yL2xzbS5jDQo+PiArKysgYi9zZWN1cml0eS9hcHBhcm1vci9sc20uYw0KPj4gQEAgLTEx
MzgsNiArMTEzOCwxMSBAQCBzdHJ1Y3QgbHNtX2Jsb2Jfc2l6ZXMgYXBwYXJtb3JfYmxvYl9z
aXplcyBfX2xzbV9yb19hZnRlcl9pbml0ID0gew0KPj4gwqDCoMKgwqDCoCAubGJzX3NvY2sg
PSBzaXplb2Yoc3RydWN0IGFhX3NrX2N0eCksDQo+PiDCoCB9Ow0KPj4gwqAgK3N0YXRpYyBz
dHJ1Y3QgbHNtX2lkIGFwcGFybW9yX2xzbWlkIF9fbHNtX3JvX2FmdGVyX2luaXQgPSB7DQo+
PiArwqDCoMKgIC5sc23CoCA9ICJhcHBhcm1vciIsDQo+PiArwqDCoMKgIC5zbG90ID0gTFNN
QkxPQl9ORUVERUQNCj4+ICt9Ow0KPj4gKw0KPj4gwqAgc3RhdGljIHN0cnVjdCBzZWN1cml0
eV9ob29rX2xpc3QgYXBwYXJtb3JfaG9va3NbXSBfX2xzbV9yb19hZnRlcl9pbml0ID0gew0K
Pj4gwqDCoMKgwqDCoCBMU01fSE9PS19JTklUKHB0cmFjZV9hY2Nlc3NfY2hlY2ssIGFwcGFy
bW9yX3B0cmFjZV9hY2Nlc3NfY2hlY2spLA0KPj4gwqDCoMKgwqDCoCBMU01fSE9PS19JTklU
KHB0cmFjZV90cmFjZW1lLCBhcHBhcm1vcl9wdHJhY2VfdHJhY2VtZSksDQo+PiBAQCAtMTY3
OSw3ICsxNjg0LDcgQEAgc3RhdGljIGludCBfX2luaXQgYXBwYXJtb3JfaW5pdCh2b2lkKQ0K
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gYnVmZmVyc19vdXQ7DQo+PiDCoMKgwqDCoMKg
IH0NCj4+IMKgwqDCoMKgwqAgc2VjdXJpdHlfYWRkX2hvb2tzKGFwcGFybW9yX2hvb2tzLCBB
UlJBWV9TSVpFKGFwcGFybW9yX2hvb2tzKSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgImFwcGFybW9yIik7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICZhcHBhcm1vcl9sc21pZCk7DQo+PiDCoCDCoMKgwqDCoMKgIC8qIFJlcG9ydCB0aGF0
IEFwcEFybW9yIHN1Y2Nlc3NmdWxseSBpbml0aWFsaXplZCAqLw0KPj4gwqDCoMKgwqDCoCBh
cHBhcm1vcl9pbml0aWFsaXplZCA9IDE7DQo+PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvY29t
bW9uY2FwLmMgYi9zZWN1cml0eS9jb21tb25jYXAuYw0KPj4gaW5kZXggYWZkOTY3OWNhODY2
Li45NzNlNmM3MDA5ZDAgMTAwNjQ0DQo+PiAtLS0gYS9zZWN1cml0eS9jb21tb25jYXAuYw0K
Pj4gKysrIGIvc2VjdXJpdHkvY29tbW9uY2FwLmMNCj4+IEBAIC0xMzQ0LDYgKzEzNDQsMTEg
QEAgaW50IGNhcF9tbWFwX2ZpbGUoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGxvbmcg
cmVxcHJvdCwNCj4+IMKgIMKgICNpZmRlZiBDT05GSUdfU0VDVVJJVFkNCj4+IMKgICtzdGF0
aWMgc3RydWN0IGxzbV9pZCBjYXBhYmlsaXR5X2xzbWlkIF9fbHNtX3JvX2FmdGVyX2luaXQg
PSB7DQo+PiArwqDCoMKgIC5sc23CoCA9ICJjYXBhYmlsaXR5IiwNCj4+ICvCoMKgwqAgLnNs
b3QgPSBMU01CTE9CX05PVF9ORUVERUQNCj4+ICt9Ow0KPj4gKw0KPj4gwqAgc3RhdGljIHN0
cnVjdCBzZWN1cml0eV9ob29rX2xpc3QgY2FwYWJpbGl0eV9ob29rc1tdIF9fbHNtX3JvX2Fm
dGVyX2luaXQgPSB7DQo+PiDCoMKgwqDCoMKgIExTTV9IT09LX0lOSVQoY2FwYWJsZSwgY2Fw
X2NhcGFibGUpLA0KPj4gwqDCoMKgwqDCoCBMU01fSE9PS19JTklUKHNldHRpbWUsIGNhcF9z
ZXR0aW1lKSwNCj4+IEBAIC0xMzY4LDcgKzEzNzMsNyBAQCBzdGF0aWMgc3RydWN0IHNlY3Vy
aXR5X2hvb2tfbGlzdCBjYXBhYmlsaXR5X2hvb2tzW10gX19sc21fcm9fYWZ0ZXJfaW5pdCA9
IHsNCj4+IMKgIHN0YXRpYyBpbnQgX19pbml0IGNhcGFiaWxpdHlfaW5pdCh2b2lkKQ0KPj4g
wqAgew0KPj4gwqDCoMKgwqDCoCBzZWN1cml0eV9hZGRfaG9va3MoY2FwYWJpbGl0eV9ob29r
cywgQVJSQVlfU0laRShjYXBhYmlsaXR5X2hvb2tzKSwNCj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgImNhcGFiaWxpdHkiKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICZjYXBhYmlsaXR5X2xzbWlkKTsNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7
DQo+PiDCoCB9DQo+PiDCoCBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvbG9hZHBpbi9sb2FkcGlu
LmMgYi9zZWN1cml0eS9sb2FkcGluL2xvYWRwaW4uYw0KPj4gaW5kZXggMDU1ZmIwYTY0MTY5
Li43YjIzZmRmMjRlMjcgMTAwNjQ0DQo+PiAtLS0gYS9zZWN1cml0eS9sb2FkcGluL2xvYWRw
aW4uYw0KPj4gKysrIGIvc2VjdXJpdHkvbG9hZHBpbi9sb2FkcGluLmMNCj4+IEBAIC0xODEs
NiArMTgxLDExIEBAIHN0YXRpYyBpbnQgbG9hZHBpbl9sb2FkX2RhdGEoZW51bSBrZXJuZWxf
bG9hZF9kYXRhX2lkIGlkKQ0KPj4gwqDCoMKgwqDCoCByZXR1cm4gbG9hZHBpbl9yZWFkX2Zp
bGUoTlVMTCwgKGVudW0ga2VybmVsX3JlYWRfZmlsZV9pZCkgaWQpOw0KPj4gwqAgfQ0KPj4g
wqAgK3N0YXRpYyBzdHJ1Y3QgbHNtX2lkIGxvYWRwaW5fbHNtaWQgX19sc21fcm9fYWZ0ZXJf
aW5pdCA9IHsNCj4+ICvCoMKgwqAgLmxzbcKgID0gImxvYWRwaW4iLA0KPj4gK8KgwqDCoCAu
c2xvdCA9IExTTUJMT0JfTk9UX05FRURFRA0KPj4gK307DQo+PiArDQo+PiDCoCBzdGF0aWMg
c3RydWN0IHNlY3VyaXR5X2hvb2tfbGlzdCBsb2FkcGluX2hvb2tzW10gX19sc21fcm9fYWZ0
ZXJfaW5pdCA9IHsNCj4+IMKgwqDCoMKgwqAgTFNNX0hPT0tfSU5JVChzYl9mcmVlX3NlY3Vy
aXR5LCBsb2FkcGluX3NiX2ZyZWVfc2VjdXJpdHkpLA0KPj4gwqDCoMKgwqDCoCBMU01fSE9P
S19JTklUKGtlcm5lbF9yZWFkX2ZpbGUsIGxvYWRwaW5fcmVhZF9maWxlKSwNCj4+IEBAIC0x
OTEsNyArMTk2LDggQEAgc3RhdGljIGludCBfX2luaXQgbG9hZHBpbl9pbml0KHZvaWQpDQo+
PiDCoCB7DQo+PiDCoMKgwqDCoMKgIHByX2luZm8oInJlYWR5IHRvIHBpbiAoY3VycmVudGx5
ICVzZW5mb3JjaW5nKVxuIiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlbmZvcmNlID8gIiIg
OiAibm90ICIpOw0KPj4gLcKgwqDCoCBzZWN1cml0eV9hZGRfaG9va3MobG9hZHBpbl9ob29r
cywgQVJSQVlfU0laRShsb2FkcGluX2hvb2tzKSwgImxvYWRwaW4iKTsNCj4+ICvCoMKgwqAg
c2VjdXJpdHlfYWRkX2hvb2tzKGxvYWRwaW5faG9va3MsIEFSUkFZX1NJWkUobG9hZHBpbl9o
b29rcyksDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmbG9hZHBpbl9sc21p
ZCk7DQo+PiDCoMKgwqDCoMKgIHJldHVybiAwOw0KPj4gwqAgfQ0KPj4gwqAgZGlmZiAtLWdp
dCBhL3NlY3VyaXR5L3NhZmVzZXRpZC9sc20uYyBiL3NlY3VyaXR5L3NhZmVzZXRpZC9sc20u
Yw0KPj4gaW5kZXggY2VjZDM4ZTJhYzgwLi40YTk2Y2Q4YzBkMTUgMTAwNjQ0DQo+PiAtLS0g
YS9zZWN1cml0eS9zYWZlc2V0aWQvbHNtLmMNCj4+ICsrKyBiL3NlY3VyaXR5L3NhZmVzZXRp
ZC9sc20uYw0KPj4gQEAgLTI1NSw2ICsyNTUsMTEgQEAgdm9pZCBmbHVzaF9zYWZlc2V0aWRf
d2hpdGVsaXN0X2VudHJpZXModm9pZCkNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gwqAgfQ0KPj4g
wqAgK3N0YXRpYyBzdHJ1Y3QgbHNtX2lkIHNhZmVzZXRpZF9sc21pZCBfX2xzbV9yb19hZnRl
cl9pbml0ID0gew0KPj4gK8KgwqDCoCAubHNtwqAgPSAic2FmZXNldGlkIiwNCj4+ICvCoMKg
wqAgLnNsb3QgPSBMU01CTE9CX05PVF9ORUVERUQNCj4+ICt9Ow0KPj4gKw0KPj4gwqAgc3Rh
dGljIHN0cnVjdCBzZWN1cml0eV9ob29rX2xpc3Qgc2FmZXNldGlkX3NlY3VyaXR5X2hvb2tz
W10gPSB7DQo+PiDCoMKgwqDCoMKgIExTTV9IT09LX0lOSVQodGFza19maXhfc2V0dWlkLCBz
YWZlc2V0aWRfdGFza19maXhfc2V0dWlkKSwNCj4+IMKgwqDCoMKgwqAgTFNNX0hPT0tfSU5J
VChjYXBhYmxlLCBzYWZlc2V0aWRfc2VjdXJpdHlfY2FwYWJsZSkNCj4+IEBAIC0yNjMsNyAr
MjY4LDggQEAgc3RhdGljIHN0cnVjdCBzZWN1cml0eV9ob29rX2xpc3Qgc2FmZXNldGlkX3Nl
Y3VyaXR5X2hvb2tzW10gPSB7DQo+PiDCoCBzdGF0aWMgaW50IF9faW5pdCBzYWZlc2V0aWRf
c2VjdXJpdHlfaW5pdCh2b2lkKQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBzZWN1cml0eV9h
ZGRfaG9va3Moc2FmZXNldGlkX3NlY3VyaXR5X2hvb2tzLA0KPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgQVJSQVlfU0laRShzYWZlc2V0aWRfc2VjdXJpdHlfaG9va3MpLCAi
c2FmZXNldGlkIik7DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBUlJBWV9T
SVpFKHNhZmVzZXRpZF9zZWN1cml0eV9ob29rcyksDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAmc2FmZXNldGlkX2xzbWlkKTsNCj4+IMKgIMKgwqDCoMKgwqAgLyogUmVw
b3J0IHRoYXQgU2FmZVNldElEIHN1Y2Nlc3NmdWxseSBpbml0aWFsaXplZCAqLw0KPj4gwqDC
oMKgwqDCoCBzYWZlc2V0aWRfaW5pdGlhbGl6ZWQgPSAxOw0KPj4gZGlmZiAtLWdpdCBhL3Nl
Y3VyaXR5L3NlY3VyaXR5LmMgYi9zZWN1cml0eS9zZWN1cml0eS5jDQo+PiBpbmRleCA3Y2Zl
ZGI5MDIxMGEuLjI3ZTJkYjNkNmIwNCAxMDA2NDQNCj4+IC0tLSBhL3NlY3VyaXR5L3NlY3Vy
aXR5LmMNCj4+ICsrKyBiL3NlY3VyaXR5L3NlY3VyaXR5LmMNCj4+IEBAIC0zMTcsNiArMzE3
LDcgQEAgc3RhdGljIHZvaWQgX19pbml0IG9yZGVyZWRfbHNtX2luaXQodm9pZCkNCj4+IMKg
wqDCoMKgwqAgaW5pdF9kZWJ1Zygic29jayBibG9iIHNpemXCoMKgwqDCoMKgwqAgPSAlZFxu
IiwgYmxvYl9zaXplcy5sYnNfc29jayk7DQo+PiDCoMKgwqDCoMKgIGluaXRfZGVidWcoInN1
cGVyYmxvY2sgYmxvYiBzaXplID0gJWRcbiIsIGJsb2Jfc2l6ZXMubGJzX3N1cGVyYmxvY2sp
Ow0KPj4gwqDCoMKgwqDCoCBpbml0X2RlYnVnKCJ0YXNrIGJsb2Igc2l6ZcKgwqDCoMKgwqDC
oCA9ICVkXG4iLCBibG9iX3NpemVzLmxic190YXNrKTsNCj4+ICvCoMKgwqAgaW5pdF9kZWJ1
ZygibHNtYmxvYiBzaXplwqDCoMKgwqDCoMKgwqDCoCA9ICVsdVxuIiwgc2l6ZW9mKHN0cnVj
dCBsc21ibG9iKSk7DQo+PiDCoCDCoMKgwqDCoMKgIC8qDQo+PiDCoMKgwqDCoMKgwqAgKiBD
cmVhdGUgYW55IGttZW1fY2FjaGVzIG5lZWRlZCBmb3IgYmxvYnMNCj4+IEBAIC0zOTksNyAr
NDAwLDcgQEAgc3RhdGljIGJvb2wgbWF0Y2hfbGFzdF9sc20oY29uc3QgY2hhciAqbGlzdCwg
Y29uc3QgY2hhciAqbHNtKQ0KPj4gwqDCoMKgwqDCoCByZXR1cm4gIXN0cmNtcChsYXN0LCBs
c20pOw0KPj4gwqAgfQ0KPj4gwqAgLXN0YXRpYyBpbnQgbHNtX2FwcGVuZChjaGFyICpuZXcs
IGNoYXIgKipyZXN1bHQpDQo+PiArc3RhdGljIGludCBsc21fYXBwZW5kKGNvbnN0IGNoYXIg
Km5ldywgY2hhciAqKnJlc3VsdCkNCj4+IMKgIHsNCj4+IMKgwqDCoMKgwqAgY2hhciAqY3A7
DQo+PiDCoCBAQCAtNDIwLDI0ICs0MjEsNDAgQEAgc3RhdGljIGludCBsc21fYXBwZW5kKGNo
YXIgKm5ldywgY2hhciAqKnJlc3VsdCkNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+PiDC
oCB9DQo+PiDCoCArLyoNCj4+ICsgKiBDdXJyZW50IGluZGV4IHRvIHVzZSB3aGlsZSBpbml0
aWFsaXppbmcgdGhlIGxzbWJsb2Igc2VjaWQgbGlzdC4NCj4+ICsgKi8NCj4+ICtzdGF0aWMg
aW50IGxzbV9zbG90IF9faW5pdGRhdGE7DQo+PiArDQo+PiDCoCAvKioNCj4+IMKgwqAgKiBz
ZWN1cml0eV9hZGRfaG9va3MgLSBBZGQgYSBtb2R1bGVzIGhvb2tzIHRvIHRoZSBob29rIGxp
c3RzLg0KPj4gwqDCoCAqIEBob29rczogdGhlIGhvb2tzIHRvIGFkZA0KPj4gwqDCoCAqIEBj
b3VudDogdGhlIG51bWJlciBvZiBob29rcyB0byBhZGQNCj4+IC0gKiBAbHNtOiB0aGUgbmFt
ZSBvZiB0aGUgc2VjdXJpdHkgbW9kdWxlDQo+PiArICogQGxzbWlkOiB0aGUgaWRlbnRpZmlj
YXRpb24gaW5mb3JtYXRpb24gZm9yIHRoZSBzZWN1cml0eSBtb2R1bGUNCj4+IMKgwqAgKg0K
Pj4gwqDCoCAqIEVhY2ggTFNNIGhhcyB0byByZWdpc3RlciBpdHMgaG9va3Mgd2l0aCB0aGUg
aW5mcmFzdHJ1Y3R1cmUuDQo+PiArICogSWYgdGhlIExTTSBpcyB1c2luZyBob29rcyB0aGF0
IGV4cG9ydCBzZWNpZHMgYWxsb2NhdGUgYSBzbG90DQo+PiArICogZm9yIGl0IGluIHRoZSBs
c21ibG9iLg0KPj4gwqDCoCAqLw0KPj4gwqAgdm9pZCBfX2luaXQgc2VjdXJpdHlfYWRkX2hv
b2tzKHN0cnVjdCBzZWN1cml0eV9ob29rX2xpc3QgKmhvb2tzLCBpbnQgY291bnQsDQo+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNoYXIgKmxzbSkNCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGxzbV9pZCAqbHNtaWQpDQo+
PiDCoCB7DQo+PiDCoMKgwqDCoMKgIGludCBpOw0KPj4gwqAgK8KgwqDCoCBpZiAobHNtaWQt
PnNsb3QgPT0gTFNNQkxPQl9ORUVERUQpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAobHNt
X3Nsb3QgPj0gTFNNQkxPQl9FTlRSSUVTKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cGFuaWMoIiVzIFRvbyBtYW55IExTTXMgcmVnaXN0ZXJlZC5cbiIsIF9fZnVuY19fKTsNCj4+
ICvCoMKgwqDCoMKgwqDCoCBsc21pZC0+c2xvdCA9IGxzbV9zbG90Kys7DQo+PiArwqDCoMKg
wqDCoMKgwqAgaW5pdF9kZWJ1ZygiJXMgYXNzaWduZWQgbHNtYmxvYiBzbG90ICVkXG4iLCBs
c21pZC0+bHNtLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbHNtaWQtPnNs
b3QpOw0KPj4gK8KgwqDCoCB9DQo+PiArDQo+PiDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkg
PCBjb3VudDsgaSsrKSB7DQo+PiAtwqDCoMKgwqDCoMKgwqAgaG9va3NbaV0ubHNtID0gbHNt
Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIGhvb2tzW2ldLmxzbWlkID0gbHNtaWQ7DQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgaGxpc3RfYWRkX3RhaWxfcmN1KCZob29rc1tpXS5saXN0LCBob29r
c1tpXS5oZWFkKTsNCj4+IMKgwqDCoMKgwqAgfQ0KPj4gLcKgwqDCoCBpZiAobHNtX2FwcGVu
ZChsc20sICZsc21fbmFtZXMpIDwgMCkNCj4+ICsNCj4+ICvCoMKgwqAgaWYgKGxzbV9hcHBl
bmQobHNtaWQtPmxzbSwgJmxzbV9uYW1lcykgPCAwKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IHBhbmljKCIlcyAtIENhbm5vdCBnZXQgZWFybHkgbWVtb3J5LlxuIiwgX19mdW5jX18pOw0K
Pj4gwqAgfQ0KPj4gwqAgQEAgLTE5MTcsNyArMTkzNCw3IEBAIGludCBzZWN1cml0eV9nZXRw
cm9jYXR0cihzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIGNvbnN0IGNoYXIgKmxzbSwgY2hhciAq
bmFtZSwNCj4+IMKgwqDCoMKgwqAgc3RydWN0IHNlY3VyaXR5X2hvb2tfbGlzdCAqaHA7DQo+
PiDCoCDCoMKgwqDCoMKgIGhsaXN0X2Zvcl9lYWNoX2VudHJ5KGhwLCAmc2VjdXJpdHlfaG9v
a19oZWFkcy5nZXRwcm9jYXR0ciwgbGlzdCkgew0KPj4gLcKgwqDCoMKgwqDCoMKgIGlmIChs
c20gIT0gTlVMTCAmJiBzdHJjbXAobHNtLCBocC0+bHNtKSkNCj4+ICvCoMKgwqDCoMKgwqDC
oCBpZiAobHNtICE9IE5VTEwgJiYgc3RyY21wKGxzbSwgaHAtPmxzbWlkLT5sc20pKQ0KPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGhwLT5ob29rLmdldHByb2NhdHRyKHAsIG5hbWUsIHZhbHVlKTsNCj4+
IMKgwqDCoMKgwqAgfQ0KPj4gQEAgLTE5MzAsNyArMTk0Nyw3IEBAIGludCBzZWN1cml0eV9z
ZXRwcm9jYXR0cihjb25zdCBjaGFyICpsc20sIGNvbnN0IGNoYXIgKm5hbWUsIHZvaWQgKnZh
bHVlLA0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qgc2VjdXJpdHlfaG9va19saXN0ICpocDsNCj4+
IMKgIMKgwqDCoMKgwqAgaGxpc3RfZm9yX2VhY2hfZW50cnkoaHAsICZzZWN1cml0eV9ob29r
X2hlYWRzLnNldHByb2NhdHRyLCBsaXN0KSB7DQo+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKGxz
bSAhPSBOVUxMICYmIHN0cmNtcChsc20sIGhwLT5sc20pKQ0KPj4gK8KgwqDCoMKgwqDCoMKg
IGlmIChsc20gIT0gTlVMTCAmJiBzdHJjbXAobHNtLCBocC0+bHNtaWQtPmxzbSkpDQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gaHAtPmhvb2suc2V0cHJvY2F0dHIobmFtZSwgdmFsdWUsIHNpemUpOw0K
Pj4gwqDCoMKgwqDCoCB9DQo+PiBkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvc2VsaW51eC9ob29r
cy5jIGIvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jDQo+PiBpbmRleCBjODNlYzI2NTJlZGEu
Ljc0YzQ5MTk4MGVkMiAxMDA2NDQNCj4+IC0tLSBhL3NlY3VyaXR5L3NlbGludXgvaG9va3Mu
Yw0KPj4gKysrIGIvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jDQo+PiBAQCAtNjYyMiw2ICs2
NjIyLDExIEBAIHN0cnVjdCBsc21fYmxvYl9zaXplcyBzZWxpbnV4X2Jsb2Jfc2l6ZXMgX19s
c21fcm9fYWZ0ZXJfaW5pdCA9IHsNCj4+IMKgwqDCoMKgwqAgLmxic19zdXBlcmJsb2NrID0g
c2l6ZW9mKHN0cnVjdCBzdXBlcmJsb2NrX3NlY3VyaXR5X3N0cnVjdCksDQo+PiDCoCB9Ow0K
Pj4gwqAgK3N0YXRpYyBzdHJ1Y3QgbHNtX2lkIHNlbGludXhfbHNtaWQgX19sc21fcm9fYWZ0
ZXJfaW5pdCA9IHsNCj4+ICvCoMKgwqAgLmxzbcKgID0gInNlbGludXgiLA0KPj4gK8KgwqDC
oCAuc2xvdCA9IExTTUJMT0JfTkVFREVEDQo+PiArfTsNCj4+ICsNCj4+IMKgIHN0YXRpYyBz
dHJ1Y3Qgc2VjdXJpdHlfaG9va19saXN0IHNlbGludXhfaG9va3NbXSBfX2xzbV9yb19hZnRl
cl9pbml0ID0gew0KPj4gwqDCoMKgwqDCoCBMU01fSE9PS19JTklUKGJpbmRlcl9zZXRfY29u
dGV4dF9tZ3IsIHNlbGludXhfYmluZGVyX3NldF9jb250ZXh0X21nciksDQo+PiDCoMKgwqDC
oMKgIExTTV9IT09LX0lOSVQoYmluZGVyX3RyYW5zYWN0aW9uLCBzZWxpbnV4X2JpbmRlcl90
cmFuc2FjdGlvbiksDQo+PiBAQCAtNjg3Nyw3ICs2ODgyLDggQEAgc3RhdGljIF9faW5pdCBp
bnQgc2VsaW51eF9pbml0KHZvaWQpDQo+PiDCoCDCoMKgwqDCoMKgIGhhc2h0YWJfY2FjaGVf
aW5pdCgpOw0KPj4gwqAgLcKgwqDCoCBzZWN1cml0eV9hZGRfaG9va3Moc2VsaW51eF9ob29r
cywgQVJSQVlfU0laRShzZWxpbnV4X2hvb2tzKSwgInNlbGludXgiKTsNCj4+ICvCoMKgwqAg
c2VjdXJpdHlfYWRkX2hvb2tzKHNlbGludXhfaG9va3MsIEFSUkFZX1NJWkUoc2VsaW51eF9o
b29rcyksDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmc2VsaW51eF9sc21p
ZCk7DQo+PiDCoCDCoMKgwqDCoMKgIGlmIChhdmNfYWRkX2NhbGxiYWNrKHNlbGludXhfbmV0
Y2FjaGVfYXZjX2NhbGxiYWNrLCBBVkNfQ0FMTEJBQ0tfUkVTRVQpKQ0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHBhbmljKCJTRUxpbnV4OiBVbmFibGUgdG8gcmVnaXN0ZXIgQVZDIG5ldGNh
Y2hlIGNhbGxiYWNrXG4iKTsNCj4+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9zbWFjay9zbWFj
a19sc20uYyBiL3NlY3VyaXR5L3NtYWNrL3NtYWNrX2xzbS5jDQo+PiBpbmRleCBlOTU2MGIw
NzhlZmUuLjdhMGVhZDRkYTQ3OSAxMDA2NDQNCj4+IC0tLSBhL3NlY3VyaXR5L3NtYWNrL3Nt
YWNrX2xzbS5jDQo+PiArKysgYi9zZWN1cml0eS9zbWFjay9zbWFja19sc20uYw0KPj4gQEAg
LTQ1NTMsNiArNDU1MywxMSBAQCBzdHJ1Y3QgbHNtX2Jsb2Jfc2l6ZXMgc21hY2tfYmxvYl9z
aXplcyBfX2xzbV9yb19hZnRlcl9pbml0ID0gew0KPj4gwqDCoMKgwqDCoCAubGJzX3N1cGVy
YmxvY2sgPSBzaXplb2Yoc3RydWN0IHN1cGVyYmxvY2tfc21hY2spLA0KPj4gwqAgfTsNCj4+
IMKgICtzdGF0aWMgc3RydWN0IGxzbV9pZCBzbWFja19sc21pZCBfX2xzbV9yb19hZnRlcl9p
bml0ID0gew0KPj4gK8KgwqDCoCAubHNtwqAgPSAic21hY2siLA0KPj4gK8KgwqDCoCAuc2xv
dCA9IExTTUJMT0JfTkVFREVEDQo+PiArfTsNCj4+ICsNCj4+IMKgIHN0YXRpYyBzdHJ1Y3Qg
c2VjdXJpdHlfaG9va19saXN0IHNtYWNrX2hvb2tzW10gX19sc21fcm9fYWZ0ZXJfaW5pdCA9
IHsNCj4+IMKgwqDCoMKgwqAgTFNNX0hPT0tfSU5JVChwdHJhY2VfYWNjZXNzX2NoZWNrLCBz
bWFja19wdHJhY2VfYWNjZXNzX2NoZWNrKSwNCj4+IMKgwqDCoMKgwqAgTFNNX0hPT0tfSU5J
VChwdHJhY2VfdHJhY2VtZSwgc21hY2tfcHRyYWNlX3RyYWNlbWUpLA0KPj4gQEAgLTQ3NDMs
NyArNDc0OCw3IEBAIHN0YXRpYyBfX2luaXQgaW50IHNtYWNrX2luaXQodm9pZCkNCj4+IMKg
wqDCoMKgwqAgLyoNCj4+IMKgwqDCoMKgwqDCoCAqIFJlZ2lzdGVyIHdpdGggTFNNDQo+PiDC
oMKgwqDCoMKgwqAgKi8NCj4+IC3CoMKgwqAgc2VjdXJpdHlfYWRkX2hvb2tzKHNtYWNrX2hv
b2tzLCBBUlJBWV9TSVpFKHNtYWNrX2hvb2tzKSwgInNtYWNrIik7DQo+PiArwqDCoMKgIHNl
Y3VyaXR5X2FkZF9ob29rcyhzbWFja19ob29rcywgQVJSQVlfU0laRShzbWFja19ob29rcyks
ICZzbWFja19sc21pZCk7DQo+PiDCoMKgwqDCoMKgIHNtYWNrX2VuYWJsZWQgPSAxOw0KPj4g
wqAgwqDCoMKgwqDCoCBwcl9pbmZvKCJTbWFjazrCoCBJbml0aWFsaXppbmcuXG4iKTsNCj4+
IGRpZmYgLS1naXQgYS9zZWN1cml0eS90b21veW8vdG9tb3lvLmMgYi9zZWN1cml0eS90b21v
eW8vdG9tb3lvLmMNCj4+IGluZGV4IDcxNmM5MmVjOTQxYS4uZjE5NjhlODBmMDZkIDEwMDY0
NA0KPj4gLS0tIGEvc2VjdXJpdHkvdG9tb3lvL3RvbW95by5jDQo+PiArKysgYi9zZWN1cml0
eS90b21veW8vdG9tb3lvLmMNCj4+IEBAIC01MjksNiArNTI5LDExIEBAIHN0YXRpYyB2b2lk
IHRvbW95b190YXNrX2ZyZWUoc3RydWN0IHRhc2tfc3RydWN0ICp0YXNrKQ0KPj4gwqDCoMKg
wqDCoCB9DQo+PiDCoCB9DQo+PiDCoCArc3RhdGljIHN0cnVjdCBsc21faWQgdG9tb3lvX2xz
bWlkIF9fbHNtX3JvX2FmdGVyX2luaXQgPSB7DQo+PiArwqDCoMKgIC5sc23CoCA9ICJ0b21v
eW8iLA0KPj4gK8KgwqDCoCAuc2xvdCA9IExTTUJMT0JfTk9UX05FRURFRA0KPj4gK307DQo+
PiArDQo+PiDCoCAvKg0KPj4gwqDCoCAqIHRvbW95b19zZWN1cml0eV9vcHMgaXMgYSAic3Ry
dWN0IHNlY3VyaXR5X29wZXJhdGlvbnMiIHdoaWNoIGlzIHVzZWQgZm9yDQo+PiDCoMKgICog
cmVnaXN0ZXJpbmcgVE9NT1lPLg0KPj4gQEAgLTU4MSw3ICs1ODYsOCBAQCBzdGF0aWMgaW50
IF9faW5pdCB0b21veW9faW5pdCh2b2lkKQ0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgdG9tb3lv
X3Rhc2sgKnMgPSB0b21veW9fdGFzayhjdXJyZW50KTsNCj4+IMKgIMKgwqDCoMKgwqAgLyog
cmVnaXN0ZXIgb3Vyc2VsdmVzIHdpdGggdGhlIHNlY3VyaXR5IGZyYW1ld29yayAqLw0KPj4g
LcKgwqDCoCBzZWN1cml0eV9hZGRfaG9va3ModG9tb3lvX2hvb2tzLCBBUlJBWV9TSVpFKHRv
bW95b19ob29rcyksICJ0b21veW8iKTsNCj4+ICvCoMKgwqAgc2VjdXJpdHlfYWRkX2hvb2tz
KHRvbW95b19ob29rcywgQVJSQVlfU0laRSh0b21veW9faG9va3MpLA0KPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgJnRvbW95b19sc21pZCk7DQo+PiDCoMKgwqDCoMKgIHBy
X2luZm8oIlRPTU9ZTyBMaW51eCBpbml0aWFsaXplZFxuIik7DQo+PiDCoMKgwqDCoMKgIHMt
PmRvbWFpbl9pbmZvID0gJnRvbW95b19rZXJuZWxfZG9tYWluOw0KPj4gwqDCoMKgwqDCoCBh
dG9taWNfaW5jKCZ0b21veW9fa2VybmVsX2RvbWFpbi51c2Vycyk7DQo+PiBkaWZmIC0tZ2l0
IGEvc2VjdXJpdHkveWFtYS95YW1hX2xzbS5jIGIvc2VjdXJpdHkveWFtYS95YW1hX2xzbS5j
DQo+PiBpbmRleCBlZmFjNjg1NTZiNDUuLjA1MjllY2M4Njk1NCAxMDA2NDQNCj4+IC0tLSBh
L3NlY3VyaXR5L3lhbWEveWFtYV9sc20uYw0KPj4gKysrIGIvc2VjdXJpdHkveWFtYS95YW1h
X2xzbS5jDQo+PiBAQCAtNDI1LDYgKzQyNSwxMSBAQCBzdGF0aWMgaW50IHlhbWFfcHRyYWNl
X3RyYWNlbWUoc3RydWN0IHRhc2tfc3RydWN0ICpwYXJlbnQpDQo+PiDCoMKgwqDCoMKgIHJl
dHVybiByYzsNCj4+IMKgIH0NCj4+IMKgICtzdGF0aWMgc3RydWN0IGxzbV9pZCB5YW1hX2xz
bWlkIF9fbHNtX3JvX2FmdGVyX2luaXQgPSB7DQo+PiArwqDCoMKgIC5sc23CoCA9ICJ5YW1h
IiwNCj4+ICvCoMKgwqAgLnNsb3QgPSBMU01CTE9CX05PVF9ORUVERUQNCj4+ICt9Ow0KPj4g
Kw0KPj4gwqAgc3RhdGljIHN0cnVjdCBzZWN1cml0eV9ob29rX2xpc3QgeWFtYV9ob29rc1td
IF9fbHNtX3JvX2FmdGVyX2luaXQgPSB7DQo+PiDCoMKgwqDCoMKgIExTTV9IT09LX0lOSVQo
cHRyYWNlX2FjY2Vzc19jaGVjaywgeWFtYV9wdHJhY2VfYWNjZXNzX2NoZWNrKSwNCj4+IMKg
wqDCoMKgwqAgTFNNX0hPT0tfSU5JVChwdHJhY2VfdHJhY2VtZSwgeWFtYV9wdHJhY2VfdHJh
Y2VtZSksDQo+PiBAQCAtNDgyLDcgKzQ4Nyw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB5YW1h
X2luaXRfc3lzY3RsKHZvaWQpIHsgfQ0KPj4gwqAgc3RhdGljIGludCBfX2luaXQgeWFtYV9p
bml0KHZvaWQpDQo+PiDCoCB7DQo+PiDCoMKgwqDCoMKgIHByX2luZm8oIllhbWE6IGJlY29t
aW5nIG1pbmRmdWwuXG4iKTsNCj4+IC3CoMKgwqAgc2VjdXJpdHlfYWRkX2hvb2tzKHlhbWFf
aG9va3MsIEFSUkFZX1NJWkUoeWFtYV9ob29rcyksICJ5YW1hIik7DQo+PiArwqDCoMKgIHNl
Y3VyaXR5X2FkZF9ob29rcyh5YW1hX2hvb2tzLCBBUlJBWV9TSVpFKHlhbWFfaG9va3MpLCAm
eWFtYV9sc21pZCk7DQo+PiDCoMKgwqDCoMKgIHlhbWFfaW5pdF9zeXNjdGwoKTsNCj4+IMKg
wqDCoMKgwqAgcmV0dXJuIDA7DQo+PiDCoCB9DQo+Pg0KPg0K
