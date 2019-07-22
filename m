Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF270163
	for <lists+linux-security-module@lfdr.de>; Mon, 22 Jul 2019 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfGVNnI (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 22 Jul 2019 09:43:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54570 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbfGVNnI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jul 2019 09:43:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so35223105wme.4
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jul 2019 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NdsQKVFmNs6oW1hJn+UT+GZIRLqio0pp3aE2kfFVFlw=;
        b=nrCT2OBgmeNDla2SEMXWJRl1pcE/QxfcWIW62ojJ4PxqsW5DyA5mumQjqIwn9+Y/3Z
         Rqf7MMAq2kxRkk6J41gMHxECVbgOd6fljjHBI5VEmB3HbxkgxTd6PsXY4KB8n7cJiTL/
         1Z89k7X5GK4TSQnE7TbAIPWMRIqltVZvSnWIiM+euvrZeoVNscPIlA2aG6+dOAn0Cff4
         90MbzO18WADV4nwrKZQYV5nObdo7VaVs+U1hfdhQWeyXecba9mxaCqlZgn129DmiPIaX
         qnDylbjVJ+eXx/xQ8UzAa7QEL2lub/H4jer8JeqDxyMI/f9B1iFALw12GjZbubQGRG81
         fEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NdsQKVFmNs6oW1hJn+UT+GZIRLqio0pp3aE2kfFVFlw=;
        b=baOdnSbu1ZPblx+29htrB5kZBkbPEC5W//zuw+i159aAOXakgQSFn38JKlYArcLvif
         17ACI/UJ+PwYpmlhuGrvQsIIirizAInXS18d53FSd6KMsE84xCab04Pd5aA0eTzss2LL
         zwI+vxJh2YGn5R3u5PT8+j213tvYLXiPFZDY3QKPekrYJ21fVekRD5t+iORJmkEUuAm6
         d8wvwCcq7cTy87HBNOZZFIJ2sc8ceuzpom/+oAhTdo2KF2/SOBDAlwlXwHvn3u45bFLH
         OcneqPXA31QFu6zKAwY0GIxZ3y8uX+AZMDM1LJ0+O58TmoZexk/fJJvHAz48rfMK254G
         zyJQ==
X-Gm-Message-State: APjAAAX2iMQRk64vQ44AqKJNX/W/oFAz8WgSW6mCMaXEW6IFxLOBMVQV
        wRNPOwcvOcA2CWcdNwFmXaShhhdLz6cadxW28POPlw==
X-Google-Smtp-Source: APXvYqwGuFmEfpzDoGKBG0BkU1w8oIlhjhTzhe3Aiom0XA9aLURTRzC8omVhkavt+9CJzeHU8H0alGht2JfV25OADsA=
X-Received: by 2002:a1c:7f93:: with SMTP id a141mr64104801wmd.131.1563802986120;
 Mon, 22 Jul 2019 06:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190722114134.3123901-1-arnd@arndb.de>
In-Reply-To: <20190722114134.3123901-1-arnd@arndb.de>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 22 Jul 2019 15:42:54 +0200
Message-ID: <CAG_fn=UxowACw5w+erKaAPRr4SWk3WbLTfAgJj=cOL4HgZHK=Q@mail.gmail.com>
Subject: Re: [PATCH] [RESEND v2] structleak: disable STRUCTLEAK_BYREF in
 combination with KASAN_STACK
To:     Arnd Bergmann <arnd@arndb.de>, Dmitriy Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jul 22, 2019 at 1:41 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF
> leads to much larger kernel stack usage, as seen from the warnings
> about functions that now exceed the 2048 byte limit:
>
> drivers/media/i2c/tvp5150.c:253:1: error: the frame size of 3936 bytes is=
 larger than 2048 bytes
> drivers/media/tuners/r820t.c:1327:1: error: the frame size of 2816 bytes =
is larger than 2048 bytes
> drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16552:1: err=
or: the frame size of 3144 bytes is larger than 2048 bytes [-Werror=3Dframe=
-larger-than=3D]
> fs/ocfs2/aops.c:1892:1: error: the frame size of 2088 bytes is larger tha=
n 2048 bytes
> fs/ocfs2/dlm/dlmrecovery.c:737:1: error: the frame size of 2088 bytes is =
larger than 2048 bytes
> fs/ocfs2/namei.c:1677:1: error: the frame size of 2584 bytes is larger th=
an 2048 bytes
> fs/ocfs2/super.c:1186:1: error: the frame size of 2640 bytes is larger th=
an 2048 bytes
> fs/ocfs2/xattr.c:3678:1: error: the frame size of 2176 bytes is larger th=
an 2048 bytes
> net/bluetooth/l2cap_core.c:7056:1: error: the frame size of 2144 bytes is=
 larger than 2048 bytes [-Werror=3Dframe-larger-than=3D]
> net/bluetooth/l2cap_core.c: In function 'l2cap_recv_frame':
> net/bridge/br_netlink.c:1505:1: error: the frame size of 2448 bytes is la=
rger than 2048 bytes
> net/ieee802154/nl802154.c:548:1: error: the frame size of 2232 bytes is l=
arger than 2048 bytes
> net/wireless/nl80211.c:1726:1: error: the frame size of 2224 bytes is lar=
ger than 2048 bytes
> net/wireless/nl80211.c:2357:1: error: the frame size of 4584 bytes is lar=
ger than 2048 bytes
> net/wireless/nl80211.c:5108:1: error: the frame size of 2760 bytes is lar=
ger than 2048 bytes
> net/wireless/nl80211.c:6472:1: error: the frame size of 2112 bytes is lar=
ger than 2048 bytes
>
> The structleak plugin was previously disabled for CONFIG_COMPILE_TEST,
> but meant we missed some bugs, so this time we should address them.
>
> The frame size warnings are distracting, and risking a kernel stack
> overflow is generally not beneficial to performance, so it may be best
> to disallow that particular combination. This can be done by turning
> off either one. I picked the dependency in GCC_PLUGIN_STRUCTLEAK_BYREF
> and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, as this option is designed to
> make uninitialized stack usage less harmful when enabled on its own,
> but it also prevents KASAN from detecting those cases in which it was
> in fact needed.
>
> KASAN_STACK is currently implied by KASAN on gcc, but could be made a
> user selectable option if we want to allow combining (non-stack) KASAN
> with GCC_PLUGIN_STRUCTLEAK_BYREF.
>
> Note that it would be possible to specifically address the files that
> print the warning, but presumably the overall stack usage is still
> significantly higher than in other configurations, so this would not
> address the full problem.
>
> I could not test this with CONFIG_INIT_STACK_ALL, which may or may not
> suffer from a similar problem.
We would love to be able to run KASAN together with
CONFIG_INIT_STACK_ALL on syzbot, as this will potentially reduce the
number of flaky errors.
Given that we already increase the stack size in KASAN builds, how big
of a problem are these warnings?
Perhaps it's better to disable them in this configuration, or push the limi=
t up?

> Fixes: 81a56f6dcd20 ("gcc-plugins: structleak: Generalize to all variable=
 types")
> Acked-by: Kees Cook <keescook@chromium.org>
> Link: https://lore.kernel.org/lkml/20190628123819.2785504-1-arnd@arndb.de=
/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> [v2] do it for both GCC_PLUGIN_STRUCTLEAK_BYREF and GCC_PLUGIN_STRUCTLEAK=
_BYREF_ALL.
>
> Andrew, can you pick this up in -mm? It looks like nobody else
> wanted it in their trees even though there was agreement on the
> patch itself.
> ---
>  security/Kconfig.hardening | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
> index a1ffe2eb4d5f..af4c979b38ee 100644
> --- a/security/Kconfig.hardening
> +++ b/security/Kconfig.hardening
> @@ -61,6 +61,7 @@ choice
>         config GCC_PLUGIN_STRUCTLEAK_BYREF
>                 bool "zero-init structs passed by reference (strong)"
>                 depends on GCC_PLUGINS
> +               depends on !(KASAN && KASAN_STACK=3D1)
>                 select GCC_PLUGIN_STRUCTLEAK
>                 help
>                   Zero-initialize any structures on the stack that may
> @@ -70,9 +71,15 @@ choice
>                   exposures, like CVE-2017-1000410:
>                   https://git.kernel.org/linus/06e7e776ca4d3654
>
> +                 As a side-effect, this keeps a lot of variables on the
> +                 stack that can otherwise be optimized out, so combining
> +                 this with CONFIG_KASAN_STACK can lead to a stack overfl=
ow
> +                 and is disallowed.
> +
>         config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
>                 bool "zero-init anything passed by reference (very strong=
)"
>                 depends on GCC_PLUGINS
> +               depends on !(KASAN && KASAN_STACK=3D1)
>                 select GCC_PLUGIN_STRUCTLEAK
>                 help
>                   Zero-initialize any stack variables that may be passed
> --
> 2.20.0
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
