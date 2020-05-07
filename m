Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1769B1C982C
	for <lists+linux-security-module@lfdr.de>; Thu,  7 May 2020 19:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGRpd (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 7 May 2020 13:45:33 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:19858 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728018AbgEGRpd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 7 May 2020 13:45:33 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047HfIXw021011;
        Thu, 7 May 2020 13:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=QdxKneCQ5JhjSE90izH6gww2BLbT8NTBXx9ipZn1+u8=;
 b=uRtpm3I4dwBu2bRwWAQoaOloevcFXVi/lPq1QrHBPC2AxbhmRjld6RH89nwvfEkAK4Td
 dSbkPs8HgBAEDG28ZOvuqqtxgpU/aAN9yzFcdMcSrhdxyIAwcINt5ZIDnVAXezCx2Ooj
 GQGdYJktZ+Jb8aBb2qAWkTQvwmE8daqGNKmF6cddaaY1rToM4I8uoSe3qlPRozcfGd8B
 Ae9w9gIN9jyxQbwDSNEeCwSCrEFMlqFL3Xm5zYSRa+UZQ8K5sYd9trSqH30tmOewsSHB
 2OkcBnLWkddGAPDEwiMSyEGzbPP8AdQHS3gymLCUfU4Ozyw6URE16ouUlBnW8I1r8yqr Ww== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 30s43af7ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 13:45:30 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047HdsUp020110;
        Thu, 7 May 2020 13:45:30 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 30vkj3ky7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 13:45:29 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="465808125"
From:   <Mario.Limonciello@dell.com>
To:     <hughsient@gmail.com>, <platform-driver-x86@vger.kernel.org>
CC:     <linux-security-module@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Thread-Topic: [PATCH] platform/x86: Export LPC attributes for the system SPI
 chip
Thread-Index: AQHWI75rctPsm0zoq0Gk7Ve+Eu3BHaic5Qmw
Date:   Thu, 7 May 2020 17:45:27 +0000
Message-ID: <aa217de398584fa7846cf4ac0c872036@AUSX13MPC101.AMER.DELL.COM>
References: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
In-Reply-To: <18e48255d68a1408b3e3152780f0e789df540059.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-07T17:44:59.1736694Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=d360ee1b-bc2e-4f16-8fda-2885409985ac;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.28]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_10:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070144
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 clxscore=1011
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070144
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

