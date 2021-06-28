Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3CB3B5D74
	for <lists+linux-security-module@lfdr.de>; Mon, 28 Jun 2021 13:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhF1MA7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 28 Jun 2021 08:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232586AbhF1MA6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 Jun 2021 08:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624881509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mAyy3fb9a/A0Wy4JT6Gz9HEgpmGDE5qbwHVNuC276O4=;
        b=P6PG5Ul2zK3uLRsK30LLEBSIM9JMFpJju7hzN6Stsliemn37swjYCEd8VvJ211Ots9Y2pI
        i7vtp9CpO1mO7js88717AwDDIcXSTSSFcYlTsT22uhHNADLt7Yh4aDWHHg8Hs4APYXTQC3
        v2oqQpnjsKRQ5X8Vru9nb37E43Ys52M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-BXtxonWWO1ueH7kJ_Dm9yg-1; Mon, 28 Jun 2021 07:58:27 -0400
X-MC-Unique: BXtxonWWO1ueH7kJ_Dm9yg-1
Received: by mail-wm1-f72.google.com with SMTP id j38-20020a05600c1c26b02901dbf7d18ff8so8878750wms.8
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jun 2021 04:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mAyy3fb9a/A0Wy4JT6Gz9HEgpmGDE5qbwHVNuC276O4=;
        b=dOuk1GLG0MX7371WjSznNT1HqMHOIOWM8zq/wz4KfUBASHW1jkJzLsjrdYXfhxmPus
         5kjf/fgguFwSYJh9qoJkQSo50sGgEjnfuaIAL5VtmNIM6kPbrVgTV6BeQGfOPBa42zXC
         tPqcnEzM6GT08qtc8jbYVh6S9jLR+7gFZeRk8WROG5Xf3chVvGlyyc0X9i9zuoFc/oFq
         wBm45SffKM4VKxdWtjOVgeJjgW0hUfBnLARBVH3mGyKnkHeV0WHAGOPXyd81J24WHJGB
         WklU8NZTZUCO6eRwDhv5mO8gkWImuKPDVBgruOBabZVhqlWPb6aH0hqn0mRMf4PaIAo8
         y6kg==
X-Gm-Message-State: AOAM531bJ72thuuuI8koiFCy2ApWxmIXDdTlO34dDIQU8CmM317X7jUp
        2mvxQZ/jpS2APBgOSJ08hSHsIMLOs58h91aqmqoTSqGUjKvE8gydiyfo34IYkeVwl6YM//6lJk3
        9b9asZENkd+NXtckRdPYNqAd20V+PPGIwSWXo
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr2237847wrs.364.1624881506751;
        Mon, 28 Jun 2021 04:58:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrkk/KgU87mrJhE843ZLCm7+57AC7KmP6Nb7lxQfMUgnmV3+0IYC6pgVkzCBCu+wPbRcgMpw==
X-Received: by 2002:a5d:49c9:: with SMTP id t9mr2237815wrs.364.1624881506582;
        Mon, 28 Jun 2021 04:58:26 -0700 (PDT)
Received: from work-vm (cpc109021-salf6-2-0-cust453.10-2.cable.virginm.net. [82.29.237.198])
        by smtp.gmail.com with ESMTPSA id v17sm7065600wrt.74.2021.06.28.04.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 04:58:26 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:58:23 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        "dwalsh@redhat.com" <dwalsh@redhat.com>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special
 files if caller has CAP_SYS_RESOURCE
Message-ID: <YNm5X/5PuqyXcZbM@work-vm>
References: <20210625191229.1752531-1-vgoyal@redhat.com>
 <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN0PR11MB57275823CE05DED7BC755460FD069@BN0PR11MB5727.namprd11.prod.outlook.com>
User-Agent: Mutt/2.0.7 (2021-05-04)
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

