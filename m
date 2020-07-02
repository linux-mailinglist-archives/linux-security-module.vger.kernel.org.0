Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0BB212A1A
	for <lists+linux-security-module@lfdr.de>; Thu,  2 Jul 2020 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgGBQr5 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 2 Jul 2020 12:47:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49492 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgGBQrz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 2 Jul 2020 12:47:55 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NO-0005mw-EU; Thu, 02 Jul 2020 10:47:54 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jr2NN-0007up-CI; Thu, 02 Jul 2020 10:47:54 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu,  2 Jul 2020 11:41:31 -0500
Message-Id: <20200702164140.4468-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1jr2NN-0007up-CI;;;mid=<20200702164140.4468-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19BYxbgM2/WpYLmhX4Zn7rTUKzvDV+Q0BI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 566 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 9 (1.7%), parse: 1.05 (0.2%),
         extract_message_metadata: 16 (2.8%), get_uri_detail_list: 2.6 (0.5%),
        tests_pri_-1000: 25 (4.4%), tests_pri_-950: 1.30 (0.2%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 182 (32.2%), check_bayes:
        181 (31.9%), b_tokenize: 11 (2.0%), b_tok_get_all: 10 (1.7%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 153 (27.0%), b_finish: 0.92
        (0.2%), tests_pri_0: 312 (55.0%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.0 (0.4%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        3.6 (0.6%), tests_pri_500: 10 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 07/16] umd: Rename umd_info.cmdline umd_info.driver_name
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The only thing supplied in the cmdline today is the driver name so
rename the field to clarify the code.

As this value is always supplied stop trying to handle the case of
a NULL cmdline.

Additionally since we now have a name we can count on use the
driver_name any place where the code is looking for a name
of the binary.

v1: https://lkml.kernel.org/r/87imfef0k3.fsf_-_@x220.int.ebiederm.org
v2: https://lkml.kernel.org/r/87366d63os.fsf_-_@x220.int.ebiederm.org
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/usermode_driver.h |  2 +-
 kernel/usermode_driver.c        | 11 ++++-------
 net/ipv4/bpfilter/sockopt.c     |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/linux/usermode_driver.h b/include/linux/usermode_driver.h
index 7131ea611bab..48cf25e3145d 100644
--- a/include/linux/usermode_driver.h
+++ b/include/linux/usermode_driver.h
@@ -18,7 +18,7 @@ static inline void exit_umh(struct task_struct *tsk)
 #endif
 
 struct umd_info {
-	const char *cmdline;
+	const char *driver_name;
 	struct file *pipe_to_umh;
 	struct file *pipe_from_umh;
 	struct list_head list;
diff --git a/kernel/usermode_driver.c b/kernel/usermode_driver.c
index e73550e946d6..46d60d855e93 100644
--- a/kernel/usermode_driver.c
+++ b/kernel/usermode_driver.c
@@ -67,9 +67,6 @@ static void umd_cleanup(struct subprocess_info *info)
  * @len: length of the blob
  * @info: information about usermode process (shouldn't be NULL)
  *
- * If info->cmdline is set it will be used as command line for the
- * user process, else "usermodehelper" is used.
- *
  * Returns either negative error or zero which indicates success
  * in executing a blob of bytes as a usermode process. In such
  * case 'struct umd_info *info' is populated with two pipes
@@ -79,7 +76,6 @@ static void umd_cleanup(struct subprocess_info *info)
  */
 int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 {
-	const char *cmdline = (info->cmdline) ? info->cmdline : "usermodehelper";
 	struct subprocess_info *sub_info;
 	char **argv = NULL;
 	struct file *file;
@@ -87,7 +83,7 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	loff_t pos = 0;
 	int err;
 
-	file = shmem_kernel_file_setup("", len, 0);
+	file = shmem_kernel_file_setup(info->driver_name, len, 0);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
@@ -100,11 +96,12 @@ int fork_usermode_blob(void *data, size_t len, struct umd_info *info)
 	}
 
 	err = -ENOMEM;
-	argv = argv_split(GFP_KERNEL, cmdline, NULL);
+	argv = argv_split(GFP_KERNEL, info->driver_name, NULL);
 	if (!argv)
 		goto out;
 
-	sub_info = call_usermodehelper_setup("none", argv, NULL, GFP_KERNEL,
+	sub_info = call_usermodehelper_setup(info->driver_name, argv, NULL,
+					     GFP_KERNEL,
 					     umd_setup, umd_cleanup, info);
 	if (!sub_info)
 		goto out;
diff --git a/net/ipv4/bpfilter/sockopt.c b/net/ipv4/bpfilter/sockopt.c
index c0dbcc86fcdb..5050de28333d 100644
--- a/net/ipv4/bpfilter/sockopt.c
+++ b/net/ipv4/bpfilter/sockopt.c
@@ -70,7 +70,7 @@ static int __init bpfilter_sockopt_init(void)
 {
 	mutex_init(&bpfilter_ops.lock);
 	bpfilter_ops.stop = true;
-	bpfilter_ops.info.cmdline = "bpfilter_umh";
+	bpfilter_ops.info.driver_name = "bpfilter_umh";
 	bpfilter_ops.info.cleanup = &bpfilter_umh_cleanup;
 
 	return 0;
-- 
2.25.0

