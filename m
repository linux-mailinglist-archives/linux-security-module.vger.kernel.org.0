Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED3C14AE9B
	for <lists+linux-security-module@lfdr.de>; Tue, 28 Jan 2020 05:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA1ERK (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 27 Jan 2020 23:17:10 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61040 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA1ERK (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 27 Jan 2020 23:17:10 -0500
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00S4H69H049054;
        Tue, 28 Jan 2020 13:17:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Tue, 28 Jan 2020 13:17:06 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00S4H6PL049050
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 28 Jan 2020 13:17:06 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-security-module <linux-security-module@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [GIT PULL] TOMOYO patches for v5.6
Message-ID: <cdf30cd3-8b0e-9014-0474-ce978e6bcc3b@i-love.sakura.ne.jp>
Date:   Tue, 28 Jan 2020 13:17:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The following changes since commit a8772fad0172aeae339144598b809fd8d4823331:

  tomoyo: Use atomic_t for statistics counter (2020-01-02 12:53:49 +0900)

are available in the git repository at:

  git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20200128

for you to fetch changes up to a8772fad0172aeae339144598b809fd8d4823331:

  tomoyo: Use atomic_t for statistics counter (2020-01-02 12:53:49 +0900)

----------------------------------------------------------------
Hello, Linus.

One "int -> atomic_t" conversion patch for suppressing KCSAN's warning.

----------------------------------------------------------------
