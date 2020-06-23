Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7662049D4
	for <lists+linux-security-module@lfdr.de>; Tue, 23 Jun 2020 08:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgFWGX5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 23 Jun 2020 02:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbgFWGX5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Jun 2020 02:23:57 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0FC061795
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2020 23:23:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id h19so918334ljg.13
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2020 23:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dPmL4ji10DM23gXnHiUP2NWgp6rzRT93lGyytV/WtJM=;
        b=BIdVinktvLNiMk2nDRyH/DIePkv0Y76ENlOPbiD73uhrPmAMWpcQr0GXrq31J7UWKy
         nx8cSiBDNUNtKhgqbuWTj5/yrtE899FP1q+Kbv9b1V1z5MhHcAfoTPmKUBPRNv4O93xb
         8ErCN2zCByMbG4NDklpkORi7nxFQvRFTmI7j6WCrrT6j3vugRvMD4MvqbAJez/VIbSj4
         F0L1wnWSrbrCCkBdJrgEi6penn3FCPOtrKz5WHjQOZua3SlwQcChthsVjDiMoQ/6X8iE
         H9FMLmhcj3Z+bPDhmvjDT6yMPl5j3w0NhSrNdNuLf8wDntXMPLPLJ4sFqphnVX3TlWyV
         A/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dPmL4ji10DM23gXnHiUP2NWgp6rzRT93lGyytV/WtJM=;
        b=HzdYuoi2Mw9l5DDM4T9z/coKBGNqBwJlucl4aXQC9feu6xdlDpofNFQSJvdU9B43AC
         siPYBxpAqf+HdYdVGHMYVIDYMOOENDJBPSNuVjBNZaTOiBJzmgn8G59ErLUyDFr3bwrj
         4dPU7IlhiQWROVbOfhx2/YzsCFy7tf439gXOCguWmRKhXDE74HccSbfkxIvoOjNiQYAx
         ZxrQ5m04hqMLwZ1o7jAdqo8rm6fEmsVgpdxEjwZUC58xnOPIpTpBs5TI+Kh78eLaZyrY
         jU26PZ2FKPVId/d1UaUCEzl6jl+y0oQVhd4tGxSn31JPmJd6aXCT3pxast9hnK/oJ6rB
         Crcg==
X-Gm-Message-State: AOAM533ZsaVZ/JzyBD/Oiz7ro3Ao1PAdPMoKPTD9ohdfJN05kH/q9QIU
        Zuh65KWUKATSyEhuMudlxqkAssXM+7jXzQs1ocGNvw==
X-Google-Smtp-Source: ABdhPJwyfBDDErbrS4GjTK/D+t1eKZ96j9X/dUhypMGUwehTdQFYmoz856g75PfnLqD8QeqGESPEHLqWG864TNrkBCI=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr10241919ljp.266.1592893434808;
 Mon, 22 Jun 2020 23:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
 <20200622224920.GA4332@42.do-not-panic.com>
In-Reply-To: <20200622224920.GA4332@42.do-not-panic.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 Jun 2020 11:53:43 +0530
Message-ID: <CA+G9fYsXDZUspc5OyfqrGZn=k=2uRiGzWY_aPePK2C_kZ+dYGQ@mail.gmail.com>
Subject: Re: LTP: crypto: af_alg02 regression on linux-next 20200621 tag
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        lkft-triage@lists.linaro.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jan Stancek <jstancek@redhat.com>, chrubis <chrubis@suse.cz>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 23 Jun 2020 at 04:19, Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Jun 23, 2020 at 12:04:06AM +0530, Naresh Kamboju wrote:
> > LTP crypto regressions noticed on linux next 20200621.
> >
> > The common case for all tests is timeout after 15 minutes which
> > means tests got hung and LTP timers killed those test runs after
> > timeout.
> > The root cause of the failure is under investigation.
> >
> >   ltp-crypto-tests:
> >     * af_alg02 - failed
> >     * af_alg05 - failed
> >   ltp-syscalls-tests:
> >     * keyctl07 - failed
> >     * request_key03 - failed
<trim>
>
> Can you try reverting:
>
> d13ef8e10756873b0a8b7cc8f230a2d1026710ea
>
> The patch is titled "umh: fix processed error when UMH_WAIT_PROC is used"

Thanks for the investigation.
After reverting, two test cases got PASS out of four reported failure cases.
 ltp-crypto-tests:
     * af_alg02 - still failing - Hung and time out
     * af_alg05 - still failing - Hung and time out
  ltp-syscalls-tests:
     * keyctl07 - PASS
     * request_key03 - PASS

Please suggest the way to debug / fix the af_alg02 and af_alg05 failures.

- Naresh
