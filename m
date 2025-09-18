Return-Path: <linux-security-module+bounces-11331-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB99B1BAFF
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Aug 2025 21:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C356164923
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Aug 2025 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFE71DF258;
	Tue,  5 Aug 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Qw0fbRPm"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B00421D5BF
	for <linux-security-module@vger.kernel.org>; Tue,  5 Aug 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422755; cv=none; b=BFxtCN/qdbKBw65R6/E1GQIh/y2L3b/CPm//xQY13helj0oMO4kZrvz2UBngsPXL1KhH6xaf6jdG/7I/dIgSKo7d/zIazD8wjYRLjm84yKojxCMmYmvRE6Yw+F+UfFbK0KveZo3XEg0JuxQ6aZEp75kHB4i6SvIbc+KFW1db+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422755; c=relaxed/simple;
	bh=mNM5ceg27t1pmPc6MFL1IkCx1VG1gkdG1QIjBvtyi7c=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Q42ouGEBHdvUZvEEQ2bZeWBbY7x+cORwEd3MsKokRXPNx64Jaz4aE/iRWmrogCsK6f2dn2vtCO1LrRrYFXBv6P+ClkQVwugovEPefTKmDcKyQ7XGH1f9UhDCdFl/tAISecZGXxw2tVOEMBtkWutDfdSifUhO4bi38bzatRx5Kw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Qw0fbRPm; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b07cb2d13bso22172441cf.1
        for <linux-security-module@vger.kernel.org>; Tue, 05 Aug 2025 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754422752; x=1755027552; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTPNLEZZkuqyqQbmqm6Yfc3sc2AjHLZIpvjt/gfXteU=;
        b=Qw0fbRPmQEB1LYmjJNbWlfw2ahY3H9mrmRSpdv7bm+TU4q7AUiZOZkIYQpzsR3pbKR
         KrU8n5TM9Qhgbzyx5piyv0tbflSLxWspj/yKt5unYY+LbTToKyY/zRCORTBG+OJUtCjz
         I0FjyuUnU/xilHk5v+CWoKgdzXJDAuHv1lkwfhb8CjKxdjBLNNsyctssUgwBayL9xnwh
         uZLzoUvy/L3sgeWGyj4+gT7WLLkuQbenDfhbDwcfIMo475xseSKWE4u2cuRWIW7NFKsT
         9GretgrGFwQbXDFD8KMsho5ORPAC4Am0YkCJSYi0xHW5OuwZZh8wpnmB4fiTVD6C2yPB
         Q2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422752; x=1755027552;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZTPNLEZZkuqyqQbmqm6Yfc3sc2AjHLZIpvjt/gfXteU=;
        b=hsYmiXJPjzXd8o7OuZZ8PxICEinz5HOC138BeLAgL+rDMH5c7chPv717Og9xQI9cFc
         X3/mgQLr0N7EGimd9p7jJ/RInalTEE9dwHjCIUXAnx0FcQJjHoIyDrKdGEBmB2A/fMrb
         izHEC/8nALi9dKCBiFEIoWtCUVO9S+eR9xDILBJtlQTTDfrEO3Czejmvt4GO9Lg52ZgY
         W1n+YjXCZMXHanqLrNjjHKBQTqZ9vsqcC2bfq+t/C8OzGVa5MZOunUNhVIr88454ndfX
         AHLe0MhzivYVhUO994CnG3PYc1wSCmWtBcMGYoKdOU/bUq0JTDoS+LQ/J5g+oyfioSs7
         AD8A==
X-Forwarded-Encrypted: i=1; AJvYcCVO7dJvbRQMuPNSY+BIfjEZq6lzcADXyEzYNhQYDpWYsheioZfda6cQbRTpvNyBM7UHyA7cWA57dNGdt2Oedm3vVVQZAZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNuHmujpLizcx4b1qdWy6wsf5lkMbvqklCMAE7HmSqUJBUzZy
	DQQrfcHO+CKOEBlG+Wp0peCHiuz5Gz9HlG9gMpNmQHkdGo1EG/fQDVdWiSH/kWptQw==