PiBFeHBvcnQgc3RhbmRhcmQgTFBDIGNvbmZpZ3VyYXRpb24gdmFsdWVzIGZyb20gdmFyaW91cyBM
UEMvZVNQSQ0KPiBjb250cm9sbGVycy4gVGhpcyBhbGxvd3MgdXNlcnNwYWNlIGNvbXBvbmVudHMg
c3VjaCBhcyBmd3VwZCB0bw0KPiB2ZXJpZnkgdGhlIG1vc3QgYmFzaWMgU1BJIHByb3RlY3Rpb25z
IGFyZSBzZXQgY29ycmVjdGx5Lg0KPiBGb3IgaW5zdGFuY2UsIGNoZWNraW5nIEJJT1NXRSBpcyBk
aXNhYmxlZCBhbmQgQkxFIGlzIGVuYWJsZWQuDQo+IA0KPiBNb3JlIGN1dHRpbmctZWRnZSBjaGVj
a3MgKGUuZy4gUFJ4IGFuZCBCb290R3VhcmQpIGNhbiBiZSBhZGRlZA0KPiBvbmNlIHRoZSBiYXNp
Y3MgYXJlIGluIHBsYWNlLiBFeHBvcnRpbmcgdGhlc2UgdmFsdWVzIGZyb20gdGhlDQo+IGtlcm5l
bCBhbGxvd3MgdXMgdG8gcmVwb3J0IHRoZSBzZWN1cml0eSBsZXZlbCBvZiB0aGUgcGxhdGZvcm0N
Cj4gd2l0aG91dCByZWJvb3RpbmcgYW5kIHJ1bm5pbmcgYW4gdW5zaWduZWQgRUZJIGJpbmFyeSBs
aWtlDQo+IGNoaXBzZWMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEh1Z2hlcyA8cmlj
aGFyZEBodWdoc2llLmNvbT4NCj4gLS0tDQo+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDYgKw0KPiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvS2NvbmZpZyAgICAgICAg
IHwgIDEwICsrDQo+ICBkcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZSAgICAgICAgfCAgIDEg
Kw0KPiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfc3BpX2xwYy5jIHwgMTgzICsrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAyMDAgaW5zZXJ0aW9ucygr
KQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX3NwaV9s
cGMuYw0KPiANCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5k
ZXggMjkyNjMyN2U0OTc2Li4yNzc5YThkNDhmMWMgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJT
DQo+ICsrKyBiL01BSU5UQUlORVJTDQo+IEBAIC00MDEsNiArNDAxLDEyIEBAIEw6CXBsYXRmb3Jt
LWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnDQo+ICBTOglNYWludGFpbmVkDQo+ICBGOglkcml2
ZXJzL3BsYXRmb3JtL3g4Ni9pMmMtbXVsdGktaW5zdGFudGlhdGUuYw0KPiANCj4gK1NQSSBMUEMg
Y29uZmlndXJhdGlvbg0KPiArTToJUmljaGFyZCBIdWdoZXMgPHJpY2hhcmRAaHVnaHNpZS5jb20+
DQo+ICtMOglwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZw0KPiArUzoJTWFpbnRh
aW5lZA0KPiArRjoJZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfc3BpX2xwYy5jDQo+ICsNCj4g
IEFDUEkgUE1JQyBEUklWRVJTDQo+ICBNOgkiUmFmYWVsIEouIFd5c29ja2kiIDxyandAcmp3eXNv
Y2tpLm5ldD4NCj4gIE06CUxlbiBCcm93biA8bGVuYkBrZXJuZWwub3JnPg0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvS2NvbmZpZw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2
L0tjb25maWcNCj4gaW5kZXggMGFkN2FkOGNmOGUxLi41Zjc0NDFjZGU1ZTcgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9wbGF0Zm9y
bS94ODYvS2NvbmZpZw0KPiBAQCAtODM3LDYgKzgzNywxNiBAQCBjb25maWcgSU5URUxfVkJUTg0K
PiAgCSAgVG8gY29tcGlsZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTog
dGhlIG1vZHVsZQ0KPiB3aWxsDQo+ICAJICBiZSBjYWxsZWQgaW50ZWxfdmJ0bi4NCj4gDQo+ICtj
b25maWcgSU5URUxfU1BJX0xQQw0KPiArCXRyaXN0YXRlICJJbnRlbCBTUEkgTFBDIGNvbmZpZ3Vy
YXRpb24iDQo+ICsJZGVwZW5kcyBvbiBTRUNVUklUWQ0KPiArCWhlbHANCj4gKwkgIEV4cG9ydCBM
UEMgY29uZmlndXJhdGlvbiBhdHRyaWJ1dGVzIGZvciB0aGUgc3lzdGVtIFNQSSBjaGlwLg0KPiAr
DQo+ICsJICBUbyBjb21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJl
OiB0aGUgbW9kdWxlDQo+IHdpbGwNCj4gKwkgIGJlIGNhbGxlZCBpbnRlbF9zcGlfbHBjLg0KPiAr
CSAgSWYgdW5zdXJlLCBzYXkgTi4NCj4gKw0KPiAgY29uZmlnIFNVUkZBQ0UzX1dNSQ0KPiAgCXRy
aXN0YXRlICJTdXJmYWNlIDMgV01JIERyaXZlciINCj4gIAlkZXBlbmRzIG9uIEFDUElfV01JDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZQ0KPiBiL2RyaXZlcnMv
cGxhdGZvcm0veDg2L01ha2VmaWxlDQo+IGluZGV4IDUzNDA4ZDk2NTg3NC4uZThmNjkwMWJiMTY1
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZQ0KPiArKysgYi9k
cml2ZXJzL3BsYXRmb3JtL3g4Ni9NYWtlZmlsZQ0KPiBAQCAtNzgsNiArNzgsNyBAQCBvYmotJChD
T05GSUdfSU5URUxfSU5UMDAwMl9WR1BJTykJKz0NCj4gaW50ZWxfaW50MDAwMl92Z3Bpby5vDQo+
ICBvYmotJChDT05GSUdfSU5URUxfTUVOTE9XKQkJKz0gaW50ZWxfbWVubG93Lm8NCj4gIG9iai0k
KENPTkZJR19JTlRFTF9PQUtUUkFJTCkJCSs9IGludGVsX29ha3RyYWlsLm8NCj4gIG9iai0kKENP
TkZJR19JTlRFTF9WQlROKQkJKz0gaW50ZWwtdmJ0bi5vDQo+ICtvYmotJChDT05GSUdfSU5URUxf
U1BJX0xQQykJCSs9IGludGVsX3NwaV9scGMubw0KPiANCj4gICMgTWljcm9zb2Z0DQo+ICBvYmot
JChDT05GSUdfU1VSRkFDRTNfV01JKQkJKz0gc3VyZmFjZTMtd21pLm8NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX3NwaV9scGMuYw0KPiBiL2RyaXZlcnMvcGxhdGZv
cm0veDg2L2ludGVsX3NwaV9scGMuYw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAw
MDAwMDAwMDAwMDAuLmRkNTczNTkzYTBmNQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2ludGVsX3NwaV9scGMuYw0KPiBAQCAtMCwwICsxLDE4MyBAQA0KPiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKy8qDQo+ICsgKiBTUEkgTFBD
IGZsYXNoIHBsYXRmb3JtIHNlY3VyaXR5IGRyaXZlcg0KPiArICoNCj4gKyAqIENvcHlyaWdodCAy
MDIwIChjKSBSaWNoYXJkIEh1Z2hlcyAocmljaGFyZEBodWdoc2llLmNvbSkNCj4gKyAqDQo+ICsg
KiBUaGlzIGZpbGUgaXMgbGljZW5zZWQgdW5kZXIgIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljDQo+ICsgKiBMaWNlbnNlIHZlcnNpb24gMi4gVGhpcyBwcm9ncmFtIGlzIGxpY2Vu
c2VkICJhcyBpcyIgd2l0aG91dCBhbnkNCj4gKyAqIHdhcnJhbnR5IG9mIGFueSBraW5kLCB3aGV0
aGVyIGV4cHJlc3Mgb3IgaW1wbGllZC4NCj4gKyAqLw0KPiArDQo+ICsjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvc2VjdXJpdHkuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9wY2kuaD4NCj4gKw0KPiArLyogTFBDIGJyaWRnZSBQQ0kgY29uZmlnIHNwYWNlIHJlZ2lz
dGVycyAqLw0KPiArI2RlZmluZSBCSU9TX0NOVExfUkVHCQkJCTB4REMNCj4gKyNkZWZpbmUgQklP
U19DTlRMX1dSSVRFX0VOQUJMRV9NQVNLCQkweDAxDQo+ICsjZGVmaW5lIEJJT1NfQ05UTF9MT0NL
X0VOQUJMRV9NQVNLCQkweDAyDQo+ICsjZGVmaW5lIEJJT1NfQ05UTF9XUF9ESVNBQkxFX01BU0sJ
CTB4MjANCj4gKw0KPiArLyoNCj4gKyAqIFRoaXMgZGF0YSBvbmx5IGV4aXN0cyBmb3IgZXhwb3J0
aW5nIHRoZSBzdXBwb3J0ZWQgUENJIGlkcyB2aWENCj4gKyAqIE1PRFVMRV9ERVZJQ0VfVEFCTEUu
ICBXZSBkbyBub3QgYWN0dWFsbHkgcmVnaXN0ZXIgYSBwY2lfZHJpdmVyLg0KPiArICovDQo+ICtz
dGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgcGNpX3RibFtdID0gew0KPiArCXtQQ0lf
REVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MDJhNCl9LCAvKiBDb21ldCBMYWtlIFNQSSAq
Lw0KPiArCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4MzRhNCl9LCAvKiBJY2Ug
TGFrZS1MUCBTUEkNCj4gKi8NCj4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCAw
eDljNjYpfSwgLyogOCBTZXJpZXMgU1BJICovDQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9J
RF9JTlRFTCwgMHg5Y2U2KX0sIC8qIFdpbGRjYXQgUG9pbnQtTFANCj4gR1NQSSAqLw0KPiArCXtQ
Q0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4OWQyYSl9LCAvKiBTdW5yaXNlIFBvaW50
LQ0KPiBMUC9TUEkgKi8NCj4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCAweDlk
NGUpfSwgLyogU3VucmlzZSBQb2ludA0KPiBMUEMvZVNQSSAqLw0KPiArCXtQQ0lfREVWSUNFKFBD
SV9WRU5ET1JfSURfSU5URUwsIDB4OWRhNCl9LCAvKiBDYW5ub24gUG9pbnQtTFANCj4gU1BJICov
DQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhMTQwKX0sIC8qIFN1bnJp
c2UgUG9pbnQtSA0KPiBMUEMgKi8NCj4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVM
LCAweGExNDEpfSwgLyogU3VucmlzZSBQb2ludC1IDQo+IExQQyAqLw0KPiArCXtQQ0lfREVWSUNF
KFBDSV9WRU5ET1JfSURfSU5URUwsIDB4YTE0Mil9LCAvKiBTdW5yaXNlIFBvaW50LUgNCj4gTFBD
ICovDQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhMTQzKX0sIC8qIEgx
MTAgTFBDL2VTUEkgKi8NCj4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCAweGEx
NDQpfSwgLyogSDE3MCBMUEMvZVNQSSAqLw0KPiArCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURf
SU5URUwsIDB4YTE0NSl9LCAvKiBaMTcwIExQQy9lU1BJICovDQo+ICsJe1BDSV9ERVZJQ0UoUENJ
X1ZFTkRPUl9JRF9JTlRFTCwgMHhhMTQ2KX0sIC8qIFExNzAgTFBDL2VTUEkgKi8NCj4gKwl7UENJ
X0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCAweGExNDcpfSwgLyogUTE1MCBMUEMvZVNQSSAq
Lw0KPiArCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4YTE0OCl9LCAvKiBCMTUw
IExQQy9lU1BJICovDQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhMTQ5
KX0sIC8qIEMyMzYgTFBDL2VTUEkgKi8NCj4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lO
VEVMLCAweGExNGEpfSwgLyogQzIzMiBMUEMvZVNQSSAqLw0KPiArCXtQQ0lfREVWSUNFKFBDSV9W
RU5ET1JfSURfSU5URUwsIDB4YTE0Yil9LCAvKiBTdW5yaXNlIFBvaW50LUgNCj4gTFBDICovDQo+
ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhMTRjKX0sIC8qIFN1bnJpc2Ug
UG9pbnQtSA0KPiBMUEMgKi8NCj4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCAw
eGExNGQpfSwgLyogUU0xNzAgTFBDL2VTUEkgKi8NCj4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9S
X0lEX0lOVEVMLCAweGExNGUpfSwgLyogSE0xNzAgTFBDL2VTUEkgKi8NCj4gKwl7UENJX0RFVklD
RShQQ0lfVkVORE9SX0lEX0lOVEVMLCAweGExNGYpfSwgLyogU3VucmlzZSBQb2ludC1IDQo+IExQ
QyAqLw0KPiArCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4YTE1MCl9LCAvKiBD
TTIzNiBMUEMvZVNQSSAqLw0KPiArCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4
YTE1MSl9LCAvKiBTdW5yaXNlIFBvaW50LUgNCj4gTFBDICovDQo+ICsJe1BDSV9ERVZJQ0UoUENJ
X1ZFTkRPUl9JRF9JTlRFTCwgMHhhMTUyKX0sIC8qIEhNMTc1IExQQy9lU1BJICovDQo+ICsJe1BD
SV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhMTUzKX0sIC8qIFFNMTc1IExQQy9lU1BJ
ICovDQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhMTU0KX0sIC8qIENN
MjM4IExQQy9lU1BJICovDQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhh
MTU1KX0sIC8qIFN1bnJpc2UgUG9pbnQtSA0KPiBMUEMgKi8NCj4gKwl7UENJX0RFVklDRShQQ0lf
VkVORE9SX0lEX0lOVEVMLCAweGExYzEpfSwgLyogQzYyMSBMUEMvZVNQSSAqLw0KPiArCXtQQ0lf
REVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4YTFjMil9LCAvKiBDNjIyIExQQy9lU1BJICov
DQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhMWMzKX0sIC8qIEM2MjQg
TFBDL2VTUEkgKi8NCj4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCAweGExYzQp
fSwgLyogQzYyNSBMUEMvZVNQSSAqLw0KPiArCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5U
RUwsIDB4YTFjNSl9LCAvKiBDNjI2IExQQy9lU1BJICovDQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZF
TkRPUl9JRF9JTlRFTCwgMHhhMWM2KX0sIC8qIEM2MjcgTFBDL2VTUEkgKi8NCj4gKwl7UENJX0RF
VklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCAweGExYzcpfSwgLyogQzYyOCBMUEMvZVNQSSAqLw0K
PiArCXtQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4YTMwNCl9LCAvKiBIMzcwIExQ
Qy9lU1BJICovDQo+ICsJe1BDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgMHhhMzA1KX0s
IC8qIFozOTAgTFBDL2VTUEkgKi8NCj4gKwl7UENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVM
LCAweGEzMDYpfSwgLyogUTM3MCBMUEMvZVNQSSAqLw0KPiArCXtQQ0lfREVWSUNFKFBDSV9WRU5E
T1JfSURfSU5URUwsIDB4YTMwYyl9LCAvKiBRTTM3MCBMUEMvZVNQSSAqLw0KPiArCXtQQ0lfREVW
SUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIDB4YTMyNCl9LCAvKiBDYW5ub24gTGFrZSBQQ0gNCg0K
VGhpcyBjYXB0dXJlcyBhIGxvdCBvZiBvbGQgb25lcywgYnV0IEkgdGhpbmsgeW91J3JlIG1pc3Np
bmcgYSBmZXcgb2YNCnRoZSBvdGhlciBtb3JlIHJlY2VudCBvbmVzIHRoZSBrZXJuZWwga25vd3Mg
YWJvdXQuDQoNClRpZ2VyIExha2U6IGYxM2UxODA0OGJkZmNlYTJjM2UyNWVjNjkxY2I2YjRkOGFi
M2NmMjENCkNhbm9uIExha2U6IDRiOTdiYTczZGNkYzI0ZmQ5NjhjYmViOTcwYWU1NzIxMmUyYzFj
NzMNCkphc3BlciBMYWtlOiAzMDdkZDgwODg1YWY3MTgzNjk2YWI2ZDgxZDczYWZjN2E1MTQ4ZGY2
DQpDb21ldCBMYWtlIEg6IDVhMGZlYjYyODdlMzcwMThhZjRjYmQ3NzU0Nzg2NTIyYWU3MTI5ODAN
CkNvbWV0IExha2UgVjogNzAxYTE2NzZmMzEzZGJhZTU3OGYzMWRhNGUwNmM1NDg3YzhhYTdiYg0K
RWxraGFydCBMYWtlOiBiYTBkNGUwNGE1YjU3ZWYwNDhkYmYzYWZkOTEwN2FlNmNhMzUzMjU4DQoN
ClRvIGVjaG8gQW5keSdzIHF1ZXN0aW9uLCBJIHdvdWxkIHdvbmRlciBpZiBpdCBtYWtlcyBzZW5z
ZSB0byBqdXN0IGV4cG9ydA0KdGhlc2UgYXR0cmlidXRlcyBpbiBzZWN1cml0eWZzIGRpcmVjdGx5
IGZyb20gdGhlIGludGVsLXNwaS1wY2kgZHJpdmVyIHJhdGhlcg0KdGhhbiB0byBoYXZlIGFub3Ro
ZXIgZHJpdmVyIGluIHBsYXRmb3JtLXg4NiB0byBnZXQgdGhlIGluZm9ybWF0aW9uLg0KDQpUaGVu
IGZvciB0aGUgZVNQSSBjYXNlcywgY2FuIGl0IGV4cG9ydCB1c2luZyBpbnRlbC1zcGktcGxhdGZv
cm0gaW5zdGVhZCBvZg0KYSBsYXJnZSB3aGl0ZWxpc3QgaW4gdGhpcyBkcml2ZXI/DQoNCg0KPiBT
UEkgKi8NCj4gKwl7MCwgfQ0KPiArfTsNCj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBwY2lf
dGJsKTsNCj4gKw0KPiArc3RydWN0IGRlbnRyeSAqc3BpX2RpcjsNCj4gK3N0cnVjdCBkZW50cnkg
KnNwaV9iaW9zd2U7DQo+ICtzdHJ1Y3QgZGVudHJ5ICpzcGlfYmxlOw0KPiArc3RydWN0IGRlbnRy
eSAqc3BpX3NtbV9id3A7DQo+ICtzdHJ1Y3QgcGNpX2RldiAqZGV2Ow0KPiArY29uc3QgdTggYmlv
c19jbnRsX29mZiA9IEJJT1NfQ05UTF9SRUc7DQo+ICsNCj4gK3N0YXRpYyBzc2l6ZV90IGJpb3N3
ZV9yZWFkKHN0cnVjdCBmaWxlICpmaWxwLCBjaGFyIF9fdXNlciAqYnVmLA0KPiArCQkJICAgc2l6
ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQo+ICt7DQo+ICsJY2hhciB0bXBbMl07DQo+ICsJdTgg
Ymlvc19jbnRsX3ZhbDsNCj4gKw0KPiArCXBjaV9yZWFkX2NvbmZpZ19ieXRlKGRldiwgYmlvc19j
bnRsX29mZiwgJmJpb3NfY250bF92YWwpOw0KPiArCXNwcmludGYodG1wLCAiJWRcbiIsDQo+ICsJ
CWJpb3NfY250bF92YWwgJiBCSU9TX0NOVExfV1JJVEVfRU5BQkxFX01BU0sgPyAxIDogMCk7DQo+
ICsJcmV0dXJuIHNpbXBsZV9yZWFkX2Zyb21fYnVmZmVyKGJ1ZiwgY291bnQsIHBwb3MsIHRtcCwN
Cj4gc2l6ZW9mKHRtcCkpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVf
b3BlcmF0aW9ucyBzcGlfYmlvc3dlX29wcyA9IHsNCj4gKwkucmVhZCAgPSBiaW9zd2VfcmVhZCwN
Cj4gK307DQo+ICsNCj4gK3N0YXRpYyBzc2l6ZV90IGJsZV9yZWFkKHN0cnVjdCBmaWxlICpmaWxw
LCBjaGFyIF9fdXNlciAqYnVmLA0KPiArCQkJc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQo+
ICt7DQo+ICsJY2hhciB0bXBbMl07DQo+ICsJdTggYmlvc19jbnRsX3ZhbDsNCj4gKw0KPiArCXBj
aV9yZWFkX2NvbmZpZ19ieXRlKGRldiwgYmlvc19jbnRsX29mZiwgJmJpb3NfY250bF92YWwpOw0K
PiArCXNwcmludGYodG1wLCAiJWRcbiIsDQo+ICsJCWJpb3NfY250bF92YWwgJiBCSU9TX0NOVExf
TE9DS19FTkFCTEVfTUFTSyA/IDEgOiAwKTsNCj4gKwlyZXR1cm4gc2ltcGxlX3JlYWRfZnJvbV9i
dWZmZXIoYnVmLCBjb3VudCwgcHBvcywgdG1wLA0KPiBzaXplb2YodG1wKSk7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHNwaV9ibGVfb3BzID0gew0K
PiArCS5yZWFkICA9IGJsZV9yZWFkLA0KPiArfTsNCj4gKw0KPiArc3RhdGljIHNzaXplX3Qgc21t
X2J3cF9yZWFkKHN0cnVjdCBmaWxlICpmaWxwLCBjaGFyIF9fdXNlciAqYnVmLA0KPiArCQkJICAg
IHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQ0KPiArew0KPiArCWNoYXIgdG1wWzJdOw0KPiAr
CXU4IGJpb3NfY250bF92YWw7DQo+ICsNCj4gKwlwY2lfcmVhZF9jb25maWdfYnl0ZShkZXYsIGJp
b3NfY250bF9vZmYsICZiaW9zX2NudGxfdmFsKTsNCj4gKwlzcHJpbnRmKHRtcCwgIiVkXG4iLA0K
PiArCQliaW9zX2NudGxfdmFsICYgQklPU19DTlRMX1dQX0RJU0FCTEVfTUFTSyA/IDEgOiAwKTsN
Cj4gKwlyZXR1cm4gc2ltcGxlX3JlYWRfZnJvbV9idWZmZXIoYnVmLCBjb3VudCwgcHBvcywgdG1w
LA0KPiBzaXplb2YodG1wKSk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZmls
ZV9vcGVyYXRpb25zIHNwaV9zbW1fYndwX29wcyA9IHsNCj4gKwkucmVhZCAgPSBzbW1fYndwX3Jl
YWQsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgaW50IF9faW5pdCBtb2RfaW5pdCh2b2lkKQ0KPiAr
ew0KPiArCWludCBpOw0KPiArDQo+ICsJLyogRmluZCBTUEkgQ29udHJvbGxlciAqLw0KPiArCWZv
ciAoaSA9IDA7ICFkZXYgJiYgcGNpX3RibFtpXS52ZW5kb3I7ICsraSkNCj4gKwkJZGV2ID0gcGNp
X2dldF9kZXZpY2UocGNpX3RibFtpXS52ZW5kb3IsDQo+ICsJCQkJICAgICBwY2lfdGJsW2ldLmRl
dmljZSwgTlVMTCk7DQo+ICsJaWYgKCFkZXYpDQo+ICsJCXJldHVybiAtRU5PREVWOw0KPiArDQo+
ICsJc3BpX2RpciA9IHNlY3VyaXR5ZnNfY3JlYXRlX2Rpcigic3BpIiwgTlVMTCk7DQo+ICsJaWYg
KElTX0VSUihzcGlfZGlyKSkNCj4gKwkJcmV0dXJuIC0xOw0KPiArDQo+ICsJc3BpX2Jpb3N3ZSA9
DQo+ICsJICAgIHNlY3VyaXR5ZnNfY3JlYXRlX2ZpbGUoImJpb3N3ZSIsDQo+ICsJCQkJICAgMDYw
MCwgc3BpX2RpciwgTlVMTCwNCj4gKwkJCQkgICAmc3BpX2Jpb3N3ZV9vcHMpOw0KPiArCWlmIChJ
U19FUlIoc3BpX2Jpb3N3ZSkpDQo+ICsJCWdvdG8gb3V0Ow0KPiArCXNwaV9ibGUgPQ0KPiArCSAg
ICBzZWN1cml0eWZzX2NyZWF0ZV9maWxlKCJibGUiLA0KPiArCQkJCSAgIDA2MDAsIHNwaV9kaXIs
IE5VTEwsDQo+ICsJCQkJICAgJnNwaV9ibGVfb3BzKTsNCj4gKwlpZiAoSVNfRVJSKHNwaV9ibGUp
KQ0KPiArCQlnb3RvIG91dDsNCj4gKwlzcGlfc21tX2J3cCA9DQo+ICsJICAgIHNlY3VyaXR5ZnNf
Y3JlYXRlX2ZpbGUoInNtbV9id3AiLA0KPiArCQkJCSAgIDA2MDAsIHNwaV9kaXIsIE5VTEwsDQo+
ICsJCQkJICAgJnNwaV9zbW1fYndwX29wcyk7DQo+ICsJaWYgKElTX0VSUihzcGlfc21tX2J3cCkp
DQo+ICsJCWdvdG8gb3V0Ow0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICtvdXQ6DQo+ICsJc2VjdXJp
dHlmc19yZW1vdmUoc3BpX2Jpb3N3ZSk7DQo+ICsJc2VjdXJpdHlmc19yZW1vdmUoc3BpX2JsZSk7
DQo+ICsJc2VjdXJpdHlmc19yZW1vdmUoc3BpX3NtbV9id3ApOw0KPiArCXNlY3VyaXR5ZnNfcmVt
b3ZlKHNwaV9kaXIpOw0KPiArCXJldHVybiAtMTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQg
X19leGl0IG1vZF9leGl0KHZvaWQpDQo+ICt7DQo+ICsJc2VjdXJpdHlmc19yZW1vdmUoc3BpX2Jp
b3N3ZSk7DQo+ICsJc2VjdXJpdHlmc19yZW1vdmUoc3BpX2JsZSk7DQo+ICsJc2VjdXJpdHlmc19y
ZW1vdmUoc3BpX3NtbV9id3ApOw0KPiArCXNlY3VyaXR5ZnNfcmVtb3ZlKHNwaV9kaXIpOw0KPiAr
fQ0KPiArDQo+ICttb2R1bGVfaW5pdChtb2RfaW5pdCk7DQo+ICttb2R1bGVfZXhpdChtb2RfZXhp
dCk7DQo+ICsNCj4gK01PRFVMRV9ERVNDUklQVElPTigiU1BJIExQQyBmbGFzaCBwbGF0Zm9ybSBz
ZWN1cml0eSBkcml2ZXIiKTsNCj4gK01PRFVMRV9BVVRIT1IoIlJpY2hhcmQgSHVnaGVzIDxyaWNo
YXJkQGh1Z2hzaWUuY29tPiIpOw0KPiArTU9EVUxFX0xJQ0VOU0UoIkdQTCIpOw0KPiANCg0K
