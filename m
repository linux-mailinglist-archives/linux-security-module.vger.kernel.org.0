Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD634E6158
	for <lists+linux-security-module@lfdr.de>; Thu, 24 Mar 2022 10:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349370AbiCXJzk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 24 Mar 2022 05:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349089AbiCXJzj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 Mar 2022 05:55:39 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3435C863
        for <linux-security-module@vger.kernel.org>; Thu, 24 Mar 2022 02:54:07 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id s18so4308031vsr.1
        for <linux-security-module@vger.kernel.org>; Thu, 24 Mar 2022 02:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=13+rXwGRPr4a9k2vxA2bU+fJEZZ58Un4R7s1pCG1lS8=;
        b=pCqWJ6IEwu7H3b21M6lq+dvU7KcWEFQXW27HSvhLVqkPIWfnScMDIznjzeHY1Xr/Cv
         55ZuLtP2jdmG3QSehqyHH0kuEMDnb3Qtp2et43HmoQLF07HfQu2lE2+C3N+xyrZaqGbj
         T4s+M73Go7/u/mAw/v6bZ0mD8SLaTVqSbiZtRiFgjV0eLlBt0jA2yU0C7Xb77O5FBPBs
         lTJv5zW7nsvyyRFh5gCEDxLQm30fj9nmLTeieOawV22TZZ85rr6HeeRC0NO2AZ0Kmgbe
         YHs/PmYW/awPgHnVdvodLHHHqkPFcpg/Zk+T64BuoiqrN7zyKk5ftgmtLx9Y4y3iEDYy
         UgMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=13+rXwGRPr4a9k2vxA2bU+fJEZZ58Un4R7s1pCG1lS8=;
        b=4FUWiv9SiBppDlemPx7/8BxMdmWGEwl3PjB4ljLHaJI9kiNWXhBksbE1wlwGCM6Htk
         sq7ZsD/e7pozi+A7L7THp8j1qvVlUkyC3bFXg8YcgMoIFvbkoBwcSS8nzBK654lSxK4L
         7P1jv0Zwc9pW4+myyX3hyjXOXoWVcoeV9SiDz61TB1wqoJpTsOFcY/7rsMbUXtFC9j/n
         M4sWW4zqHLAqvdhWRwNw2OnU01sP0hNeqZ9iWOgv+9C9/+CGKnziRpgVcK4nTXwoF3j/
         fsje7Oa45f58bGwAch+nq/gHsCsxrMGcx+GnU7nAHJKnm3eVbH006gUTZO/I0gE/Wq3P
         6/sw==
X-Gm-Message-State: AOAM5335sOrDNAuELBayYkAzZaYMEYymE4tRcxNoeS869EMH7MhpeqWi
        hSPFOrDeetsJdJ42UHxWTMUxJefxKlxyHB7IhX0=
X-Google-Smtp-Source: ABdhPJw1WdongvX6cLj4accQ9JY6898x77nQqf/nyqhNrVP3DL+lMweVws+zRrqLv+M6shfeJovU3Xw1fXo7FCxwxvs=
X-Received: by 2002:a67:eaca:0:b0:31b:f480:6de2 with SMTP id
 s10-20020a67eaca000000b0031bf4806de2mr2045479vso.24.1648115646656; Thu, 24
 Mar 2022 02:54:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:5c12:0:b0:2a3:1110:6996 with HTTP; Thu, 24 Mar 2022
 02:54:06 -0700 (PDT)
Reply-To: ozkansahin.gbbva@gmail.com
From:   OZKAN SAHIN <ahmeddiarra25@gmail.com>
Date:   Thu, 24 Mar 2022 12:54:06 +0300
Message-ID: <CAMpRB37ektaDdT_H7KzOV36sq3mADrNJQyELZRbhQ-ROx-9Qxg@mail.gmail.com>
Subject: Greetings to You
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4426]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ahmeddiarra25[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ahmeddiarra25[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Greetings,
I'm  Ozkan Sahin, and I work as a Financial Management Consultant. I'm
thrilled to approach you and present you with a lucrative offer I've
prepared. If you're interested in learning more, Please reply as soon
as possible.

Please contact me at (ozkansahin.gbbva@gmail.com).
Respectfully,
Ozkan Sahin
Financial Management Consultant
