Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F229C1EC59F
	for <lists+linux-security-module@lfdr.de>; Wed,  3 Jun 2020 01:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFBXZm (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 2 Jun 2020 19:25:42 -0400
Received: from namei.org ([65.99.196.166]:40580 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgFBXZm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 2 Jun 2020 19:25:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 052NPTYc023408;
        Tue, 2 Jun 2020 23:25:29 GMT
Date:   Wed, 3 Jun 2020 09:25:29 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Stefan Hajnoczi <stefanha@redhat.com>
cc:     linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] capabilities: add description for CAP_SETFCAP
In-Reply-To: <20200602091728.10843-1-stefanha@redhat.com>
Message-ID: <alpine.LRH.2.21.2006030925190.23005@namei.org>
References: <20200602091728.10843-1-stefanha@redhat.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 2 Jun 2020, Stefan Hajnoczi wrote:

> Document the purpose of CAP_SETFCAP.  For some reason this capability
> had no description while the others did.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general


-- 
James Morris
<jmorris@namei.org>

