Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E8F7B58E5
	for <lists+linux-security-module@lfdr.de>; Mon,  2 Oct 2023 19:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238648AbjJBRGM (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 2 Oct 2023 13:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbjJBRGL (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 2 Oct 2023 13:06:11 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00DFC6
        for <linux-security-module@vger.kernel.org>; Mon,  2 Oct 2023 10:06:05 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-690d2441b95so2350701b3a.1
        for <linux-security-module@vger.kernel.org>; Mon, 02 Oct 2023 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696266365; x=1696871165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FWT1o7z+vodeJwxdjf+52i0N/hl1q9fVGZUu0nFHkQk=;
        b=FQkoKYpZXBPpHO5//K/PtTfjf55oDt15pi5E9qsM+hV2MxF0mprASsxwOL9XdAxdYH
         SOxrZbHl/xNBhSDa6TphXObcSTzbr3l1vNvfOxrpGI4wTEjRw2juWLcoDlTfz7CbUwVd
         z9vqTZxjKDgFle51hwoyOiWDuF95OP3c/vfkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266365; x=1696871165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWT1o7z+vodeJwxdjf+52i0N/hl1q9fVGZUu0nFHkQk=;
        b=B2DqIYguxYKh3nZbK7e/DOGScgnIaEhnRqOEKCOAOd4C5MTvoUZEx/1PAeuPOxuIXD
         m6kgfp+MKu/w2jvteIeeyt2HisgPeaLElj5gYJRHcI9S9zhPMFRiqGEL/cg91TPV34Od
         bkLX1Nu3Hd4cn2ftkPxHZaPgy9nNmFw6OeuE87UDCQIsraLGW3Nuu/6tuxnwdTjQlqxZ
         mkb9WqaNZKf3Ec7AujMHjPiul8+yR+LosKubjLVeuUd76VzOi+5HmHK/e7pjOny4TjLB
         IzuMa5vWyREmAzUou9ETRmTbIVMjHa0rTed3nwigaYBqMVuAua12jBXe+2ZHghW+L+ek
         ZxjA==
X-Gm-Message-State: AOJu0Yw9gKshd2+yerww51/5XfxJRfDdbwOIrNy441yOeePekw+nFrQQ
        zsbHnpLy8kL26zqD9iOz8CV6mg==
X-Google-Smtp-Source: AGHT+IHWktqy/Ig5bRtUEX5eoAhhEFlysZrPjWA3hlV06CMuNlNAfXU2aoElCs528ZaVE/QaTnBecw==
X-Received: by 2002:a05:6a00:188d:b0:68b:a137:373d with SMTP id x13-20020a056a00188d00b0068ba137373dmr320609pfh.17.1696266365160;
        Mon, 02 Oct 2023 10:06:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z35-20020a056a001da300b00692c5b1a731sm15616362pfw.186.2023.10.02.10.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:06:04 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:05:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Kees Cook <kees@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] LSM: Allow dynamically appendable LSM modules.
Message-ID: <202310021000.B494D0DD@keescook>
References: <cc8e16bb-5083-01da-4a77-d251a76dc8ff@I-love.SAKURA.ne.jp>
 <57295dac-9abd-3bac-ff5d-ccf064947162@schaufler-ca.com>
 <b2cd749e-a716-1a13-6550-44a232deac25@I-love.SAKURA.ne.jp>
 <06BC106C-E0FD-4ACA-83A8-DFD1400B696E@kernel.org>
 <51d6c605-25cc-71fc-9c11-707b78297b38@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d6c605-25cc-71fc-9c11-707b78297b38@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Oct 02, 2023 at 07:04:27PM +0900, Tetsuo Handa wrote:
> On 2023/10/02 0:44, Kees Cook wrote:
> > On October 1, 2023 4:31:05 AM PDT, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wrote:
> >> Kees Cook said there is no problem if the policy of assigning LSM ID value were
> >>
> >>  1) author: "Hello, here is a new LSM I'd like to upstream, here it is. I assigned
> >>              it the next LSM ID."
> >>     maintainer(s): "Okay, sounds good. *review*"
> >>
> >>  2) author: "Hello, here is an LSM that has been in active use at $Place,
> >>              and we have $Xxx many userspace applications that we cannot easily
> >>              rebuild. We used LSM ID $Value that is far away from the sequential
> >>              list of LSM IDs, and we'd really prefer to keep that assignment."
> >>    maintainer(s): "Okay, sounds good. *review*"
> >>
> >> and I agreed at https://lkml.kernel.org/r/6e1c25f5-b78c-8b4e-ddc3-484129c4c0ec@I-love.SAKURA.ne.jp .
> >>
> >> But Paul Moore's response was
> >>
> >>  No LSM ID value is guaranteed until it is present in a tagged release
> >>  from Linus' tree, and once a LSM ID is present in a tagged release
> >>  from Linus' tree it should not change.  That's *the* policy.
> >>
> >> which means that the policy is not what Kees Cook has said.
> > 
> > These don't conflict at all! Paul is saying an ID isn't guaranteed in upstream
> > until it's in upstream. I'm saying the id space is large enough that you could
> > make a new out of tree LSM every second for the next billion years. The upstream
> > assignment process is likely sequential, but that out of sequence LSMs that show
> > a need to be upstream could make a case for their existing value.
> 
> Excuse me? If the LSM community wants the assignment sequential, the LSM community
> cannot admit the LSM value assigned to a not-yet-in-tree LSM.
> 
> If "Okay, sounds good." does not imply that the LSM community admits the LSM value
> assigned to a not-yet-in-tree LSM, what did "Okay, sounds good." mean?

I'm saying that if someone participates with upstream correctly, they'll
get a sequential ID since that is the expected process.

And if an LSM is out of tree for years and years in some large ecosystem
that has deeply hard-coded the LSM ID but now wants the LSM to land
upstream, then it's likely that an out-of-sequence ID would be accepted.

My point is that there is nothing technical stopping an out-of-tree LSM
from existing, and that the political issues for bringing a large
out-of-tree LSM upstream are going to have plenty of other negotiations
around maintaining operational behavior, of which and LSM ID is unlikely
to be a sticking point. Every release that some code (LSM or not) is out
of tree makes it that much harder to land upstream. (In other words, the
challenges to upstreaming a long-time-out-of-tree codebase are much
larger than dealing with an out-of-sequence LSM ID.)

-Kees

-- 
Kees Cook
