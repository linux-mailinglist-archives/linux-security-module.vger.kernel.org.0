Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5114CD6A6
	for <lists+linux-security-module@lfdr.de>; Fri,  4 Mar 2022 15:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiCDOog (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 4 Mar 2022 09:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239925AbiCDOof (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 Mar 2022 09:44:35 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F11BD071
        for <linux-security-module@vger.kernel.org>; Fri,  4 Mar 2022 06:43:47 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qx21so17896373ejb.13
        for <linux-security-module@vger.kernel.org>; Fri, 04 Mar 2022 06:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9EdPYiVYFEGT7WXfdTQ+DM8Rd0Oojjp9HvMnxorUW0w=;
        b=2j4G/eCC5cV6nb3yTMvSO4aNKmommilMbdTyKZIgLCh6pbC0rCz0DMiqWj6OV3ivwN
         yFepQ49oQyQm0bvgi0cqP5Ipc7SrYCUGLYXQjM91bSqh2D1AX5tAE6Buc5MMQLjzqBVV
         sQ0hHlSbXynWvtz3J6lkHx2XbwAHOBT5nfATFDiPjxeb6nvrP4uURtDtR03NCEh7ayHW
         F6x65vtBMZWhuzj1JiuJS5pKPOuA7iU3/OAkiwoLOmlU3Q/jPcjs1VLp/eOMHxIhWyQC
         47jSjsq7S2TrP6pxOJGMEGDuz9/FizoFlMz0PvFNDhJeyGBejzD71WEoLr4LkyDgAm0m
         BYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9EdPYiVYFEGT7WXfdTQ+DM8Rd0Oojjp9HvMnxorUW0w=;
        b=K47in6M4okaBOdRnNyHX5y9OD4Qxw1D38wcNWYgX85xuaYhawzfAmKzABlMO+sfOcG
         qjKHaBwi0nerjU4AniK/GRJWcX6zoA6RrRiA5acJ1OOHp9vGvLn1fHQpQsBxWVIMRMm6
         cuTZpK5YGSAHAKm0LFSCE+dgOytggG3T01qlsXbQ2VDFjd26Ww1AgE3iOMA/SlleS2o6
         s9SE5qREz9fbX37V1M0iETacZnVJndgttAGhWBATdz9vKVaEFehAdy4DGraoUUVY1YnH
         MQNdmL5yRNQmlq5ut7YFhyuhjF9RaHxybF2FhDlFkLhomN29aXb7+CHFHqrHD7jqaYOO
         BGqQ==
X-Gm-Message-State: AOAM530ZZLTHZLy1tK1hEz2/QpksRAJe+cQb9r3p76hrxCdsmlhjvTE+
        AO6uzPxxmFfJ5klDauiBFP5ETXURAvN8l9ZuPaoK
X-Google-Smtp-Source: ABdhPJwYUPmHIXmuKyRCCCuUwU1LnQ4xS2DnqMVUc3W2/V05vUsnDQ9LEnCVCgEeQJeBjV1s2lpXWERkfieRwSRzXkc=
X-Received: by 2002:a17:907:da6:b0:6da:8f3f:d563 with SMTP id
 go38-20020a1709070da600b006da8f3fd563mr6651337ejc.112.1646405025870; Fri, 04
 Mar 2022 06:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20220202235323.23929-1-casey@schaufler-ca.com>
 <20220202235323.23929-25-casey@schaufler-ca.com> <CAHC9VhS6An9L7LavYTP57QXdOugQf62NCjDmS4kQq3wk+yemcg@mail.gmail.com>
 <0bbd2d61-415f-08f2-251e-2dd6b8991d6a@schaufler-ca.com>
In-Reply-To: <0bbd2d61-415f-08f2-251e-2dd6b8991d6a@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 4 Mar 2022 09:43:34 -0500
Message-ID: <CAHC9VhQEJOu_G16eSfMipbMyU-fQZW6bnm2OdstmKHLdgm9Nsg@mail.gmail.com>
Subject: Re: [PATCH v32 24/28] Audit: Add framework for auxiliary records
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Mar 3, 2022 at 9:13 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 3/3/2022 3:36 PM, Paul Moore wrote:
> > Adding a new aux record would involve calling some private audit
> > function (no one outside of the audit subsystem should need access)
> > that would allocate a new skb similar to what we do in
> > audit_buffer_alloc() and add it to the end of the sk_buff_head list
> > via skb_queue_tail() and resetting audit_buffer::skb to point to the
> > newly allocated skb.
>
> Good naming may be tricky as we need to indicate that a new buffer is
> being allocated for an attached aux record and that the buffer to which
> it's being attached is going to temporarily be in a curious state.
> audit_buffer_add_aux() seems wordy, but it's what I'll start with lacking
> a better suggestion.

I agree that it will leave the audit_buffer in an odd state, at least
with the current definition of the audit_buffer.  However, this is
mitigated by the restriction that the only callers should be within
the audit subsystem.  Here is some quick pseudo-code mockup of what
I'm thinking:

/* on success, ab->skb will point to the new aux record */
static int audit_buffer_aux_new(struct audit_buffer *ab, int type)
{
  WARN_ON(ab->skb != skb_peek(&ab->skb_list));

  ab->skb = nlmsg_new(AUDIT_BUFSIZ, ab->gfp_mask);
  if (!ab->skb)
    goto err;
  if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
    goto err;
  skb_queue_tail(&ab->skb_list);
  return 0;

err:
  kfree_skb(&ab->skb);
  ab->skb = skb_peek(&ab->skb_list);
  return -ENOMEM;
}

/* restores the "main" record into ab->skb */
static void audit_buffer_aux_end(struct audit_buffer *ab)
{
  ab->skb = skb_peek(&ab->skb_list);
}

/* free the current aux record and reset ab->skb to the "main" */
static void audit_buffer_aux_cancel(struct audit_buffer *ab)
{
  if (ab->skb != skb_peek_tail(&ab->skb_list)) {
    BUG();
    return;
  }
  ab->skb = skb_peek(&ab->skb_list);
  kfree_skb(skb_dequeue_tail(&ab->skb_list));
}

-- 
paul-moore.com
