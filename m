Return-Path: <linux-security-module+bounces-6641-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683209D1AA9
	for <lists+linux-security-module@lfdr.de>; Mon, 18 Nov 2024 22:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DFF62826FA
	for <lists+linux-security-module@lfdr.de>; Mon, 18 Nov 2024 21:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AB61E572E;
	Mon, 18 Nov 2024 21:37:06 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC3014D71A
	for <linux-security-module@vger.kernel.org>; Mon, 18 Nov 2024 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965826; cv=none; b=rD2AvAF8WkBJscUzs2wM2G0hta9L7BPwTdJSpZDGpCFojPCw+ZAQtURmEWafFsNknTTEthUjvy4G+ZqXgoUX0JFeeFz0bb3NdtUAHiltLs+qp7gjRfO2kIPNP3yuXFuQuFkwVP7oSGvxWuhLykIN77NcepuIb7k+IczkOOBEWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965826; c=relaxed/simple;
	bh=AD8RL+a16qS304XyMe5fRqoLGy5XqE4pyAEjYUVdeB0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aMZYf2fwPCF4yA0Lb4ZDXXf6zRNeACeRbu5CW/2jlVyatJa8S3iJ3yJQlDEWRRAYvlcWeeGkiYBQcPEx4mdba4F/YTu5qNOVuWynhYlWhfYr7TZ+dHX1vTI+s9/ZY3vP8p1o9pv2LRdKQqOAadF65yXyhTaQZeb0IJ5CnQENWRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a76d10a7dbso13726395ab.0
        for <linux-security-module@vger.kernel.org>; Mon, 18 Nov 2024 13:37:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965824; x=1732570624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nICKXi7/BY4L+b4MgIKYet21aV0bch1WeZjTtJNx1VM=;
        b=lCmI2J/G+fWr6pquLA168di7vxbKRHlmhbRyip1rzFG4INSUxTx8cYv0MJOw2fSnmE
         2mhP2z+cxvZ0eH2PYcTLTEwKKP6nRbY39OP3+XlAHzDd6stzY2nXk8yo6kzxYpkJEQYY
         JSp0MgsVBCeGpM80PXRkppOqB3adBJAuqJ/KuLDkg4KrfaBvetlFIi4zmME1YinzzJGC
         rA0PsPZoimxToLPOVXaxykRiMEkQ7k9MPpddwWPrBI6kEQDRQwrb57nI1l4/D/jc2Ktt
         QgaXVV5ojF92S+9ACMr9R8OOqxB8H/dgdlz5Fq0gAA6j0lGm07oehtxH7h94B5gufpUn
         ZiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0Qh+FxlsuW3/YMtwMlezc0Zb7mSQuOYspIgnO4RazrzphqAZSrHMzJ7W3+8MBh7EVVoo0Dgq1dzm6N64M8qQv+k+mxpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO/AdYs0/nqz8xeT2mTl5CjP1ZyEqcPzbePKxjz9+wuyV/QrRZ
	Nw5UwRi0S5nTmCkCHiQ8Q60gVgYwkn+t64rXj0ozDK8/gYnNsgTFbrBe7pUBW1Tq4skJzaSXj1q
	2/MJ9JihClYfSIgw0izhtnVvUhT+3c0UdWzwiO+G3AAAPdM0E7OL7cnI=
X-Google-Smtp-Source: AGHT+IGJW+n7lvA83sJnLZWBSzq5D53guT7v7kIGh3rmiBABzveN4sxuyZ+8da1KEFDylZ92PG81tcaxMFqjeI71tSx+BKKbO1L+
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2d:b0:3a7:74e1:d54d with SMTP id
 e9e14a558f8ab-3a774e1d777mr22152385ab.21.1731965823827; Mon, 18 Nov 2024
 13:37:03 -0800 (PST)
Date: Mon, 18 Nov 2024 13:37:03 -0800
In-Reply-To: <CAHiZj8j7dp5L_A_nvN4zv9q9qH865MDhhzgEgtZUBMq9H1gPMg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673bb37f.050a0220.87769.005d.GAE@google.com>
Subject: Re: [syzbot] [keyrings?] [lsm?] KASAN: slab-use-after-free Read in key_put
From: syzbot <syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jarkko@kernel.org, jmorris@namei.org, 
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

security/keys/gc.c:146:40: error: 'KEY_IS_DEAD' undeclared (first use in this function); did you mean 'KEY_USR_READ'?


Tested on:

commit:         9fb2cfa4 Merge tag 'pull-ufs' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=55f8591b98dd132
dashboard link: https://syzkaller.appspot.com/bug?extid=6105ffc1ded71d194d6d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1781eac0580000


