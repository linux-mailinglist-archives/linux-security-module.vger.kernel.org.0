Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E988451CBF
	for <lists+linux-security-module@lfdr.de>; Mon, 24 Jun 2019 23:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfFXVGN (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 24 Jun 2019 17:06:13 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38348 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfFXVGM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jun 2019 17:06:12 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so4130033ioa.5
        for <linux-security-module@vger.kernel.org>; Mon, 24 Jun 2019 14:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qsiy4GMqJp8OpN08sGtvyRN/iizHHt1yJkFR39fo0EA=;
        b=AfDiePpE+a5nc6qa49QzPgmPwYggmKliwXdfvpiy7UQT/bVYNMVaOHV5Ktwh3u+YUZ
         +TdIpcDQJUBkv2lxbRtRSmOVLI61Bn2aAW6Ge+Zai32LvXsxsfx/7ELuMHRfwC99S6Go
         dHCihXe0aU2qgLK9jYy1cMsDvX4VYUuST3O5ovrC4/4nIJvAnWOfLCgzSHAUGZJD6qw8
         /y/t/UNGfybachMS13UMBQ6y4dgTFO/ohApf7LqGxuz2ujPoOg2QR4xhW+QEvV96SQWk
         khL/qDDPTdLoAmVKwNzNqFqoYISbEZ2ipCgj/ZomTocT/BQlHHuLS3qx6qdl2R/NSCUt
         89Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qsiy4GMqJp8OpN08sGtvyRN/iizHHt1yJkFR39fo0EA=;
        b=DS6HqpmI9WUCTF+RCcOVdYubNpmeoNoqQMwaSofXNkKdMFomM1Vf3hgjxBNl3HL/BG
         KVmGnEz20GRDt8MEwXpyp0XsMh/6KwsONabGGWnYvrlSoXn0EmmMQli/tHz9GFk7tD+g
         aXpDutBcbAzzQeQSkKh4LQnUF8PhlC54VncKX4Ioz5cl0LkWmY0JMFUerHhk8i+RcLV0
         6aHQm6qEuiwsgs4eE6jSdWbTlKOZRX24+pOoU7oLQuAqwE4vn/fuh+E90YmgpWSL1zBO
         2Gg+BwTs6SUSdmJP+EDtpPb86GR1+685CZZ4DNb+nMlufJ+KnsM1QMCEom1jK9edrBoJ
         KLBw==
X-Gm-Message-State: APjAAAVz0PBo0FILiFAIgrkKY5ny/12JRbXB7qDlONaLWbWhM/zhwAO9
        1Mnkkl9zGsNUKOXHzMmxPLQPHzJG1ckdrk4mj9U1/g==
X-Google-Smtp-Source: APXvYqwv4riJcpp85SGhSbO9g75WovIl5ds69I6e8yCEhOaWFyb3mGnt+TYj+cuUzPOyZ5lIXy/KTsrYc1TP3QArKeA=
X-Received: by 2002:a6b:f114:: with SMTP id e20mr39290067iog.169.1561410371602;
 Mon, 24 Jun 2019 14:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com> <20190621064340.GB4528@localhost.localdomain>
 <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com> <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 24 Jun 2019 14:06:00 -0700
Message-ID: <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Jiri Bohac <jbohac@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jun 23, 2019 at 6:52 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 06/21/19 at 01:18pm, Matthew Garrett wrote:
> > I don't think so - we want it to be possible to load images if they
> > have a valid signature.
>
> I know it works like this way because of the previous patch.  But from
> the patch log "When KEXEC_SIG is not enabled, kernel should not load
> images", it is simple to check it early for !IS_ENABLED(CONFIG_KEXEC_SIG) &&
> kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)  instead of depending
> on the late code to verify signature.  In that way, easier to
> understand the logic, no?

But that combination doesn't enforce signature validation? We can't
depend on !IS_ENABLED(CONFIG_KEXEC_SIG_FORCE) because then it'll
enforce signature validation even if lockdown is disabled.
