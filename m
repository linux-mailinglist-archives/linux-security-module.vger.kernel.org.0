Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173F2597487
	for <lists+linux-security-module@lfdr.de>; Wed, 17 Aug 2022 18:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiHQQuT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 17 Aug 2022 12:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbiHQQty (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Aug 2022 12:49:54 -0400
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085747E329
        for <linux-security-module@vger.kernel.org>; Wed, 17 Aug 2022 09:49:51 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4M7DWx1mbZzMpp3C;
        Wed, 17 Aug 2022 18:49:49 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4M7DWw5fxgzlqwwc;
        Wed, 17 Aug 2022 18:49:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1660754989;
        bh=nq1DdW2pNinPQGbPhawokMPbx8tQLJR7cigpQW/6b6o=;
        h=Date:From:To:Cc:Subject:From;
        b=TEmgI5+0rqKSnzHmE7BPW+0rAcWhBYoh27IoMb9ynzssj18Ug0HjD7db7SYSuPRg9
         wGSBfBQ6Lm5J/ETZXm6TnayCpmMyU+LmYk0np7c8SBUtSPcQnDT0efmIUqgkt6cOfM
         yP5iazGYIQf1WN0iZk9aUBXbmkzZnBvhQu3XsvA0=
Message-ID: <441bd1cd-03fd-8e30-c370-3d0f0263d564@digikod.net>
Date:   Wed, 17 Aug 2022 18:49:48 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     landlock@lists.linux.dev
Cc:     linux-security-module@vger.kernel.org,
        oss-security@lists.openwall.com
Subject: Landlock news #2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi,

Here is the second Landlock newsletter! It's been a while and there is
some news to catch up.

Official website: https://landlock.io
Previews newsletter:
https://lore.kernel.org/landlock/2df4887a-1710-bba2-f49c-cd5b785bb565@digikod.net/

Kernel
------

### Linux distributions

Landlock is now supported by default in major Linux distributions:
* Alpine Linux
* Arch Linux
* chromeOS (including for Linux 5.10)
* Debian Sid
* Fedora 35
* Ubuntu 20.04 LTS

### New features for Linux 5.19

Linux 5.19 is now released, and it includes some Landlock changes:
https://git.kernel.org/torvalds/c/cb44e4f061e1
The main one being full renaming and linking support thanks to the new
LANDLOCK_ACCESS_FS_REFER access right. This lift one major limitation
that was blocking for more generic sandboxing (e.g., container
runtimes).

This comes with a second Landlock ABI version that should be checked to
leverage Landlock in a best-effort way. See the updated documentation:
https://docs.kernel.org/userspace-api/landlock.html
If developers don't change their ruleset's handled access rights, a
sandboxed application will not change. If they add the new
LANDLOCK_ACCESS_FS_REFER right, then they should first check the ABI
version to make sure it will work as expected:

int abi = landlock_create_ruleset(NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
if (abi < 2) {
     ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
}
path_beneath_attr.allowed_access &= ruleset_attr.handled_access_fs;

### Backports

A too-restrictive filesystem control for a rare corner case was fixed
and backported down to Linux 5.13:
https://git.kernel.org/stable/c/8ba0005ff418
The backports also include more tests to check ABI stability, and the
maximum number of nested sandboxes is now down to 16:
https://git.kernel.org/stable/c/75c542d6c6cc

User space
----------

We are currently brainstorming about how to make libraries properly and
easily handle compatibility for several kernel versions:
https://lore.kernel.org/landlock/7290b021-c90f-76e9-7868-ed612595b411@digikod.net/

### Go library

As described by Günther Noack, go-landlock added support for Landlock
ABI v2 and the LANDLOCK_ACCESS_FS_REFER flag. Usage example:

err := landlock.V2.RestrictPaths(
     landlock.RWDirs("/src", "/dest").WithRefer(),
)

See the documentation:
https://pkg.go.dev/github.com/landlock-lsm/go-landlock/landlock

### Rust library

There is some work going on for the Rust library. There is new
documentation, test coverage improvements, CI checks with different
kernel versions, API improvements, and new helpers to make it easier for
common use cases (while leveraging the strong type system). Usage
example:

let abi = ABI::V1;
let status = Ruleset::new()
     .handle_access(AccessFs::from_all(abi))?
     .create()?
     // Read-only access to /usr, /etc and /dev.
     .add_rules(path_beneath_rules(&["/usr", "/etc", "/dev"], 
AccessFs::from_read(abi)))?
     // Read-write access to /home and /tmp.
     .add_rules(path_beneath_rules(&["/home", "/tmp"], 
AccessFs::from_all(abi)))?
     .restrict_self()?;

There is still some room for improvements with syntactic sugar, but the
priority is to make the compatibility (with different kernel versions)
flexible, easy to handle and future-proof:
https://github.com/landlock-lsm/rust-landlock/pull/12

We plan to release a new version in the coming weeks, but in the
meantime, you can try the development branch which is much easier to use
than the currently released version:
https://doc.rust-lang.org/cargo/reference/specifying-dependencies.html#specifying-dependencies-from-git-repositories
See the new documentation: https://landlock.io/rust-landlock/landlock/

### New Landlock users

New sandbox manager and library support:
* A Pledge and Unveil implementation for Linux (with the Cosmopolitan
   libc): https://justine.lol/pledge/
* Minijail:
 
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/platform/minijail/landlock_util.h
* exile.h (header-only sandboxing library):
   https://github.com/quitesimpleorg/exile.h

New open-source software using or working on supporting Landlock:
* Game of Trees (version control system):
 
https://git.gameoftrees.org/gitweb/?p=got-portable.git;a=blob;f=compat/landlock.c
* Suricata (network IDS): https://github.com/OISF/suricata/pull/7697
* Landlock Make (zero-configuration sandboxing for hermetic builds):
   https://justine.lol/make/

Please let me know if I missed other Landlock users.

Conferences
-----------

I gave two talks about Landlock. One about the new Landlock features
brought by Linux 5.19 and the other about practical example of how to
sandbox an application.

### Update on Landlock: Lifting the File Reparenting Limits and 
Supporting Network Rules

The Linux Security Summit North America talk is about the lifting of
some Landlock limitations due to incremental development. One of the
most annoying limitations, especially for generic containers, is the
inability to change the parent directory of a file e.g., with rename(2)
or link(2). In the first part, we explain what the related challenges
were and how we can now use the new LANDLOCK_ACCESS_FS_REFER right to
allow renaming and linking without risking bypassing the security
policy. File system access control is required to protect data, but
network access control is also very important. In the second part, we
talk about the upcoming network access control support that will enable
us to create simple app-centric or container firewalls.
https://sched.co/11MXq
https://youtu.be/MWjW-QwK_ZA

### Sandboxing your application with Landlock, illustration with the 
p7zip case

The Pass the Salt talk quickly introduces the main Landlock properties,
and we then explain how to sandbox your own application. We use p7zip, a
C++ archive manager, as a practical example.
https://cfp.pass-the-salt.org/pts2022/talk/BGQGZC/

Unconstrained access and ongoing development
--------------------------------------------

One important thing to keep in mind about Landlock is that it is an
incremental development, and it is not complete yet, but still useful
(especially in combination with seccomp to deny some access types). See
the Pledge implementation on Linux for such example. It should be noted
that this also has limits: https://blog.gnoack.org/post/pledge-on-linux/

One step in this journey is to control access to truncate operations.
Günther Noack is implementing such a feature which should be merged
soon:
https://lore.kernel.org/all/20220814192603.7387-1-gnoack3000@gmail.com/

Konstantin Meskhidze is working on the initial network implementation
which will bring two new access rights (TCP_BIND and TCP_CONNECT):
https://lore.kernel.org/all/20220621082313.3330667-1-konstantin.meskhidze@huawei.com/

There are still some unanswered questions about the best approach to
restrict UDP:
https://lore.kernel.org/all/a5ef620d-0447-3d58-d9bd-1220b8411957@digikod.net/
Feel free to reply to this thread.

Roadmap
-------

And finally, an update on the Landlock kernel roadmap.

Short term:
* add audit features to ease debugging;
* add minimal network access-control types;
* add minimal process signaling access-control types;
* improve kernel performance for the current features;

Medium term:
* extend filesystem access-control types to address the current
   limitations;
* add the ability to follow a deny listing approach, which is required
   for some use cases.
* extend network access-control types;

Long term:
* add the ability to create (file descriptor) capabilities compatible
   with Capsicum.

Regards,
  Mickaël
