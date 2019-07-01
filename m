Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078591A8FE
	for <lists+linux-security-module@lfdr.de>; Sat, 11 May 2019 20:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfEKSNX (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 11 May 2019 14:13:23 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35066 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfEKSNX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 11 May 2019 14:13:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id j20so6316179lfh.2
        for <linux-security-module@vger.kernel.org>; Sat, 11 May 2019 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CWP16Nyxw5qoo1hd2mChxbEzA6Fb4BMPJLsU//Q1vrc=;
        b=kyIAiixp5qZdQKPS40mqarIBWtsGQQbSIaVwYs8g9wa7xANkHruKKuaChRej94Pg/i
         nydybmuTIbEN/nIHH/fFtVf8Pwt/bwxeEFtarsy5916oxBYRM4xUagKe2FPfrzmmCLGH
         jkpUh/MuNTKlmUCyvKbTSzLysX257xss7joIwm+l64AUvzaWNgHzNDHVNk4NWYhpVGwN
         NWGtqNsbujAj0y+U7thWVn/c+tTXI5FYYRUtKUyfiD/XZEYEpqE276/Eq35y7Jeysdkx
         BfvGGfNet6SgoPfcLHe2vdT2RPuWbLXmDF69X/fnGIMk3/kSjPP+x30nFDK0HDaUHLEO
         IS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CWP16Nyxw5qoo1hd2mChxbEzA6Fb4BMPJLsU//Q1vrc=;
        b=hI2GSPTCiCIsT/KmhKGqszbYLRKgPjgu0xN1c6Dkwwkt1j+iqyFsHA96zg2DuqwKBb
         5MgGXzD1LsVwXI/jfRNuHrP1NaMDGrEZ325oeXmA6ryxJSF3FqUDgLWaC/3BIVJ3rT/x
         eRSoxsrYdPlWhwkDWozAcny0pFmKMBL2iL86TuAXUkjnjh8vyjvAY4dS6n9F/J7pPxHI
         qFRA/h7SGlE2E1ni+RVifjwthLKpIu6glV37aO99C7s/6/5ZtZZFKGsWYSKKXfViBYCJ
         VKDKNfX2XNj/Vg01N7EMacuYGlsEUopp+ATjfyNPc1Sg1f5T6d1P/S+jX8W6QmAakVbM
         zdew==
X-Gm-Message-State: APjAAAWxh6h94GRqdG+Hi4IxssPwa8pZoV5qdpX4ldpdoI0Kf1/6qnAL
        JIirzUBdfWiIfKVyhrNz7GLY7ipDiTyTH0X7a004WMjZ8ghd
X-Google-Smtp-Source: APXvYqyPZ06o+XO2LbPfsvUMqGLt/5r1ZRgUHok6ntDskfjhMm4IfhhujC45DdXbYCEHwKZO26Dprgpr44MS9YDq6Fk=
X-Received: by 2002:a19:760c:: with SMTP id c12mr9090091lff.105.1557598400815;
 Sat, 11 May 2019 11:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1905110801350.9392@namei.org> <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
In-Reply-To: <CAHk-=wg8UFHD_KmTWF3LMnDf_VN7cv_pofpc4eOHmx_8kmMPWw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 11 May 2019 14:13:09 -0400
Message-ID: <CAHC9VhSSwYk6isqz8N3nOO_O17C30E2EyCHKf5OqsdESeMoT7g@mail.gmail.com>
Subject: Re: [GIT PULL] security subsystem: Tomoyo updates for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Morris <jmorris@namei.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sat, May 11, 2019 at 10:38 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, May 10, 2019 at 6:09 PM James Morris <jmorris@namei.org> wrote:
> >
> > These patches include fixes to enable fuzz testing, and a fix for
> > calculating whether a filesystem is user-modifiable.
>
> So now these have been very recently rebased (on top of a random
> merge-window "tree of the day" version) instead of having multiple
> merges.
>
> That makes the history cleaner, but has its own issues.
>
> We really need to find a different model for the security layer patches.

If it helps, the process I use for the SELinux and audit trees is
documented below.  While it's far from perfect (I still don't like
basing the -next trees on -rcX releases) it has seemed to work
reasonably well for some time now.

* https://github.com/SELinuxProject/selinux-kernel/blob/master/README.md

-- 
paul moore
www.paul-moore.com
