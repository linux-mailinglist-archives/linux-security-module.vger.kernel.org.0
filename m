Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23401222472
	for <lists+linux-security-module@lfdr.de>; Thu, 16 Jul 2020 15:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgGPN5G (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 16 Jul 2020 09:57:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:3858 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728891AbgGPN5F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 16 Jul 2020 09:57:05 -0400
IronPort-SDR: 6NtJxy/n+/BdehSMYT3TK9HQswMIGp9Q0yoPvTzPP4fuMWGGFp/XI+EuygFHPH2UM+h6FF76CB
 lt748erWzPwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="137503259"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="137503259"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 06:57:04 -0700
IronPort-SDR: M8sjhSfa7qr+6J6F0oEtSGIoAa9oF3cU8Ydfy95gMWjc37PHRJTd02tJKPfM2o1iNMOvK/4jab
 cSSA8nAUgsrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="325150613"
Received: from lettner-mobl.ger.corp.intel.com (HELO localhost) ([10.252.32.212])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2020 06:56:52 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-security-module@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        Andy Lutomirski <luto@kernel.org>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        sean.j.christopherson@intel.com, tglx@linutronix.de,
        yaozhangx@google.com
Subject: [PATCH v36 15/24] x86/sgx: Allow a limited use of ATTRIBUTE.PROVISIONKEY for attestation
Date:   Thu, 16 Jul 2020 16:52:54 +0300
Message-Id: <20200716135303.276442-16-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135303.276442-1-jarkko.sakkinen@linux.intel.com>
References: <20200716135303.276442-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Provisioning Certification Enclave (PCE), the root of trust for other
enclaves, generates a signing key from a fused key called Provisioning
Certification Key. PCE can then use this key to certify an attestation key
of a Quoting Enclave (QE), e.g. we get the chain of trust down to the
hardware if the Intel signed PCE is used.

To use the needed keys, ATTRIBUTE.PROVISIONKEY is required but should be
only allowed for those who actually need it so that only the trusted
parties can certify QE's.

Obviously the attestation service should know the public key of the used
PCE and that way detect illegit attestation, but whitelisting the legit
users still adds an additional layer of defence.

Add new device file called /dev/sgx/provision. The sole purpose of this
file is to provide file descriptors that act as privilege tokens to allow
to build enclaves with ATTRIBUTE.PROVISIONKEY set. A new ioctl called
SGX_IOC_ENCLAVE_SET_ATTRIBUTE is used to assign this token to an enclave.

Cc: linux-security-module@vger.kernel.org
Acked-by: Jethro Beekman <jethro@fortanix.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/uapi/asm/sgx.h  | 11 ++++++++
 arch/x86/kernel/cpu/sgx/driver.c | 18 ++++++++++++
 arch/x86/kernel/cpu/sgx/driver.h |  2 ++
 arch/x86/kernel/cpu/sgx/ioctl.c  | 47 ++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 5edb08ab8fd0..57d0d30c79b3 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -25,6 +25,8 @@ enum sgx_page_flags {
 	_IOWR(SGX_MAGIC, 0x01, struct sgx_enclave_add_pages)
 #define SGX_IOC_ENCLAVE_INIT \
 	_IOW(SGX_MAGIC, 0x02, struct sgx_enclave_init)
+#define SGX_IOC_ENCLAVE_SET_ATTRIBUTE \
+	_IOW(SGX_MAGIC, 0x03, struct sgx_enclave_set_attribute)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -63,4 +65,13 @@ struct sgx_enclave_init {
 	__u64 sigstruct;
 };
 
+/**
+ * struct sgx_enclave_set_attribute - parameter structure for the
+ *				      %SGX_IOC_ENCLAVE_SET_ATTRIBUTE ioctl
+ * @attribute_fd:	file handle of the attribute file in the securityfs
+ */
+struct sgx_enclave_set_attribute {
+	__u64 attribute_fd;
+};
+
 #endif /* _UAPI_ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 5559bc18de41..b9af330a16fa 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -138,6 +138,10 @@ static const struct file_operations sgx_encl_fops = {
 	.get_unmapped_area	= sgx_get_unmapped_area,
 };
 
+const struct file_operations sgx_provision_fops = {
+	.owner			= THIS_MODULE,
+};
+
 static struct miscdevice sgx_dev_enclave = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "enclave",
@@ -145,6 +149,13 @@ static struct miscdevice sgx_dev_enclave = {
 	.fops = &sgx_encl_fops,
 };
 
+static struct miscdevice sgx_dev_provision = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "provision",
+	.nodename = "sgx/provision",
+	.fops = &sgx_provision_fops,
+};
+
 int __init sgx_drv_init(void)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -185,5 +196,12 @@ int __init sgx_drv_init(void)
 		return ret;
 	}
 
+	ret = misc_register(&sgx_dev_provision);
+	if (ret) {
+		pr_err("Creating /dev/sgx/provision failed with %d.\n", ret);
+		misc_deregister(&sgx_dev_enclave);
+		return ret;
+	}
+
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/driver.h
index e4063923115b..72747d01c046 100644
--- a/arch/x86/kernel/cpu/sgx/driver.h
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -23,6 +23,8 @@ extern u64 sgx_attributes_reserved_mask;
 extern u64 sgx_xfrm_reserved_mask;
 extern u32 sgx_xsave_size_tbl[64];
 
+extern const struct file_operations sgx_provision_fops;
+
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 
 int sgx_drv_init(void);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 3444de955191..95b0a1e62ea7 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -669,6 +669,50 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 	return ret;
 }
 
+/**
+ * sgx_ioc_enclave_set_attribute - handler for %SGX_IOC_ENCLAVE_SET_ATTRIBUTE
+ * @filep:	open file to /dev/sgx
+ * @arg:	userspace pointer to a struct sgx_enclave_set_attribute instance
+ *
+ * Mark the enclave as being allowed to access a restricted attribute bit.
+ * The requested attribute is specified via the attribute_fd field in the
+ * provided struct sgx_enclave_set_attribute.  The attribute_fd must be a
+ * handle to an SGX attribute file, e.g. "/dev/sgx/provision".
+ *
+ * Failure to explicitly request access to a restricted attribute will cause
+ * sgx_ioc_enclave_init() to fail.  Currently, the only restricted attribute
+ * is access to the PROVISION_KEY.
+ *
+ * Note, access to the EINITTOKEN_KEY is disallowed entirely.
+ *
+ * Return: 0 on success, -errno otherwise
+ */
+static long sgx_ioc_enclave_set_attribute(struct sgx_encl *encl,
+					  void __user *arg)
+{
+	struct sgx_enclave_set_attribute params;
+	struct file *attribute_file;
+	int ret;
+
+	if (copy_from_user(&params, arg, sizeof(params)))
+		return -EFAULT;
+
+	attribute_file = fget(params.attribute_fd);
+	if (!attribute_file)
+		return -EINVAL;
+
+	if (attribute_file->f_op != &sgx_provision_fops) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	encl->allowed_attributes |= SGX_ATTR_PROVISIONKEY;
+	ret = 0;
+
+out:
+	fput(attribute_file);
+	return ret;
+}
 
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
@@ -694,6 +738,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_INIT:
 		ret = sgx_ioc_enclave_init(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_SET_ATTRIBUTE:
+		ret = sgx_ioc_enclave_set_attribute(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.25.1

