Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BAA3E23C4
	for <lists+linux-security-module@lfdr.de>; Fri,  6 Aug 2021 09:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbhHFHL6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 6 Aug 2021 03:11:58 -0400
Received: from mail.astralinux.ru ([217.74.38.119]:49300 "EHLO
        mail.astralinux.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbhHFHL6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 6 Aug 2021 03:11:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 6E7D72F62F80;
        Fri,  6 Aug 2021 10:03:18 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yduaqOkklze7; Fri,  6 Aug 2021 10:03:17 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id E006E2F62F7C;
        Fri,  6 Aug 2021 10:03:17 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DaHiHlSbzyMP; Fri,  6 Aug 2021 10:03:17 +0300 (MSK)
Received: from mastykin.cct.rbt (unknown [192.168.32.67])
        by mail.astralinux.ru (Postfix) with ESMTPSA id AF8EF2F62ED8;
        Fri,  6 Aug 2021 10:03:17 +0300 (MSK)
From:   Dmitry Mastykin <dmastykin@astralinux.ru>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc:     dmastykin@astralinux.ru, akovalenko@astralinux.ru
Subject: lsm-stacking: fix broken lsm audit
Date:   Fri,  6 Aug 2021 10:02:42 +0300
Message-Id: <20210806070245.26338-1-dmastykin@astralinux.ru>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello,
These patches address the problem of not processing LSM audit rules.
Problem was introduced in lsm stacking series.
These patches are for cschaufler/lsm-stacking repository branch stack-5.10-rc4-v23 
Some UBUNTU distributions have also this problem.

Kind regards,
Dmitry Mastykin
