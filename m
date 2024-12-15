Return-Path: <linux-security-module+bounces-7058-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A29F0619
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Dec 2024 09:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0A1281A15
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Dec 2024 08:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4B19EED0;
	Fri, 13 Dec 2024 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="btngp3V2"
X-Original-To: linux-security-module@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D8B19E98B
	for <linux-security-module@vger.kernel.org>; Fri, 13 Dec 2024 08:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734077522; cv=none; b=SP2sJEzApn0qrYblZ4p+Z8Hta3AeCm+hV3kz1TIjMBy/nA7JD0aigvENywM7BESDZl6NF3EF5rGFkNJ17mCW8a/qT6/5rOe8uS14yEp+nENVuqr30FiIlbrx4nrq3S4BgspyNusuvbgFYvrzceY9+QtG7TwuBMSCd0kJZhb+Pp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734077522; c=relaxed/simple;
	bh=0dnLDpY0UScEuW9SwzS101MDI9EqmarsBXoJW4J/arE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=mdhmquFGF5Cm7DD2A38/5VcPpZardybWMNl4UwszX33YvpoJWSgXt/kaYFWn3QIkLKvcvSQxkUOf8YAlmbr66qyTCNJb0JLt8Cg+ir/dwsG25/bt7A10gcfp9STrBVQ8kXMFzW9IqkbDN4FJV/7jvNZ8t6W2JuxmU4y9QdZJPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=btngp3V2 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=SYoM4I7FWnWZhiYPk5UGfY+6aeBXSDi1Pkrl+UtCTig=; b=b
	tngp3V2nRPid5QwNUN6pzTpsCBEtlzIkJHXxhHAdtEToH9Zu4MPw/ZzD2T6u912e
	gQjQjD1I2kB4cj5+XwvMQyzyWnZOstdQDu2bTcEL3sRu04yKVbDccMc0vTiKxDvR
	vN2LVt7bzltTeUHuVR2CR2PHUxz/Hgt6ttuR8DodBU=
Received: from 15074444048$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr-40-121 (Coremail) ; Fri, 13 Dec 2024 16:11:31 +0800
 (CST)
Date: Fri, 13 Dec 2024 16:11:31 +0800 (CST)
From: =?UTF-8?B?5p2O6LGq5p2w?= <15074444048@163.com>
To: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-security-module@vger.kernel.org
Cc: lihaojie <lihaojie@kylinos.cn>
Subject: Re:[PATCH] lsm: add reserved flag in lsm_prop struct
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20241206114108.342819-1-15074444048@163.com>
References: <aef181673159ac72f1e7922548186fc6@paul-moore.com>
 <20241206114108.342819-1-15074444048@163.com>
