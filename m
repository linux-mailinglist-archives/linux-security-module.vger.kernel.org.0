Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C2C26B8F2
	for <lists+linux-security-module@lfdr.de>; Wed, 16 Sep 2020 02:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIPAw7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 15 Sep 2020 20:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgIOLdB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 15 Sep 2020 07:33:01 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B180C061224;
        Tue, 15 Sep 2020 04:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QE1Xi/YD6acZw3ExWtlutd0OjFac+kcZ6vKNXWFskhs=; b=yEb7CF7VXUBTMqzfiw4ld3c6IU
        JM7fjBDUbJf0yFLlx59z3IYLWvPbd7ozfT3p6u4Rjc3S5OKmGWW26rytfV55J+HLJZAXFPY0CIWjs
        ETJpme56f1MNL0KgiTv5lajkRy3bU0cFYE6WyYx4TQdcpEljmOD63gS++/0rpdjbe88GWMKi8g5rz
        MhOwaTrW9y8rVvWFZTw75YerrbZceHMVe8p1ABONIYctP6bCJ8lZYRuXrX6fUUJ6nErNh5sZOeEBp
        i5pZMpWFZiE4dVev9drtmT/fvBCoOaUIUefMZKzdYOoTk4RF99XPteV1toMgEbE5o8IxZ7L7ll6rP
        fbkMKd5w==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jjs@kapsi.fi>)
        id 1kI98m-0000l5-EX; Tue, 15 Sep 2020 14:28:52 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-security-module@vger.kernel.org,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
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
Subject: [PATCH v38 15/24] x86/sgx: Enable provisioning for remote attestation
Date:   Tue, 15 Sep 2020 14:28:33 +0300
Message-Id: <20200915112842.897265-16-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
References: <20200915112842.897265-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jjs@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
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
SGX_IOC_ENCLAVE_PROVISION is used to assign this token to an enclave.

Cc: linux-security-module@vger.kernel.org
Acked-by: Jethro Beekman <jethro@fortanix.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/include/uapi/asm/sgx.h  | 11 ++++++++
 arch/x86/kernel/cpu/sgx/driver.c | 18 ++++++++++++
 arch/x86/kernel/cpu/sgx/driver.h |  2 ++
 arch/x86/kernel/cpu/sgx/ioctl.c  | 47 ++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 7729730d8580..d0916fb9629e 100644
--- a/arch/x86/include/uapi/asm/sgx.h
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -25,6 +25,8 @@ enum sgx_page_flags {
 	_IOWR(SGX_MAGIC, 0x01, struct sgx_enclave_add_pages)
 #define SGX_IOC_ENCLAVE_INIT \
 	_IOW(SGX_MAGIC, 0x02, struct sgx_enclave_init)
+#define SGX_IOC_ENCLAVE_PROVISION \
+	_IOW(SGX_MAGIC, 0x03, struct sgx_enclave_provision)
 
 /**
  * struct sgx_enclave_create - parameter structure for the
@@ -61,4 +63,13 @@ struct sgx_enclave_init {
 	__u64 sigstruct;
 };
 
+/**
+ * struct sgx_enclave_provision - parameter structure for the
+ *				  %SGX_IOC_ENCLAVE_PROVISION ioctl
+ * @attribute_fd:	file handle of the attribute file in the securityfs
+ */
+struct sgx_enclave_provision {
+	__u64 attribute_fd;
+};
+
 #endif /* _UAPI_ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 7bdb49dfcca6..d01b28f7ce4a 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -134,6 +134,10 @@ static const struct file_operations sgx_encl_fops = {
 	.get_unmapped_area	= sgx_get_unmapped_area,
 };
 
+const struct file_operations sgx_provision_fops = {
+	.owner			= THIS_MODULE,
+};
+
 static struct miscdevice sgx_dev_enclave = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "enclave",
@@ -141,6 +145,13 @@ static struct miscdevice sgx_dev_enclave = {
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
@@ -181,5 +192,12 @@ int __init sgx_drv_init(void)
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
index de2ed4f35ffb..4227bca7b477 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -673,6 +673,50 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 	return ret;
 }
 
+/**
+ * sgx_ioc_enclave_set_attribute - handler for %SGX_IOC_ENCLAVE_PROVISION
+ * @filep:	open file to /dev/sgx
+ * @arg:	userspace pointer to a struct sgx_enclave_provision instance
+ *
+ * Mark the enclave as being allowed to access a restricted attribute bit.
+ * The requested attribute is specified via the attribute_fd field in the
+ * provided struct sgx_enclave_provision.  The attribute_fd must be a
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
+static long sgx_ioc_enclave_provision(struct sgx_encl *encl,
+					  void __user *arg)
+{
+	struct sgx_enclave_provision params;
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
+	encl->attributes |= SGX_ATTR_PROVISIONKEY;
+	ret = 0;
+
+out:
+	fput(attribute_file);
+	return ret;
+}
 
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
@@ -698,6 +742,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	case SGX_IOC_ENCLAVE_INIT:
 		ret = sgx_ioc_enclave_init(encl, (void __user *)arg);
 		break;
+	case SGX_IOC_ENCLAVE_PROVISION:
+		ret = sgx_ioc_enclave_provision(encl, (void __user *)arg);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
-- 
2.25.1

