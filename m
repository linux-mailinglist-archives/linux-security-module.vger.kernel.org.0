Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FBF6F6FAD
	for <lists+linux-security-module@lfdr.de>; Thu,  4 May 2023 18:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjEDQOY (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 4 May 2023 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEDQOX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 4 May 2023 12:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF60A59FD
        for <linux-security-module@vger.kernel.org>; Thu,  4 May 2023 09:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683216810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCERTes3cUqeH2NVPYErrzXP04o1ceM5Rm63oz0hrwA=;
        b=Kzrhjr0y3YpjtMQdhzVwM/x6pXVJ5c8jm1upIVJ0cZax+PqJZj3DM2NJGj1tK5AdQq0zJF
        3jNmsaqZ8yvTGtB9URcq14TauKgwL1Heh/KWVb9aSC1C1OYNIBjNcZhs/UInlH0ytaSSJ3
        9xdIhLoEZ7dbLhn57IbMvOiuU9WyFbc=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-k8RHwPG3PWCcdV1SA78SnQ-1; Thu, 04 May 2023 12:13:28 -0400
X-MC-Unique: k8RHwPG3PWCcdV1SA78SnQ-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-44fe5556165so16457e0c.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 May 2023 09:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683216808; x=1685808808;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCERTes3cUqeH2NVPYErrzXP04o1ceM5Rm63oz0hrwA=;
        b=Yt+msNHlaLZcMyelQWWH2Sazx9sJp2YUeooDraJoNUMrSq+RKFXD6J3g3mOUqVM5T3
         gQHdITmVcz01O5NJ3EKlHERO+yRa0K6Wh4fY0qtXeJNicKYm8fwe4tUWFSs1VW6zns0K
         Q76rTLnGH/dq3SBhfMiqHxSp9KViR3LsR+9sSGkuYshsh4M/nh/UxDubJYC8ewkVUnpi
         K82nPOJk4EboBNzLAozC2pdS1+9f86msOak50brljDQ3+V4EDsb0Mnr3ar/WlzMKuie5
         DYdKY9tdp/lnboBtMA1ZAEqme04L2BsPkSbQc86cHoytqfTuejVVu8zf18YDjBztL79p
         eY0A==
X-Gm-Message-State: AC+VfDzDkCVl2+2rbn0iXCzZ/4lCRVwvSd0ekUnDNb/yvt03/T3zmNAK
        ULUKYuYbE8nUlz9HbLdhhHCxFk0/mZYGtDa0SheMXfxpnAN6CjRY9NbgYn0zkO3aw5moZQQ8CQ8
        BPcjBxpoZJwwFep88+UDHTQocro44Fl96fC8T
X-Received: by 2002:a1f:b646:0:b0:448:1241:47ae with SMTP id g67-20020a1fb646000000b00448124147aemr3069421vkf.1.1683216807871;
        Thu, 04 May 2023 09:13:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pUnL9fUfiStXzh1jo+rajlFzURLwzhhKGNCKNVHx6d9nP0QKmPVmXXzyvOtLVq7RYWk28Ew==
X-Received: by 2002:a1f:b646:0:b0:448:1241:47ae with SMTP id g67-20020a1fb646000000b00448124147aemr3069388vkf.1.1683216807461;
        Thu, 04 May 2023 09:13:27 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-79.dyn.eolo.it. [146.241.244.79])
        by smtp.gmail.com with ESMTPSA id 75-20020a370b4e000000b0074df3f7e14esm11694249qkl.67.2023.05.04.09.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 09:13:27 -0700 (PDT)
Message-ID: <11201df515ec41db88ad915fd1e425e62c4f81e5.camel@redhat.com>
Subject: Re: [PATCH LSM v2 0/2] security: SELinux/LSM label with MPTCP and
 accept
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, mptcp@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Date:   Thu, 04 May 2023 18:13:23 +0200
In-Reply-To: <CAFqZXNt16B5A2o6fZeN5b1coNCW2m6kp7JToJFDorvPajhFyxA@mail.gmail.com>
References: <20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-v2-0-e7a3c8c15676@tessares.net>
         <CAFqZXNt16B5A2o6fZeN5b1coNCW2m6kp7JToJFDorvPajhFyxA@mail.gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, 2023-05-04 at 16:14 +0200, Ondrej Mosnacek wrote:
