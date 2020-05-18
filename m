Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE081D7ED7
	for <lists+linux-security-module@lfdr.de>; Mon, 18 May 2020 18:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgERQnp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 18 May 2020 12:43:45 -0400
Received: from mga14.intel.com ([192.55.52.115]:49851 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQnp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 18 May 2020 12:43:45 -0400
IronPort-SDR: hSwCGbZgt+pHGGEspG+ATXejYkevxLnAu6S7H6ZVmPT1SXP9lcGGU01haqx5RAfZ30JrLnExxK
 lbL7fknawEvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:43:45 -0700
IronPort-SDR: qr0kF9qWnTNZYfGPt7PBTpB+JsoKd5PmpbswqO12vYKP/r2Ur97QZ28tgNNITROskfBNEjO4qu
 hI2YHUkPAphw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="252950028"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2020 09:43:39 -0700
Received: from [10.249.230.167] (abudanko-mobl.ccr.corp.intel.com [10.249.230.167])
        by linux.intel.com (Postfix) with ESMTP id 8300E580100;
        Mon, 18 May 2020 09:43:37 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] perf tool: make Perf tool aware of SELinux access
 control
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <0fffd9e2-1f22-a0c2-c2e3-cb7f4bb89d66@linux.intel.com>
 <819338ce-d160-4a2f-f1aa-d756a2e7c6fc@linux.intel.com>
 <20200518155843.GF24211@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d10fd4b0-d516-cf16-4379-c5299d0c5cc3@linux.intel.com>
Date:   Mon, 18 May 2020 19:43:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518155843.GF24211@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>


On 18.05.2020 18:58, Arnaldo Carvalho de Melo wrote:
> Em Thu, Apr 30, 2020 at 10:15:57AM +0300, Alexey Budankov escreveu:
>>
>> Implement selinux sysfs check to see the system is in enforcing
>> mode and print warning message with pointer to check audit logs.
> 
> There were some changes in this area meanwhile, so I had to apply the
> evsel.c by hand, when I push this please double check everything is ok,

Will do. I appreciate your integrating effort.

Thanks,
Alexey 
