Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943D763233A
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Nov 2022 14:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiKUNOa (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 21 Nov 2022 08:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKUNO3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Nov 2022 08:14:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825111E3DB
        for <linux-security-module@vger.kernel.org>; Mon, 21 Nov 2022 05:14:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l24so3602065edj.8
        for <linux-security-module@vger.kernel.org>; Mon, 21 Nov 2022 05:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hL5iYCNYJT5CdfaY+BylUC9g4Yj0+Fyiqmr6KtQn1vE=;
        b=SJ0n9BGCNHZN7ZTRm2uV3ZVxyT/FY2VQf/AjpGsdiHsBc1oAiTyl6OaxV+My2+DAMl
         Y7pz8wTjyHMwhFAyT6Pf+pMdVNseoOss8yTUgvbNMds9QwHBSSJaUWzXDAatEXnPplVS
         2/9ZwW+Vg5p+SPMmqOmXOhDkih2DJYCXJx8Ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hL5iYCNYJT5CdfaY+BylUC9g4Yj0+Fyiqmr6KtQn1vE=;
        b=mhJ0isi+bH54xkAkD1IenVG3Eq4I1IuJ9JpqyYym3e3cAQRhOiesV5Xh4JvsB7+y2L
         Qwjk8GdQecWVve63HqfpIYhL4RRDEkMMIpZbyRmiMGXlRESnOWQwZvs9ipu8eSAheFO7
         SRXhHZ9IcYbrjD/5b8o5/fJZVKBQvHVUhzGyGwIsas2vbZ+NExlHdEYRWVSvHct2ZT1w
         2maoU9tiPxTcoZ43DuDPQtCOVeYm57bg49vAljxWY9tvrr0n7BwnY0zsjNWpLYxpwti4
         LZpHLoDj5/PA4TARVjFp/4gBi/pyZPCHBWpGE7gJsdR9MOGYowDsGvsAHJ4JewSLi1Pn
         Dw3g==
X-Gm-Message-State: ANoB5pkDJoNHBmTOm2q3Mtffk47azyjkqpYtOaBKIapXfY8HMBWE8ab/
        rFokzyy2OMjPgM6DDhy36ghe6Gg1YBy0h/VcjVy0d4VfDZkvtA==
X-Google-Smtp-Source: AA0mqf6CkCLlvlbPBG7lbXZwKejw1tqr1gAqg5GXZcO1FPZlNWmSntkUVVVE7G9p9sIApKxgSEl9NVZ78UPr6zIsx+o=
X-Received: by 2002:a50:bb08:0:b0:469:1684:217d with SMTP id
 y8-20020a50bb08000000b004691684217dmr6579098ede.270.1669036464083; Mon, 21
 Nov 2022 05:14:24 -0800 (PST)
MIME-Version: 1.0
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Nov 2022 14:14:13 +0100
Message-ID: <CAJfpegsVAUUg5p6DbL1nA_oRF4Bui+saqbFjjYn=VYtd-N2Xew@mail.gmail.com>
Subject: sgid clearing rules?
To:     linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

I'm looking at sgid clearing in case of file modification.  Seems like
the intent was:

 - if not a regular file, then don't clear
 - else if task has CAP_FSETID in init_user_ns, then don't clear
 - else if group exec is set, then clear
 - else if gid is in task's group list, then don't clear
 - else if gid and uid are mapped in current namespace and task has
CAP_FSETID in current namespace, then don't clear
 - else clear

However behavior seems to deviate from that if group exec is clear and
*suid* bit is not set.  The reason is that inode_has_no_xattr() will
set S_NOSEC and __file_remove_privs() will bail out before even
starting to interpret the rules.

This behavior is also codified in xfstests.  E.g. generic/683.out:

Test 1 - qa_user, non-exec file falloc
6666 -rwSrwSrw- TEST_DIR/683/a
666 -rw-rw-rw- TEST_DIR/683/a

vs

Test 9 - qa_user, non-exec file falloc, only sgid
2666 -rw-rwSrw- TEST_DIR/683/a
2666 -rw-rwSrw- TEST_DIR/683/a

and

Test 3 - qa_user, user-exec file falloc
6766 -rwsrwSrw- TEST_DIR/683/a
766 -rwxrw-rw- TEST_DIR/683/a

vs

_user, user-exec file falloc, only sgid
2766 -rwxrwSrw- TEST_DIR/683/a
2766 -rwxrwSrw- TEST_DIR/683/a

Should the S_IXGRP test be purged from is_sxid() to make this consistent?

Thanks,
Miklos
