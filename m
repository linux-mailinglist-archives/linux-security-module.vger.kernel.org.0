Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201ECEB54
	for <lists+linux-security-module@lfdr.de>; Mon, 29 Apr 2019 22:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfD2UGf (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 29 Apr 2019 16:06:35 -0400
Received: from namei.org ([65.99.196.166]:36462 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbfD2UGe (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 29 Apr 2019 16:06:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3TK6WlZ026025;
        Mon, 29 Apr 2019 20:06:32 GMT
Date:   Tue, 30 Apr 2019 06:06:32 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH 3/3] tomoyo: Check address length before reading address
 family
In-Reply-To: <1555066776-9758-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.21.1904300606070.20645@namei.org>
References: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <1555066776-9758-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, 12 Apr 2019, Tetsuo Handa wrote:

> KMSAN will complain if valid address length passed to bind()/connect()/
> sendmsg() is shorter than sizeof("struct sockaddr"->sa_family) bytes.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tomoyo


-- 
James Morris
<jmorris@namei.org>