* Schaufler, Casey (casey.schaufler@intel.com) wrote:
> > -----Original Message-----
> > From: Vivek Goyal <vgoyal@redhat.com>
> > Sent: Friday, June 25, 2021 12:12 PM
> > To: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> > viro@zeniv.linux.org.uk
> > Cc: virtio-fs@redhat.com; dwalsh@redhat.com; dgilbert@redhat.com;
> > berrange@redhat.com; vgoyal@redhat.com
> 
> Please include Linux Security Module list <linux-security-module@vger.kernel.org>
> and selinux@vger.kernel.org on this topic.
> 
> > Subject: [RFC PATCH 0/1] xattr: Allow user.* xattr on symlink/special files if
> > caller has CAP_SYS_RESOURCE
> > 
> > Hi,
> > 
> > In virtiofs, actual file server is virtiosd daemon running on host.
> > There we have a mode where xattrs can be remapped to something else.
> > For example security.selinux can be remapped to
> > user.virtiofsd.securit.selinux on the host.
> 
> This would seem to provide mechanism whereby a user can violate
> SELinux policy quite easily. 
> 
> > 
> > This remapping is useful when SELinux is enabled in guest and virtiofs
> > as being used as rootfs. Guest and host SELinux policy might not match
> > and host policy might deny security.selinux xattr setting by guest
> > onto host. Or host might have SELinux disabled and in that case to
> > be able to set security.selinux xattr, virtiofsd will need to have
> > CAP_SYS_ADMIN (which we are trying to avoid). Being able to remap
> > guest security.selinux (or other xattrs) on host to something else
> > is also better from security point of view.
> 
> Can you please provide some rationale for this assertion?
> I have been working with security xattrs longer than anyone
> and have trouble accepting the statement.

There seem to be a few very different ways of using SELinux in
containers/guests, and many ways of using shared filesystems.

A common request is that we share a host filesystem into the guest (a
VM), and then the guest can do with it whatever it likes, preferably
without making the guest privileged in any way, and with having as few
priviliges on the daemons running on behalf of the guest ('virtiofd'
which is a fuse implementation daemon that runs on the host).

By remapping all guests xattr to add a "user.virtiofsd." prefix,
the guest can label it's filesystem and implement it's own SELinux
policy, but because it's using "user." on the host, it can neither
bypass nor change the hosts SELinux labelling or policies.

(It also means that the guest can set capabilities and other xattr's,
again without confusing the host).

> > But when we try this, we noticed that SELinux relabeling in guest
> > is failing on some symlinks. When I debugged a little more, I
> > came to know that "user.*" xattrs are not allowed on symlinks
> > or special files.
> > 
> > "man xattr" seems to suggest that primary reason to disallow is
> > that arbitrary users can set unlimited amount of "user.*" xattrs
> > on these files and bypass quota check.
> > 
> > If that's the primary reason, I am wondering is it possible to relax
> > the restrictions if caller has CAP_SYS_RESOURCE. This capability
> > allows caller to bypass quota checks. So it should not be
> > a problem atleast from quota perpective.
> > 
> > That will allow me to give CAP_SYS_RESOURCE to virtiofs deamon
> > and remap xattrs arbitrarily.
> 
> On a Smack system you should require CAP_MAC_ADMIN to remap
> security. xattrs. I sounds like you're in serious danger of running afoul
> of LSM attribute policy on a reasonable general level.

Note that the remapping is done by the userspace daemon running on the
host (and takes parameters saying what remapping is required); as
such it's still bound by whatever LSM policies the host wants; we're
just giving the guest the ability to add it's own policies without
breaking the hosts.

Of course if you want the guest kernel to see the host xattrs
then you don't want the remapping; there are even some cases where you
might want to allow the guest to set those xattrs; but then you really
do have to start worrying about what the guest could do to your
filesystem.

The only thing getting in the way of the guest being able to do a full
relabel seems to be the limitation on user.* on non-files.

Dave

> > 
> > Thanks
> > Vivek
> > 
> > Vivek Goyal (1):
> >   xattr: Allow user.* xattr on symlink/special files with
> >     CAP_SYS_RESOURCE
> > 
> >  fs/xattr.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > --
> > 2.25.4
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

