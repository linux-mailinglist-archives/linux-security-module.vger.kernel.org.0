Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F5B1A9C44
	for <lists+linux-security-module@lfdr.de>; Wed, 15 Apr 2020 13:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896989AbgDOL2s (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 15 Apr 2020 07:28:48 -0400
Received: from mout.web.de ([212.227.17.11]:43313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896984AbgDOL2k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 15 Apr 2020 07:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586950082;
        bh=7xKTR06OVFKwW78tneySnyQHTGaymdDqDTgeiiTyqQo=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=eLm8/RFyvR1NubQRr+sMCUwM+8kvHdaMYdNSCWqmX2zrECID5vfsaCQH47PUrQ3Cn
         JLRi5UtYHw0nfGfuktTN/e9LjG5dJ4Djc6EUWRV7EWDEMSJ9/GUW/Lj8g7hf6K6ejo
         m67R/D+O7cqL1aXsBJUIRh3/Bz3NAlZ58lkCtTcU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.133.192]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LwHxK-1jBn8m12nW-017zEy; Wed, 15
 Apr 2020 13:28:02 +0200
Cc:     linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Kangjie Lu <kjlu@umn.edu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Yuan Zhang <yuanxzhang@fudan.edu.cn>
Subject: Re: [PATCH v2] apparmor: fix potential label refcnt leak in
 aa_change_profile
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        linux-security-module@vger.kernel.org
Message-ID: <e9f36822-2483-9512-732b-b158ed104bf2@web.de>
Date:   Wed, 15 Apr 2020 13:27:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HlGwp1Jlncc7qkjY+MrWR+P5GDDuC7x5uCE5yBkbusZZzlyIjC0
 Cc86YJeWdFuGw9in63yttMPupDNKhZO1GyRU7qSmFFJ+X/iCuMPEBZXttlqT5ifZwZtA7Ny
 BQe78HV1+MYMtKxxq+/4t5GV6lReOqLc2RFpsYPA+lGG45Tmp08fUbrivbHcMvUK+Y8BiQM
 bAYO/EHr2ta/1MVBAHKFw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DI42qCKGF9c=:JQHn+FHNyZ8AelsbHweBhM
 eUYVQZxMIUUsYzxsk0n6Kor32rwb75PHhsn4GA7b6mSzTv1FK7JeOvap2rjYOvQkW9jle2ac6
 MGx7G24DFJTdNAo6bUF7J8ZWdGnBuYxlj8S+mmXOn7I2NJTZNS4q/78JyOIR4HW4mUsm+DwZx
 /XHWaRlT6tHleRymOAJSMWelG5ym+8ssIOGNcSsbmYZjfoRyHJp310Rf04OI2g4NUV8VEIEkt
 f3AyApLP/WNS6rf43mQHQ+JAZzVi6upplxqWzTLkTCs/wx7axud3lgm1NvEgA+cfhbnm1RSuo
 LKqBAiAVDsFjz4zsYAZg5t1O20yCPGObA5Iit01cK/2HLcSVSciYVT0CrfeFzg3kIZRSQAVzG
 5FhFCZK8oOUAJwoPnl/NdDk1UZ0DPk+FMR3sVwbddQVVrgOpJSRg8NKTRmK8+ZhynFCksOVpX
 2GvReOUHn33yzqe64xVhJXZ30JIbC7ddh/p1QU7I/UdcCKQHJxKvf/4iiPZj0p/bAgWtuj09g
 q+DhvbuZnY+UDArF9pZDpQi2VycnZadPgtacHGUSHo/4jMc1C4f6H+IEibR67w02rqap4vxw6
 PTlWH+CvAZjFAw1Yo8s1tiq7ZfcWeuoMLZ+ASOBVOFYu5IChxQqsONKf/ytg1EX2FqGGbhtVa
 /GhNpZF14EeyBoXiJsHk/UApMP7yEn5163rR9Vh5ZcFJCYRohES2JlWvmjs8VTPUTfr5aTY8t
 CSOqcxw7soycO7mmikQGDrCa5QcA/1y4haPFBhaBIzIyHwuVJF7aWTYyQgZsP1VNx6yFKhdzl
 opAYO9hqgxhRo1J15h3yVOnfTeW3BWNuea06/YjH4sblWr3bgfJxaWYrLl6+3qCcH1jy7i9xK
 qVOdGzXP+e8e77Pkq6pV1Wt57Q2+7pH/Wwos5SwCDvQQKjjc4iM2P8HdfBdKtINN/NOzNCdCA
 BPDj2WtP4CXxC2ykyIZq8yskAEg8bVS4II6WcagSbPtUx2J/g4Zbykeuf3bXfuyVp1g3OL8BG
 wtDimmfkthk55OmN9bmA+eAPagE5iPk8vDa1MBW5FxEHXw886sgs/YW2fiHhPAZYXhrx6QhIH
 LkuIxgxriBVJF6mO8RG9+Wp24/WBvzpWX2mE7K1iGCZyyxFvpeZMkFqMqcOWYnsFk6gyKW2gf
 Frqlu7sYjfQ5S+wqooIF9y+TO2chRXyn0hbV3JQ2zn65dWZ5Uv31YchG3oaHWaoJ2hir+8m9I
 3W2jmNPY7ekfIgirZ
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> According to the comment of aa_get_current_label(), =E2=80=A6

I suggest to make this wording clearer.
Would you like to refer to any software documentation here?


> However, when the original object pointed by "label" becomes
> unreachable because aa_change_profile() returns or a new object
> is assigned to "label", reference count increased by
> aa_get_current_label() is not decreased, causing a refcnt leak.

How do you think about to reduce abbreviations in the commit message?

Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the change descri=
ption?

Regards,
Markus
