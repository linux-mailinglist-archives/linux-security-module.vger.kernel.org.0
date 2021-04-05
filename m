Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E617354201
	for <lists+linux-security-module@lfdr.de>; Mon,  5 Apr 2021 14:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhDEMXe (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 5 Apr 2021 08:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232650AbhDEMXe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 5 Apr 2021 08:23:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01A5D61003;
        Mon,  5 Apr 2021 12:23:23 +0000 (UTC)
Date:   Mon, 5 Apr 2021 14:23:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tyler Hicks <code@tyhicks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>
Subject: Re: LSM and setxattr helpers
Message-ID: <20210405122320.qnjiqlyvzkb2xxi2@wittgenstein>
References: <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein>
 <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz>
 <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxgE_bCK_URCe=_4mBq4_72bazM86D859Kzs_ZoWyKJRhw@mail.gmail.com>
 <CAOQ4uxg+82RLt+KZXVLYhuDvrPLE0zaLf3Nw=oCJ=wBY6j6hTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg+82RLt+KZXVLYhuDvrPLE0zaLf3Nw=oCJ=wBY6j6hTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Apr 04, 2021 at 01:27:21PM +0300, Amir Goldstein wrote:
> [forking question about security modules]
> 
> >
> > Nice thing about vfs_{set,remove}xattr() is that they already have
> > several levels of __vfs_ helpers and nfsd already calls those, so
> > we can hoist fsnotify_xattr() hooks hooks up from the __vfs_xxx
> > helpers to the common vfs_xxx helpers and add fsnotify hooks to
> > the very few callers of __vfs_ helpers.
> >
> > nfsd is consistently calling __vfs_{set,remove}xattr_locked() which
> > do generate events, but ecryptfs mixes __vfs_setxattr_locked() with
> > __vfs_removexattr(), which does not generate event and does not
> > check permissions - it looks like an oversight.
> >
> > The thing is, right now __vfs_setxattr_noperm() generates events,
> > but looking at all the security/* callers, it feels to me like those are
> > very internal operations and that "noperm" should also imply "nonotify".
> >
> > To prove my point, all those callers call __vfs_removexattr() which
> > does NOT generate an event.
> >
> > Also, I *think* the EVM setxattr is something that usually follows
> > another file data/metadata change, so some event would have been
> > generated by the original change anyway.
> >
> > Mimi,
> >
> > Do you have an opinion on that?
> >
> > The question is if you think it is important for an inotify/fanotify watcher
> > that subscribed to IN_ATTRIB/FAN_ATTRIB events on a file to get an
> > event when the IMA security blob changes.
> >
> 
> Guys,
> 
> I was doing some re-factoring of the __vfs_setxattr helpers
> and noticed some strange things.
> 
> The wider context is fsnotify_xattr() hooks inside internal
> setxattr,removexattr calls. I would like to move those hooks
> to the common vfs_{set,remove}xattr() helpers.
> 
> SMACK & SELINUX:
> For the callers of __vfs_setxattr_noperm(),
> smack_inode_setsecctx() and selinux_inode_setsecctx()
> It seems that the only user is nfsd4_set_nfs4_label(), so it
> makes sense for me to add the fsnotify_xattr() in nfsd context,
> same as I did with other fsnotify_ hooks.
> 
> Are there any other expected callers of security_inode_setsecctx()
> except nfsd in the future? If so they would need to also add the
> fsnotify_xattr() hook, if at all the user visible FS_ATTRIB event is
> considered desirable.
> 
> SMACK:
> Just to be sure, is the call to __vfs_setxattr() from smack_d_instantiate()
> guaranteed to be called for an inode whose S_NOSEC flag is already
> cleared? Because the flag is being cleared by __vfs_setxattr_noperm().
> 
> EVM:
> I couldn't find what's stopping this recursion:
> evm_update_evmxattr() => __vfs_setxattr_noperm() =>
> security_inode_post_setxattr() => evm_inode_post_removexattr() =>
> evm_update_evmxattr()
> 
> It looks like the S_NOSEC should already be clear when
> evm_update_evmxattr() is called(?), so it seems more logical to me to
> call __vfs_setxattr() as there is no ->inode_setsecurity() hook for EVM.
> Am I missing something?
> 
> It seems to me that updating the EVM hmac should not generate
> a visible FS_ATTRIB event to listeners, because it is an internal
> implementation detail and because update EVM hmac happens
> following another change to the inode which anyway reports a
> visible event to listeners.
> Also, please note that evm_update_evmxattr() may also call
> __vfs_removexattr() which does not call the fsnotify_xattr() hook.
> 
> IMA:
> Similarly, ima_fix_xattr() should be called on an inode without
> S_NOSEC flag and no other LSM should be interested in the
> IMA hash update, right? So wouldn't it be better to use
> __vfs_setxattr() in this case as well?

It feels like xattr changes that are essentially side-effects of another
operation should probably not generate fsnotify() events in general; at
least not without a good reason why userspace needs to know about the
event.

Christian
