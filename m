Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86C5F8C16F
	for <lists+linux-security-module@lfdr.de>; Tue, 13 Aug 2019 21:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHMTVc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 13 Aug 2019 15:21:32 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:45289 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfHMTVb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 13 Aug 2019 15:21:31 -0400
Received: by mail-vs1-f73.google.com with SMTP id v20so29324289vsi.12
        for <linux-security-module@vger.kernel.org>; Tue, 13 Aug 2019 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=BDuuPvThS9J0e+So1x3sBYf3hnCiwQJJSrbuYxZSQjs=;
        b=r3Cy/0oVwIppxeYsBhtRjJ40thJiJsj6ShvjKe5n8HRQfkJynWpwJmgTAt0gvcAkPO
         joFusNVJpvQ28UoXNo79ylVDCoA1IijDH3qFoPFKgMPCaNxfjQiD/z0C+0L9+ky56VB/
         w4GeR5WnSqflK2G46a/tnrfISo5GZQBP2zL3UK2Tdi5XbE2ki+/KX6hJou2qkqUjOkeC
         pXhv/92S0ghKwgGL9i3jLZlW5viK5GZPV2nK2ElhMU92MKmdlXK5L/MrWJP9Bq7Hoiso
         pfAp9mEAVzq6GaOp9N45ne8uOmJn25ZA7KUVbLDP2FpOjRIpTRUkN/62Q2U+tJLKNiwI
         zaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=BDuuPvThS9J0e+So1x3sBYf3hnCiwQJJSrbuYxZSQjs=;
        b=GYTpuv65Gy0lmT4Lz5mD1ni+ni4zOs48gpqz0ShT33idorOCuqn3PfvPcLc0Hd0wHE
         vm8L+bAJ0AinBFQ+lfGHoN+smvfqsxwcX+cedyEs0acb4o5TbfV/DHw6PUn2AMOEr3qR
         fpcXU0sdt6Xxt3K0PUgiEsPKmAgaqcsmAkuntW/soR+wRhPHTHl2aKJeAhhdXmwN1qqv
         I0OrixMZnltS8UAKzkK6ETuni5DfXP1AVfvjp8LgHXak1ZW+XYXvHYijpz4sXcc7Vjo6
         G+HKqKLxf8b03Yu2duPpnTE2SYgejwQVkQmE/UxyIw676uoVip8zYzvbbeHrZD2eG8fB
         Jwfw==
X-Gm-Message-State: APjAAAXBrXriuyRHXlrWxjxT+SauVGhlD046fXN4NlqZHW49oGW/klPE
        sHoA41EGt4DiuK9iMHF3ru/V+AeD4Tp6axm76+lRFA==
X-Google-Smtp-Source: APXvYqzy3e9NY0D1hNTI0EKPrPcXi4gHsIBVLS9dW5ISmcZ9bnL3yns7IK5/b5CR0h5efbjBjaEAn8UDoYyxKE5ugpyCaQ==
X-Received: by 2002:a1f:d1c3:: with SMTP id i186mr16816143vkg.26.1565724090567;
 Tue, 13 Aug 2019 12:21:30 -0700 (PDT)
Date:   Tue, 13 Aug 2019 12:21:20 -0700
Message-Id: <20190813192126.122370-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 0/6] lockdown fixups
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fixups for the lockdown patchset. Potentially makes more sense to merge
these into the relevant original patches rather than keeping them
separate, but sending them for review.


