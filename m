Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510D0724D7
	for <lists+linux-security-module@lfdr.de>; Wed, 24 Jul 2019 04:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGXCmy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 23 Jul 2019 22:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfGXCmy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 23 Jul 2019 22:42:54 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D5320828;
        Wed, 24 Jul 2019 02:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563936173;
        bh=DvKFb//NwiSlJFmS8fTpbjuHVD7LocVfvojzT6o2ZrQ=;
        h=Date:From:To:Cc:Subject:From;
        b=kZhYGzDDFxIUXDjBO6Kcgm7wuSpD2a89QvtDZHfqNAWznYmigmUn8/tMr1UtRSbZV
         hF2mGfK73DHaILklKkUqD6zDzM8bfnG0qTMSGRbthjCbBHGJoExuH8H0UkA0jOQx19
         DFbidLtsnYEVFGwb8PU2OdOPDFZmIQ5Mb94dkUR0=
Date:   Tue, 23 Jul 2019 19:42:51 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Reminder: 2 open syzbot bugs in "security/tomoyo" subsystem
Message-ID: <20190724024251.GF643@sol.localdomain>
Mail-Followup-To: linux-security-module@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

[This email was generated by a script.  Let me know if you have any suggestions
to make it better, or if you want it re-generated with the latest status.]

Of the currently open syzbot reports against the upstream kernel, I've manually
marked 2 of them as possibly being bugs in the "security/tomoyo" subsystem. 
I've listed these reports below, sorted by an algorithm that tries to list first
the reports most likely to be still valid, important, and actionable.

If you believe a bug is no longer valid, please close the syzbot report by
sending a '#syz fix', '#syz dup', or '#syz invalid' command in reply to the
original thread, as explained at https://goo.gl/tpsmEJ#status

If you believe I misattributed a bug to the "security/tomoyo" subsystem, please
let me know, and if possible forward the report to the correct people or mailing
list.

Here are the bugs:

--------------------------------------------------------------------------------
Title:              KASAN: use-after-free Read in tomoyo_realpath_from_path
Last occurred:      28 days ago
Reported:           48 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=73d590010454403d55164cca23bd0565b1eb3b74
Original thread:    https://lkml.kernel.org/lkml/0000000000004f43fa058a97f4d3@google.com/T/#u

This bug has a syzkaller reproducer only.

The original thread for this bug has received 7 replies; the last was 31 days
ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+0341f6a4d729d4e0acf1@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/0000000000004f43fa058a97f4d3@google.com

--------------------------------------------------------------------------------
Title:              KASAN: invalid-free in tomoyo_realpath_from_path
Last occurred:      57 days ago
Reported:           56 days ago
Branches:           net-next
Dashboard link:     https://syzkaller.appspot.com/bug?id=e9e5a1d41c3fb5d0f79aeea0e4cd535f160a6702
Original thread:    https://lkml.kernel.org/lkml/000000000000785e9d0589ec359a@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

The original thread for this bug has received 1 reply, 56 days ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+9742b1c6c7aedf18beda@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/000000000000785e9d0589ec359a@google.com

