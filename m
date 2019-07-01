Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379AC101D9
	for <lists+linux-security-module@lfdr.de>; Tue, 30 Apr 2019 23:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfD3VfW (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 30 Apr 2019 17:35:22 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55301 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfD3VfW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 30 Apr 2019 17:35:22 -0400
Received: by mail-it1-f195.google.com with SMTP id w130so7214627itc.5
        for <linux-security-module@vger.kernel.org>; Tue, 30 Apr 2019 14:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwbA6m1IlkHcQAdDn+q8EF7OA9bDmXUDL8pQ3xlxeqo=;
        b=Sq8KNLYMoEQTJQ8Stw6ktrYFYw+zkDUBePOHtQKKTkZvwVtovOluTVKwMnP5OxwkEI
         xRPL4YOMPiqolt7cnNDIoRjpVwHdC9cPNhE5Az/2QlbtpvjxgVHuNqQuQHGGwpUVVukW
         nC5xJQiZfC1wh2gFeunojseYcQqwKNo5P06mvHmBW2ZJ7630qxkTzOArc13ieUXbbmh7
         u5k9icmaMxO9TnXKm5AyU5gnXzs5kmyR4Kumoh2cWT3xkILJnt8pw/wQ2BbT/p/BhhX2
         Y8Wt5n3FwizMxkHPOOXZHoN+O5XlGBIpYOk+347M3eRzLEcaJhRYkVvbP14mTC1og8mp
         0aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwbA6m1IlkHcQAdDn+q8EF7OA9bDmXUDL8pQ3xlxeqo=;
        b=tm3NIZT022gWbvpYPq0/wLtV/ZLmfM8z6tgo7nQYWknA5oXpOYs5lcNFYQ4gvEIdd6
         VSqlhdIEWRKfzuBKUWIjIH/aeJNG0wyBvyS+e/pyfjrBRzzAbI/DCwucQpcFJSeHwgWe
         P9FlOvR3mh+rAnI8G5984cAhnb1nhl5mVAu02TIqCy+7igAddVUqogUt8iRlMr4E4s0s
         KFyVTAiEYSysNk9MvQ435W71MHeolGMml6JA9atp1Gzq4126MbhBxQLBwN5PfVE7gAYo
         3FIj+9WSk7QaXrfA+brv/boGAbCk549+8xYkdTiAunxb+I+g3OxLWOhGybM+gPdZGxDf
         93pQ==
X-Gm-Message-State: APjAAAXgdg9A8R9GDJeWxRYIPOE3Rq8ULuEUE17Sz4D+1/muks8RHqFC
        n5Rs8eYjr0p9VPPncCOo5RcGv/hcaghdPYWYCR2+NQ==
X-Google-Smtp-Source: APXvYqzIenEc1fHVzRGEEU14wPVQmKcjNo/JeR+UzSCvKt1pTOpxhl8Bq8KqDZSLgHNDy7fTG9L+3o5JTKEc6QSn4hM=
X-Received: by 2002:a24:a86:: with SMTP id 128mr5346735itw.118.1556660120632;
 Tue, 30 Apr 2019 14:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com>
 <20190227202658.197113-3-matthewgarrett@google.com> <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
 <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
In-Reply-To: <CACdnJutpBPAX6TOGgs3Ng2v_cC5hAf-3pHThESvjQ9vbvQeVkA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 30 Apr 2019 14:35:09 -0700
Message-ID: <CACdnJuvYAfFboej4e5jQ=iwhb-5Pi7BgSKEWGqJ0q=uarCoOfQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Bartosz Szczepanek <bsz@semihalf.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Content-Type: multipart/mixed; boundary="0000000000008759370587c62d7b"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--0000000000008759370587c62d7b
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 30, 2019 at 12:51 PM Matthew Garrett <mjg59@google.com> wrote:
> Yes, it looks like this is just broken. Can you try with the attached patch?

Actually, please try this one.

--0000000000008759370587c62d7b
Content-Type: text/x-patch; charset="US-ASCII"; name="fix_log.diff"
Content-Disposition: attachment; filename="fix_log.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jv4b8h1f0>
X-Attachment-Id: f_jv4b8h1f0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL3RwbS5jIGIvZHJpdmVycy9maXJtd2Fy
ZS9lZmkvdHBtLmMKaW5kZXggMmNjYWE2NjYxYWFmLi5kYjBmZGFhOWM2NjYgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZmlybXdhcmUvZWZpL3RwbS5jCisrKyBiL2RyaXZlcnMvZmlybXdhcmUvZWZpL3Rw
bS5jCkBAIC0yOCw2ICsyOCw3IEBAIHN0YXRpYyBpbnQgdHBtMl9jYWxjX2V2ZW50X2xvZ19zaXpl
KHZvaWQgKmRhdGEsIGludCBjb3VudCwgdm9pZCAqc2l6ZV9pbmZvKQogCQlpZiAoZXZlbnRfc2l6
ZSA9PSAwKQogCQkJcmV0dXJuIC0xOwogCQlzaXplICs9IGV2ZW50X3NpemU7CisJCWNvdW50LS07
CiAJfQogCiAJcmV0dXJuIHNpemU7CkBAIC00MSw2ICs0Miw3IEBAIGludCBfX2luaXQgZWZpX3Rw
bV9ldmVudGxvZ19pbml0KHZvaWQpCiAJc3RydWN0IGxpbnV4X2VmaV90cG1fZXZlbnRsb2cgKmxv
Z190Ymw7CiAJc3RydWN0IGVmaV90Y2cyX2ZpbmFsX2V2ZW50c190YWJsZSAqZmluYWxfdGJsOwog
CXVuc2lnbmVkIGludCB0Ymxfc2l6ZTsKKwlpbnQgcmV0ID0gMDsKIAogCWlmIChlZmkudHBtX2xv
ZyA9PSBFRklfSU5WQUxJRF9UQUJMRV9BRERSKSB7CiAJCS8qCkBAIC02MCwxMCArNjIsOSBAQCBp
bnQgX19pbml0IGVmaV90cG1fZXZlbnRsb2dfaW5pdCh2b2lkKQogCiAJdGJsX3NpemUgPSBzaXpl
b2YoKmxvZ190YmwpICsgbG9nX3RibC0+c2l6ZTsKIAltZW1ibG9ja19yZXNlcnZlKGVmaS50cG1f
bG9nLCB0Ymxfc2l6ZSk7Ci0JZWFybHlfbWVtdW5tYXAobG9nX3RibCwgc2l6ZW9mKCpsb2dfdGJs
KSk7CiAKIAlpZiAoZWZpLnRwbV9maW5hbF9sb2cgPT0gRUZJX0lOVkFMSURfVEFCTEVfQUREUikK
LQkJcmV0dXJuIDA7CisJCWdvdG8gb3V0OwogCiAJZmluYWxfdGJsID0gZWFybHlfbWVtcmVtYXAo
ZWZpLnRwbV9maW5hbF9sb2csIHNpemVvZigqZmluYWxfdGJsKSk7CiAKQEAgLTcxLDE3ICs3Miwy
MCBAQCBpbnQgX19pbml0IGVmaV90cG1fZXZlbnRsb2dfaW5pdCh2b2lkKQogCQlwcl9lcnIoIkZh
aWxlZCB0byBtYXAgVFBNIEZpbmFsIEV2ZW50IExvZyB0YWJsZSBAIDB4JWx4XG4iLAogCQkgICAg
ICAgZWZpLnRwbV9maW5hbF9sb2cpOwogCQllZmkudHBtX2ZpbmFsX2xvZyA9IEVGSV9JTlZBTElE
X1RBQkxFX0FERFI7Ci0JCXJldHVybiAtRU5PTUVNOworCQlyZXQgPSAtRU5PTUVNOworCQlnb3Rv
IG91dDsKIAl9CiAKIAl0Ymxfc2l6ZSA9IHRwbTJfY2FsY19ldmVudF9sb2dfc2l6ZShmaW5hbF90
YmwtPmV2ZW50cywKIAkJCQkJICAgIGZpbmFsX3RibC0+bnJfZXZlbnRzLAotCQkJCQkgICAgKHZv
aWQgKillZmkudHBtX2xvZyk7CisJCQkJCSAgICBsb2dfdGJsLT5sb2cpOwogCW1lbWJsb2NrX3Jl
c2VydmUoKHVuc2lnbmVkIGxvbmcpZmluYWxfdGJsLAogCQkJIHRibF9zaXplICsgc2l6ZW9mKCpm
aW5hbF90YmwpKTsKIAllYXJseV9tZW11bm1hcChmaW5hbF90YmwsIHNpemVvZigqZmluYWxfdGJs
KSk7CiAJZWZpX3RwbV9maW5hbF9sb2dfc2l6ZSA9IHRibF9zaXplOwogCi0JcmV0dXJuIDA7Citv
dXQ6CisJZWFybHlfbWVtdW5tYXAobG9nX3RibCwgc2l6ZW9mKCpsb2dfdGJsKSk7CisJcmV0dXJu
IHJldDsKIH0KIApkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC90cG1fZXZlbnRsb2cuaCBiL2lu
Y2x1ZGUvbGludXgvdHBtX2V2ZW50bG9nLmgKaW5kZXggZGNjYzk3ZTYxMzVjLi42NjI0MTA3MTBh
YzAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvdHBtX2V2ZW50bG9nLmgKKysrIGIvaW5jbHVk
ZS9saW51eC90cG1fZXZlbnRsb2cuaApAQCAtMTU4LDcgKzE1OCw2IEBAIHN0YXRpYyBpbmxpbmUg
aW50IF9fY2FsY190cG0yX2V2ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2
ZW50LAogewogCXN0cnVjdCB0Y2dfZWZpX3NwZWNpZF9ldmVudF9oZWFkICplZmlzcGVjaWQ7CiAJ
c3RydWN0IHRjZ19ldmVudF9maWVsZCAqZXZlbnRfZmllbGQ7Ci0Jdm9pZCAqbWFwcGluZyA9IE5V
TEw7CiAJaW50IG1hcHBpbmdfc2l6ZTsKIAl2b2lkICptYXJrZXI7CiAJdm9pZCAqbWFya2VyX3N0
YXJ0OwpAQCAtMTc2LDkgKzE3NSw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fY2FsY190cG0yX2V2
ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2ZW50LAogCS8qIE1hcCB0aGUg
ZXZlbnQgaGVhZGVyICovCiAJaWYgKGRvX21hcHBpbmcpIHsKIAkJbWFwcGluZ19zaXplID0gbWFy
a2VyIC0gbWFya2VyX3N0YXJ0OwotCQltYXBwaW5nID0gZWFybHlfbWVtcmVtYXAoKHVuc2lnbmVk
IGxvbmcpbWFya2VyX3N0YXJ0LAorCQlldmVudCA9IGVhcmx5X21lbXJlbWFwKCh1bnNpZ25lZCBs
b25nKW1hcmtlcl9zdGFydCwKIAkJCQkJIG1hcHBpbmdfc2l6ZSk7Ci0JCWlmICghbWFwcGluZykg
eworCQlpZiAoIWV2ZW50KSB7CiAJCQlzaXplID0gMDsKIAkJCWdvdG8gb3V0OwogCQl9CkBAIC0x
OTksOSArMTk4LDkgQEAgc3RhdGljIGlubGluZSBpbnQgX19jYWxjX3RwbTJfZXZlbnRfc2l6ZShz
dHJ1Y3QgdGNnX3Bjcl9ldmVudDJfaGVhZCAqZXZlbnQsCiAJCWlmIChkb19tYXBwaW5nKSB7CiAJ
CQllYXJseV9tZW11bm1hcChtYXBwaW5nLCBtYXBwaW5nX3NpemUpOwogCQkJbWFwcGluZ19zaXpl
ID0gbWFya2VyIC0gbWFya2VyX3N0YXJ0ICsgaGFsZ19zaXplOwotCQkJbWFwcGluZyA9IGVhcmx5
X21lbXJlbWFwKCh1bnNpZ25lZCBsb25nKW1hcmtlcl9zdGFydCwKKwkJCWV2ZW50ID0gZWFybHlf
bWVtcmVtYXAoKHVuc2lnbmVkIGxvbmcpbWFya2VyX3N0YXJ0LAogCQkJCQkJIG1hcHBpbmdfc2l6
ZSk7Ci0JCQlpZiAoIW1hcHBpbmcpIHsKKwkJCWlmICghZXZlbnQpIHsKIAkJCQlzaXplID0gMDsK
IAkJCQlnb3RvIG91dDsKIAkJCX0KQEAgLTIxOSw5ICsyMTgsOSBAQCBzdGF0aWMgaW5saW5lIGlu
dCBfX2NhbGNfdHBtMl9ldmVudF9zaXplKHN0cnVjdCB0Y2dfcGNyX2V2ZW50Ml9oZWFkICpldmVu
dCwKIAkJCQlpZiAoZG9fbWFwcGluZykgewogCQkJCQllYXJseV9tZW11bm1hcChtYXBwaW5nLCBt
YXBwaW5nX3NpemUpOwogCQkJCQltYXBwaW5nX3NpemUgPSBtYXJrZXIgLSBtYXJrZXJfc3RhcnQ7
Ci0JCQkJCW1hcHBpbmcgPSBlYXJseV9tZW1yZW1hcCgodW5zaWduZWQgbG9uZyltYXJrZXJfc3Rh
cnQsCisJCQkJCWV2ZW50ID0gZWFybHlfbWVtcmVtYXAoKHVuc2lnbmVkIGxvbmcpbWFya2VyX3N0
YXJ0LAogCQkJCQkJICAgICAgbWFwcGluZ19zaXplKTsKLQkJCQkJaWYgKCFtYXBwaW5nKSB7CisJ
CQkJCWlmICghZXZlbnQpIHsKIAkJCQkJCXNpemUgPSAwOwogCQkJCQkJZ290byBvdXQ7CiAJCQkJ
CX0KQEAgLTI0MywxMSArMjQyLDExIEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fY2FsY190cG0yX2V2
ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2ZW50LAogCSAqIHdlIGRvbid0
IG5lZWQgdG8gbWFwIGl0CiAJICovCiAJaWYgKGRvX21hcHBpbmcpIHsKLQkJZWFybHlfbWVtdW5t
YXAobWFya2VyX3N0YXJ0LCBtYXBwaW5nX3NpemUpOworCQllYXJseV9tZW11bm1hcChtYXBwaW5n
LCBtYXBwaW5nX3NpemUpOwogCQltYXBwaW5nX3NpemUgKz0gc2l6ZW9mKGV2ZW50X2ZpZWxkLT5l
dmVudF9zaXplKTsKLQkJbWFwcGluZyA9IGVhcmx5X21lbXJlbWFwKCh1bnNpZ25lZCBsb25nKW1h
cmtlcl9zdGFydCwKLQkJCQkJIG1hcHBpbmdfc2l6ZSk7Ci0JCWlmICghbWFwcGluZykgeworCQll
dmVudCA9IGVhcmx5X21lbXJlbWFwKCh1bnNpZ25lZCBsb25nKW1hcmtlcl9zdGFydCwKKwkJCQkg
ICAgICAgbWFwcGluZ19zaXplKTsKKwkJaWYgKCFldmVudCkgewogCQkJc2l6ZSA9IDA7CiAJCQln
b3RvIG91dDsKIAkJfQpAQCAtMjU3LDggKzI1Niw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fY2Fs
Y190cG0yX2V2ZW50X3NpemUoc3RydWN0IHRjZ19wY3JfZXZlbnQyX2hlYWQgKmV2ZW50LAogCQkr
IGV2ZW50X2ZpZWxkLT5ldmVudF9zaXplOwogCXNpemUgPSBtYXJrZXIgLSBtYXJrZXJfc3RhcnQ7
CiAKLQlpZiAoKGV2ZW50LT5ldmVudF90eXBlID09IDApICYmIChldmVudF9maWVsZC0+ZXZlbnRf
c2l6ZSA9PSAwKSkKLQkJc2l6ZSA9IDA7CiBvdXQ6CiAJaWYgKGRvX21hcHBpbmcpCiAJCWVhcmx5
X21lbXVubWFwKG1hcHBpbmcsIG1hcHBpbmdfc2l6ZSk7Cg==
--0000000000008759370587c62d7b--
