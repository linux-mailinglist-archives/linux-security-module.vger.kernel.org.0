Return-Path: <linux-security-module+bounces-411-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 459C380A388
	for <lists+linux-security-module@lfdr.de>; Fri,  8 Dec 2023 13:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C021C20959
	for <lists+linux-security-module@lfdr.de>; Fri,  8 Dec 2023 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB93C1C694
	for <lists+linux-security-module@lfdr.de>; Fri,  8 Dec 2023 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsOG9GQy"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F63171C
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 04:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702038432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MVkISSEH+FBdQzDw8GhWybc3B9G1vZlEpKHv0PrW/Q0=;
	b=VsOG9GQyyw+yGSlHE/4NZfMwFuvNA0FcYUCn7YOq5CQQBBfseLd+c0VxMJfm8bgm34DYHk
	IKFYIAyYlmarSRmLUP4BhR9PCtSS+LxWan2RGVEpmDtVykZ8EODawYICY2hbfz0oTHr6yU
	zzHvewegYlTFXYI6Q0o+lDIn7weeksY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-EY4e9PFrOZ-gtcH4PrhyCw-1; Fri, 08 Dec 2023 07:27:11 -0500
X-MC-Unique: EY4e9PFrOZ-gtcH4PrhyCw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-54d8783972dso1057548a12.2
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 04:27:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702038430; x=1702643230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVkISSEH+FBdQzDw8GhWybc3B9G1vZlEpKHv0PrW/Q0=;
        b=wnUtSwP2dLb/sVIg4dcNkkACQQFuwlpzkjii7lkE8QYYQl0zGwhcXAEbbNtfT3v8It
         bs2HSWTm8MHU2CIEXoOtYP+yNqxHRHEJF5DCj5gTQWU4mECaaqD4y6ebU7WUofGyEZ/f
         ldGdSLozt7n1BbV8hAZg7N/2EPveRdY7xaBpocTkViaFKoXjMu59weh2yuuUvPg3CZNh
         jg3fyg8DOMfGvTGAnnsSIEegppMPBJudjGikN68O4hDx/R9igCCgISeSWeJKAM+B/Gcz
         VdF40Ew2nYEb4u/ZUTSImniWMJ2X3UipKuvlwKU/c2gC3oXnMtElEV/omL61Vz1TD0X0
         8+Xw==
X-Gm-Message-State: AOJu0YyIklqFbfbJqU8frDw9JZMoU2MpMizJ0tD6HOx13iIXLEU79eWi
	qa/NkZN9TcAGXDuTYAumIf8y9XbY3GRQTHuadE1o1+Em+qvXAeWgMLE+q+yOSDfXWBABlcSZXIh
	hwLndbuWQjG9xsC6bwCNHDRyQokMiKsZ6mZuk
X-Received: by 2002:a50:9fa9:0:b0:54d:8e9e:c835 with SMTP id c38-20020a509fa9000000b0054d8e9ec835mr12163edf.78.1702038430263;
        Fri, 08 Dec 2023 04:27:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMFEvK3hIa6NTwh4M4b1Lj05T78HNsQaqmShsFPjb+rBrGd/VH7pLicv91797yDItcZw6KJw==
X-Received: by 2002:a50:9fa9:0:b0:54d:8e9e:c835 with SMTP id c38-20020a509fa9000000b0054d8e9ec835mr12148edf.78.1702038429859;
        Fri, 08 Dec 2023 04:27:09 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f0:7466:b10d:58c8:869f:7e91])
        by smtp.gmail.com with ESMTPSA id n17-20020a509351000000b0054c5b5c0893sm792181eda.71.2023.12.08.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:27:09 -0800 (PST)
Date: Fri, 8 Dec 2023 07:26:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, jmorris@namei.org, serge@hallyn.com,
	stephen.smalley.work@gmail.com, eparis@parisplace.org,
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Message-ID: <20231208072649-mutt-send-email-mst@kernel.org>
References: <20231020155819.24000-5-maxime.coquelin@redhat.com>
 <2b8269b7c58ebf9b260b4e2a0676bc22.paul@paul-moore.com>
 <8ec2ae21-603d-4ce1-944b-09e042751806@redhat.com>
 <20231208060249-mutt-send-email-mst@kernel.org>
 <a5faf263-d998-4845-952f-9c8dc1d4609f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a5faf263-d998-4845-952f-9c8dc1d4609f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2023 at 01:23:00PM +0100, Maxime Coquelin wrote:
> 
> 
> On 12/8/23 12:05, Michael S. Tsirkin wrote:
> > On Fri, Dec 08, 2023 at 12:01:15PM +0100, Maxime Coquelin wrote:
> > > Hello Paul,
> > > 
> > > On 11/8/23 03:31, Paul Moore wrote:
> > > > On Oct 20, 2023 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > 
> > > > > This patch introduces LSM hooks for devices creation,
> > > > > destruction and opening operations, checking the
> > > > > application is allowed to perform these operations for
> > > > > the Virtio device type.
> > > > > 
> > > > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > > ---
> > > > >    drivers/vdpa/vdpa_user/vduse_dev.c  | 12 +++++++
> > > > >    include/linux/lsm_hook_defs.h       |  4 +++
> > > > >    include/linux/security.h            | 15 ++++++++
> > > > >    security/security.c                 | 42 ++++++++++++++++++++++
> > > > >    security/selinux/hooks.c            | 55 +++++++++++++++++++++++++++++
> > > > >    security/selinux/include/classmap.h |  2 ++
> > > > >    6 files changed, 130 insertions(+)
> > > > 
> > > > My apologies for the late reply, I've been trying to work my way through
> > > > the review backlog but it has been taking longer than expected; comments
> > > > below ...
> > > 
> > > No worries, I have also been busy these days.
> > > 
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 2aa0e219d721..65d9262a37f7 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -21,6 +21,7 @@
> > > > >     *  Copyright (C) 2016 Mellanox Technologies
> > > > >     */
> > > > > +#include "av_permissions.h"
> > > > >    #include <linux/init.h>
> > > > >    #include <linux/kd.h>
> > > > >    #include <linux/kernel.h>
> > > > > @@ -92,6 +93,7 @@
> > > > >    #include <linux/fsnotify.h>
> > > > >    #include <linux/fanotify.h>
> > > > >    #include <linux/io_uring.h>
> > > > > +#include <uapi/linux/virtio_ids.h>
> > > > >    #include "avc.h"
> > > > >    #include "objsec.h"
> > > > > @@ -6950,6 +6952,56 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
> > > > >    }
> > > > >    #endif /* CONFIG_IO_URING */
> > > > > +static int vduse_check_device_type(u32 sid, u32 device_id)
> > > > > +{
> > > > > +	u32 requested;
> > > > > +
> > > > > +	if (device_id == VIRTIO_ID_NET)
> > > > > +		requested = VDUSE__NET;
> > > > > +	else if (device_id == VIRTIO_ID_BLOCK)
> > > > > +		requested = VDUSE__BLOCK;
> > > > > +	else
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested, NULL);
> > > > > +}
> > > > > +
> > > > > +static int selinux_vduse_dev_create(u32 device_id)
> > > > > +{
> > > > > +	u32 sid = current_sid();
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVCREATE, NULL);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > > +
> > > > > +	return vduse_check_device_type(sid, device_id);
> > > > > +}
> > > > 
> > > > I see there has been some discussion about the need for a dedicated
> > > > create hook as opposed to using the existing ioctl controls.  I think
> > > > one important point that has been missing from the discussion is the
> > > > idea of labeling the newly created device.  Unfortunately prior to a
> > > > few minutes ago I hadn't ever looked at VDUSE so please correct me if
> > > > I get some things wrong :)
> > > > 
> > > >   From what I can see userspace creates a new VDUSE device with
> > > > ioctl(VDUSE_CREATE_DEV), which trigger the creation of a new
> > > > /dev/vduse/XXX device which will be labeled according to the udev
> > > > and SELinux configuration, likely with a generic udev label.  My
> > > > question is if we want to be able to uniquely label each VDUSE
> > > > device based on the process that initiates the device creation
> > > > with the call to ioctl()?  If that is the case, we would need a
> > > > create hook not only to control the creation of the device, but to
> > > > record the triggering process' label in the new device; this label
> > > > would then be used in subsequent VDUSE open and destroy operations.
> > > > The normal device file I/O operations would still be subject to the
> > > > standard SELinux file I/O permissions using the device file label
> > > > assigned by systemd/udev when the device was created.
> > > 
> > > I don't think we need a unique label for VDUSE devices, but maybe
> > > Michael thinks otherwise?
> > 
> > I don't know.
> > All this is consumed by libvirt, you need to ask these guys.
> 
> I think it is not consumed by libvirt, at least not in the usecases I
> have in mind. For networking devices, it will be consumed by OVS.
> 
> Maxime

OK, ovs then :)

-- 
MST