X-Gm-Gg: ASbGnctqIVA9pRu1r/3ErgT2rGeTxtJ36wwKggdmmH5ERS/+6Kq54eKr8ox0EnxuZHm
	joM4OI5zpJabiLx8HHMXJmHLsP6oq+L8ItUdFf6bqFF2bRdBMvSIeLTYlYkk3rW6XiXs5FtLAjp
	Ki8t9wA3EGYTYwMXRwwFVO7MyIN5NFbFf8P/5us/la/8TmypodAyzvVqENhIDzmXd253PYyoPS/
	lA6RJXa9/vFW08PgOO1E6tTPu5rWgO8OkK2R+978siqL4NqJI0njTPKCHnQ4dC6snwhvUQYerOd
	mHPe8kaBBmDWsg4VYOpvlPJT2LT2LUt7VR3/h8eg4LX1EOUNFSc/zRC3om0O5rHOQsApWKpiWK1
	Yo0GJX7cOoaSk4ecAm+kQySPh52+TxV9+krLFWd1BgnSO98H2tVxks/IlbXtiWbT6UZ8=
X-Google-Smtp-Source: AGHT+IG8l0bLRrSlwfPmL45Yk0MG8/c7kPJgmEK8f1pFbtct6QaXmsUO6kX5XPX2x2gQ5mXM1RQ4YA==
X-Received: by 2002:a05:622a:216:b0:4ab:c0ec:6236 with SMTP id d75a77b69052e-4b09132dd52mr2620841cf.12.1754422752057;
        Tue, 05 Aug 2025 12:39:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4aeeed67010sm69419191cf.30.2025.08.05.12.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:39:11 -0700 (PDT)
Date: Tue, 05 Aug 2025 15:39:10 -0400
Message-ID: <aafebe14727836ea747b97982926cc38@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250805_1248/pstg-lib:20250804_1752/pstg-pwork:20250805_1248
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, eparis@redhat.com, linux-security-module@vger.kernel.org, audit@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v5 3/5] Audit: Add record for multiple task security  contexts
References: <20250716212731.31628-4-casey@schaufler-ca.com>
In-Reply-To: <20250716212731.31628-4-casey@schaufler-ca.com>

On Jul 16, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> Replace the single skb pointer in an audit_buffer with a list of
> skb pointers. Add the audit_stamp information to the audit_buffer as
> there's no guarantee that there will be an audit_context containing
> the stamp associated with the event. At audit_log_end() time create
> auxiliary records as have been added to the list. Functions are
> created to manage the skb list in the audit_buffer.
> 
> Create a new audit record AUDIT_MAC_TASK_CONTEXTS.
> An example of the MAC_TASK_CONTEXTS record is:
> 
>     type=MAC_TASK_CONTEXTS
>     msg=audit(1600880931.832:113)
>     subj_apparmor=unconfined
>     subj_smack=_
> 
> When an audit event includes a AUDIT_MAC_TASK_CONTEXTS record the
> "subj=" field in other records in the event will be "subj=?".
> An AUDIT_MAC_TASK_CONTEXTS record is supplied when the system has
> multiple security modules that may make access decisions based on a
> subject security context.
> 
> Refactor audit_log_task_context(), creating a new audit_log_subj_ctx().
> This is used in netlabel auditing to provide multiple subject security
> contexts as necessary.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h        |  16 +++
>  include/uapi/linux/audit.h   |   1 +
>  kernel/audit.c               | 207 +++++++++++++++++++++++++++++------
>  net/netlabel/netlabel_user.c |   9 +-
>  security/apparmor/lsm.c      |   3 +
>  security/lsm.h               |   4 -
>  security/lsm_init.c          |   5 -
>  security/security.c          |   3 -
>  security/selinux/hooks.c     |   3 +
>  security/smack/smack_lsm.c   |   3 +
>  10 files changed, 202 insertions(+), 52 deletions(-)

If there were no other issues with this patch I would have just fixed
this up during the merge (I did it in my review branch already), but
since you're no longer dependent on the LSM init rework changes (and
I've dropped the subj/obj counting in the latest revision), just go
ahead and base your next revision on the audit tree or Linus' tree as
one normally would.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 226c8ae00d04..c7dea6bfacdd 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c

...

