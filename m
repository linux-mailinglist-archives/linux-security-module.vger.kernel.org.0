Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423A93D1886
	for <lists+linux-security-module@lfdr.de>; Wed, 21 Jul 2021 23:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhGUUV0 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 21 Jul 2021 16:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhGUUVU (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 21 Jul 2021 16:21:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18FBC061796
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jul 2021 14:01:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id l1so4087673edr.11
        for <linux-security-module@vger.kernel.org>; Wed, 21 Jul 2021 14:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vC36KsI6Uxi409tFL3B3jUEJG1QhGnIsFKbWDeC28sg=;
        b=dmzRr0Oly+zPPi4Jak/1BckWfrjbks+MNNxD1BQDA0I/KW+RDDmTeHkG+KZRRZnCSV
         jG3AvcX5AmKrKNlSv1aV2MizlYQH01eDiiLnjqqv/efHpaXVURVkDXwjjW8xhkT6aTMc
         QPxQPlGlDisEQll+gMtny3BN6ZPP2zdwHeWKsIMQgmmMWJyBAEilTeIpkmp/g2/DxuY4
         T8yy/w7QO24lvf+GHSdPomW3Bx7Th+lXg5Zs+po3/u2oAJGWt/JMuQ/u0AkZAQ4oMW0F
         VoFRWMtd8laFiiU7/Uo+edToLIm84qmxqq4nTkNIx2seAHw/cmEcKUCdLgHxUOmonbcN
         UKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vC36KsI6Uxi409tFL3B3jUEJG1QhGnIsFKbWDeC28sg=;
        b=ClDwek2/o5Kh4dQyS258xx6SJowUhcWW3Tbbn0r3O4zulc5mOV3hofDzFd7DaAcThy
         OHvITAtAodvXMXNQWFlI7j/vmVZHXQdvfojkNHfsXEuDJ0Tsqno0hosAu3/8Hq8pNWOJ
         ROvifsezeFw0IeMWj3guvfQcYC6fnEA3edzOSx3c54htYTS/Hjoyr3BKwnh825wvBSCp
         zesZztYGqelhw5bNHSvQG5hAUqfdvgczT+FbriMXoG0t0nxyJ8UxXW1RM+12qd+tzIo8
         Sv8ORjq+/N2T0DNIifkcXUIvRLRRpIeGlFqLeLctCL8gFB8KHz3SFLXrzPU2bzg3QSOr
         e+bA==
X-Gm-Message-State: AOAM531Q7+OlvdYJy9jxHzGNinHhRbgIqsEl4TEVlS8v4kuGb0LYwjwm
        ndxa/09WYZgraUU2d+Iqeg4ps6soSUJQEYO7N8yG
X-Google-Smtp-Source: ABdhPJxGW0gP2pEJftb3MQLTIiM9WlXT/Km9lZZHiwA5Eb42uka6hs594c+U71M4wDAXmP6LMBUClAKWo462yguhzZY=
X-Received: by 2002:aa7:d04d:: with SMTP id n13mr50389932edo.31.1626901314501;
 Wed, 21 Jul 2021 14:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAP198X8TNTv1tqpO6Y7eyE2+iSwK9XHk0qRH6J-Z0Ww=a+53tA@mail.gmail.com>
In-Reply-To: <CAP198X8TNTv1tqpO6Y7eyE2+iSwK9XHk0qRH6J-Z0Ww=a+53tA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 21 Jul 2021 17:01:43 -0400
Message-ID: <CAHC9VhSBo1CHCM+k5TocQS7--+bGL5RY0z6WKKunE76-fuR6iw@mail.gmail.com>
Subject: Re: AVC denied for docker while trying to set labels for tmpfs mounts
To:     Sujithra P <sujithrap@gmail.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jul 21, 2021 at 2:46 PM Sujithra P <sujithrap@gmail.com> wrote:
>
> Hi SELinux Experts,
>
> The following issue is described in the below post as well.
> https://github.com/containers/container-selinux/issues/141
>
> Occasionally running into the following selinux denials for docker
>
> type=AVC msg=audit(1626732057.636:4583): avc:  denied  { associate }
> for  pid=57450 comm="dockerd" name="/" dev="tmpfs" ino=150014
> scontext=system_u:object_r:container_file_t:s0:c263,c914
> tcontext=system_u:object_r:lib_t:s0 tclass=filesystem permissive=0
>
> type=AVC msg=audit(1626812823.170:9434): avc:  denied  { associate }
> for  pid=20027 comm="dockerd" name="/" dev="tmpfs" ino=198147
> scontext=system_u:object_r:container_file_t:s0:c578,c672
> tcontext=system_u:object_r:locale_t:s0 tclass=filesystem permissive=0
>
>
>  level=error msg="Handler for POST
> /v1.40/containers/a3a875e7896384e3bff53b8317e91ed4301a13957f42187eb227f28e09bd877c/start
> returned error: error setting label on mount source
> '/var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret':
> failed to set file label on
> /var/lib/kubelet/pods/f7cee5b2-bcd9-4aa1-9d67-c75b677ba2a1/volumes/kubernetes.io~secret/secret:
> permission denied"
>
>
> Docker is not able to set labels for these tmpfs mounts because they
> end up having wrong labels when they are created (sometimes
> "locale_t", sometimes "lib_t" which of course is not the
> default/correct context for tmpfs fs).
> Apparently semodule -R and deleting these tmps files or reboot of the
> node fixes the problem.
> Not sure what is causing the tmpfs mounts to get wrong labels in the
> first place.
>
> Everything seems to be fine to begin with, but as the system keeps
> scheduling pods on the node, this behavior is observed sometimes (not
> consistent always).
>
>
> OS Details:
>
> NAME="CentOS Linux"
> VERSION="8 (Core)"
> ID="centos"
> ID_LIKE="rhel fedora"
> VERSION_ID="8"
> PLATFORM_ID="platform:el8"
> PRETTY_NAME="CentOS Linux 8 (Core)"
>
> Docker Version:
> Client: Docker Engine - Community
> Version: 19.03.13
> API version: 1.40
> Go version: go1.13.15
> Git commit: 4484c46d9d
> Built: Wed Sep 16 17:02:36 2020
> OS/Arch: linux/amd64
> Experimental: false
>
> Kubernetes Version*
> v1.20.8-gke.1500
>
>
> Any help on how to debug this issue  would be greatly appreciated.

This sounds like it might be a problem with CentOS and/or your Docker
install, have you tried talking with the RH/CentOS folks about this
problem?  We focus mostly on upstream issues here and it isn't clear
to me at this moment that this is an upstream issue.

-- 
paul moore
www.paul-moore.com
