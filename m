Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C3E50BCFF
	for <lists+linux-security-module@lfdr.de>; Fri, 22 Apr 2022 18:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355209AbiDVQa4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 22 Apr 2022 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiDVQaz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 22 Apr 2022 12:30:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B305EBF1
        for <linux-security-module@vger.kernel.org>; Fri, 22 Apr 2022 09:28:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w4so11773515wrg.12
        for <linux-security-module@vger.kernel.org>; Fri, 22 Apr 2022 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9bDWcRZVjx6GPxFzW3UVWhMMo07Zuw7+gtRI+X12kIY=;
        b=79S0AvECfJoFsHa2OLfcMdtwWILG5UB8TcEvYJkodbNOprYOeNc08ZiU83eUZEhclp
         Q91DiEx3Ph0IS64JucJtoyZPZxIIONW0WL84gOoog140iSkoygCeU+GGZLsz00NlbUsc
         XHL5Y/DXa9FD0dbjT5WsKWLnx6S+/cEIfrhBldN2a2JooajesP3/F8EqE4XXv2Temx6r
         DS9+ndOgLYwsrFFeiInxz5Tcr0hJWQvA8NnU7hWHoPxqlgfpjnfUUOs0TCtj4nLtj1Gc
         h96d1llH8q53gI1vT9jdKBxuVTm9XNdd1JFIs6zzXWJL9R989Uw8V1/jUr7cYts7k6rS
         XCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bDWcRZVjx6GPxFzW3UVWhMMo07Zuw7+gtRI+X12kIY=;
        b=qXwd0npISCXeC6qUyodKW+pqiFhbm7eKI1Zqp8x3mX3WbqQGhHUVg3hqxFAJZpd6dM
         rxpdOqFj4NhCgElagZz052QEgvzA/e4eNm1TfLBx32ELgQKyE2PEgwsSzKBRlhYL7zlu
         0Y6NcEhmGIHRQwysTE6hvciAqlDBAO8Y3FFb/y3W+nspk2IqUYxI4UWF+XrYwb5qWCrq
         SW7GoHVZCdaA6SCfRjDKng6pthDJBSD/jV0icpvzHs18bUf1a7RSKvUkxoLlZ4XibcEx
         oNpXmwCuw5nco0reM1hvOIpePSDOTog3CX5AheMVGhhJm9kSvDJJ24yOVBuL7gHUAwnW
         9gEA==
X-Gm-Message-State: AOAM533BlCcqj762ieFwp3nX2Rmrff8iGn8HAhpMmlBzvkL+kfXUVGej
        ca4Sb5quxNPiZs5mGZuSIrTffc6BU9h9WxlIhpvZ
X-Google-Smtp-Source: ABdhPJwdlLgCr8/r8VUVhCDVqpoOKgB7ViucHZSYkzmPRtbdWPlYnR3ZpOIh8SIIvGQjH5nxZNxeK5ajA4b8BchK7Jc=
X-Received: by 2002:a5d:59a5:0:b0:20a:95c8:7820 with SMTP id
 p5-20020a5d59a5000000b0020a95c87820mr4295435wrr.395.1650644880760; Fri, 22
 Apr 2022 09:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com> <20220418145945.38797-26-casey@schaufler-ca.com>
In-Reply-To: <20220418145945.38797-26-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Apr 2022 12:27:50 -0400
Message-ID: <CAHC9VhTSdTm+91NtwkuKBi=uY9233kFAzPY=wYpeepcFwanZ=w@mail.gmail.com>
Subject: Re: [PATCH v35 25/29] Audit: Allow multiple records in an audit_buffer
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Apr 18, 2022 at 11:12 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Replace the single skb pointer in an audit_buffer with
> a list of skb pointers. Add the audit_stamp information
> to the audit_buffer as there's no guarantee that there
> will be an audit_context containing the stamp associated
> with the event. At audit_log_end() time create auxiliary
> records (none are currently defined) as have been added
> to the list.
>
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  kernel/audit.c | 62 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 23 deletions(-)

I believe the audit_buffer_aux_new() and audit_buffer_aux_end()
functions from patch 26/29 belong in this patch, but otherwise it
looks okay to me.

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
