Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D41513F9A4
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Jan 2020 20:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgAPThc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 Jan 2020 14:37:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33400 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgAPThc (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jan 2020 14:37:32 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so23942186lji.0
        for <linux-security-module@vger.kernel.org>; Thu, 16 Jan 2020 11:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/6nixoSIoKE6eZ+cJNMdmi8y/6oky8cFSXcKfYMtxQ=;
        b=lQeRJkmRDyrHLNcLnxExOdsvsc6kYdTstdedfLJdxBc2Hb3NbgtxdXq880Yfcy82zG
         +B+Vj80m+NtyaXkPaj1oRCBWHZw+GQgQ30H1LhlD5+Kga/+5lKOt7WrVHgEFRKopB44a
         RFWPlwiohqMayaO3MO4ek0DoQ9Ff1EfnmeIyaoDhopImoqVNumyuBCo9PDfxM1ouTBsY
         DWUVkhfv5yaDU08IGVaS+B0+gdsSWikaE2NGLkHrZDFpqeqVJ+l8SQOT1CzlM+6bJ+Ym
         K8Gxs5sKXmBofKEQrueCfPV/lt1FSA0dU8fbsE/pFEJOEhaTyAqPZHacl3xhe+JttXvx
         cCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/6nixoSIoKE6eZ+cJNMdmi8y/6oky8cFSXcKfYMtxQ=;
        b=osLx264aG+vl328/HWbLEXLWujCVHs9RQYv7LzSS8rmXPqtZm1rMBSyaQEZxsBTsDI
         e/idg536NMeShls7SVDRLRzZaXjEBN3eOo6Uql2woMOrqzknmVBTHia0nyRc7XZo4z+l
         r/JRq0Dz0lRpzTypK8FbP/NPhZxVCmy3cdAB2dV+vOCpV91nEicUoW6SYdHfpPDjsGmi
         OkEd1EMnrHy7bUe4yYXy2/Ypx4VEpdQ2fcqU3GORNJMl9XfIa/EPdhy1CKoCIhr0Wy7S
         3fMdo9duJVSb6VZGl5w/bE02ObXSaHlIRfWSrjf+vfr9BHQTRFiaYyitZm/SM6Du3Crs
         4qLA==
X-Gm-Message-State: APjAAAXag3txpWfBQ04JixDZuxiWS0b7vtMq+QyBKwlwVcKuJYOaj1qU
        rEFSr1S/sNWbQFXiEfTSOArsQXnppmBwl2RyqNiY
X-Google-Smtp-Source: APXvYqwKAWhKu2+URonvJ2ikEe5O/sYBlf20qhEgS2M6oEN/BhsztPpWGHIRzliVuWewDjHKHrmByY0zmqg+gZCZzlw=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3313585lji.93.1579203450159;
 Thu, 16 Jan 2020 11:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20200113150331.34108-1-yehs2007@zoho.com>
In-Reply-To: <20200113150331.34108-1-yehs2007@zoho.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 16 Jan 2020 14:37:19 -0500
Message-ID: <CAHC9VhQTa9VcO9Yq4e36zd8ZAVNDb3_tA-uSgmH_aMX2p5QXLA@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: remove redundant selinux_nlmsg_perm
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, tyu1@lenovo.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Jan 13, 2020 at 10:05 AM Huaisheng Ye <yehs2007@zoho.com> wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> selinux_nlmsg_perm is used for only by selinux_netlink_send. Remove
> the redundant function to simplify the code.
>
> Fix a typo by suggestion from Stephen.
>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/hooks.c | 73 ++++++++++++++++++++++--------------------------
>  1 file changed, 34 insertions(+), 39 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
