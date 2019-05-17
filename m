Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4794221FB4
	for <lists+linux-security-module@lfdr.de>; Fri, 17 May 2019 23:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfEQVjX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 May 2019 17:39:23 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:47392 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfEQVjW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 May 2019 17:39:22 -0400
Received: by mail-vk1-f202.google.com with SMTP id x77so3080912vke.14
        for <linux-security-module@vger.kernel.org>; Fri, 17 May 2019 14:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CxlinLSdgStAZj8ZYyY8C5jglK14sBrM48vYUM57nQk=;
        b=Lr1hshRLI8bkkP5XQ+UnqbvtSIn4+GxIHNrUKo5knOvGtLVWvllhbmL/P7SFVq0q3G
         oySlkP3VC/FArrDJIA9lERGu11efUk2HE1iv+rtqxt5h25S7olLYbSifqxp2Pm5Sa14n
         eJG55mOsEM7FGWG36vVTPIvS49vJRvB2AnCjRfPc+2yd0Vqq9usi7KTHCKhCd0IyT4PR
         qBfAxm/5OnPt9nlgrr+zu3mJDsmaWzAe27XN5d6ZwKQ4qa8VeYXAmd15kiS/0jyawOr0
         9nYCnuQt/oEVdCzXELQw2AWQANdTpFx0IkvBjyPIam8tKwuieV42gWQlnehz57Ep/F18
         7Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CxlinLSdgStAZj8ZYyY8C5jglK14sBrM48vYUM57nQk=;
        b=hCxIsBSmVNQ2bTaAPJP/zGHe8/uTfalyW67Xph8FT2VkTCTc5pm3aoN53Xm0rTj6vH
         tE5mZKrUClv5q0CcNCr466Ggfa4OAoxGlzFByidkAxQf/7ART4iFAt/+QZ3Kru0Y4jaq
         T4QSIOy64MrvFgqzarp5fMlt4/2aLquPTZMkHTzEfPMDxSlCPYhsnjQMRIvIfQ9nUmPM
         rLskWlu5n/wo+LqEkV1Wogqabz7/tOiUZgNh0qYZKHurarXBkcjjW+OMBotZj99RDgT/
         UkkscGAfdYCIhtEPGo/KOw4Gpbro44kyU4vEbUhmjC5+P2G9wlDi9lgecp0Tnd38n0Fk
         bpbA==
X-Gm-Message-State: APjAAAUIUEmP8G4Tl/kVZJ0lkh49yJQDSh40F1nIP5cBs342JQVDcRh4
        oWiMexjYb6NfNGwdJNeLKx7KOLYCq0hWVaWQqU0veA==
X-Google-Smtp-Source: APXvYqwIDbPWP1gGpGqX0HDPWX3Ohrqk6UfCTZUEHeW8kUGSBX2WSMELoI3iXY6X+cwOujb0YKqTVixq1iTSqpDOz3RSCw==
X-Received: by 2002:ab0:5a07:: with SMTP id l7mr22035272uad.78.1558129161944;
 Fri, 17 May 2019 14:39:21 -0700 (PDT)
Date:   Fri, 17 May 2019 14:39:14 -0700
Message-Id: <20190517213918.26045-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH V6 0/4] Add support for crypto agile TPM event logs
From:   Matthew Garrett <matthewgarrett@google.com>
To:     linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com, bsz@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Updated with the fixes from Bartosz and the header fixes folded in.
Bartosz, my machine still doesn't generate any final event log entries -
are you able to give this a test and make sure it's good?


