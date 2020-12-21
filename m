Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E322E0157
	for <lists+linux-security-module@lfdr.de>; Mon, 21 Dec 2020 20:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgLUT4Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 21 Dec 2020 14:56:25 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:60162 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUT4Y (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 Dec 2020 14:56:24 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1krRHT-00CG6m-5k; Mon, 21 Dec 2020 12:55:43 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1krRHS-00GWfl-5v; Mon, 21 Dec 2020 12:55:42 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     "SMACK-discuss\@lists.01.org" <SMACK-discuss@lists.01.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        LKML <linux-kernel@vger.kernel.org>
References: <dacfb329-de66-d0cf-dcf9-f030ea1370de.ref@schaufler-ca.com>
        <dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com>
Date:   Mon, 21 Dec 2020 13:55:01 -0600
In-Reply-To: <dacfb329-de66-d0cf-dcf9-f030ea1370de@schaufler-ca.com> (Casey
        Schaufler's message of "Thu, 17 Dec 2020 17:12:29 -0800")
Message-ID: <877dpbkk8a.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1krRHS-00GWfl-5v;;;mid=<877dpbkk8a.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ZoV3zem0M+sG6nXw/9Ef2BPwgVflGuUk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Casey Schaufler <casey@schaufler-ca.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 405 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 10 (2.4%), parse: 1.02
        (0.3%), extract_message_metadata: 19 (4.8%), get_uri_detail_list: 1.45
        (0.4%), tests_pri_-1000: 15 (3.7%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 88 (21.6%), check_bayes:
        85 (21.1%), b_tokenize: 6 (1.4%), b_tok_get_all: 5 (1.3%),
        b_comp_prob: 1.97 (0.5%), b_tok_touch_all: 69 (17.2%), b_finish: 0.86
        (0.2%), tests_pri_0: 226 (55.8%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.4 (0.6%), poll_dns_idle: 18 (4.5%), tests_pri_10:
        2.9 (0.7%), tests_pri_500: 37 (9.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] Smack: Handle io_uring kernel thread privileges.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Casey Schaufler <casey@schaufler-ca.com> writes:

> Smack assumes that kernel threads are privileged for smackfs
> operations. This was necessary because the credential of the
> kernel thread was not related to a user operation. With io_uring
> the credential does reflect a user's rights and can be used.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Suggested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack_access.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index efe2406a3960..7eabb448acab 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -688,9 +688,10 @@ bool smack_privileged_cred(int cap, const struct cred *cred)
>  bool smack_privileged(int cap)
>  {
>  	/*
> -	 * All kernel tasks are privileged
> +	 * Kernel threads may not have credentials we can use.
> +	 * The io_uring kernel threads do have reliable credentials.
>  	 */
> -	if (unlikely(current->flags & PF_KTHREAD))
> +	if ((current->flags & (PF_KTHREAD | PF_IO_WORKER)) == PF_KTHREAD)
>  		return true;
>  
>  	return smack_privileged_cred(cap, current_cred());