X-NTES-SC: AL_Qu2YBvycuEwi5yGQY+kfmkgajuw7XcK5v/Un3IBXOZFwjArpyz8ER25SElbPyM60NQKpmgmGbyBy1vp3UaRFZb8NPcDKxUzMvzZJhC+tQCQyMw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <d382c0e.8393.193bf12a7f7.Coremail.15074444048@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eSgvCgD3H_s07Ftnd+Q+AA--.14945W
X-CM-SenderInfo: rprvilauuukiiuy6il2tof0z/1tbiIAq0UGdb540vaAACsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBwYXVsLAoKCml0J3MgdGhlIGNvbXBpbGUgZXJyb3IgdGhhdCBpIG1ldC4KSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIC4vaW5jbHVkZS9saW51eC9zdHJpbmcuaDozODksCiAgICAgICAgICAgICAg
ICAgZnJvbSAuL2luY2x1ZGUvbGludXgvYml0bWFwLmg6MTMsCiAgICAgICAgICAgICAgICAgZnJv
bSAuL2luY2x1ZGUvbGludXgvY3B1bWFzay5oOjEyLAogICAgICAgICAgICAgICAgIGZyb20gLi9p
bmNsdWRlL2xpbnV4L3NtcC5oOjEzLAogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xp
bnV4L2xvY2tkZXAuaDoxNCwKICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9z
cGlubG9jay5oOjYzLAogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3dhaXQu
aDo5LAogICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3dhaXRfYml0Lmg6OCwK
ICAgICAgICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9mcy5oOjYsCiAgICAgICAgICAg
ICAgICAgZnJvbSBrZXJuZWwvYXVkaXRzYy5jOjM3OgpJbiBmdW5jdGlvbiDigJhzaXplZF9zdHJz
Y3B54oCZLAogICAgaW5saW5lZCBmcm9tIOKAmF9fYXVkaXRfcHRyYWNl4oCZIGF0IGtlcm5lbC9h
dWRpdHNjLmM6MjczMjoyOgouL2luY2x1ZGUvbGludXgvZm9ydGlmeS1zdHJpbmcuaDoyOTM6Mzog
ZXJyb3I6IGNhbGwgdG8g4oCYX193cml0ZV9vdmVyZmxvd+KAmSBkZWNsYXJlZCB3aXRoIGF0dHJp
YnV0ZSBlcnJvcjogZGV0ZWN0ZWQgd3JpdGUgYmV5b25kIHNpemUgb2Ygb2JqZWN0ICgxc3QgcGFy
YW1ldGVyKQogIDI5MyB8ICAgX193cml0ZV9vdmVyZmxvdygpOwogICAgICB8ICAgXn5+fn5+fn5+
fn5+fn5+fn5+CkluIGZ1bmN0aW9uIOKAmHNpemVkX3N0cnNjcHnigJksCiAgICBpbmxpbmVkIGZy
b20g4oCYYXVkaXRfc2lnbmFsX2luZm9fc3lzY2FsbOKAmSBhdCBrZXJuZWwvYXVkaXRzYy5jOjI3
NTk6MzoKLi9pbmNsdWRlL2xpbnV4L2ZvcnRpZnktc3RyaW5nLmg6MjkzOjM6IGVycm9yOiBjYWxs
IHRvIOKAmF9fd3JpdGVfb3ZlcmZsb3figJkgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJyb3I6
IGRldGVjdGVkIHdyaXRlIGJleW9uZCBzaXplIG9mIG9iamVjdCAoMXN0IHBhcmFtZXRlcikKICAy
OTMgfCAgIF9fd3JpdGVfb3ZlcmZsb3coKTsKCmkgc2VlIGNvbW1pdCBkOTM4MTUwOGVhMmI1OTBh
ZmY0NmQyOGQ0MzJkMjBiZmVmMWJhNjRjIG1lcmdlZCwKYnV0IGl0J3MgYSB3b3JrYXJvdW5kLCBz
byBob3cgYWJvdXQgbXnCoHRob3VnaHRzIGJlbG93PwoKbG9vayBmb3J3YXJkIHRvIHlvdXIgcmVw
bHkKCgpBdCAyMDI0LTEyLTA2IDE5OjQxOjA4LCAxNTA3NDQ0NDA0OEAxNjMuY29tIHdyb3RlOgo+
RnJvbTogbGloYW9qaWUgPGxpaGFvamllQGt5bGlub3MuY24+Cj4KPmxzbV9wcm9wIHNpemUgaXMg
Y29udHJvbGVkIGJ5IG1hY3JvLCBsc21fcHJvcCBzaXplIHdpbGwgYmUgMAo+d2hlbiBtYXJjbyBk
b24ndCBkZWZpbmUuIGFkZCBmbGFnIHRvIGFsbG9jIHNtX3Byb3AgYmFzaWMgc2l6ZS4KPgo+ZW1w
dHkgc3RydWN0IHdpbGwgbWFrZSB0YXJnZXRfcmVmICYgdGFyZ2V0X2NvbW0gaW4gYXVkaXRfY29u
dGV4dAo+bG9jYXRlZCBhdCB0aGUgc2FtZSBhZGRyZXNzLCBfX21lbWJlcl9zaXplIG9mIHRhcmdl
dF9jb21tIGlzCj5zYW1lIGFzIF9fbWVtYmVyX3NpemUgb2YgdGFyZ2V0X3JlZiwgc28gc3Ryc2Nw
eSB3YXJuIGJ1ZmZlcgo+b3ZlcmZsb3cgd2hlbiBjb21waWxlIHRpbWUuCj4KPlNpZ25lZC1vZmYt
Ynk6IGxpaGFvamllIDxsaWhhb2ppZUBreWxpbm9zLmNuPgo+LS0tCj4gaW5jbHVkZS9saW51eC9z
ZWN1cml0eS5oIHwgMSArCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3NlY3VyaXR5LmggYi9pbmNsdWRlL2xpbnV4L3NlY3VyaXR5
LmgKPmluZGV4IGNiZGJhNDM1Yjc5OC4uZjUwMmRlZWNiMTQyIDEwMDY0NAo+LS0tIGEvaW5jbHVk
ZS9saW51eC9zZWN1cml0eS5oCj4rKysgYi9pbmNsdWRlL2xpbnV4L3NlY3VyaXR5LmgKPkBAIC0x
NjQsNiArMTY0LDcgQEAgc3RydWN0IGxzbV9wcm9wIHsKPiAJc3RydWN0IGxzbV9wcm9wX3NtYWNr
IHNtYWNrOwo+IAlzdHJ1Y3QgbHNtX3Byb3BfYXBwYXJtb3IgYXBwYXJtb3I7Cj4gCXN0cnVjdCBs
c21fcHJvcF9icGYgYnBmOwo+Kwl1OCByZXNlcnZlZDsKPiB9Owo+IAo+IGV4dGVybiBjb25zdCBj
aGFyICpjb25zdCBsb2NrZG93bl9yZWFzb25zW0xPQ0tET1dOX0NPTkZJREVOVElBTElUWV9NQVgr
MV07Cj4tLSAKPjIuMjUuMQo+Cj5IaSBwYXVsCj4KPgo+VGhlIHJvb3QgY2F1c2UgaXMgdGhhdCB0
YXJnZXRfcmVmIGlzIGVtcHR5LCB0aGF0IG1ha2UgX19tZW1iZXJfc2l6ZSBvZiB0YXJnZXRfY29t
bSB3aWxsIAo+cmV0dXJuIHRhcmdldF9yZWYgc2l6ZSwgYmVjYXVzZSB0aGV5IGhhdmUgc2FtZSBh
ZGRyZXNzLCBzbywgb3ZlcmZsb3cgd2lsbCBiZSBkZXRlY3RlZC4KPmFzIHlvdSBzYWlkLCBJIHNo
b3VsZCBub3QgY2hhbmdlIG1lbWJlciBzaXplLCB0aGVyZSBtYXkgYmUgb3RoZXIgcG90ZW50aWFs
IGhhemFyZHMuCj4KPnNvIGkgYWRkIHBhdGNoIHYzLCBwbGVhc2UgY2hlY2sgYWJvdmUuIAo+Cj5J
IGhhdmUgYmVlbiB0ZXN0IGxvY2FsLgo+LWdjYyB3aWxsIGFsbG9jIGVtcHR5IHN0cnVjdCAwIGJ5
dGUuIF9fbWVtYmVyX3NpemUgb2YgbWVtYmVyIGJlaGluZCBlbXB0eSBzdHJ1Y3Qgd2lsbCByZXR1
cm4gMCBieXRlOwo+Cj4tZysrIHdpbGwgYWxsb2MgZW1wdHkgc3RydWN0IDEgYnl0ZS4gX19tZW1i
ZXJfc2l6ZSBvZiBtZW1iZXIgYmVoaW5kIGVtcHR5IHN0cnVjdCB3aWxsIHJldHVybiBub3JtYWwg
Ynl0ZXM7IAo+Cj4tcGFob2xlIHJlc3VsdAo+ICAgICAgICBzdHJ1Y3QgbHNtX3Byb3AgICAgICAg
ICAgICB0YXJnZXRfcmVmOyAgICAgICAgICAgLyogICA4MTIgICAgIDEgKi8KPiAgICAgICAgY2hh
ciAgICAgICAgICAgICAgICAgICAgICAgdGFyZ2V0X2NvbW1bMTZdOyAgICAgIC8qICAgODEzICAg
IDE2ICovCj4KPgo+dGhhbmtzCj5saWhhb2ppZQo=

