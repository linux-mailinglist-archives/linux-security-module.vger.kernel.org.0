Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342EF1B5135
	for <lists+linux-security-module@lfdr.de>; Thu, 23 Apr 2020 02:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDWAOb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 22 Apr 2020 20:14:31 -0400
Received: from namei.org ([65.99.196.166]:52142 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgDWAOb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 22 Apr 2020 20:14:31 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 03N0ESid031355;
        Thu, 23 Apr 2020 00:14:29 GMT
Date:   Thu, 23 Apr 2020 10:14:28 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
cc:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC] Documentation: LSM: Correct the basic LSM
 description
In-Reply-To: <3d5970b8-f95a-2f15-851a-472cbceb94d4@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.2004231013490.30239@namei.org>
References: <3d5970b8-f95a-2f15-851a-472cbceb94d4.ref@schaufler-ca.com> <3d5970b8-f95a-2f15-851a-472cbceb94d4@schaufler-ca.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, 20 Apr 2020, Casey Schaufler wrote:

> This is a first pass at updating the basic documentation on
> Linux Security Modules (LSM), which is frighteningly out of date.
> Remove untrue statements about the LSM framework. Replace them
> with true statements where it is convenient to do so. This is
> the beginning of a larger effort to bring the LSM documentation
> up to date.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

Looks good to me on a quick read.


-- 
James Morris
<jmorris@namei.org>

