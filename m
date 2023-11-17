Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967EF7EF59B
	for <lists+linux-security-module@lfdr.de>; Fri, 17 Nov 2023 16:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjKQPtg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 17 Nov 2023 10:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjKQPtf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Nov 2023 10:49:35 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C6B9
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:31 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab7badadeso2857175276.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Nov 2023 07:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700236170; x=1700840970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GWzjwemHVnboIvAGDjxXzY657GUx5oZnM/Gu7ZKaHIQ=;
        b=lmUCtJFf9olJFIQtqTPLeCHEpZd9czIvodLADKZSr1BbqPITi/NkJMFi2fKMI4YSO7
         bqYsmh7V1ybGzQEk9+ADD0cCCbjXR8B/dr3Ia5ZQsrOeAVdMZDfzSiBBB2qorx6iqBvU
         GdXPXmTMqk5Rw17RO+s92zFfbc6xGlPozwNnmqm79daqkRmz8fQ+QLVB2Zx9F6Rv290k
         108T46o/iykwViG/eoovdykIZQs6uuumY8NtMyzt0fV68KJRca9KqLkuQgLdGMzNxfDR
         A9zt8rBHV9wXqKOijgIBxL0FyzzHQMzXiNl0W8xzByIICiHzsmUJguv5svPhtvcX7pdK
         XuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700236170; x=1700840970;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWzjwemHVnboIvAGDjxXzY657GUx5oZnM/Gu7ZKaHIQ=;
        b=a6FKFvVWL8XR4X8de4JgWzzqebDtZxTjPdtCXs2ZPaQe6H0/yeNfG/qCc5/Svqudvj
         4/keZo3rc2DERjMcqxwOKcKDC6sfC7tyP5aMcjAdt4kMqDcH81bA9s4aBTpw3zHS2iiF
         8ufAuqloUuBe9u+j4Iev3YbXrQmnnkgN1sgQyewcCDKULXKGnfrFark0hzUzfJA8FTPm
         VvnlBkZIQ0zAUj1zdAahm8Kx6JfNKtHDHipyXeWBe1qntRRhC2cDqHal2zeJnAWUMWO1
         wHG2nog1ABYEf2Bt+rVQb5JUfdVLjQkXkIaZBx52rBwu4+xRsqv1GTJq85FtDFkin77s
         GWxw==
X-Gm-Message-State: AOJu0YyuwJZuhkVImPmMMei7IjMtdUEVZkrTjqJDCmr3O0oF9A71DpJX
        Gm0TZQaX+BZvIGNNombV8QS3f5TCl+d4MCUW9N3ds2Lb05OC3x3c8v9j92t+AeI5lPUtDup9I9+
        FHB6/APHO5g5vpvEh4slwvx0gp4nLSniZV6k4s3g8WstbTcofXBnOCKcbZkcR5bQkdu/YtP0gWb
        GVZ981EQ==
X-Google-Smtp-Source: AGHT+IG8N06sNWEAwsciTDeTJSXl7GG6VCv8pn/6vMdz/sg2CymlKqAzK4WCzrKJajC39uqhSJsU7MN0zBI=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a25:d7c4:0:b0:d9a:4f4c:961b with SMTP id
 o187-20020a25d7c4000000b00d9a4f4c961bmr463055ybg.1.1700236170109; Fri, 17 Nov
 2023 07:49:30 -0800 (PST)
Date:   Fri, 17 Nov 2023 16:49:13 +0100
Message-Id: <20231117154920.1706371-1-gnoack@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v5 0/7] Landlock: IOCTL support
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hello!

These patches add simple ioctl(2) support to Landlock.

Objective
~~~~~~~~~

Make ioctl(2) requests restrictable with Landlock,
in a way that is useful for real-world applications.

Proposed approach
~~~~~~~~~~~~~~~~~

Introduce the LANDLOCK_ACCESS_FS_IOCTL right, which restricts the use
of ioctl(2) on file descriptors.

We attach IOCTL access rights to opened file descriptors, as we
already do for LANDLOCK_ACCESS_FS_TRUNCATE.

If LANDLOCK_ACCESS_FS_IOCTL is handled (restricted in the ruleset),
the LANDLOCK_ACCESS_FS_IOCTL access right governs the use of all IOCTL
commands.

We make an exception for the common and known-harmless IOCTL commands
FIOCLEX, FIONCLEX, FIONBIO and FIONREAD.  These IOCTL commands are
always permitted.  Their functionality is already available through
fcntl(2).

