Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0C259B58
	for <lists+linux-security-module@lfdr.de>; Fri, 28 Jun 2019 14:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfF1McV (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 28 Jun 2019 08:32:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfF1Mam (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 28 Jun 2019 08:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ykWkFsumL0ayFcjE+xBNFzyP+ofeeOxpiUoXLTtt7vY=; b=LTqUMzhs41rcttK/soKsV1UIN3
        LoQYuPajw1HHFL3YMIv6D/yUuQALnQpcQF+7onrNI2iaTqsK0bQhqVi6IcXycksWISx+3RYnjdf17
        tZmbpoV0iiQiRPnnceV3TnvbhhxiCsrTMIRbKsi307xqI2e+13y6x8j01plF4zNJvms+sK/kw0ntj
        VFwVV7+OHkOjg2f2viWFKJhidq1uDrBkrPhQASslBz23bXxo285FdMvebQPdXkBUUxEPg0WZm3PLS
        /lpZjBKvAzRqLugjwDvvLJVrOKpwzptQCzjefAKUmashyWLkZJfeFZZfkDwLjKeNK0uRr1tA6mtFg
        IREdxPVw==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgq1U-00055T-Lv; Fri, 28 Jun 2019 12:30:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgq1S-0005Sa-Fu; Fri, 28 Jun 2019 09:30:34 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ning Sun <ning.sun@intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        tboot-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org
Subject: [PATCH 21/39] docs: x86: move two x86-specific files to x86 arch dir
Date:   Fri, 28 Jun 2019 09:30:14 -0300
Message-Id: <caa8ba95b2b74a93e588edfa6bbd50b7bfa7ee09.1561724493.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561724493.git.mchehab+samsung@kernel.org>
References: <cover.1561724493.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Those two docs belong to the x86 architecture:

   Documentation/Intel-IOMMU.txt -> Documentation/x86/intel-iommu.rst
   Documentation/intel_txt.txt -> Documentation/x86/intel_txt.rst

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/index.rst                            | 2 ++
 Documentation/{Intel-IOMMU.txt => x86/intel-iommu.rst} | 0
 Documentation/{intel_txt.txt => x86/intel_txt.rst}     | 0
 MAINTAINERS                                            | 2 +-
 security/Kconfig                                       | 2 +-
 5 files changed, 4 insertions(+), 2 deletions(-)
 rename Documentation/{Intel-IOMMU.txt => x86/intel-iommu.rst} (100%)
 rename Documentation/{intel_txt.txt => x86/intel_txt.rst} (100%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f2de1b2d3ac7..af64c4bb4447 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -20,6 +20,8 @@ x86-specific Documentation
    mtrr
    pat
    intel_mpx
+   intel-iommu
+   intel_txt
    amd-memory-encryption
    pti
    mds
diff --git a/Documentation/Intel-IOMMU.txt b/Documentation/x86/intel-iommu.rst
similarity index 100%
rename from Documentation/Intel-IOMMU.txt
rename to Documentation/x86/intel-iommu.rst
diff --git a/Documentation/intel_txt.txt b/Documentation/x86/intel_txt.rst
similarity index 100%
rename from Documentation/intel_txt.txt
rename to Documentation/x86/intel_txt.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 3f0f654d1166..29d1498ad39d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8259,7 +8259,7 @@ L:	tboot-devel@lists.sourceforge.net
 W:	http://tboot.sourceforge.net
 T:	hg http://tboot.hg.sourceforge.net:8000/hgroot/tboot/tboot
 S:	Supported
-F:	Documentation/intel_txt.txt
+F:	Documentation/x86/intel_txt.rst
 F:	include/linux/tboot.h
 F:	arch/x86/kernel/tboot.c
 
diff --git a/security/Kconfig b/security/Kconfig
index 06a30851511a..0d65594b5196 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -121,7 +121,7 @@ config INTEL_TXT
 	  See <http://www.intel.com/technology/security/> for more information
 	  about Intel(R) TXT.
 	  See <http://tboot.sourceforge.net> for more information about tboot.
-	  See Documentation/intel_txt.txt for a description of how to enable
+	  See Documentation/x86/intel_txt.rst for a description of how to enable
 	  Intel TXT support in a kernel boot.
 
 	  If you are unsure as to whether this is required, answer N.
-- 
2.21.0