> +/**
> + * audit_log_subj_ctx - Add LSM subject information
> + * @ab: audit_buffer
> + * @prop: LSM subject properties.
> + *
> + * Add a subj= field and, if necessary, a AUDIT_MAC_TASK_CONTEXTS record.
> + */
> +int audit_log_subj_ctx(struct audit_buffer *ab, struct lsm_prop *prop)
>  {
> -	struct lsm_prop prop;
>  	struct lsm_context ctx;
> +	char *space = "";
>  	int error;
> +	int i;
>  
> -	security_current_getlsmprop_subj(&prop);
> -	if (!lsmprop_is_set(&prop))
> +	security_current_getlsmprop_subj(prop);
> +	if (!lsmprop_is_set(prop))
>  		return 0;
>  
> -	error = security_lsmprop_to_secctx(&prop, &ctx, LSM_ID_UNDEF);
> -	if (error < 0) {
> -		if (error != -EINVAL)
> -			goto error_path;
> +	if (audit_subj_secctx_cnt < 2) {
> +		error = security_lsmprop_to_secctx(prop, &ctx, LSM_ID_UNDEF);
> +		if (error < 0) {
> +			if (error != -EINVAL)
> +				goto error_path;
> +			return 0;
> +		}
> +		audit_log_format(ab, " subj=%s", ctx.context);
> +		security_release_secctx(&ctx);
>  		return 0;
>  	}
> -
> -	audit_log_format(ab, " subj=%s", ctx.context);
> -	security_release_secctx(&ctx);
> +	/* Multiple LSMs provide contexts. Include an aux record. */
> +	audit_log_format(ab, " subj=?");
> +	error = audit_buffer_aux_new(ab, AUDIT_MAC_TASK_CONTEXTS);
> +	if (error)
> +		goto error_path;
> +
> +	for (i = 0; i < audit_subj_secctx_cnt; i++) {
> +		error = security_lsmprop_to_secctx(prop, &ctx,
> +						   audit_subj_lsms[i]->id);
> +		if (error < 0) {
> +			/*
> +			 * Don't print anything. An LSM like BPF could
> +			 * claim to support contexts, but only do so under
> +			 * certain conditions.
> +			 */
> +			if (error == -EOPNOTSUPP)
> +				continue;
> +			if (error != -EINVAL)
> +				audit_panic("error in audit_log_task_context");

Argh ... please read prior review comments a bit more carefully.  As was
pointed out in the v4 posting you're using the wrong function name here.

https://lore.kernel.org/audit/fc242f4c853fee16e587e9c78e1f282e@paul-moore.com

> +		} else {
> +			audit_log_format(ab, "%ssubj_%s=%s", space,
> +					 audit_subj_lsms[i]->name, ctx.context);
> +			space = " ";
> +			security_release_secctx(&ctx);
> +		}
> +	}
> +	audit_buffer_aux_end(ab);
>  	return 0;
>  
>  error_path:
> -	audit_panic("error in audit_log_task_context");
> +	audit_panic("error in audit_log_subj_ctx");
>  	return error;
>  }
> +EXPORT_SYMBOL(audit_log_subj_ctx);

...

> @@ -2423,25 +2575,16 @@ int audit_signal_info(int sig, struct task_struct *t)
>  void audit_log_end(struct audit_buffer *ab)
>  {
>  	struct sk_buff *skb;
> -	struct nlmsghdr *nlh;
>  
>  	if (!ab)
>  		return;
>  
> -	if (audit_rate_check()) {
> -		skb = ab->skb;
> -		ab->skb = NULL;
> +	while ((skb = skb_dequeue(&ab->skb_list)))
> +		__audit_log_end(skb);
>  
> -		/* setup the netlink header, see the comments in
> -		 * kauditd_send_multicast_skb() for length quirks */
> -		nlh = nlmsg_hdr(skb);
> -		nlh->nlmsg_len = skb->len - NLMSG_HDRLEN;
> -
> -		/* queue the netlink packet and poke the kauditd thread */
> -		skb_queue_tail(&audit_queue, skb);
> +	/* poke the kauditd thread */
> +	if (audit_rate_check())
>  		wake_up_interruptible(&kauditd_wait);
> -	} else
> -		audit_log_lost("rate limit exceeded");

... here is another case where you've missed/ignored previous feedback.
I believe this is the second revision in the history of this patchset
where you've missed feedback; *please* try to do better Casey, stuff like
this wastes time and drags things out longer than needed.

https://lore.kernel.org/audit/fc242f4c853fee16e587e9c78e1f282e@paul-moore.com

>  	audit_buffer_free(ab);
>  }

--
paul-moore.com