If additionally(!), the access rights LANDLOCK_ACCESS_FS_READ_FILE,
LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_DIR are
handled, these access rights also unlock some IOCTL commands which are
considered safe for use with files opened in these ways.

As soon as these access rights are handled, the affected IOCTL
commands can not be permitted through LANDLOCK_ACCESS_FS_IOCTL any
more, but only be permitted through the respective more specific
access rights.  A full list of these access rights is listed below in
this cover letter and in the documentation.

I believe that this approach works for the majority of use cases, and
offers a good trade-off between Landlock API and implementation
complexity and flexibility when the feature is used.

Current limitations
~~~~~~~~~~~~~~~~~~~

With this patch set, ioctl(2) requests can *not* be filtered based on
file type, device number (dev_t) or on the ioctl(2) request number.

On the initial RFC patch set [1], we have reached consensus to start
with this simpler coarse-grained approach, and build additional IOCTL
restriction capabilities on top in subsequent steps.

[1] https://lore.kernel.org/linux-security-module/d4f1395c-d2d4-1860-3a02-2=
a0c023dd761@digikod.net/

Notable implications of this approach
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Existing inherited file descriptors stay unaffected
  when a program enables Landlock.

  This means in particular that in common scenarios,
  the terminal's IOCTLs (ioctl_tty(2)) continue to work.

* ioctl(2) continues to be available for file descriptors acquired
  through means other than open(2).  Example: Network sockets,
  memfd_create(2), file descriptors that are already open before the
  Landlock ruleset is enabled.

Examples
~~~~~~~~

Starting a sandboxed shell from $HOME with samples/landlock/sandboxer:

  LL_FS_RO=3D/ LL_FS_RW=3D. ./sandboxer /bin/bash

The LANDLOCK_ACCESS_FS_IOCTL right is part of the "read-write" rights
here, so we expect that newly opened files outside of $HOME don't work
with most IOCTL commands.

  * "stty" works: It probes terminal properties

  * "stty </dev/tty" fails: /dev/tty can be reopened, but the IOCTL is
    denied.

  * "eject" fails: ioctls to use CD-ROM drive are denied.

  * "ls /dev" works: It uses ioctl to get the terminal size for
    columnar layout

  * The text editors "vim" and "mg" work.  (GNU Emacs fails because it
    attempts to reopen /dev/tty.)

IOCTL groups
~~~~~~~~~~~~

To decide which IOCTL commands should be blanket-permitted we went
through the list of IOCTL commands mentioned in fs/ioctl.c and looked
at them individually to understand what they are about.  The following
list is for reference.

We should always allow the following IOCTL commands, which are also
available through fcntl(2) with the F_SETFD and F_SETFL commands:

 * FIOCLEX, FIONCLEX - these work on the file descriptor and
   manipulate the close-on-exec flag
 * FIONBIO, FIOASYNC - these work on the struct file and enable
   nonblocking-IO and async flags

The following command is guarded and enabled by either of
LANDLOCK_ACCESS_FS_WRITE_FILE, LANDLOCK_ACCESS_FS_READ_FILE or
LANDLOCK_ACCESS_FS_READ_DIR (G2), once one of them is handled
(otherwise by LANDLOCK_ACCESS_FS_IOCTL):

 * FIOQSIZE - get the size of the opened file

The following commands are guarded and enabled by either of
LANDLOCK_ACCESS_FS_WRITE_FILE or LANDLOCK_ACCESS_FS_READ_FILE (G2),
once one of them is handled (otherwise by LANDLOCK_ACCESS_FS_IOCTL):

