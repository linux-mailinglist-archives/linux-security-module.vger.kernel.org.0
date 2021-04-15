Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80D5361010
	for <lists+linux-security-module@lfdr.de>; Thu, 15 Apr 2021 18:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhDOQXi (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 15 Apr 2021 12:23:38 -0400
Received: from namei.org ([65.99.196.166]:43726 "EHLO mail.namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOQXi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Apr 2021 12:23:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id BC10C4E1;
        Thu, 15 Apr 2021 16:19:35 +0000 (UTC)
Date:   Fri, 16 Apr 2021 02:19:35 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     linux-kernel@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] security: commoncap: clean up kernel-doc comments
In-Reply-To: <20210412005528.3326-1-rdunlap@infradead.org>
Message-ID: <f1b7edf3-2df-64c-91a5-f9989b745136@namei.org>
References: <20210412005528.3326-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, 11 Apr 2021, Randy Dunlap wrote:

> Fix kernel-doc notation in commoncap.c.
> 
> Use correct (matching) function name in comments as in code.
> Use correct function argument names in kernel-doc comments.
> Use kernel-doc's "Return:" format for function return values.
> 
> Fixes these kernel-doc warnings:
> 
> ../security/commoncap.c:1206: warning: expecting prototype for cap_task_ioprio(). Prototype was for cap_task_setioprio() instead
> ../security/commoncap.c:1219: warning: expecting prototype for cap_task_ioprio(). Prototype was for cap_task_setnice() instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: linux-security-module@vger.kernel.org

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.12

-- 
James Morris
<jmorris@namei.org>

