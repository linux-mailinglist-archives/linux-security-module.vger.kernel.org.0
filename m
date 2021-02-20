Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D47C320353
	for <lists+linux-security-module@lfdr.de>; Sat, 20 Feb 2021 03:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBTC4f (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 19 Feb 2021 21:56:35 -0500
Received: from namei.org ([65.99.196.166]:53830 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhBTC4f (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 19 Feb 2021 21:56:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 9011F67;
        Sat, 20 Feb 2021 02:54:04 +0000 (UTC)
Date:   Sat, 20 Feb 2021 13:54:04 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com
Subject: Re: security_task_getsecid() and subjective vs objective task
 creds
In-Reply-To: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
Message-ID: <67cacc61-4d6a-39d5-f2c0-5530e8d1e39@namei.org>
References: <CAHC9VhSiq5gqY1bfouia4GwYsE9MGGXnUOqwEtHi2u0-1=8aZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 18 Feb 2021, Paul Moore wrote:

> Hi all,
> 
> When looking into a problem I noticed that audit was recording the
> wrong subject label for a process.

Is this a public bug? It would be good to know what the extent of this 
issue may be and whether it warrants a CVE.

-- 
James Morris
<jmorris@namei.org>

