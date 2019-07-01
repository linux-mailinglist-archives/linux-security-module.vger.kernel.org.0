Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3903A2A173
	for <lists+linux-security-module@lfdr.de>; Sat, 25 May 2019 01:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfEXXKQ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 24 May 2019 19:10:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56400 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbfEXXKQ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 May 2019 19:10:16 -0400
Received: from jaskaran-Intel-Server-Board-S1200V3RPS-UEFI-Development-Kit.corp.microsoft.com (unknown [131.107.160.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0B2D720B7192;
        Fri, 24 May 2019 16:04:27 -0700 (PDT)
From:   Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
To:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        jmorris@namei.org, scottsh@microsoft.com
Subject: [PATCH 0/1 v2] Add dm verity root hash pkcs7 sig validation. 
Date:   Fri, 24 May 2019 16:04:10 -0700
Message-Id: <20190524230411.9238-1-jaskarankhurana@linux.microsoft.com>
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

Changelog:
v2:
  - Code review feedback to pass the signature binary blob as a key that can be
    looked up in the kernel and be used to verify the roothash.
    [Suggested by Milan Broz]
  - Made the code related change suggested in review of v1.
    [Suggested by Balbir Singh]

v1:
  - Add kconfigs to control dm-verity root has signature verification and 
    use the signature if specified to verify the root hash.

Jaskaran Khurana (1):
  Adds in-kernel pkcs7 sig checking the roothash of the dm-verity hash
    tree

 drivers/md/Kconfig                |  23 +++++
 drivers/md/Makefile               |   2 +-
 drivers/md/dm-verity-target.c     |  34 +++++++-
 drivers/md/dm-verity-verify-sig.c | 137 ++++++++++++++++++++++++++++++
 drivers/md/dm-verity-verify-sig.h |  31 +++++++
 5 files changed, 222 insertions(+), 5 deletions(-)
 create mode 100644 drivers/md/dm-verity-verify-sig.c
 create mode 100644 drivers/md/dm-verity-verify-sig.h

-- 
2.17.1

