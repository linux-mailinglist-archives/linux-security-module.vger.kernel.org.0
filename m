Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1CEB75B
	for <lists+linux-security-module@lfdr.de>; Thu, 31 Oct 2019 19:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJaSkl (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 31 Oct 2019 14:40:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34891 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbfJaSki (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 31 Oct 2019 14:40:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6so3076813pln.2
        for <linux-security-module@vger.kernel.org>; Thu, 31 Oct 2019 11:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4ZF1W1bG/Rl8CChrQFOeusHspeNIEyvicA7XRZyNais=;
        b=ToKg4woxb646iL0UBTpW7kOzBulVyPZE8eDKGJRbGidQmuB1kSZuXXGKQrlmhVqoG/
         6mqlKlPwwHbv30/kmrxykMo2JifdPmff3G7Vcjm5igE3zt+aH+NuABmoc8V6qYyGdAUo
         73/woDqeWba6Ad8QQ0T/3wSFBcBSEsb+D3la0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ZF1W1bG/Rl8CChrQFOeusHspeNIEyvicA7XRZyNais=;
        b=e+9MxLcLwDEGZ4Rxt/ybZ+tPQNInHPG6cKTIh54nVdVVIGJMys/cW3ZG6N7TltTaDs
         uHYKoLQPE+oXTFumwu+colmjB5p95Z8N9LFQGkcrRLAEhKhXNA3+A8nBHT6vDg5Mzq89
         8ROH5aRaUOsggcB6fKpOTGDUt6xjmAgnRVcpwfe6FnEvMMIairJrATroN/h5GmvXtC4Y
         rVDm/gzZgLFcARv44DmpKftgH5nWwTFhYnWVHdbRMsdkdk1AKyt+xivRwoHFqPI/25gQ
         hhp4vHKE5lwcTf2SN1nE8XKAZnf8hMIT184xEqaCAGdmlrksJ839bm58avokdZVqfupY
         F9BQ==
X-Gm-Message-State: APjAAAXBqOZAN9YIBuI26+nLezNjkkUF+cGWGrpkK/EyOUBCzx2x/Qu9
        fcg6jAcxEuKkexfwGABEvbn3pw==
X-Google-Smtp-Source: APXvYqzTiXUhiopZUISbbRLvil8rhHffcEWWEBYAGxeX2kHSa42od+2QUV+X5ZsC/43T4hltLWmqWA==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr8047584pld.248.1572547237564;
        Thu, 31 Oct 2019 11:40:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j14sm3913682pfi.168.2019.10.31.11.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:40:36 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:40:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Matthias Maennich <maennich@google.com>,
        shuah <shuah@kernel.org>,
        John Johansen <john.johansen@canonical.com>, jmorris@namei.org,
        serge@hallyn.com, David Gow <davidgow@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <201910311136.BBC4C70B@keescook>
References: <20191018001816.94460-1-brendanhiggins@google.com>
 <20191018122949.GD11244@42.do-not-panic.com>
 <alpine.LRH.2.20.1910191348280.11804@dhcp-10-175-221-34.vpn.oracle.com>
 <CAFd5g46aO4jwyo32DSz4L8GdhP6t38+Qb9NB+3fev3u4G6sg4w@mail.gmail.com>
 <20191024101529.GK11244@42.do-not-panic.com>
 <201910301205.74EC2A226D@keescook>
 <CAAXuY3o31iCJwZ+WGHMaK1MgpC0qv=JkJWnzv8Lhym9TnZQvcQ@mail.gmail.com>
 <CAFd5g446cyijzgap9r8nm_202zkUsfdZXrn5E1_Mfe-R+eFb_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g446cyijzgap9r8nm_202zkUsfdZXrn5E1_Mfe-R+eFb_g@mail.gmail.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Oct 31, 2019 at 02:33:32AM -0700, Brendan Higgins wrote:
> 2) One of the layers in your program is too think, and you should
> introduce a new layer with a new public interface that you can test
> through.
> 
> I think the second point here is problematic with how C is written in
> the kernel. We don't really have any concept of public vs. private
> inside the kernel outside of static vs. not static, which is much more
> restricted.

I don't find "2" to be a convincing argument (as you hint a bit at in
the next paragraph)_. There are lots of things code is depending on
(especially given the kernel's coding style guides about breaking up
large functions into little ones), that you want to test to make sure
is working correctly that has no public exposure, and you want to test
those helper's corner cases which might be hard to (currently) reach via
the higher level public APIs.

-- 
Kees Cook
