Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9478424338
	for <lists+linux-security-module@lfdr.de>; Mon, 20 May 2019 23:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfETVy3 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 20 May 2019 17:54:29 -0400
Received: from linux.microsoft.com ([13.77.154.182]:35994 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfETVy3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 20 May 2019 17:54:29 -0400
Received: from jaskaran-Intel-Server-Board-S1200V3RPS-UEFI-Development-Kit.corp.microsoft.com (unknown [131.107.160.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 69C3C20B7192;
        Mon, 20 May 2019 14:54:28 -0700 (PDT)
From:   Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
To:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        jmorris@namei.org
Subject: [RFC 0/1] Add dm verity root hash pkcs7 sig validation.
Date:   Mon, 20 May 2019 14:54:21 -0700
Message-Id: <20190520215422.23939-1-jaskarankhurana@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

This patch set adds in-kernel pkcs7 signature checking for the roothash of
the dm-verity hash tree.
The verification is to support cases where the roothash is not secured by
Trusted Boot, UEFI Secureboot or similar technologies.
One of the use cases for this is for dm-verity volumes mounted after boot,
the root hash provided during the creation of the dm-verity volume has to
be secure and thus in-kernel validation implemented here will be used
before we trust the root hash and allow the block device to be created.

Why we are doing validation in the Kernel?

The reason is to still be secure in cases where the attacker is able to
compromise the user mode application in which case the user mode validation
could not have been trusted.
The root hash signature validation in the kernel along with existing
dm-verity implementation gives a higher level of confidence in the
executable code or the protected data. Before allowing the creation of
the device mapper block device the kernel code will check that the detached
pkcs7 signature passed to it validates the roothash and the signature is
trusted by builtin keys set at kernel creation. The kernel should be
secured using Verified boot, UEFI Secure Boot or similar technologies so we
can trust it.

What about attacker mounting non dm-verity volumes to run executable
code?

This verification can be used to have a security architecture where a LSM
can enforce this verification for all the volumes and by doing this it can
ensure that all executable code runs from signed and trusted dm-verity
volumes.

Further patches will be posted that build on this and enforce this
verification based on policy for all the volumes on the system.

How are these changes tested?

veritysetup part of cryptsetup library was modified to take a optional
root-hash-sig parameter.

Commandline used to test the changes:

veritysetup open  <data_device> <name> <hash_device> <root_hash>
 --root-hash-sig=<root_hash_pkcs7_detached_sig>

The changes for veritysetup are in a topic branch for now at:
https://github.com/jaskarankhurana/veritysetup/tree/veritysetup_add_sig

Jaskaran Khurana (1):
  Add dm verity root hash pkcs7 sig validation.

 drivers/md/Kconfig                |  23 ++++++
 drivers/md/Makefile               |   2 +-
 drivers/md/dm-verity-target.c     |  44 ++++++++--
 drivers/md/dm-verity-verify-sig.c | 129 ++++++++++++++++++++++++++++++
 drivers/md/dm-verity-verify-sig.h |  32 ++++++++
 5 files changed, 222 insertions(+), 8 deletions(-)
 create mode 100644 drivers/md/dm-verity-verify-sig.c
 create mode 100644 drivers/md/dm-verity-verify-sig.h

-- 
2.17.1