> On Thu, Apr 20, 2023 at 7:17=E2=80=AFPM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
> >=20
> > In [1], Ondrej Mosnacek explained they discovered the (userspace-facing=
)
> > sockets returned by accept(2) when using MPTCP always end up with the
> > label representing the kernel (typically system_u:system_r:kernel_t:s0)=
,
> > while it would make more sense to inherit the context from the parent
> > socket (the one that is passed to accept(2)). Thanks to the
> > participation of Paul Moore in the discussions, modifications on MPTCP
> > side have started and the result is available here.
> >=20
> > Paolo Abeni worked hard to refactor the initialisation of the first
> > subflow of a listen socket. The first subflow allocation is no longer
> > done at the initialisation of the socket but later, when the connection
> > request is received or when requested by the userspace. This was a
> > prerequisite to proper support of SELinux/LSM labels with MPTCP and
> > accept. The last batch containing the commit ddb1a072f858 ("mptcp: move
> > first subflow allocation at mpc access time") [2] has been recently
> > accepted and applied in netdev/net-next repo [3].
> >=20
> > This series of 2 patches is based on top of the lsm/next branch. Despit=
e
> > the fact they depend on commits that are in netdev/net-next repo to
> > support the new feature, they can be applied in lsm/next without
> > creating conflicts with net-next or causing build issues. These two
> > patches on top of lsm/next still passes all the MPTCP-specific tests.
> > The only thing is that the new feature only works properly with the
> > patches that are on netdev/net-next. The tests with the new labels have
> > been done on top of them.
> >=20
> > Regarding the two patches, the first one introduces a new LSM hook
> > called from MPTCP side when creating a new subflow socket. This hook
> > allows the security module to relabel the subflow according to the owin=
g
> > process. The second one implements this new hook on the SELinux side.
> >=20
> > Link: https://lore.kernel.org/netdev/CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCf=
BkMkwFeM6qEwMKCTw@mail.gmail.com/ [1]
> > Link: https://git.kernel.org/netdev/net-next/c/ddb1a072f858 [2]
> > Link: https://lore.kernel.org/netdev/20230414-upstream-net-next-2023041=
4-mptcp-refactor-first-subflow-init-v1-0-04d177057eb9@tessares.net/ [3]
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > ---
> > Changes in v2:
> > - Address Paul's comments, see the notes on each patch
> > - Link to v1: https://lore.kernel.org/r/20230419-upstream-lsm-next-2023=
0419-mptcp-sublows-user-ctx-v1-0-9d4064cb0075@tessares.net
> >=20
> > ---
> > Paolo Abeni (2):
> >       security, lsm: Introduce security_mptcp_add_subflow()
> >       selinux: Implement mptcp_add_subflow hook
> >=20
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  6 ++++++
> >  net/mptcp/subflow.c           |  6 ++++++
> >  security/security.c           | 17 +++++++++++++++++
> >  security/selinux/hooks.c      | 16 ++++++++++++++++
> >  security/selinux/netlabel.c   |  8 ++++++--
> >  6 files changed, 52 insertions(+), 2 deletions(-)
> > ---
> > base-commit: d82dcd9e21b77d338dc4875f3d4111f0db314a7c
> > change-id: 20230419-upstream-lsm-next-20230419-mptcp-sublows-user-ctx-e=
ee658fafcba
> >=20
> > Best regards,
> > --
> > Matthieu Baerts <matthieu.baerts@tessares.net>
> >=20
>=20
> I haven't yet looked closer at the code in this series, but I can at
> least confirm that with the series (applied on top of net-next) the
> selinux-testsuite now passes when run under mptcpize, with one caveat:
>=20
> The "client" test prog in the inet_socket subtest sets the SO_SNDTIMEO
> socket option on the client socket, but the subtest takes
> significantly longer to complete than when run without mptcpize. That
> suggests to me that there is possibly some (pre-existing) issue with
> MPTCP where the send/receive timeouts are not being passed to the
> subflow socket(s), leading to a longer wait (I guess the default is
> higher?)=C2=A0

Indeed the behavior you describe is due to some mptcp bug in handling
the SO_{SND,RCV}TIMEO socket tions, and it's really unrelated to the
initially reported selinux issue.

If you could file an issue on our tracker, that would help ;)

Thanks!

Paolo

