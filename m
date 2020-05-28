Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0C61E66B7
	for <lists+linux-security-module@lfdr.de>; Thu, 28 May 2020 17:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404600AbgE1Psb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 28 May 2020 11:48:31 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47924 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404544AbgE1Ps3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 28 May 2020 11:48:29 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKlg-0003vA-65; Thu, 28 May 2020 09:48:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeKlf-0007Eb-7U; Thu, 28 May 2020 09:48:28 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
Date:   Thu, 28 May 2020 10:44:35 -0500
In-Reply-To: <87k10wysqz.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Thu, 28 May 2020 10:38:28 -0500")
Message-ID: <87lflcxdwc.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeKlf-0007Eb-7U;;;mid=<87lflcxdwc.fsf_-_@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/QbUmGNs6WJY8er87D7LRHfXhQCTcWzGM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 506 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (2.4%), b_tie_ro: 10 (1.9%), parse: 1.84
        (0.4%), extract_message_metadata: 24 (4.6%), get_uri_detail_list: 2.0
        (0.4%), tests_pri_-1000: 36 (7.1%), tests_pri_-950: 2.4 (0.5%),
        tests_pri_-900: 1.68 (0.3%), tests_pri_-90: 129 (25.6%), check_bayes:
        126 (24.9%), b_tokenize: 25 (4.9%), b_tok_get_all: 12 (2.4%),
        b_comp_prob: 5 (1.0%), b_tok_touch_all: 77 (15.1%), b_finish: 2.6
        (0.5%), tests_pri_0: 278 (55.0%), check_dkim_signature: 1.08 (0.2%),
        check_dkim_adsp: 4.3 (0.9%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 12 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 05/11] exec: In bprm_fill_uid use CAP_SETGID to see if a gid change is safe
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


If the task has CAP_SETGID and a shared fs struct or is being ptraced
than it is clear that nothing new is being introduced when the gid
changes, and so it is safe to honor a setgid executable.

However if all we know is that the task has CAP_SETUID things are less
clear.

This bug looks like it was introduced in v2.1.100 when !suser was
replaced by !capable(CAP_SETUID).  It appears to have been an oversight
at that time.

Fixing this 22 years later seems weird but even now it still looks
worth fixing.  As conceptually what is happening is testing to see if
the process already had the potential to make a gid change or if the
trancer needs permissions in addition to the permissions needed to
trace the process to trace the process through a gid change.

Fixes: v2.1.100
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 956ee3a0d824..bac8db14f30d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1654,7 +1654,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm)
 			new->euid = new->uid;
 		}
 		if (need_cap && !gid_eq(new->egid, new->gid) &&
-		    (!ns_capable(new->user_ns, CAP_SETUID) ||
+		    (!ns_capable(new->user_ns, CAP_SETGID) ||
 		     (bprm->unsafe & LSM_UNSAFE_NO_NEW_PRIVS))) {
 			new->egid = new->gid;
 		}
-- 
2.25.0

