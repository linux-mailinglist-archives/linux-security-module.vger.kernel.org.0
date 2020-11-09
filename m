Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB922AC3C2
	for <lists+linux-security-module@lfdr.de>; Mon,  9 Nov 2020 19:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKISYg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 9 Nov 2020 13:24:36 -0500
Received: from mout.gmx.net ([212.227.17.21]:41837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgKISYg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 9 Nov 2020 13:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604946242;
        bh=WqIeflJSIlbYefgQQeWSGrItmuRntyT1T0hegn+ItPU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=XCdtV1blAQXrTCOSFtrBcv8Mh9UbKawLpFL3nZHFRYfna4OsIJ9yF6C6pAvhAAuDl
         /4h3bASY0Ivfwp82T9gQSHpralUDDjpWg0kSSlRBYhaMGc+f/wRhDdp/zqyI72fU1v
         WRudfFToHwR7fyK1w+SIrckkx4kjx/4ePBaPlcDk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.231.59]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1k7Y371Ht5-00ecTa; Mon, 09
 Nov 2020 19:24:02 +0100
Date:   Mon, 9 Nov 2020 19:23:48 +0100
From:   John Wood <john.wood@gmx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Cc:     John Wood <john.wood@gmx.com>, Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 7/8] Documentation: Add documentation for the Brute LSM
Message-ID: <20201109182348.GA3110@ubuntu>
References: <20201025134540.3770-1-john.wood@gmx.com>
 <20201025134540.3770-8-john.wood@gmx.com>
 <2ab35578-832a-6b92-ca9b-2f7d42bc0792@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab35578-832a-6b92-ca9b-2f7d42bc0792@infradead.org>
X-Provags-ID: V03:K1:WdI92dEESOw+IgoEK7rINKMLkOZRlvr4IU++VYFxIy5Ur0nV16w
 Sqk+PhsyjhswmvKyBUujNzib3b/wlEFMi39I/2/Bce6C0eAMeXnWS9YK6rlW9reHWAz9Szd
 ICX7ASR+WHwx4BL2+H8Aeq3GTAh49+HVm+XJdYJvJgA4+9gc3QJYZQFBI08chIEExKq2+yS
 nAguvprm3r390hvh6TrRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:98HlGKz9byI=:y9WvS6BYmDogmfNlP3PqZd
 sWZq3sMViZO0xAzwsWRVGRHjkt5YyU+C1AqB2JSCjSM8i69/rcn4dBDna+E1t83MSnIjZpQvW
 NeaZmFproIgh57IAwipps3xUj8zq8vmjCGqZten0jYdleE7hRN3Nhn14vdrxjnB/0SS9obIgK
 hKFu5IIEC7sLEHovDjYww3kv6l9ZR89B229SvWx5jTYSCgkAfZ1xNL5C/Blv9gPDFlzMOAtUV
 EzrWNW/1W8gfPufebymUZYPomyz2Jf+5LBPugLT+m1ZTLzo1rA9O7lp+AO5GH+uF3/wnMMNkE
 pCsMl0RqRKJN4L1OoegURKyPmqH7zY/60BThS4RNQ29yB7LGF+usuXQoQneqHgcoWXXBZ4NWM
 XFNXjfRKoGwgo/VHiNcf+UcyBHpoTEoPTIA0D2LnpyuAZW8YTg5zrf5CSS+j2maMyxiIMLvlw
 qwdUB8yW7LmJJMdfU75NWEcxLnj4KOi6RhddjfM1q61f9QSPwNjdnbNtDT6wCW9Sb+lefroBS
 GxNkPOp+8dPaCGGKxJO7iOm5EZPjpusjupOGqBwQb0B7TrK9lJTJmu3YRVBNA4hWjzliTvFzx
 fkSGuTLCStJJi1Jc9aocu5R4O2TZlWWTYpx2M/w30puxorF4WzvWs5JpsEi3DByYIVRBikAVZ
 IkW1mGIFY+Nd2/tQDrSQxe+uLBejHR0k0nc2ihQsGOSXotUvJdkW1PtuMOZ4u+ydyoB2wnmAI
 wCUaD9Bn+3gNcjb7H8+lM9PGYm/jhSY/5rUE6qA3wpgMdNL3JeQmLe3Pdk0JFcVCTjfGxQDNu
 /I/dZ44v3f2rv4wu0X/LaNajwe5DtUSwdq5gUB6dVKSbaQt8qPUXpgKBabvA2gk9QWKHmwmz5
 coBqJksRfE5u8uNHeX9Q==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,
Thanks for the typos corrections. Will be corrected in the next patch
version.

On Sun, Nov 08, 2020 at 08:31:13PM -0800, Randy Dunlap wrote:
>
> So an app could read crash_period_threshold and just do a new fork every
> threshold + 1 time units, right? and not be caught?

Yes, you are right. But we must set a crash_period_threshold that does not
make an attack feasible. For example, with the default value of 30000 ms,
an attacker can break the app only once every 30 seconds. So, to guess
canaries or break ASLR, the attack needs a big amount of time. But it is
possible.

So, I think that to avoid this scenario we can add a maximum number of
faults per fork hierarchy. Then, the mitigation will be triggered if the
application crash period falls under the period threshold or if the number
of faults exceed the maximum commented.

This way, if an attack is of long duration, it will also be detected and
mitigated.

What do you think?

>
> thanks for the documentation.
> --
> ~Randy
>

Thanks,
John Wood

