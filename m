Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D87848F707
	for <lists+linux-security-module@lfdr.de>; Fri, 16 Aug 2019 00:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbfHOWcU (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 15 Aug 2019 18:32:20 -0400
Received: from namei.org ([65.99.196.166]:40792 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731768AbfHOWcU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 15 Aug 2019 18:32:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x7FMWCnq026112;
        Thu, 15 Aug 2019 22:32:12 GMT
Date:   Fri, 16 Aug 2019 08:32:12 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Aaron Goidel <acgoide@tycho.nsa.gov>
cc:     paul@paul-moore.com, rgb@redhat.com, mortonm@chromium.org,
        john.johansen@canonical.com, selinux@vger.kernel.org,
        luto@amacapital.net, linux-security-module@vger.kernel.org,
        linux-audit@redhat.com, nhfran2@tycho.nsa.gov, serge@hallyn.com,
        sds@tycho.nsa.gov
Subject: Re: [RFC PATCH v3] security,capability: pass object information to
 security_capable
In-Reply-To: <20190815202357.4238-1-acgoide@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.21.1908160817300.22623@namei.org>
References: <20190815202357.4238-1-acgoide@tycho.nsa.gov>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 15 Aug 2019, Aaron Goidel wrote:

> In SELinux this new information is leveraged here to perform an
> additional inode based check for capabilities relevant to inodes. Since
> the inode provided to capable_wrt_inode_uidgid() is a const argument,
> this also required propagating const down to dump_common_audit_data() and
> dropping the use of d_find_alias() to find an alias for the inode. This
> was sketchy to begin with and should be obsoleted by a separate change
> that will allow LSMs to trigger audit collection for all file-related
> information.

Will the audit logs look the same once the 2nd patch is applied? We need 
to be careful about breaking existing userland.


-- 
James Morris
<jmorris@namei.org>

