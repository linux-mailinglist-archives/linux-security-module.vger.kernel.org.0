Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92206A3FE2
	for <lists+linux-security-module@lfdr.de>; Fri, 30 Aug 2019 23:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfH3Vqy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 30 Aug 2019 17:46:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40546 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfH3Vqy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 30 Aug 2019 17:46:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id e27so7732002ljb.7
        for <linux-security-module@vger.kernel.org>; Fri, 30 Aug 2019 14:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/IKEwtiMoZTtijwK84EjX+6xulxKmEOQTSwaaf+y48=;
        b=aoFTsFCWzMtsMdDPZj1Iv+ZXjcGyzvvosDEXplOewRaj+VHWw2zUfXIYkswbA6TzJG
         NWskcFkqaH33yD+gnvU6OO/RnyTek1/Exi1PL2s5XvzcF0WOzloSQDks895e3GD+I6Ru
         yfoGDqbh7NXYFS8NxLwN3aMItjNI4N4qw9p1GJVb527MIY+fAYqZihttFdD1lM1jTR/G
         XPyyDWKMXjWmZUab9jO0ywCx8EOyDfknhtAwoChxtu9Fkiw8rx0o98r68ncPLR1iFFGR
         pw7g9f+S0bTZTxxjffvpwIIAVsRK0jXWsL+MZHB+HRZFdOyfLgBxSb9Hefqrf9jS3bxq
         tfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/IKEwtiMoZTtijwK84EjX+6xulxKmEOQTSwaaf+y48=;
        b=Wqe7CETAPdih/hrd8qg3pykLo02eBdp9WGhEBCY484inW8Be5wX0lslTSrxs8dsCMS
         7nfSzE5cOjAlI6yCtncD3QKA7cJRS6znrokKcXbEjTY7dI/MXwPHhh5VhOE4Oni4NIED
         lEMCGTcmvHTBfYShyyp9dKuQvc2bQcEKyhQogdPSBhvUm6fAh75Y1OBJQj+Dz3JzlERA
         LYtCpmgFgexmiwbwa1SKR/QuOErf44+SfFv7OWgsO1Pf1CNR4r7lKbaANsThWLj49Jtw
         KGKoKNGWcqOnT1rqAQlX1Y8KUj/qVIcGZJ8z3inUxXhi89Y5pEJ7Jo+da3YrdDBANvrH
         4YXg==
X-Gm-Message-State: APjAAAWsQkP53EfiC3gA8JWQDfyXz8oh9ukx20XxI6Fg9tx8P2pmPIvp
        bE5V75W2aIDecYJgbF/321NTDMvWtrnpmSKVo3Ov
X-Google-Smtp-Source: APXvYqxirrtwxKydgvqj+iXwb2e01CWP4pG1x5kPYkURSbjtWQcwHoS1PGYLKIwllBMJ+BeSHOXr3+1+9uKQ3teRW3k=
X-Received: by 2002:a05:651c:1111:: with SMTP id d17mr9377947ljo.87.1567201611994;
 Fri, 30 Aug 2019 14:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190821134547.96929-1-jeffv@google.com> <20190822.161913.326746900077543343.davem@davemloft.net>
 <CABXk95BF=RfqFSHU_---DRHDoKyFON5kS_vYJbc4ns2OS=_t0w@mail.gmail.com>
 <CAHC9VhRmmEp_nFtOFy_YRa9NwZA4qPnjw7D3JQvqED-tO4Ha1g@mail.gmail.com> <20190829074516.GM29594@unicorn.suse.cz>
In-Reply-To: <20190829074516.GM29594@unicorn.suse.cz>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 30 Aug 2019 17:46:40 -0400
Message-ID: <CAHC9VhSDZd9EZuKB0WcHW1P8va=vFdpG_Gnnx9ZELdqVtZ=Wgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtnetlink: gate MAC address with an LSM hook
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, Jeffrey Vander Stoep <jeffv@google.com>,
        David Miller <davem@davemloft.net>,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Aug 29, 2019 at 3:45 AM Michal Kubecek <mkubecek@suse.cz> wrote:
> On Tue, Aug 27, 2019 at 04:47:04PM -0400, Paul Moore wrote:
> >
> > I'm also not a big fan of inserting the hook in rtnl_fill_ifinfo(); as
> > presented it is way too specific for a LSM hook for me to be happy.
> > However, I do agree that giving the LSMs some control over netlink
> > messages makes sense.  As others have pointed out, it's all a matter
> > of where to place the hook.
> >
> > If we only care about netlink messages which leverage nlattrs I
> > suppose one option that I haven't seen mentioned would be to place a
> > hook in nla_put().  While it is a bit of an odd place for a hook, it
> > would allow the LSM easy access to the skb and attribute type to make
> > decisions, and all of the callers should already be checking the
> > return code (although we would need to verify this).  One notable
> > drawback (not the only one) is that the hook is going to get hit
> > multiple times for each message.
>
> For most messages, "multiple times" would mean tens, for many even
> hundreds of calls. For each, you would have to check corresponding
> socket (and possibly also genetlink header) to see which netlink based
> protocol it is and often even parse existing part of the message to get
> the context (because the same numeric attribute type can mean something
> completely different if it appears in a nested attribute).
>
> Also, nla_put() (or rather __nla_put()) is not used for all attributes,
> one may also use nla_reserve() and then compose the attribute date in
> place.

I never said it was a great idea, just an idea ;)

Honestly I'm just trying to spur some discussion on this so we can
hopefully arrive at a solution which allows a LSM to control kernel
generated netlink messages that we can all accept.

-- 
paul moore
www.paul-moore.com
