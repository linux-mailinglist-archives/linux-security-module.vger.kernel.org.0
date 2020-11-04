Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF62A66DD
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Nov 2020 15:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730514AbgKDO4R (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 4 Nov 2020 09:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbgKDO4Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Nov 2020 09:56:16 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D490C223AB;
        Wed,  4 Nov 2020 14:56:08 +0000 (UTC)
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
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, sean.j.christopherson@intel.com,
        tglx@linutronix.de, yaozhangx@google.com, mikko.ylinen@intel.com
Subject: [PATCH v40 15/24] x86/sgx: Add SGX_IOC_ENCLAVE_PROVISION
Date:   Wed,  4 Nov 2020 16:54:21 +0200
Message-Id: <20201104145430.300542-16-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

The whole point of SGX is to create a hardware protected place to do
“stuff”.  But, before someone is willing to hand the keys to the castle
over, an enclave must often prove that it is running on an SGX-protected
processor.  Provisioning enclaves play a key role in providing proof.

There are actually three different enclaves in play in order to make this
happen:

1. The application enclave.  The familiar one we know and love that runs
   the actual code that’s doing real work.  There can be many of these on
   a single system, or even in a single application.
2. The quoting enclave  (QE).  The QE is mentioned in lots of silly
   whitepapers, but, for the purposes of kernel enabling, just pretend they
   do not exist.
3. The provisioning enclave.  There is typically only one of these
   enclaves per system.  Provisioning enclaves have access to a special
   hardware key.

   They can use this key to help to generate certificates which serve as
   proof that enclaves are running on trusted SGX hardware.  These
   certificates can be passed around without revealing the special key.

Any user which can create a provisioning enclave can access the
processor-unique Provisioning Certificate Key which has privacy and
fingerprinting implications.  Even if a user is permitted to create normal
application enclaves (via /dev/sgx_enclave), they should not be able to
create provisioning enclaves.  That means a separate permissions scheme is
needed to control provisioning enclave privileges.

Implement a separate device file (/dev/sgx_provision) which permits
creating provisioning enclaves.  This device will typically have more
strict permissions than the plain enclave device.

The actual device “driver” is an empty stub.  Open file descriptors for
this device will represent a token which allows provisioning enclave duty.
This file descriptor can be passed around and ultimately given as an
argument to the /dev/sgx_enclave driver ioctl().

Cc: linux-security-module@vger.kernel.org
Acked-by: Jethro Beekman <jethro@fortanix.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
Changes from v39:
* Rename /dev/sgx/provision as /dev/sgx_provision.

 arch/x86/include/uapi/asm/sgx.h  | 11 ++++++++++
 arch/x86/kernel/cpu/sgx/driver.c | 24 ++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/driver.h |  2 ++
 arch/x86/kernel/cpu/sgx/ioctl.c  | 37 ++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
index 66f2d32cb4d7..c32210235bf5 100644
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
@@ -63,4 +65,13 @@ struct sgx_enclave_init {
 	__u64 sigstruct;
 };
 
+/**
+ * struct sgx_enclave_provision - parameter structure for the
+ *				  %SGX_IOC_ENCLAVE_PROVISION ioctl
+ * @fd:		file handle of /dev/sgx_provision
+ */
+struct sgx_enclave_provision {
+	__u64 fd;
+};
+
 #endif /* _UAPI_ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index ef14abbb67e1..f618a04c4224 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -112,6 +112,10 @@ static const struct file_operations sgx_encl_fops = {
 	.get_unmapped_area	= sgx_get_unmapped_area,
 };
 
+const struct file_operations sgx_provision_fops = {
+	.owner			= THIS_MODULE,
+};
+
 static struct miscdevice sgx_dev_enclave = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "sgx_enclave",
@@ -119,11 +123,19 @@ static struct miscdevice sgx_dev_enclave = {
 	.fops = &sgx_encl_fops,
 };
 
+static struct miscdevice sgx_dev_provision = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "sgx_provision",
+	.nodename = "sgx_provision",
+	.fops = &sgx_provision_fops,
+};
+
 int __init sgx_drv_init(void)
 {
 	unsigned int eax, ebx, ecx, edx;
 	u64 attr_mask;
 	u64 xfrm_mask;
+	int ret;
 
 	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
 		return -ENODEV;
@@ -147,5 +159,15 @@ int __init sgx_drv_init(void)
 		sgx_xfrm_reserved_mask = ~xfrm_mask;
 	}
 
-	return misc_register(&sgx_dev_enclave);
+	ret = misc_register(&sgx_dev_enclave);
+	if (ret)
+		return ret;
+
+	ret = misc_register(&sgx_dev_provision);
+	if (ret) {
+		misc_deregister(&sgx_dev_enclave);
+		return ret;
+	}
+
+	return 0;
 }
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/driver.h
index 6b0063221659..4eddb4d571ef 100644
--- a/arch/x86/kernel/cpu/sgx/driver.h
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -20,6 +20,8 @@ extern u64 sgx_attributes_reserved_mask;
 extern u64 sgx_xfrm_reserved_mask;
 extern u32 sgx_misc_reserved_mask;
 
+extern const struct file_operations sgx_provision_fops;
+
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 
 int sgx_drv_init(void);
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index e036819ea5c1..0ba0e670e2f0 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -569,6 +569,40 @@ static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
 	return ret;
 }
 
+/**
+ * sgx_ioc_enclave_provision() - handler for %SGX_IOC_ENCLAVE_PROVISION
+ * @enclave:	an enclave pointer
+ * @arg:	userspace pointer to a struct sgx_enclave_provision instance
+ *
+ * Allow ATTRIBUTE.PROVISION_KEY for an enclave by providing a file handle to
+ * /dev/sgx_provision.
+ *
+ * Return:
+ * - 0:		Success.
+ * - -errno:	Otherwise.
+ */
+static long sgx_ioc_enclave_provision(struct sgx_encl *encl, void __user *arg)
+{
+	struct sgx_enclave_provision params;
+	struct file *file;
+
+	if (copy_from_user(&params, arg, sizeof(params)))
+		return -EFAULT;
+
+	file = fget(params.fd);
+	if (!file)
+		return -EINVAL;
+
+	if (file->f_op != &sgx_provision_fops) {
+		fput(file);
+		return -EINVAL;
+	}
+
+	encl->attributes_mask |= SGX_ATTR_PROVISIONKEY;
+
+	fput(file);
+	return 0;
+}
 
 long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
@@ -588,6 +622,9 @@ long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
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
2.27.0

