Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69213BC70
	for <lists+linux-security-module@lfdr.de>; Mon, 10 Jun 2019 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbfFJTG0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 10 Jun 2019 15:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388544AbfFJTGZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Jun 2019 15:06:25 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED769207E0;
        Mon, 10 Jun 2019 19:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560193585;
        bh=raeylV3VoaIg61MFgkPBLaPp7VUmGTWBluotgx9RhnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hZuAZErpG5I85Y9L/RNGXXEDk5onpPpwOSJKSirowqjMIPKqJlD768Zm1eUWZgUE2
         NYRdIIGy4ViqvgbSIQTIYlrH30SU2uh0YSp8ajgL+e9GXqvfrvrY4+tN8R6HoxVtmw
         15Ksnd1IWZb+Hb+5+elM5sjb2UvKllviGdYxY6Ow=
Date:   Mon, 10 Jun 2019 12:06:23 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     syzbot <syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dan.j.williams@intel.com, ira.weiny@intel.com, jack@suse.cz,
        jhubbard@nvidia.com, jmorris@namei.org, keith.busch@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, richard.weiyang@gmail.com,
        rppt@linux.ibm.com, serge@hallyn.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Subject: [IMA] Re: possible deadlock in get_user_pages_unlocked (2)
Message-ID: <20190610190622.GI63833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001d42b5058a895703@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Jun 04, 2019 at 06:16:00PM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 69d61f577d147b396be0991b2ac6f65057f7d445
> Author: Mimi Zohar <zohar@linux.ibm.com>
> Date:   Wed Apr 3 21:47:46 2019 +0000
> 
>     ima: verify mprotect change is consistent with mmap policy
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1055a2f2a00000
> start commit:   56b697c6 Add linux-next specific files for 20190604
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=1255a2f2a00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1455a2f2a00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4248d6bc70076f7d
> dashboard link: https://syzkaller.appspot.com/bug?extid=e1374b2ec8f6a25ab2e5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165757eea00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dd3e86a00000
> 
> Reported-by: syzbot+e1374b2ec8f6a25ab2e5@syzkaller.appspotmail.com
> Fixes: 69d61f577d14 ("ima: verify mprotect change is consistent with mmap
> policy")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

Hi Mimi, it seems your change to call ima_file_mmap() from
security_file_mprotect() violates the locking order by taking i_rwsem while
mmap_sem is held.

- Eric
