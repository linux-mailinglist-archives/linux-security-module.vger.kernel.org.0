Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E341536A8
	for <lists+linux-security-module@lfdr.de>; Wed,  5 Feb 2020 18:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBERd6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 5 Feb 2020 12:33:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:18354 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbgBERd6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Feb 2020 12:33:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 09:33:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="249777027"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 05 Feb 2020 09:33:52 -0800
Received: from [10.252.5.149] (abudanko-mobl.ccr.corp.intel.com [10.252.5.149])
        by linux.intel.com (Postfix) with ESMTP id 3BBF75802BC;
        Wed,  5 Feb 2020 09:33:44 -0800 (PST)
Subject: [PATCH v6 05/10] drm/i915/perf: open access for CAP_PERFMON
 privileged process
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        oprofile-list@lists.sf.net
References: <576a6141-36d4-14c0-b395-8d195892b916@linux.intel.com>
Organization: Intel Corp.
Message-ID: <265ed94d-8a26-b038-5d7e-c634095a3b12@linux.intel.com>
Date:   Wed, 5 Feb 2020 20:33:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <576a6141-36d4-14c0-b395-8d195892b916@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


Open access to i915_perf monitoring for CAP_PERFMON privileged process.
Providing the access under CAP_PERFMON capability singly, without the
rest of CAP_SYS_ADMIN credentials, excludes chances to misuse the
credentials and makes operation more secure.

CAP_PERFMON implements the principal of least privilege for performance
monitoring and observability operations (POSIX IEEE 1003.1e 2.2.2.39
principle of least privilege: A security design principle that states that
a process or program be granted only those privileges (e.g., capabilities)
necessary to accomplish its legitimate function, and only for the time
that such privileges are actually required)

For backward compatibility reasons access to i915_perf subsystem remains
open for CAP_SYS_ADMIN privileged processes but CAP_SYS_ADMIN usage for
secure i915_perf monitoring is discouraged with respect to CAP_PERFMON
capability.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 2ae14bc14931..d89347861b7d 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -3375,10 +3375,10 @@ i915_perf_open_ioctl_locked(struct i915_perf *perf,
 	/* Similar to perf's kernel.perf_paranoid_cpu sysctl option
 	 * we check a dev.i915.perf_stream_paranoid sysctl option
 	 * to determine if it's ok to access system wide OA counters
-	 * without CAP_SYS_ADMIN privileges.
+	 * without CAP_PERFMON or CAP_SYS_ADMIN privileges.
 	 */
 	if (privileged_op &&
-	    i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
+	    i915_perf_stream_paranoid && !perfmon_capable()) {
 		DRM_DEBUG("Insufficient privileges to open i915 perf stream\n");
 		ret = -EACCES;
 		goto err_ctx;
@@ -3571,9 +3571,8 @@ static int read_properties_unlocked(struct i915_perf *perf,
 			} else
 				oa_freq_hz = 0;
 
-			if (oa_freq_hz > i915_oa_max_sample_rate &&
-			    !capable(CAP_SYS_ADMIN)) {
-				DRM_DEBUG("OA exponent would exceed the max sampling frequency (sysctl dev.i915.oa_max_sample_rate) %uHz without root privileges\n",
+			if (oa_freq_hz > i915_oa_max_sample_rate && !perfmon_capable()) {
+				DRM_DEBUG("OA exponent would exceed the max sampling frequency (sysctl dev.i915.oa_max_sample_rate) %uHz without CAP_PERFMON or CAP_SYS_ADMIN privileges\n",
 					  i915_oa_max_sample_rate);
 				return -EACCES;
 			}
@@ -3994,7 +3993,7 @@ int i915_perf_add_config_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	}
 
-	if (i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
+	if (i915_perf_stream_paranoid && !perfmon_capable()) {
 		DRM_DEBUG("Insufficient privileges to add i915 OA config\n");
 		return -EACCES;
 	}
@@ -4141,7 +4140,7 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
 		return -ENOTSUPP;
 	}
 
-	if (i915_perf_stream_paranoid && !capable(CAP_SYS_ADMIN)) {
+	if (i915_perf_stream_paranoid && !perfmon_capable()) {
 		DRM_DEBUG("Insufficient privileges to remove i915 OA config\n");
 		return -EACCES;
 	}
-- 
2.20.1


