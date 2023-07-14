Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1B3752F65
	for <lists+linux-security-module@lfdr.de>; Fri, 14 Jul 2023 04:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGNCa4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 13 Jul 2023 22:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjGNCaz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 13 Jul 2023 22:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E812D40
        for <linux-security-module@vger.kernel.org>; Thu, 13 Jul 2023 19:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689301808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7rR7vBZIbJEjWBvWkQDdyveT7be3Oj/MPoWB5KAF05U=;
        b=N2+zTmiTQaWkSVZPc2tMk0g9H+U0DefJ4H8Dm6lh21U8gGpjl74xX3PvEI9Ge6dOFiB+pK
        MKxm/TGgl4d3JluWwGlaqBodHNqNjxI/JDby2VwbFwVHnVXsjVgL9x4STgMlWXiAmJjdjW
        LCILQTlVJ8rqPIMT5X0lxnb8wDzwpIM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-8Qxzw9_YNguiMQME2wLZlg-1; Thu, 13 Jul 2023 22:30:07 -0400
X-MC-Unique: 8Qxzw9_YNguiMQME2wLZlg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-55b1a2f51edso783435a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 13 Jul 2023 19:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689301806; x=1691893806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rR7vBZIbJEjWBvWkQDdyveT7be3Oj/MPoWB5KAF05U=;
        b=lYfIwGhxnvgOr0iH0bBj1jlofVjhnHyRRAPAgFwPvGUu2QKkcdhgeKgcO8CfGi+6MX
         U6fS4iXmCYDIoF1uCPAU0F+OH35WgBWjArVs92QMlg+7jCHngQbFLNPK4I9ftQKB17J9
         wx0yDXELu0lC7G8XdteXCfqKAHOxTUcuSgRb15sOh+/kRLUGh+SXoo8AF3CfD+bxR1KF
         tDjAa+XsRxASrME/dZWZbM1A84kw42AitPXo0XpyQhzTVVfNjPQz0glEabjYbsJzmlQX
         azNT49bcBb7TcTKQfgFDWESnk/r17/SudmPTR6oUCUpP22W6MHppW5Fwbt5LLeGpRdMm
         pjFw==
X-Gm-Message-State: ABy/qLah/3ccE18uvoVeVOQjzbsDhDENNi36N0zTWNSiVbNzF420JUbO
        4aVr9+yIlQIx+X5DgsXf2x/E7zlbpCE+XjqcmI7/ygO8kQBLHrT76tKh7aDXrynLP5FBvsPQ6Wo
        2MdMxOrjcYsocXLy3cBwR4s1bXlxNkfnTk/vU
X-Received: by 2002:a17:903:32cd:b0:1b8:a936:1905 with SMTP id i13-20020a17090332cd00b001b8a9361905mr3308411plr.38.1689301806531;
        Thu, 13 Jul 2023 19:30:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEs4pde8jppPSPo0CHtKv6YPw48gJ9ZsJ9Jr04I327cFtviAE9UC1q66//Yn7OoEuBGrzwEoQ==
X-Received: by 2002:a17:903:32cd:b0:1b8:a936:1905 with SMTP id i13-20020a17090332cd00b001b8a9361905mr3308403plr.38.1689301806236;
        Thu, 13 Jul 2023 19:30:06 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902c50d00b001b03b7f8adfsm6566850plx.246.2023.07.13.19.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 19:30:05 -0700 (PDT)
Date:   Fri, 14 Jul 2023 10:29:56 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "open list:KEXEC" <kexec@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kexec_file: ima: allow loading a kernel with its IMA
 signature verified
Message-ID: <4d6t456sswt66tnpzysxuu2wmlgkmlww3elhdsf4fxzejbroza@qig3hahn5paq>
References: <20230711031604.717124-1-coxu@redhat.com>
 <eaa1f1901abbceb2edc0aadaa94d9d959413c984.camel@linux.ibm.com>
 <6879D379-926E-4684-8CB2-B84D81E697D4@oracle.com>
MIME-Version: 1.0
In-Reply-To: <6879D379-926E-4684-8CB2-B84D81E697D4@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jul 13, 2023 at 05:59:38PM +0000, Eric Snowberg wrote:
>
>
>> On Jul 12, 2023, at 12:31 PM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> [Cc'ing the LSM mailing list.]
>>
>> On Tue, 2023-07-11 at 11:16 +0800, Coiby Xu wrote:
>>> When IMA has verified the signature of the kernel image, kexec'ing this
>>> kernel should be allowed.
>>>
>>> Fixes: af16df54b89d ("ima: force signature verification when CONFIG_KEXEC_SIG is configured")
>>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>>
>> The original commit  29d3c1c8dfe7 ("kexec: Allow kexec_file() with
>> appropriate IMA policy when locked down") was not in lieu of the PE-
>> COFF signature, but allowed using the IMA signature on other
>> architectures.
>>
>> Currently on systems with both PE-COFF and IMA signatures, both
>> signatures are verified, assuming the file is in the IMA policy.  If
>> either signature verification fails, the kexec fails.
>>
>> With this patch, only the IMA signature would be verified.
>>
>>> ---
>>> kernel/kexec_file.c | 14 +++++++++-----
>>> 1 file changed, 9 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>> index 881ba0d1714c..96fce001fbc0 100644
>>> --- a/kernel/kexec_file.c
>>> +++ b/kernel/kexec_file.c
>>> @@ -162,6 +162,13 @@ kimage_validate_signature(struct kimage *image)
>>> 	ret = kexec_image_verify_sig(image, image->kernel_buf,
>>> 				     image->kernel_buf_len);
>>> 	if (ret) {
>>> +		/*
>>> +		 * If the kernel image already has its IMA signature verified, permit it.
>>> +		 */
>>> +		if (ima_appraise_signature(READING_KEXEC_IMAGE)) {
>>> +			pr_notice("The kernel image already has its IMA signature verified.\n");
>>> +			return 0;
>>> +		}
>
>The issue I see here is ret could be many things, for example it could be
>-EKEYREJECTED, meaning it was contained on a revocation list.  With this patch
>the revocation could be overruled if the image was IMA signed with a different
>key.  Do we really want to add the ability to overrule a revocation?

Thanks for raising the concern! I haven't thought about this case of the
key being in a revocation list. If the IMA signature comes from a
distribution, the distribution should also blocklist the IMA key when
the PE-COFF signature key is added to the revocation list. If the IMA
signature is from an end-user, I think the user wants to pass the
verification in this case.

Or how about only allowing IMA signature when EFI runtime services are
disabled?  Another reason I am yet to add to the commit message is a
real-time kernel currently disables EFI runtime services for latency
issues so it can't access the MOK keys to verify the PECOFF signature.

