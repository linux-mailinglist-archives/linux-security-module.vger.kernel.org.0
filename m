Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE84529F2F
	for <lists+linux-security-module@lfdr.de>; Fri, 24 May 2019 21:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbfEXTil (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 24 May 2019 15:38:41 -0400
Received: from namei.org ([65.99.196.166]:34320 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbfEXTil (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 24 May 2019 15:38:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4OJcdxh008796;
        Fri, 24 May 2019 19:38:39 GMT
Date:   Sat, 25 May 2019 05:38:39 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     David Howells <dhowells@redhat.com>
cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] keys: sparse: Fix key_fs[ug]id_changed()
In-Reply-To: <155856409010.10428.11692778420533145488.stgit@warthog.procyon.org.uk>
Message-ID: <alpine.LRH.2.21.1905250538260.7233@namei.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk> <155856409010.10428.11692778420533145488.stgit@warthog.procyon.org.uk>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, 22 May 2019, David Howells wrote:

> Sparse warnings are incurred by key_fs[ug]id_changed() due to unprotected
> accesses of tsk->cred, which is marked __rcu.
> 
> Fix this by passing the new cred struct to these functions from
> commit_creds() rather than the task pointer.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

