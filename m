Return-Path: <linux-security-module+bounces-410-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B817C80A387
	for <lists+linux-security-module@lfdr.de>; Fri,  8 Dec 2023 13:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5101C20919
	for <lists+linux-security-module@lfdr.de>; Fri,  8 Dec 2023 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8201C68A
	for <lists+linux-security-module@lfdr.de>; Fri,  8 Dec 2023 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaM9C3VE"
X-Original-To: linux-security-module@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D109A
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 04:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702038194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TW1a2SjT4hZBlOK3S5/vczhORcUO0BHsyObSqXfFQNA=;
	b=EaM9C3VENGRpvvQhm1IiiUSonQOTLUkn746R7gbJqoUFLqG9VxystfY1MdZJLq1VtKZxR+
	BKyOI6hbGvO7nPcdRTgfYiMREEuzae3YdjcRDDm8WB64fiwenZCFlmxFQcOXQgtadUCjNd
	F7RQkRE/fUs/GlekyeuRprz7Nh9EC8Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-KKUptsraNz2X8UhhZ_nD-g-1; Fri,
 08 Dec 2023 07:23:09 -0500
X-MC-Unique: KKUptsraNz2X8UhhZ_nD-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 909BA29AC03E;
	Fri,  8 Dec 2023 12:23:08 +0000 (UTC)
Received: from [10.39.208.34] (unknown [10.39.208.34])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B8B5C18572;
	Fri,  8 Dec 2023 12:23:02 +0000 (UTC)
Message-ID: <a5faf263-d998-4845-952f-9c8dc1d4609f@redhat.com>
Date: Fri, 8 Dec 2023 13:23:00 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] vduse: Add LSM hooks to check Virtio device type
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Casey Schaufler
 <casey@schaufler-ca.com>, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 jmorris@namei.org, serge@hallyn.com, stephen.smalley.work@gmail.com,
 eparis@parisplace.org, xieyongji@bytedance.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 david.marchand@redhat.com, lulu@redhat.com
References: <20231020155819.24000-5-maxime.coquelin@redhat.com>
 <2b8269b7c58ebf9b260b4e2a0676bc22.paul@paul-moore.com>
 <8ec2ae21-603d-4ce1-944b-09e042751806@redhat.com>
 <20231208060249-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Autocrypt: addr=maxime.coquelin@redhat.com; keydata=
 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
 Mwqu3GQ=
In-Reply-To: <20231208060249-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8



On 12/8/23 12:05, Michael S. Tsirkin wrote:
> On Fri, Dec 08, 2023 at 12:01:15PM +0100, Maxime Coquelin wrote:
>> Hello Paul,
>>
>> On 11/8/23 03:31, Paul Moore wrote:
>>> On Oct 20, 2023 "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>>>
>>>> This patch introduces LSM hooks for devices creation,
>>>> destruction and opening operations, checking the
>>>> application is allowed to perform these operations for
>>>> the Virtio device type.
>>>>
>>>> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>>> ---
>>>>    drivers/vdpa/vdpa_user/vduse_dev.c  | 12 +++++++
>>>>    include/linux/lsm_hook_defs.h       |  4 +++
>>>>    include/linux/security.h            | 15 ++++++++
>>>>    security/security.c                 | 42 ++++++++++++++++++++++
>>>>    security/selinux/hooks.c            | 55 +++++++++++++++++++++++++++++
>>>>    security/selinux/include/classmap.h |  2 ++
>>>>    6 files changed, 130 insertions(+)
>>>
>>> My apologies for the late reply, I've been trying to work my way through
>>> the review backlog but it has been taking longer than expected; comments
>>> below ...
>>
>> No worries, I have also been busy these days.
>>
>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>> index 2aa0e219d721..65d9262a37f7 100644
>>>> --- a/security/selinux/hooks.c
>>>> +++ b/security/selinux/hooks.c
>>>> @@ -21,6 +21,7 @@
>>>>     *  Copyright (C) 2016 Mellanox Technologies
>>>>     */
>>>> +#include "av_permissions.h"
>>>>    #include <linux/init.h>
>>>>    #include <linux/kd.h>
>>>>    #include <linux/kernel.h>
>>>> @@ -92,6 +93,7 @@
>>>>    #include <linux/fsnotify.h>
>>>>    #include <linux/fanotify.h>
>>>>    #include <linux/io_uring.h>
>>>> +#include <uapi/linux/virtio_ids.h>
>>>>    #include "avc.h"
>>>>    #include "objsec.h"
>>>> @@ -6950,6 +6952,56 @@ static int selinux_uring_cmd(struct io_uring_cmd *ioucmd)
>>>>    }
>>>>    #endif /* CONFIG_IO_URING */
>>>> +static int vduse_check_device_type(u32 sid, u32 device_id)
>>>> +{
>>>> +	u32 requested;
>>>> +
>>>> +	if (device_id == VIRTIO_ID_NET)
>>>> +		requested = VDUSE__NET;
>>>> +	else if (device_id == VIRTIO_ID_BLOCK)
>>>> +		requested = VDUSE__BLOCK;
>>>> +	else
>>>> +		return -EINVAL;
>>>> +
>>>> +	return avc_has_perm(sid, sid, SECCLASS_VDUSE, requested, NULL);
>>>> +}
>>>> +
>>>> +static int selinux_vduse_dev_create(u32 device_id)
>>>> +{
>>>> +	u32 sid = current_sid();
>>>> +	int ret;
>>>> +
>>>> +	ret = avc_has_perm(sid, sid, SECCLASS_VDUSE, VDUSE__DEVCREATE, NULL);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	return vduse_check_device_type(sid, device_id);
>>>> +}
>>>
>>> I see there has been some discussion about the need for a dedicated
>>> create hook as opposed to using the existing ioctl controls.  I think
>>> one important point that has been missing from the discussion is the
>>> idea of labeling the newly created device.  Unfortunately prior to a
>>> few minutes ago I hadn't ever looked at VDUSE so please correct me if
>>> I get some things wrong :)
>>>
>>>   From what I can see userspace creates a new VDUSE device with
>>> ioctl(VDUSE_CREATE_DEV), which trigger the creation of a new
>>> /dev/vduse/XXX device which will be labeled according to the udev
>>> and SELinux configuration, likely with a generic udev label.  My
>>> question is if we want to be able to uniquely label each VDUSE
>>> device based on the process that initiates the device creation
>>> with the call to ioctl()?  If that is the case, we would need a
>>> create hook not only to control the creation of the device, but to
>>> record the triggering process' label in the new device; this label
>>> would then be used in subsequent VDUSE open and destroy operations.
>>> The normal device file I/O operations would still be subject to the
>>> standard SELinux file I/O permissions using the device file label
>>> assigned by systemd/udev when the device was created.
>>
>> I don't think we need a unique label for VDUSE devices, but maybe
>> Michael thinks otherwise?
> 
> I don't know.
> All this is consumed by libvirt, you need to ask these guys.

I think it is not consumed by libvirt, at least not in the usecases I
have in mind. For networking devices, it will be consumed by OVS.

Maxime


