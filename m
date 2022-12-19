Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3137D651583
	for <lists+linux-security-module@lfdr.de>; Mon, 19 Dec 2022 23:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiLSWYn (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 19 Dec 2022 17:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiLSWYm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 19 Dec 2022 17:24:42 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B92B7CB
        for <linux-security-module@vger.kernel.org>; Mon, 19 Dec 2022 14:24:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so10322562pjd.0
        for <linux-security-module@vger.kernel.org>; Mon, 19 Dec 2022 14:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VAT/DeU4WF68oq7nSs81RA7o2EbEGc7CyHhB3lQLXe4=;
        b=GgGIluoprh00zY/KQJOuCpGQ8xQZ+yMoUwdFW/1pMXkUmgm+gflowLVZAy6RIzO0h8
         sdW3yR0kfA0HA0gH9xYdYKBELdmACUSLvGeRs8O5opcvC5lCkn4uGPhE9zwmT8UkBfte
         jnTuvUdkwAECXCbaqvJ1sdLfa2smauLfvuGywfGkUGHRULbeEv5VdZ3dygx3sMadXR4o
         J6vmHaEVLLVYfBbAMt82VwXzDVKlBbSgOf6U0ko6NTeAUANd8V7SWOqKdvbAx1XaglmY
         Pra0GwFtC5SUmK2iZywxYzYlyOLuPLnyZbYRHB4Jli5FdZecXdRz49X0qX5T1DkwJR94
         C+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAT/DeU4WF68oq7nSs81RA7o2EbEGc7CyHhB3lQLXe4=;
        b=gOHmEJBErYW+7nthlyuXxrD3TMZYxTeWe6xxUt9R6eWki34pti+i++gX1qT3nz/Pcx
         q7KBRgc3qa5KWjguNg2QXQFe2rZUp5g7nhCcK29cl+dciJjYEwXupELnXd1hSTCe+FSx
         8SO8S+XkMaPvAHqkHLGJ0tJDDX/YRQDsx//59fizdcrOMkBrNrzXQGsdeCsDv++O/PoL
         NHAv2ztgR0f5GfEendu4Kmw2VdLWm9oq4Hj25IlQMOZkSzSO+IXEvseynM7Xv+IBJFQ0
         mJ+2sJ5WhEiLJ2FFu7CvVUAiKZT9ecKVw5NamEaUM7tMV+zb7Un0P+tUEQZxCpbqFIvz
         xUzw==
X-Gm-Message-State: AFqh2krkNE1V20O0aFxE6btHNpTFaBBbxxC3zjN9fj3qTvD150arIYQ9
        a27Zh+7ROT7AQzS2v3kO0rwTQm02BjoAmEBTsOsn
X-Google-Smtp-Source: AMrXdXsgvCSuQsV5A3IA7e2nywnPvULN+JePYCpJFFzRUH/F9wNdmrLucNJ4UzmtEMrD+9wKjOAcEMhqw357dWJmEM0=
X-Received: by 2002:a17:90a:6481:b0:221:5597:5de7 with SMTP id
 h1-20020a17090a648100b0022155975de7mr1623054pjj.147.1671488680853; Mon, 19
 Dec 2022 14:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20221219175449.1657640-1-omosnace@redhat.com> <20221219175449.1657640-2-omosnace@redhat.com>
 <fae32a51-d422-d3ea-0bee-6223ca2cf902@schaufler-ca.com>
In-Reply-To: <fae32a51-d422-d3ea-0bee-6223ca2cf902@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Dec 2022 17:24:29 -0500
Message-ID: <CAHC9VhT8TiEFPBFeRXzE6qCyyXjL4rtQc7=iJ+AqeBkkfgw-mA@mail.gmail.com>
Subject: Re: [PATCH 1/2] audit: introduce a struct to represent an audit timestamp
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>,
        selinux@vger.kernel.org,
        Peter Enderborg <peter.enderborg@sony.com>,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        Zdenek Pytela <zpytela@redhat.com>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Dec 19, 2022 at 1:47 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 12/19/2022 9:54 AM, Ondrej Mosnacek wrote:
> > Join the two fields that comprise an audit timestamp into a common
> > structure. This will be used further in later commits.
>
> Patch 30/39 of my LSM stacking patchset[1] is almost identical to this.
> The only significant difference is the structure name. You use audit_timestamp
> whereas I use audit_stamp. I believe that audit_stamp is more correct and
> more consistent with the code that uses it.
>
> [1] https://lore.kernel.org/lkml/f6b8ac05-6900-f57d-0daf-02d5ae53bc47@schaufler-ca.com/T/#m3205b98b2a6b21a296fb831ed35892f01ead191f

For the record, if "audit_stamp" and "audit_timestamp" are my only two
options I prefer "audit_stamp" simply because it is shorter :)

That said, see my comments on patch 2/2.  While an audit timestamp
struct improvement such as is proposed here and in the LSM stacking
patchset is fine, I'm not in favor of exposing the audit timestamp
outside the audit subsystem.

-- 
paul-moore.com
