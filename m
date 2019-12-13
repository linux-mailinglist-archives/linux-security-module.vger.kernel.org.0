Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34B6411EAB5
	for <lists+linux-security-module@lfdr.de>; Fri, 13 Dec 2019 19:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbfLMStT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 13 Dec 2019 13:49:19 -0500
Received: from namei.org ([65.99.196.166]:37392 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbfLMStS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Dec 2019 13:49:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id xBDImkv5010187;
        Fri, 13 Dec 2019 18:48:46 GMT
Date:   Sat, 14 Dec 2019 05:48:46 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
In-Reply-To: <CAFqZXNv=AnPxHuQCusoJQGEJ8Q+yF7_TPBCRyAcE5OPzoYFc9w@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1912140547490.9693@namei.org>
References: <20191211140833.939845-1-omosnace@redhat.com> <66706222-b6af-5099-e485-b99391ad70b3@i-love.sakura.ne.jp> <CAFqZXNv=AnPxHuQCusoJQGEJ8Q+yF7_TPBCRyAcE5OPzoYFc9w@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 12 Dec 2019, Ondrej Mosnacek wrote:

> I'd say the burden of implementing this would lie on the arms of
> whoever prepares the patches for dynamic load/unload.

Correct, and I don't see any such patches being accepted.

Go and look at some exploits, where LSM is used as a rootkit API...


-- 
James Morris
<jmorris@namei.org>

