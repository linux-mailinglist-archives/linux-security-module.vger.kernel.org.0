Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2583E4352A7
	for <lists+linux-security-module@lfdr.de>; Wed, 20 Oct 2021 20:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhJTS1z (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 20 Oct 2021 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhJTS1w (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 20 Oct 2021 14:27:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01712C061749
        for <linux-security-module@vger.kernel.org>; Wed, 20 Oct 2021 11:25:38 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id o133so3670715pfg.7
        for <linux-security-module@vger.kernel.org>; Wed, 20 Oct 2021 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xV+lLzyHVxIjvZzd/hg4IldWQ3x8L8qi3sbsTagkSSs=;
        b=Fps+FWweiAhdayAWJ3/8vERgnVSDMt8sI1DOq5LEaDp5fLqtRt2z6x79JeWOpKn5kr
         Q3SbbBNL6dIyD/T4PnxWFd/aiFgxk9fy9r6yLE+sGMKh2SV4MdW4TdmEra/n7w7vMnfM
         6VX26yqezXP9JNOPRVkyjgBMoRvS3ELkvYaULNf+oDM3vfJuElwnYpx8RMdFwswYb9Ns
         gW1kF73fTyUdGBZCiLTj+I+484nauWYn4iWZvzDCqI1H9eGVWivK4FO280CTZ8HnNEaD
         PxRUCN6ko0mCf0Fi/LCLORQq13jcrQOZRdVAP3l5EvuCU7ebV6TsKrZZb/tzI/EMdGhp
         WzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xV+lLzyHVxIjvZzd/hg4IldWQ3x8L8qi3sbsTagkSSs=;
        b=raZGzzfjVJ4jRc5FJkRv45HtkdOyDvqFTaeU4SG2uvdm6v6xdpGIaIsRkeRPXjja0V
         7+yjnQq7A9AiuqwhDNvk0N8KS1ctlkn11XujFWDRGS6zfJsudJ2caPToOXupusWV4ZV3
         XPMJXhmzijOOls/TBcKOCBWMcbne6MI0xr3WxZ0N0trtaA7mQ3lokYguxnIlMFshKncx
         Gw1WbCBUeRF6As9ClfNAdaPqhKPp7j7d4d/ax5y9JKhAm1brJQauZ7o5KWB+1634a7bH
         tCrW4T4i8Rr6l0ekyayXqj1TdziVXU2C2fwU82P94dnnLsWwLm+kGMorgwpVWHrEJymQ
         EQPw==
X-Gm-Message-State: AOAM531jrswvWYBdUV3omgkXuQ0JHrCiEuV/rLrQCgP6AmYtE5k7IQEx
        TBfgJyl1VCgWkio7mPTa8VBl+qcl09DIDNKCQ58=
X-Google-Smtp-Source: ABdhPJzLPQtyN9DN87V1VpXVZ/E5cTU3r4N4KeZ1PU3orBFqOkM/VPCscDLPW+daHbKsRc09bOGsBMeQq1RlkUPIMps=
X-Received: by 2002:a62:5209:0:b0:44c:68a7:3a61 with SMTP id
 g9-20020a625209000000b0044c68a73a61mr356397pfb.83.1634754337350; Wed, 20 Oct
 2021 11:25:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:bb0b:0:0:0:0 with HTTP; Wed, 20 Oct 2021 11:25:36
 -0700 (PDT)
Reply-To: uchennailobi@gmail.com
From:   uchenna <ohehehe3055@gmail.com>
Date:   Wed, 20 Oct 2021 11:25:36 -0700
Message-ID: <CADYWKHyyibRhSwvtcdKTHwqZ3r4=aKyiBOrs=C9WmkG7gGD6cQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQoNCtCa0LDQuiDQv9C+0LbQuNCy0LDQtdGI0Yw/INCv
INC00YPQvNCw0Y4sINGH0YLQviDQstGLINCyINC/0L7RgNGP0LTQutC1INC4INC30LTQvtGA0L7Q
stGLLiDQrdGC0L4g0YHQvtC+0LHRidC40YLRjA0K0YfRgtC+INGPINGD0YHQv9C10YjQvdC+INC3
0LDQutC70Y7Rh9C40Lsg0YHQtNC10LvQutGDLiDQrdGC0L4g0LHRi9C70L4g0LTQsNCy0L3Qvg0K
0LLRgNC10LzRjyDRgSDQvNC+0LzQtdC90YLQsCDQvdCw0YjQtdCz0L4g0L/QvtGB0LvQtdC00L3Q
tdCz0L4g0L7QsdGJ0LXQvdC40Y8uINCaINGB0L7QttCw0LvQtdC90LjRjiwg0LLQsNGI0LUg0L/Q
sNGA0YLQvdC10YDRgdGC0LLQvg0K0YHQviDQvNC90L7QuSDQvdC1INGD0LTQsNC70L7RgdGMINC3
0LDQstC10YDRiNC40YLRjCDQv9C10YDQtdCy0L7QtCDRgdGA0LXQtNGB0YLQsi4g0K8g0LTRg9C8
0LDRjiwg0L3QsNGB0YLQsNC70L4g0LLRgNC10LzRjw0K0LrQvtCz0LTQsCDQsdGL0LvQviDRgtCw
0Log0LzQvdC+0LPQviDQtNCw0LLQu9C10L3QuNGPINC4INC30LDQvNC10YjQsNGC0LXQu9GM0YHR
gtCy0LAsINGH0YLQviDQstGLINGB0YLQsNC70Lgg0LzQtdC90YzRiNC1DQrQt9Cw0LjQvdGC0LXR
gNC10YHQvtCy0LDQvSDQsiDRgdC00LXQu9C60LUuDQoNCg0K0JIg0LvRjtCx0L7QvCDRgdC70YPR
h9Cw0LUg0Y8g0YDQsNC0INGB0L7QvtCx0YnQuNGC0Ywg0LLQsNC8INC+INC80L7QtdC8INGD0YHQ
v9C10YXQtSDQsiDQv9C+0LvRg9GH0LXQvdC40Lgg0YTQvtC90LTQsA0K0L/QtdGA0LXQtNCw0L3R
iyDQv9GA0Lgg0YHQvtGC0YDRg9C00L3QuNGH0LXRgdGC0LLQtSDQvdC+0LLQvtCz0L4g0L/QsNGA
0YLQvdC10YDQsC4g0K8g0YHQtdC50YfQsNGBINCyDQrQktC10L3QtdGB0YPRjdC70LAg0L7QsSDQ
uNC90LLQtdGB0YLQuNGG0LjRj9GFLiDQntC00L3QsNC60L47INGPINC90LUg0LfQsNCx0YvQuyDR
gtCy0L7QuCDQv9GA0L7RiNC70YvQtSDRg9GB0LjQu9C40Y8g0LgNCtC/0YvRgtCw0LXRgtGB0Y8g
0L/QvtC80L7Rh9GMINC80L3QtSDQsiDQv9C10YDQtdCy0L7QtNC1INGB0YDQtdC00YHRgtCyLCDQ
vdC10YHQvNC+0YLRgNGPINC90LAg0YLQviwg0YfRgtC+INC80YsNCtC90LUg0YHQvNC+0LMg0L/R
gNC40LnRgtC4INC6INC60L7QvdC60YDQtdGC0L3QvtC80YMg0LLRi9Cy0L7QtNGDLg0KDQrQkiDQ
t9C90LDQuiDQv9GA0LjQt9C90LDRgtC10LvRjNC90L7RgdGC0Lgg0LfQsCDQstCw0YjRgyDQv9C+
0L/Ri9GC0LrRgyDQv9C+0LzQvtGH0YwsINGPINC4INC80L7QuSDQvdC+0LLRi9C5INC/0LDRgNGC
0L3QtdGAINC00L7RgdGC0LjQs9C70LgNCtGA0LXRiNC10L3QuNC1INC+INGC0L7QvCwg0YfRgtC+
INCy0Ysg0LfQsNGB0LvRg9C20LjQstCw0LXRgtC1INC60L7QvNC/0LXQvdGB0LDRhtC40LgsINC/
0L7RjdGC0L7QvNGDINGN0YLQviDQv9C40YHRjNC80L4NCtGB0L7QvtCx0YnQsNGOINCy0LDQvCwg
0YfRgtC+INGPINC+0YHRgtCw0LLQuNC7INC60L7QvNC/0LXQvdGB0LDRhtC40Y4g0LIg0YDQsNC3
0LzQtdGA0LUgMzUwIDAwMCDQtNC+0LvQu9Cw0YDQvtCyINCh0KjQkA0K0L3QsCDQstCw0YjQtSDQ
uNC80Y8sINGH0YLQvtCx0YsNCtCS0Ysg0L/QvtC00LXQu9C40YLQtdGB0Ywg0YHQviDQvNC90L7Q
uSDRgNCw0LTQvtGB0YLRjNGOLiDQodC+0LLQtdGC0YPRjiDQvtCx0YDQsNGC0LjRgtGM0YHRjyDQ
siDQsdCw0L3QuiBCVENJINC00LvRjyDQv9C+0LvRg9GH0LXQvdC40Y8NCtC/0LXRgNC10LLQvtC0
ICQgMzUwLDAwMC4wMC4g0KfRgtC+0LHRiyDQuNC30LHQtdC20LDRgtGMINC00L7Qu9Cz0L7QuSDQ
t9Cw0LTQtdGA0LbQutC4INCy0YvQv9C70LDRgtGLDQrQutC+0LzQv9C10L3RgdCw0YbQuNC+0L3Q
vdC+0LPQviDRhNC+0L3QtNCwDQrQv9C10YDQtdCy0L7QtCwg0Y8g0L/QvtGA0YPRh9C40Lsg0LHQ
sNC90LrRgyBCVENJINCy0YvQv9GD0YHRgtC40YLRjCDQvNC10LbQtNGD0L3QsNGA0L7QtNC90YPR
jiDQsdCw0L3QutC+0LzQsNGC0L3Rg9GOINC60LDRgNGC0YMgdmlzYQ0K0Lgg0L7RgtC/0YDQsNCy
0YzRgtC1INC10LPQviDQvdCwINC00L7QvNCw0YjQvdC40Lkg0LDQtNGA0LXRgSDQutGD0YDRjNC1
0YDRgdC60L7QuSDRgdC70YPQttCx0L7QuS4NCg0K0JrQvtC90YLQsNC60YLQvdCw0Y8g0LjQvdGE
0L7RgNC80LDRhtC40Y8g0LHQsNC90LrQsCDRg9C60LDQt9Cw0L3QsCDQvdC40LbQtToNCg0K0J3Q
sNC30LLQsNC90LjQtSDQsdCw0L3QutCwOiBCVENJIEJhbmsNCtCt0LvQtdC60YLRgNC+0L3QvdGL
0Lkg0LDQtNGA0LXRgTogYnRjYmFua3RnNDc4QGdtYWlsLmNvbQ0K0JDQtNGA0LXRgTogMTY5LCBC
b3VsZXZhcmQgZHUgMTMgamFudmllciBCUCAzNjMgTG9tw6ksINCi0L7Qs9C+Lg0K0JrQvtC90YLQ
sNC60YLQvdC+0LUg0LvQuNGG0L46INCzLdC9INCb0LXQvtC90LDRgNC0INCc0LDRgtC40LDRgQ0K
DQrQodC+0L7QsdGJ0LjRgtC1INC80L3QtSwg0LrQsNC6INGC0L7Qu9GM0LrQviDQv9C+0LvRg9GH
0LjRgtC1INC60LDRgNGC0YMgVmlzYSDQtNC70Y8g0LHQsNC90LrQvtC80LDRgtC+0LIg0L7RgiDQ
sdCw0L3QutCwDQpCVENJLiDRhdC+0YLQtdC7INCx0Ysg0Y8NCtCS0LDQvCDRg9GB0L/QtdGF0L7Q
siDQstC+INCy0YHQtdGFINC90LDRh9C40L3QsNC90LjRj9GFLg0KDQrQoSDRg9Cy0LDQttC10L3Q
uNC10LwNCtCR0LDRgNGA0LjRgdGC0LXRgCDRg9GH0LXQvdC90LAg0LjQu9C+0LHQuA0K
