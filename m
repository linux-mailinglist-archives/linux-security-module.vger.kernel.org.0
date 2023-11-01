Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8307DE030
	for <lists+linux-security-module@lfdr.de>; Wed,  1 Nov 2023 12:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjKALNj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 1 Nov 2023 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKALNi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Nov 2023 07:13:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A450F7;
        Wed,  1 Nov 2023 04:13:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5860EC433C9;
        Wed,  1 Nov 2023 11:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698837215;
        bh=N6UVVns/VSWJvvvj6Jyp/eMunRO6kModQGgkQaRIaQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sy4Rxi2OPF+XMY89X0x7G4Df22/7CmUQqn3N+1UFEGdivQpNgTMq7V0eFIjbhlHy4
         NJ+SneIU7hLdENdE8i3xuGqt0DWisuf6j6dMTpH7rt7+f+c2HLH/QpGZmSSy3tDHAo
         jkWxzsSGXF/Iy/Fvavj8jPNeeb2Hjqn3mLGNLuoWIjzIktyHko0WNwy7mYWoooIl2x
         RqL8ijcizyWd4X8B4FZ6xFYCT5zjiKLKFbOmKaggI1Nb8kxSM5Sz8h+dl8NYx6VOAr
         AJ3E120jL+X3i0qStXrxsrApc40u3MiIjSxus9h6cZ4HXOQZHOtSo4SzklF7i/nZHc
         NuRLHu3IY++mg==
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] querying mount attributes
Date:   Wed,  1 Nov 2023 12:13:22 +0100
Message-Id: <20231101-urenkel-banal-b232d7a3cbe8@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2563; i=brauner@kernel.org; h=from:subject:message-id; bh=N6UVVns/VSWJvvvj6Jyp/eMunRO6kModQGgkQaRIaQ8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ6GZ289OXCtbZoBr++dRPd5U8zfzd2E9PQv/qguNnzmCyb I9fzjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImsX8nI8G7S4mBTpv1PprLka33dfK jgxsVD9lziqkscTjw5GpmzpZuRYbnXm9lXvtvfKju9Ii6KS9eKb9+Pl6nfWMLjLzsILdXeywYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 25 Oct 2023 16:01:58 +0200, Miklos Szeredi wrote:
> Implement mount querying syscalls agreed on at LSF/MM 2023.
> 
> Features:
> 
>  - statx-like want/got mask
>  - allows returning ascii strings (fs type, root, mount point)
>  - returned buffer is relocatable (no pointers)
> 
> [...]

I think we should start showing clear signs of commitment to this. In
absence of strong objections I don't see a reason to let this rot on
list until we forget about it. Maybe this will entice people to provide
more reviews as well.

It's all pretty close to what we discussed at LSFMM23 and we stated that
we aim to merge something by the end of the year. Let's see if that can
actually happen.

I don't have huge quarrels with this. Yes, there's stuff I'd like to see
done differently but nothing I consider blockers. So let's get this
into -next once rc1 is out so it can get a full cycle of exposure.

I've renamed struct statmnt to struct statmount to align with statx()
and struct statx. I also renamed struct stmt_state to struct kstatmount
as that's how we usually do this. And I renamed struct __mount_arg to
struct mnt_id_req and dropped the comment. Libraries can expose this in
whatever form they want but we'll also have direct consumers. I'd rather
have this struct be underscore free and officially sanctioned.

---

Applied to the vfs.mount branch of the vfs/vfs.git tree.
Patches in the vfs.mount branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.master

[1/6] add unique mount ID
      https://git.kernel.org/vfs/vfs/c/ec873c3baa0c
[2/6] mounts: keep list of mounts in an rbtree
      https://git.kernel.org/vfs/vfs/c/f15247ad234c
[3/6] namespace: extract show_path() helper
      https://git.kernel.org/vfs/vfs/c/6e5f64ac5382
[4/6] add statmount(2) syscall
      https://git.kernel.org/vfs/vfs/c/edf3b2ac1bd5
[5/6] add listmount(2) syscall
      https://git.kernel.org/vfs/vfs/c/4412ca803757
[6/6] wire up syscalls for statmount/listmount
      https://git.kernel.org/vfs/vfs/c/d0a56e829d2c
