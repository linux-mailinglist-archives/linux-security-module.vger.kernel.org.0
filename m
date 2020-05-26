Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7FB1E239F
	for <lists+linux-security-module@lfdr.de>; Tue, 26 May 2020 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgEZOEu (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 26 May 2020 10:04:50 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:46256 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEZOEu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 26 May 2020 10:04:50 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdaC5-0003Ev-6o; Tue, 26 May 2020 08:04:37 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdaAo-0000EQ-TA; Tue, 26 May 2020 08:04:36 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Adrian Reber <areber@redhat.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>
References: <20200522055350.806609-1-areber@redhat.com>
        <dc86dffb-c7f8-15bb-db4e-be135da650cc@schaufler-ca.com>
        <20200525080541.GF104922@dcbz.redhat.com>
Date:   Tue, 26 May 2020 08:59:29 -0500
In-Reply-To: <20200525080541.GF104922@dcbz.redhat.com> (Adrian Reber's message
        of "Mon, 25 May 2020 10:05:41 +0200")
Message-ID: <877dwybxvi.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jdaAo-0000EQ-TA;;;mid=<877dwybxvi.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184zXKTFqE/g2hdbG7ONqk2DTs8REhARQ8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3728]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Adrian Reber <areber@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 9391 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.0%), b_tie_ro: 2.6 (0.0%), parse: 0.82
        (0.0%), extract_message_metadata: 3.3 (0.0%), get_uri_detail_list:
        1.72 (0.0%), tests_pri_-1000: 3.4 (0.0%), tests_pri_-950: 1.13 (0.0%),
        tests_pri_-900: 0.87 (0.0%), tests_pri_-90: 90 (1.0%), check_bayes: 89
        (0.9%), b_tokenize: 9 (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob:
        2.4 (0.0%), b_tok_touch_all: 65 (0.7%), b_finish: 0.70 (0.0%),
        tests_pri_0: 6410 (68.3%), check_dkim_signature: 0.41 (0.0%),
        check_dkim_adsp: 6008 (64.0%), poll_dns_idle: 8867 (94.4%),
        tests_pri_10: 2.8 (0.0%), tests_pri_500: 2868 (30.5%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] capabilities: Introduce CAP_RESTORE
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Adrian Reber <areber@redhat.com> writes:

> On Fri, May 22, 2020 at 09:40:37AM -0700, Casey Schaufler wrote:

>> What are the other blockers? Are you going to suggest additional new
>> capabilities to clear them?
>
> As mentioned somewhere else access to /proc/<pid>/map_files/ would be
> helpful. Right now I am testing with a JVM and it works without root
> just with the attached patch. Without access to /proc/<pid>/map_files/
> not everything CRIU can do will actually work, but we are a lot closer
> to what our users have been asking for.

The current permission checks on /proc/<pid>/map_files/ are simply
someone being over-cautious.

Someone needs to think through the threat landscape and figure out what
permission checks are actually needed.

Making the permission check ns_capable instead of capable is a
no-brainer.  Figuring out which user_ns to test against might be a
we bit harder.

We could probably even allow the owner of the process to open the files
but that requires someone doing the work of thinking through how
being able to opening files that you have mmaped might be a problem.

>> > There are probably a few more things guarded by CAP_SYS_ADMIN required
>> > to run checkpoint/restore as non-root,
>> 
>> If you need CAP_SYS_ADMIN anyway you're not gaining anything by
>> separating out CAP_RESTORE.
>
> No, as described we can checkpoint and restore a JVM with this patch and
> it also solves the problem the set_ns_last_pid fork() loop daemon tries
> to solve. It is not enough to support the full functionality of CRIU as
> map_files is also important, but we do not need CAP_SYS_ADMIN and
> CAP_RESTORE. Only CAP_RESTORE would be necessary.
>
> With a new capability users can enable checkpoint/restore as non-root
> without giving CRIU access to any of the other possibilities offered by
> CAP_SYS_ADMIN. Setting a PID and map_files have been introduced for CRIU
> and used to live behind CONFIG_CHECKPOINT_RESTORE. Having a capability
> for checkpoint/restore would make it easier for CRIU users to run it as
> non-root and make it very clear what is possible when giving CRIU the
> new capability. No other things would be allowed than necessary for
> checkpoint/restore. Setting a PID is most important for the restore part
> and reading map_files would be helpful during checkpoint. So it actually
> should be called CAP_CHECKPOINT_RESTORE as Christian mentioned in
> another email.

Please if one is for checkpoint and one is for restore asking for a pair
of capabilities is probably more appropriate.

>> >  but by applying this patch I can
>> > already checkpoint and restore processes as non-root. As there are
>> > already multiple workarounds I would prefer to do it correctly in the
>> > kernel to avoid that CRIU users are starting to invent more workarounds.
>> 
>> You've presented a couple of really inappropriate implementations
>> that would qualify as workarounds. But the other two are completely
>> appropriate within the system security policy. They don't "get around"
>> the problem, they use existing mechanisms as they are intended.
>
> I agree with the user namespace approach to be appropriate, but not the
> CAP_SYS_ADMIN approach as CRIU only needs a tiny subset (2 things) of
> what CAP_SYS_ADMIN allows.


If we are only talking 2 things can you please include in your patchset
a patch enabling those 2 things?

But even more than this we need a request that asks not for the least
you can possibly ask for but asks for what you need to do a good job.

I am having visions of a recurring discussion that says can we add one
more permission check to CAP_RESTORE or CAP_CHECKPOINT when they are
things we could know today.

Eric
