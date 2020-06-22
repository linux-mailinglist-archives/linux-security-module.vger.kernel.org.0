Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48185203F34
	for <lists+linux-security-module@lfdr.de>; Mon, 22 Jun 2020 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgFVSeV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 22 Jun 2020 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgFVSeU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 22 Jun 2020 14:34:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3799CC061797
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2020 11:34:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t74so10233911lff.2
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2020 11:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sBexF5ssPbh5LGo0nOeoAmYTVHXNPIpTHLnki7UR7GA=;
        b=dLVhwzoIaHVDtXlEa1yvKtmI/A8BJFihnPmuFHEt+CIA+Blq4FXWfgRDj5VbpYeAvs
         LExEGz+hg9FoBlNsk/KDwNo6DL+1H0Oln1cW6CTVsYdLj81cGymdJ+LHP340gPCojzAn
         WzoZSRf0551K9N59cmTYzZBiMUrU1INtRsyrH5hUFAx4zevjJoB8bUY98vkN5e0Y1w3v
         oweWmToFE3c0cUPu4Nc2eOF9DffAZo7jcaDQWC3Mhg7iqjVdCc3wUq8fp/bN4yC6PVjs
         aVCjsY+vU5prFJAmP1JwVT+P5UBgdgG+Y6dIk4QkSei7A2y/3Jkdq8CMMhhEhD7DXrQL
         Mh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sBexF5ssPbh5LGo0nOeoAmYTVHXNPIpTHLnki7UR7GA=;
        b=rbanAXXa9EYiBLiAJNJPsZxdl7hF48+J2dDkxU6wvQ8t5kQ/b//Dx3K1eS40grzZ4s
         xPeic2dgbEzV+vJDFr0+FTKK5iM+ARkW6A83mROcPUyT8JrlI3HO6seoB2UzIc2N29lX
         5yiOOoalWOYhMZV21XQjKok56IKlnPiZyX/Q8jTKfQtwhc7xH5tjMgkrxxUN35D0Btpy
         Mm7QfWWuxzEjDUlNVpEp/9Po36rFe11G5va+xXTmD38DmfxDYF/8a7cxZjN++HcXYbiL
         0ZE6lKuR7H2eB14+/cxrFtdYCIVOmsXCkquQe97yX1zOrMeeJ9vj4w6hMl7E0Y64l0Mu
         zn7A==
X-Gm-Message-State: AOAM5309NHmQqQPmmATXNpvvY3Hm47NyFTe0HZmdhlKvi8UrsH1MIFl6
        zMceySc8UhxRASffXBtnloAHX2Te9dHGcTRkuYsY/Q==
X-Google-Smtp-Source: ABdhPJyPOJcIhXBV0KqXpX75z6mrdlBxWTdsbbkx8Ha1UrGxW5K2yYQvin6nrIjvzB6DkFmVg0qpX8oS1eea80qkSR0=
X-Received: by 2002:ac2:4db2:: with SMTP id h18mr10513503lfe.167.1592850858186;
 Mon, 22 Jun 2020 11:34:18 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 Jun 2020 00:04:06 +0530
Message-ID: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
Subject: LTP: crypto: af_alg02 regression on linux-next 20200621 tag
To:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        lkft-triage@lists.linaro.org, linux-crypto@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Jan Stancek <jstancek@redhat.com>, chrubis <chrubis@suse.cz>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

LTP crypto regressions noticed on linux next 20200621.

The common case for all tests is timeout after 15 minutes which
means tests got hung and LTP timers killed those test runs after
timeout.
The root cause of the failure is under investigation.

  ltp-crypto-tests:
    * af_alg02 - failed
    * af_alg05 - failed
  ltp-syscalls-tests:
    * keyctl07 - failed
    * request_key03 - failed

Output log:
--------------
af_alg02:
af_alg02.c:52: BROK: Timed out while reading from request socket.

Test code at line number 52 is

pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
SAFE_PTHREAD_CREATE(&thr, NULL, verify_encrypt, NULL);

TST_CHECKPOINT_WAIT(0);

while (pthread_kill(thr, 0) != ESRCH) {
    if (tst_timeout_remaining() <= 10) {
        pthread_cancel(thr);
        tst_brk(TBROK,
                   "Timed out while reading from request socket.");


af_alg05:
tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
[  362.599868] kworker/dying (137) used greatest stack depth: 11600 bytes left
Test timeouted, sending SIGKILL!
tst_test.c:1286: INFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1287: BROK: Test killed! (timeout?)

request_key03:
tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
request_key03.c:65: CONF: kernel doesn't support key type 'encrypted'
request_key03.c:65: CONF: kernel doesn't support key type 'trusted'
Test timeouted, sending SIGKILL!
tst_test.c:1286: INFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1287: BROK: Test killed! (timeout?)

keyctl07
tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
Test timeouted, sending SIGKILL!
tst_test.c:1286: INFO: If you are running on slow machine, try
exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1287: BROK: Test killed! (timeout?)

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: 5a94f5bc041ea9e4d17c93b11ea6f6a2e5ad361b
  git describe: next-20200621
  kernel-config:
https://builds.tuxbuild.com/PB-45Luvlx0yYJ8MZgpijA/kernel.config

ref:
https://lkft.validation.linaro.org/scheduler/job/1511938#L2211
https://lkft.validation.linaro.org/scheduler/job/1511935#L9225

- Naresh
