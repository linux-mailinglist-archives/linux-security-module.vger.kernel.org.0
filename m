Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB49910F0E5
	for <lists+linux-security-module@lfdr.de>; Mon,  2 Dec 2019 20:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfLBTn6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 2 Dec 2019 14:43:58 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36139 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbfLBTn6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Dec 2019 14:43:58 -0500
Received: by mail-qv1-f67.google.com with SMTP id b18so381935qvy.3
        for <linux-security-module@vger.kernel.org>; Mon, 02 Dec 2019 11:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+qcQW9hWasWaqu6GZWXOVR5TqFK59lILsNn4HqBCK8=;
        b=jijyuc/pIrljftQhFAGwpVV2OycUrD3C4TwYN0tImfdcqjWzDUzoDC3z2746/LiDBO
         hsfeiBxinq6hzNbm+xgMZQIJxctafpIq/lb0tothlCSQzYSV++vLJlcTfd6gKyw7AWkl
         3VgCjX3tCna01G3qMLZvVgMQ6rctVAfv6UxvcS6TmAbAVbsAnWWWxD0Y0+5O4/PO/PHk
         7F99EErLzB+Y8F0OQRjmrFjAIa7OO+ElIdX48gwy3R+8yuz1mS5QxMte2nCuX6tLTIl7
         EJ5qmKnRbrehv5uInpHapaxVLE1kNk3BOfSzuXvA3M9erqyKweAp/mcGw9UzMRgPdyte
         oLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+qcQW9hWasWaqu6GZWXOVR5TqFK59lILsNn4HqBCK8=;
        b=i9GTk6Xm/wbt2uvQlThj0Tv0rU5eKZgPX/D+7hRR4a6Rm11nOZ4pvSuk4r8rWTVHyc
         z4lMu4W6T2Xmx9e0mT2xo75r/2lX/3ZvfxMz77A86e95LjaXiVgqe4S4rxVg2GLPNJ5T
         XJ8nqePQl5KGkeYa5OMOUEUUsb4r4hRaUESleEDDDapfTC5WJnmzmM37atLq3EmZFEby
         aYiviwX+gmGohXE48HH+Oud9QHMp90JgW6NEU0PHJzbJTu1gybt1XBoXUvXe+B7viOw9
         qNBnelkAEA1ofMeM0y8U/vLV+ZuyDbRcts9yqcSMphVfkCHu7x2NqGkh0DnZdDdONPKW
         B2bQ==
X-Gm-Message-State: APjAAAVAoXeLxW49zhLvlvBHlKuTu5ArWLYwyongOgJE86bfvexZGycx
        SxdhHMNqla1Rek3S8oF36LhsvanldgfKAMgna81BYQ5IUKk=
X-Google-Smtp-Source: APXvYqyqvcK7FYM+nJgu5ZdnizdgqVGM5U1CDUpapnEtUJj6PavJUdGNEPoPZZ6avBN+DbR+XTyWRX7f5vLnpUEF4OE=
X-Received: by 2002:a6b:f70e:: with SMTP id k14mr299727iog.169.1575315834593;
 Mon, 02 Dec 2019 11:43:54 -0800 (PST)
MIME-Version: 1.0
References: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
In-Reply-To: <339ca47a-6ed1-4ab4-f8cf-7b205fa9f773@gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 2 Dec 2019 11:43:43 -0800
Message-ID: <CACdnJus-CQPKgL8cW1TAH3u_SSWHBk608tJsx8Uc-dMDPHyRqg@mail.gmail.com>
Subject: Re: [PATCH] Kernel Lockdown: Add an option to allow raw MSR access
 even, in confidentiality mode.
To:     Matt Parnell <mparnell@gmail.com>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        matthew.garrett@nebula.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Nov 29, 2019 at 10:50 PM Matt Parnell <mparnell@gmail.com> wrote:
> For Intel CPUs, some of the MDS mitigations utilize the new "flush" MSR, and
> while this isn't something normally used in userspace, it does cause false
> positives for the "Forshadow" vulnerability.

The msr interface is pretty terrible - it exposes a consistent
interface over very inconsistent CPUs. Where there's CPU functionality
that's implemented via MSRs it makes sense to expose that over a
separate kernel interface.
