Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED81F8D3D
	for <lists+linux-security-module@lfdr.de>; Mon, 15 Jun 2020 07:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgFOFVl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 15 Jun 2020 01:21:41 -0400
Received: from namei.org ([65.99.196.166]:38108 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgFOFVl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 15 Jun 2020 01:21:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 05F5LW2f009419;
        Mon, 15 Jun 2020 05:21:32 GMT
Date:   Mon, 15 Jun 2020 15:21:32 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
In-Reply-To: <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.2006151517230.9003@namei.org>
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com> <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com> <CAJ-EccPGQ62yMK1Nmvie4qWzproSqb4POwAD4_0Nt62KLbGhqg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 14 Jun 2020, Micah Morton wrote:

> This patch was sent to the security mailing list and there were no objections.

Standard practice for new or modified LSM hooks is that they are reviewed 
and acked by maintainers of major LSMs (SELinux, AppArmor, and Smack, at 
least).

"No objections" should be considered "not reviewed".

Can you add your tree to linux-next?
https://www.kernel.org/doc/man-pages/linux-next.html

-- 
James Morris
<jmorris@namei.org>

