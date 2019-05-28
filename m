Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 940AC2CED5
	for <lists+linux-security-module@lfdr.de>; Tue, 28 May 2019 20:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfE1SoJ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 28 May 2019 14:44:09 -0400
Received: from namei.org ([65.99.196.166]:34832 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfE1SoI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 28 May 2019 14:44:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4SIi7UK030824;
        Tue, 28 May 2019 18:44:07 GMT
Date:   Wed, 29 May 2019 04:44:07 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Micah Morton <mortonm@chromium.org>
cc:     linux-security-module@vger.kernel.org
Subject: Re: [PATCH] LSM: Fix formatting errors in SafeSetID LSM docs
In-Reply-To: <20190528155844.171547-1-mortonm@chromium.org>
Message-ID: <alpine.LRH.2.21.1905290443580.27221@namei.org>
References: <20190528155844.171547-1-mortonm@chromium.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 28 May 2019, Micah Morton wrote:

> This fixes the unintended occurrences of ??? in the text.
> 
> Signed-off-by: Micah Morton <mortonm@chromium.org>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