These are commands that read file system internals:

 * FS_IOC_FIEMAP - get information about file extent mapping
   (c.f. https://www.kernel.org/doc/Documentation/filesystems/fiemap.txt)
 * FIBMAP - get a file's file system block number
 * FIGETBSZ - get file system blocksize

The following commands are guarded and enabled by
LANDLOCK_ACCESS_FS_READ_FILE (G3), if it is handled (otherwise by
LANDLOCK_ACCESS_FS_IOCTL):

 * FIONREAD - get the number of bytes available for reading (the
   implementation is defined per file type)
 * FIDEDUPRANGE - manipulating shared physical storage between files.

The following commands are guarded and enabled by
LANDLOCK_ACCESS_FS_WRITE_FILE (G4), if it is handled (otherwise by
LANDLOCK_ACCESS_FS_IOCTL):

 * FICLONE, FICLONERANGE - making files share physical storage between
   multiple files.  These only work on some file systems, by design.
 * FS_IOC_RESVSP, FS_IOC_RESVSP64, FS_IOC_UNRESVSP, FS_IOC_UNRESVSP64,
   FS_IOC_ZERO_RANGE: Backwards compatibility with legacy XFS
   preallocation syscalls which predate fallocate(2).

The following commands are also mentioned in fs/ioctl.c, but are not
handled specially and are managed by LANDLOCK_ACCESS_FS_IOCTL together
with all other remaining IOCTL commands:

 * FIFREEZE, FITHAW - work on superblock(!) to freeze/thaw the file
   system. Requires CAP_SYS_ADMIN.
 * Accessing file attributes:
   * FS_IOC_GETFLAGS, FS_IOC_SETFLAGS - manipulate inode flags (ioctl_iflag=
s(2))
   * FS_IOC_FSGETXATTR, FS_IOC_FSSETXATTR - more attributes

Related Work
~~~~~~~~~~~~

OpenBSD's pledge(2) [2] restricts ioctl(2) independent of the file
descriptor which is used.  The implementers maintain multiple
allow-lists of predefined ioctl(2) operations required for different
application domains such as "audio", "bpf", "tty" and "inet".

OpenBSD does not guarantee ABI backwards compatibility to the same
extent as Linux does, so it's easier for them to update these lists in
later versions.  It might not be a feasible approach for Linux though.

[2] https://man.openbsd.org/OpenBSD-7.3/pledge.2

Changes
~~~~~~~

V5:
 * Implementation:
   * move IOCTL group expansion logic into fs.c (implementation suggested b=
y
     mic)
   * rename IOCTL_CMD_G* constants to LANDLOCK_ACCESS_FS_IOCTL_GROUP*
   * fs.c: create ioctl_groups constant
   * add "const" to some variables
 * Formatting and docstring fixes (including wrong kernel-doc format)
 * samples/landlock: fix ABI version and fallback attribute (mic)
 * Documentation
   * move header documentation changes into the implementation commit
   * spell out how FIFREEZE, FITHAW and attribute-manipulation ioctls from
     fs/ioctl.c are handled
   * change ABI 4 to ABI 5 in some missing places
  =20
V4:
 * use "synthetic" IOCTL access rights, as previously discussed
 * testing changes
   * use a large fixture-based test, for more exhaustive coverage,
     and replace some of the earlier tests with it
 * rebased on mic-next

V3:
 * always permit the IOCTL commands FIOCLEX, FIONCLEX, FIONBIO, FIOASYNC an=
d
   FIONREAD, independent of LANDLOCK_ACCESS_FS_IOCTL
 * increment ABI version in the same commit where the feature is introduced
 * testing changes
   * use FIOQSIZE instead of TTY IOCTL commands
     (FIOQSIZE works with regular files, directories and memfds)
   * run the memfd test with both Landlock enabled and disabled
   * add a test for the always-permitted IOCTL commands

V2:
 * rebased on mic-next
 * added documentation
 * exercise ioctl(2) in the memfd test
 * test: Use layout0 for the test

---

V1: https://lore.kernel.org/linux-security-module/20230502171755.9788-1-gno=
ack3000@gmail.com/
V2: https://lore.kernel.org/linux-security-module/20230623144329.136541-1-g=
noack@google.com/
V3: https://lore.kernel.org/linux-security-module/20230814172816.3907299-1-=
gnoack@google.com/
V4: https://lore.kernel.org/linux-security-module/20231103155717.78042-1-gn=
oack@google.com/

G=C3=BCnther Noack (7):
  landlock: Optimize the number of calls to get_access_mask slightly
  landlock: Add IOCTL access right
  selftests/landlock: Test IOCTL support
  selftests/landlock: Test IOCTL with memfds
  selftests/landlock: Test ioctl(2) and ftruncate(2) with open(O_PATH)
  samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
  landlock: Document IOCTL support

 Documentation/userspace-api/landlock.rst     |  74 ++-
 include/uapi/linux/landlock.h                |  58 ++-
 samples/landlock/sandboxer.c                 |  13 +-
 security/landlock/fs.c                       | 150 +++++-
 security/landlock/fs.h                       |  11 +
 security/landlock/limits.h                   |  15 +-
 security/landlock/ruleset.c                  |   5 +-
 security/landlock/ruleset.h                  |   2 +-
 security/landlock/syscalls.c                 |  10 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 498 ++++++++++++++++++-
 11 files changed, 789 insertions(+), 49 deletions(-)


base-commit: f12f8f84509a084399444c4422661345a15cc713
--=20
2.43.0.rc1.413.gea7ed67945-goog

