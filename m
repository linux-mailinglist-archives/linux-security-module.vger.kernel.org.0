Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8734F178679
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Mar 2020 00:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgCCXic (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 3 Mar 2020 18:38:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:14428 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgCCXic (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Mar 2020 18:38:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2020 15:38:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,511,1574150400"; 
   d="scan'208";a="229117593"
Received: from kwasilew-mobl.ger.corp.intel.com (HELO localhost) ([10.251.88.57])
  by orsmga007.jf.intel.com with ESMTP; 03 Mar 2020 15:38:18 -0800
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-security-module@vger.kernel.org,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>
Subject: [PATCH v28 11/22] x86/sgx: Linux Enclave Driver
Date:   Wed,  4 Mar 2020 01:35:58 +0200
Message-Id: <20200303233609.713348-12-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Intel Software Guard eXtensions (SGX) is a set of CPU instructions that
can be used by applications to set aside private regions of code and
data. The code outside the SGX hosted software entity is disallowed to
access the memory inside the enclave enforced by the CPU. We call these
entities as enclaves.

This commit implements a driver that provides an ioctl API to construct
and run enclaves. Enclaves are constructed from pages residing in
reserved physical memory areas. The contents of these pages can only be
accessed when they are mapped as part of an enclave, by a hardware
thread running inside the enclave.

The starting state of an enclave consists of a fixed measured set of
pages that are copied to the EPC during the construction process by
using ENCLS leaf functions and Software Enclave Control Structure (SECS)
that defines the enclave properties.

Enclave are constructed by using ENCLS leaf functions ECREATE, EADD and
EINIT. ECREATE initializes SECS, EADD copies pages from system memory to
the EPC and EINIT check a given signed measurement and moves the enclave
into a state ready for execution.

An initialized enclave can only be accessed through special Thread Control
Structure (TCS) pages by using ENCLU (ring-3 only) leaf EENTER.  This leaf
function converts a thread into enclave mode and continues the execution in
the offset defined by the TCS provided to EENTER. An enclave is exited
through syscall, exception, interrupts or by explicitly calling another
ENCLU leaf EEXIT.

The permissions, which enclave page is added will set the limit for maximum
permissions that can be set for mmap() and mprotect(). This will
effectively allow to build different security schemes between producers and
consumers of enclaves. Later on we can increase granularity with LSM hooks
for page addition (i.e. for producers) and mapping of the enclave (i.e. for
consumers)

Cc: linux-security-module@vger.kernel.org
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Tested-by: Haitao Huang <haitao.huang@linux.intel.com>
Tested-by: Jethro Beekman <jethro@fortanix.com>
Tested-by: Chunyang Hui <sanqian.hcy@antfin.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 arch/x86/include/uapi/asm/sgx.h               |  66 ++
 arch/x86/kernel/cpu/sgx/Makefile              |   3 +
 arch/x86/kernel/cpu/sgx/driver.c              | 194 +++++
 arch/x86/kernel/cpu/sgx/driver.h              |  30 +
 arch/x86/kernel/cpu/sgx/encl.c                | 336 +++++++++
 arch/x86/kernel/cpu/sgx/encl.h                |  87 +++
 arch/x86/kernel/cpu/sgx/encls.h               |   5 +-
 arch/x86/kernel/cpu/sgx/ioctl.c               | 692 ++++++++++++++++++
 arch/x86/kernel/cpu/sgx/main.c                |  12 +-
 arch/x86/kernel/cpu/sgx/reclaim.c             |   1 +
 11 files changed, 1423 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/include/uapi/asm/sgx.h
 create mode 100644 arch/x86/kernel/cpu/sgx/driver.c
 create mode 100644 arch/x86/kernel/cpu/sgx/driver.h
 create mode 100644 arch/x86/kernel/cpu/sgx/encl.c
 create mode 100644 arch/x86/kernel/cpu/sgx/encl.h
 create mode 100644 arch/x86/kernel/cpu/sgx/ioctl.c

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 2e91370dc159..1c54dd2704db 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -321,6 +321,7 @@ Code  Seq#    Include File                                           Comments
                                                                      <mailto:tlewis@mindspring.com>
 0xA3  90-9F  linux/dtlk.h
 0xA4  00-1F  uapi/linux/tee.h                                        Generic TEE subsystem
+0xA4  00-1F  uapi/asm/sgx.h                                          Intel SGX subsystem (a legit conflict as TEE and SGX do not co-exist)
 0xAA  00-3F  linux/uapi/linux/userfaultfd.h
 0xAB  00-1F  linux/nbd.h
 0xAC  00-1F  linux/raw.h
diff --git a/arch/x86/include/uapi/asm/sgx.h b/arch/x86/include/uapi/asm/sgx.h
new file mode 100644
index 000000000000..5edb08ab8fd0
--- /dev/null
+++ b/arch/x86/include/uapi/asm/sgx.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) WITH Linux-syscall-note */
+/*
+ * Copyright(c) 2016-19 Intel Corporation.
+ */
+#ifndef _UAPI_ASM_X86_SGX_H
+#define _UAPI_ASM_X86_SGX_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/**
+ * enum sgx_epage_flags - page control flags
+ * %SGX_PAGE_MEASURE:	Measure the page contents with a sequence of
+ *			ENCLS[EEXTEND] operations.
+ */
+enum sgx_page_flags {
+	SGX_PAGE_MEASURE	= 0x01,
+};
+
+#define SGX_MAGIC 0xA4
+
+#define SGX_IOC_ENCLAVE_CREATE \
+	_IOW(SGX_MAGIC, 0x00, struct sgx_enclave_create)
+#define SGX_IOC_ENCLAVE_ADD_PAGES \
+	_IOWR(SGX_MAGIC, 0x01, struct sgx_enclave_add_pages)
+#define SGX_IOC_ENCLAVE_INIT \
+	_IOW(SGX_MAGIC, 0x02, struct sgx_enclave_init)
+
+/**
+ * struct sgx_enclave_create - parameter structure for the
+ *                             %SGX_IOC_ENCLAVE_CREATE ioctl
+ * @src:	address for the SECS page data
+ */
+struct sgx_enclave_create  {
+	__u64	src;
+};
+
+/**
+ * struct sgx_enclave_add_pages - parameter structure for the
+ *                                %SGX_IOC_ENCLAVE_ADD_PAGE ioctl
+ * @src:	start address for the page data
+ * @offset:	starting page offset
+ * @length:	length of the data (multiple of the page size)
+ * @secinfo:	address for the SECINFO data
+ * @flags:	page control flags
+ * @count:	number of bytes added (multiple of the page size)
+ */
+struct sgx_enclave_add_pages {
+	__u64	src;
+	__u64	offset;
+	__u64	length;
+	__u64	secinfo;
+	__u64	flags;
+	__u64	count;
+};
+
+/**
+ * struct sgx_enclave_init - parameter structure for the
+ *                           %SGX_IOC_ENCLAVE_INIT ioctl
+ * @sigstruct:	address for the SIGSTRUCT data
+ */
+struct sgx_enclave_init {
+	__u64 sigstruct;
+};
+
+#endif /* _UAPI_ASM_X86_SGX_H */
diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makefile
index 2dec75916a5e..f8d32da3a67a 100644
--- a/arch/x86/kernel/cpu/sgx/Makefile
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -1,3 +1,6 @@
 obj-y += \
+	driver.o \
+	encl.o \
+	ioctl.o \
 	main.o \
 	reclaim.o
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
new file mode 100644
index 000000000000..b4aa7b9f8376
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-18 Intel Corporation.
+
+#include <linux/acpi.h>
+#include <linux/miscdevice.h>
+#include <linux/mman.h>
+#include <linux/security.h>
+#include <linux/suspend.h>
+#include <asm/traps.h>
+#include "driver.h"
+#include "encl.h"
+
+MODULE_DESCRIPTION("Intel SGX Enclave Driver");
+MODULE_AUTHOR("Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>");
+MODULE_LICENSE("Dual BSD/GPL");
+
+u64 sgx_encl_size_max_32;
+u64 sgx_encl_size_max_64;
+u32 sgx_misc_reserved_mask;
+u64 sgx_attributes_reserved_mask;
+u64 sgx_xfrm_reserved_mask = ~0x3;
+u32 sgx_xsave_size_tbl[64];
+
+static int sgx_open(struct inode *inode, struct file *file)
+{
+	struct sgx_encl *encl;
+	int ret;
+
+	encl = kzalloc(sizeof(*encl), GFP_KERNEL);
+	if (!encl)
+		return -ENOMEM;
+
+	atomic_set(&encl->flags, 0);
+	kref_init(&encl->refcount);
+	INIT_RADIX_TREE(&encl->page_tree, GFP_KERNEL);
+	mutex_init(&encl->lock);
+	INIT_LIST_HEAD(&encl->mm_list);
+	spin_lock_init(&encl->mm_lock);
+
+	ret = init_srcu_struct(&encl->srcu);
+	if (ret) {
+		kfree(encl);
+		return ret;
+	}
+
+	file->private_data = encl;
+
+	return 0;
+}
+
+static int sgx_release(struct inode *inode, struct file *file)
+{
+	struct sgx_encl *encl = file->private_data;
+	struct sgx_encl_mm *encl_mm;
+
+	for ( ; ; )  {
+		spin_lock(&encl->mm_lock);
+
+		if (list_empty(&encl->mm_list)) {
+			encl_mm = NULL;
+		} else {
+			encl_mm = list_first_entry(&encl->mm_list,
+						   struct sgx_encl_mm, list);
+			list_del_rcu(&encl_mm->list);
+		}
+
+		spin_unlock(&encl->mm_lock);
+
+		/* The list is empty, ready to go. */
+		if (!encl_mm)
+			break;
+
+		synchronize_srcu(&encl->srcu);
+		mmu_notifier_unregister(&encl_mm->mmu_notifier, encl_mm->mm);
+		kfree(encl_mm);
+	};
+
+	mutex_lock(&encl->lock);
+	atomic_or(SGX_ENCL_DEAD, &encl->flags);
+	mutex_unlock(&encl->lock);
+
+	kref_put(&encl->refcount, sgx_encl_release);
+	return 0;
+}
+
+#ifdef CONFIG_COMPAT
+static long sgx_compat_ioctl(struct file *filep, unsigned int cmd,
+			      unsigned long arg)
+{
+	return sgx_ioctl(filep, cmd, arg);
+}
+#endif
+
+static int sgx_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct sgx_encl *encl = file->private_data;
+	int ret;
+
+	ret = sgx_encl_may_map(encl, vma->vm_start, vma->vm_end,
+			       vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC));
+	if (ret)
+		return ret;
+
+	ret = sgx_encl_mm_add(encl, vma->vm_mm);
+	if (ret)
+		return ret;
+
+	vma->vm_ops = &sgx_vm_ops;
+	vma->vm_flags |= VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_IO;
+	vma->vm_private_data = encl;
+
+	return 0;
+}
+
+static unsigned long sgx_get_unmapped_area(struct file *file,
+					   unsigned long addr,
+					   unsigned long len,
+					   unsigned long pgoff,
+					   unsigned long flags)
+{
+	if (flags & MAP_PRIVATE)
+		return -EINVAL;
+
+	if (flags & MAP_FIXED)
+		return addr;
+
+	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+}
+
+static const struct file_operations sgx_encl_fops = {
+	.owner			= THIS_MODULE,
+	.open			= sgx_open,
+	.release		= sgx_release,
+	.unlocked_ioctl		= sgx_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl		= sgx_compat_ioctl,
+#endif
+	.mmap			= sgx_mmap,
+	.get_unmapped_area	= sgx_get_unmapped_area,
+};
+
+const struct file_operations sgx_provision_fops = {
+	.owner			= THIS_MODULE,
+};
+
+static struct miscdevice sgx_dev_enclave = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "enclave",
+	.nodename = "sgx/enclave",
+	.fops = &sgx_encl_fops,
+};
+
+int __init sgx_drv_init(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+	u64 attr_mask, xfrm_mask;
+	int ret;
+	int i;
+
+	if (!boot_cpu_has(X86_FEATURE_SGX_LC)) {
+		pr_info("The public key MSRs are not writable.\n");
+		return -ENODEV;
+	}
+
+	cpuid_count(SGX_CPUID, 0, &eax, &ebx, &ecx, &edx);
+	sgx_misc_reserved_mask = ~ebx | SGX_MISC_RESERVED_MASK;
+	sgx_encl_size_max_64 = 1ULL << ((edx >> 8) & 0xFF);
+	sgx_encl_size_max_32 = 1ULL << (edx & 0xFF);
+
+	cpuid_count(SGX_CPUID, 1, &eax, &ebx, &ecx, &edx);
+
+	attr_mask = (((u64)ebx) << 32) + (u64)eax;
+	sgx_attributes_reserved_mask = ~attr_mask | SGX_ATTR_RESERVED_MASK;
+
+	if (boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+		xfrm_mask = (((u64)edx) << 32) + (u64)ecx;
+
+		for (i = 2; i < 64; i++) {
+			cpuid_count(0x0D, i, &eax, &ebx, &ecx, &edx);
+			if ((1 << i) & xfrm_mask)
+				sgx_xsave_size_tbl[i] = eax + ebx;
+		}
+
+		sgx_xfrm_reserved_mask = ~xfrm_mask;
+	}
+
+	ret = misc_register(&sgx_dev_enclave);
+	if (ret) {
+		pr_err("Creating /dev/sgx/enclave failed with %d.\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/driver.h
new file mode 100644
index 000000000000..e4063923115b
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+#ifndef __ARCH_SGX_DRIVER_H__
+#define __ARCH_SGX_DRIVER_H__
+
+#include <crypto/hash.h>
+#include <linux/kref.h>
+#include <linux/mmu_notifier.h>
+#include <linux/radix-tree.h>
+#include <linux/rwsem.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+#include <uapi/asm/sgx.h>
+#include "sgx.h"
+
+#define SGX_EINIT_SPIN_COUNT	20
+#define SGX_EINIT_SLEEP_COUNT	50
+#define SGX_EINIT_SLEEP_TIME	20
+
+extern u64 sgx_encl_size_max_32;
+extern u64 sgx_encl_size_max_64;
+extern u32 sgx_misc_reserved_mask;
+extern u64 sgx_attributes_reserved_mask;
+extern u64 sgx_xfrm_reserved_mask;
+extern u32 sgx_xsave_size_tbl[64];
+
+long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
+
+int sgx_drv_init(void);
+
+#endif /* __ARCH_X86_SGX_DRIVER_H__ */
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
new file mode 100644
index 000000000000..f349697c7508
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-18 Intel Corporation.
+
+#include <linux/lockdep.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/shmem_fs.h>
+#include <linux/suspend.h>
+#include <linux/sched/mm.h>
+#include "arch.h"
+#include "encl.h"
+#include "sgx.h"
+
+static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
+						unsigned long addr)
+{
+	struct sgx_encl_page *entry;
+	unsigned int flags;
+
+	/* If process was forked, VMA is still there but vm_private_data is set
+	 * to NULL.
+	 */
+	if (!encl)
+		return ERR_PTR(-EFAULT);
+
+	flags = atomic_read(&encl->flags);
+
+	if ((flags & SGX_ENCL_DEAD) || !(flags & SGX_ENCL_INITIALIZED))
+		return ERR_PTR(-EFAULT);
+
+	entry = radix_tree_lookup(&encl->page_tree, addr >> PAGE_SHIFT);
+	if (!entry)
+		return ERR_PTR(-EFAULT);
+
+	/* Page is already resident in the EPC. */
+	if (entry->epc_page)
+		return entry;
+
+	return ERR_PTR(-EFAULT);
+}
+
+static void sgx_mmu_notifier_release(struct mmu_notifier *mn,
+				     struct mm_struct *mm)
+{
+	struct sgx_encl_mm *encl_mm =
+		container_of(mn, struct sgx_encl_mm, mmu_notifier);
+	struct sgx_encl_mm *tmp = NULL;
+
+	/*
+	 * The enclave itself can remove encl_mm.  Note, objects can't be moved
+	 * off an RCU protected list, but deletion is ok.
+	 */
+	spin_lock(&encl_mm->encl->mm_lock);
+	list_for_each_entry(tmp, &encl_mm->encl->mm_list, list) {
+		if (tmp == encl_mm) {
+			list_del_rcu(&encl_mm->list);
+			break;
+		}
+	}
+	spin_unlock(&encl_mm->encl->mm_lock);
+
+	if (tmp == encl_mm) {
+		synchronize_srcu(&encl_mm->encl->srcu);
+		mmu_notifier_put(mn);
+	}
+}
+
+static void sgx_mmu_notifier_free(struct mmu_notifier *mn)
+{
+	struct sgx_encl_mm *encl_mm =
+		container_of(mn, struct sgx_encl_mm, mmu_notifier);
+
+	kfree(encl_mm);
+}
+
+static const struct mmu_notifier_ops sgx_mmu_notifier_ops = {
+	.release		= sgx_mmu_notifier_release,
+	.free_notifier		= sgx_mmu_notifier_free,
+};
+
+static struct sgx_encl_mm *sgx_encl_find_mm(struct sgx_encl *encl,
+					    struct mm_struct *mm)
+{
+	struct sgx_encl_mm *encl_mm = NULL;
+	struct sgx_encl_mm *tmp;
+	int idx;
+
+	idx = srcu_read_lock(&encl->srcu);
+
+	list_for_each_entry_rcu(tmp, &encl->mm_list, list) {
+		if (tmp->mm == mm) {
+			encl_mm = tmp;
+			break;
+		}
+	}
+
+	srcu_read_unlock(&encl->srcu, idx);
+
+	return encl_mm;
+}
+
+int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm)
+{
+	struct sgx_encl_mm *encl_mm;
+	int ret;
+
+	if (atomic_read(&encl->flags) & SGX_ENCL_DEAD)
+		return -EINVAL;
+
+	/*
+	 * mm_structs are kept on mm_list until the mm or the enclave dies,
+	 * i.e. once an mm is off the list, it's gone for good, therefore it's
+	 * impossible to get a false positive on @mm due to a stale mm_list.
+	 */
+	if (sgx_encl_find_mm(encl, mm))
+		return 0;
+
+	encl_mm = kzalloc(sizeof(*encl_mm), GFP_KERNEL);
+	if (!encl_mm)
+		return -ENOMEM;
+
+	encl_mm->encl = encl;
+	encl_mm->mm = mm;
+	encl_mm->mmu_notifier.ops = &sgx_mmu_notifier_ops;
+
+	ret = __mmu_notifier_register(&encl_mm->mmu_notifier, mm);
+	if (ret) {
+		kfree(encl_mm);
+		return ret;
+	}
+
+	spin_lock(&encl->mm_lock);
+	list_add_rcu(&encl_mm->list, &encl->mm_list);
+	spin_unlock(&encl->mm_lock);
+
+	synchronize_srcu(&encl->srcu);
+
+	return 0;
+}
+
+static void sgx_vma_open(struct vm_area_struct *vma)
+{
+	struct sgx_encl *encl = vma->vm_private_data;
+
+	if (!encl)
+		return;
+
+	if (sgx_encl_mm_add(encl, vma->vm_mm))
+		vma->vm_private_data = NULL;
+}
+
+static unsigned int sgx_vma_fault(struct vm_fault *vmf)
+{
+	unsigned long addr = (unsigned long)vmf->address;
+	struct vm_area_struct *vma = vmf->vma;
+	struct sgx_encl *encl = vma->vm_private_data;
+	struct sgx_encl_page *entry;
+	int ret = VM_FAULT_NOPAGE;
+	unsigned long pfn;
+
+	if (!encl)
+		return VM_FAULT_SIGBUS;
+
+	mutex_lock(&encl->lock);
+
+	entry = sgx_encl_load_page(encl, addr);
+	if (IS_ERR(entry)) {
+		if (unlikely(PTR_ERR(entry) != -EBUSY))
+			ret = VM_FAULT_SIGBUS;
+
+		goto out;
+	}
+
+	if (!follow_pfn(vma, addr, &pfn))
+		goto out;
+
+	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(entry->epc_page->desc));
+	if (ret != VM_FAULT_NOPAGE) {
+		ret = VM_FAULT_SIGBUS;
+		goto out;
+	}
+
+out:
+	mutex_unlock(&encl->lock);
+	return ret;
+}
+
+/**
+ * sgx_encl_may_map() - Check if a requested VMA mapping is allowed
+ * @encl:		an enclave
+ * @start:		lower bound of the address range, inclusive
+ * @end:		upper bound of the address range, exclusive
+ * @vm_prot_bits:	requested protections of the address range
+ *
+ * Iterate through the enclave pages contained within [@start, @end) to verify
+ * the permissions requested by @vm_prot_bits do not exceed that of any enclave
+ * page to be mapped.  Page addresses that do not have an associated enclave
+ * page are interpreted to zero permissions.
+ *
+ * Return:
+ *   0 on success,
+ *   -EACCES if VMA permissions exceed enclave page permissions
+ */
+int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
+		     unsigned long end, unsigned long vm_prot_bits)
+{
+	unsigned long idx, idx_start, idx_end;
+	struct sgx_encl_page *page;
+
+	/*
+	 * Disallow RIE tasks as their VMA permissions might conflict with the
+	 * enclave page permissions.
+	 */
+	if (!!(current->personality & READ_IMPLIES_EXEC))
+		return -EACCES;
+
+	/* PROT_NONE always succeeds. */
+	if (!vm_prot_bits)
+		return 0;
+
+	idx_start = PFN_DOWN(start);
+	idx_end = PFN_DOWN(end - 1);
+
+	for (idx = idx_start; idx <= idx_end; ++idx) {
+		mutex_lock(&encl->lock);
+		page = radix_tree_lookup(&encl->page_tree, idx);
+		mutex_unlock(&encl->lock);
+
+		if (!page || (~page->vm_max_prot_bits & vm_prot_bits))
+			return -EACCES;
+	}
+
+	return 0;
+}
+
+static int sgx_vma_mprotect(struct vm_area_struct *vma, unsigned long start,
+			    unsigned long end, unsigned long prot)
+{
+	return sgx_encl_may_map(vma->vm_private_data, start, end,
+				calc_vm_prot_bits(prot, 0));
+}
+
+const struct vm_operations_struct sgx_vm_ops = {
+	.open = sgx_vma_open,
+	.fault = sgx_vma_fault,
+	.may_mprotect = sgx_vma_mprotect,
+};
+
+/**
+ * sgx_encl_find - find an enclave
+ * @mm:		mm struct of the current process
+ * @addr:	address in the ELRANGE
+ * @vma:	the resulting VMA
+ *
+ * Find an enclave identified by the given address. Give back a VMA that is
+ * part of the enclave and located in that address. The VMA is given back if it
+ * is a proper enclave VMA even if an &sgx_encl instance does not exist yet
+ * (enclave creation has not been performed).
+ *
+ * Return:
+ *   0 on success,
+ *   -EINVAL if an enclave was not found,
+ *   -ENOENT if the enclave has not been created yet
+ */
+int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
+		  struct vm_area_struct **vma)
+{
+	struct vm_area_struct *result;
+	struct sgx_encl *encl;
+
+	result = find_vma(mm, addr);
+	if (!result || result->vm_ops != &sgx_vm_ops || addr < result->vm_start)
+		return -EINVAL;
+
+	encl = result->vm_private_data;
+	*vma = result;
+
+	return encl ? 0 : -ENOENT;
+}
+
+/**
+ * sgx_encl_destroy() - destroy enclave resources
+ * @encl:	an &sgx_encl instance
+ */
+void sgx_encl_destroy(struct sgx_encl *encl)
+{
+	struct sgx_encl_page *entry;
+	struct radix_tree_iter iter;
+	void **slot;
+
+	atomic_or(SGX_ENCL_DEAD, &encl->flags);
+
+	radix_tree_for_each_slot(slot, &encl->page_tree, &iter, 0) {
+		entry = *slot;
+
+		if (entry->epc_page) {
+			sgx_free_page(entry->epc_page);
+			encl->secs_child_cnt--;
+			entry->epc_page = NULL;
+		}
+
+		radix_tree_delete(&entry->encl->page_tree,
+				  PFN_DOWN(entry->desc));
+		kfree(entry);
+	}
+
+	if (!encl->secs_child_cnt && encl->secs.epc_page) {
+		sgx_free_page(encl->secs.epc_page);
+		encl->secs.epc_page = NULL;
+	}
+}
+
+/**
+ * sgx_encl_release - Destroy an enclave instance
+ * @kref:	address of a kref inside &sgx_encl
+ *
+ * Used together with kref_put(). Frees all the resources associated with the
+ * enclave and the instance itself.
+ */
+void sgx_encl_release(struct kref *ref)
+{
+	struct sgx_encl *encl = container_of(ref, struct sgx_encl, refcount);
+
+	sgx_encl_destroy(encl);
+
+	if (encl->backing)
+		fput(encl->backing);
+
+	WARN_ON_ONCE(!list_empty(&encl->mm_list));
+
+	/* Detect EPC page leak's. */
+	WARN_ON_ONCE(encl->secs_child_cnt);
+	WARN_ON_ONCE(encl->secs.epc_page);
+
+	kfree(encl);
+}
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
new file mode 100644
index 000000000000..1d1bc5d590ee
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/**
+ * Copyright(c) 2016-19 Intel Corporation.
+ */
+#ifndef _X86_ENCL_H
+#define _X86_ENCL_H
+
+#include <linux/cpumask.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mm_types.h>
+#include <linux/mmu_notifier.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/radix-tree.h>
+#include <linux/srcu.h>
+#include <linux/workqueue.h>
+#include "sgx.h"
+
+/**
+ * enum sgx_encl_page_desc - defines bits for an enclave page's descriptor
+ * %SGX_ENCL_PAGE_ADDR_MASK:		Holds the virtual address of the page.
+ *
+ * The page address for SECS is zero and is used by the subsystem to recognize
+ * the SECS page.
+ */
+enum sgx_encl_page_desc {
+	/* Bits 11:3 are available when the page is not swapped. */
+	SGX_ENCL_PAGE_ADDR_MASK		= PAGE_MASK,
+};
+
+#define SGX_ENCL_PAGE_ADDR(page) \
+	((page)->desc & SGX_ENCL_PAGE_ADDR_MASK)
+
+struct sgx_encl_page {
+	unsigned long desc;
+	unsigned long vm_max_prot_bits;
+	struct sgx_epc_page *epc_page;
+	struct sgx_encl *encl;
+};
+
+enum sgx_encl_flags {
+	SGX_ENCL_CREATED	= BIT(0),
+	SGX_ENCL_INITIALIZED	= BIT(1),
+	SGX_ENCL_DEBUG		= BIT(2),
+	SGX_ENCL_DEAD		= BIT(3),
+	SGX_ENCL_IOCTL		= BIT(4),
+};
+
+struct sgx_encl_mm {
+	struct sgx_encl *encl;
+	struct mm_struct *mm;
+	struct list_head list;
+	struct mmu_notifier mmu_notifier;
+};
+
+struct sgx_encl {
+	atomic_t flags;
+	u64 secs_attributes;
+	u64 allowed_attributes;
+	unsigned int page_cnt;
+	unsigned int secs_child_cnt;
+	struct mutex lock;
+	struct list_head mm_list;
+	spinlock_t mm_lock;
+	struct file *backing;
+	struct kref refcount;
+	struct srcu_struct srcu;
+	unsigned long base;
+	unsigned long size;
+	unsigned long ssaframesize;
+	struct radix_tree_root page_tree;
+	struct sgx_encl_page secs;
+	cpumask_t cpumask;
+};
+
+extern const struct vm_operations_struct sgx_vm_ops;
+
+int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
+		  struct vm_area_struct **vma);
+void sgx_encl_destroy(struct sgx_encl *encl);
+void sgx_encl_release(struct kref *ref);
+int sgx_encl_mm_add(struct sgx_encl *encl, struct mm_struct *mm);
+int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
+		     unsigned long end, unsigned long vm_prot_bits);
+
+#endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/encls.h b/arch/x86/kernel/cpu/sgx/encls.h
index f91da6a1bddc..072d42973c68 100644
--- a/arch/x86/kernel/cpu/sgx/encls.h
+++ b/arch/x86/kernel/cpu/sgx/encls.h
@@ -186,10 +186,9 @@ static inline int __eadd(struct sgx_pageinfo *pginfo, void *addr)
 	return __encls_2(EADD, pginfo, addr);
 }
 
-static inline int __einit(void *sigstruct, struct sgx_einittoken *einittoken,
-			  void *secs)
+static inline int __einit(void *sigstruct, void *token, void *secs)
 {
-	return __encls_ret_3(EINIT, sigstruct, secs, einittoken);
+	return __encls_ret_3(EINIT, sigstruct, secs, token);
 }
 
 static inline int __eremove(void *addr)
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
new file mode 100644
index 000000000000..27de304efe39
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -0,0 +1,692 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-19 Intel Corporation.
+
+#include <asm/mman.h>
+#include <linux/mman.h>
+#include <linux/delay.h>
+#include <linux/file.h>
+#include <linux/hashtable.h>
+#include <linux/highmem.h>
+#include <linux/ratelimit.h>
+#include <linux/sched/signal.h>
+#include <linux/shmem_fs.h>
+#include <linux/slab.h>
+#include <linux/suspend.h>
+#include "driver.h"
+#include "encl.h"
+#include "encls.h"
+
+/* A per-cpu cache for the last known values of IA32_SGXLEPUBKEYHASHx MSRs. */
+static DEFINE_PER_CPU(u64 [4], sgx_lepubkeyhash_cache);
+
+static u32 sgx_calc_ssaframesize(u32 miscselect, u64 xfrm)
+{
+	u32 size_max = PAGE_SIZE;
+	u32 size;
+	int i;
+
+	for (i = 2; i < 64; i++) {
+		if (!((1 << i) & xfrm))
+			continue;
+
+		size = SGX_SSA_GPRS_SIZE + sgx_xsave_size_tbl[i];
+		if (miscselect & SGX_MISC_EXINFO)
+			size += SGX_SSA_MISC_EXINFO_SIZE;
+
+		if (size > size_max)
+			size_max = size;
+	}
+
+	return PFN_UP(size_max);
+}
+
+static int sgx_validate_secs(const struct sgx_secs *secs,
+			     unsigned long ssaframesize)
+{
+	if (secs->size < (2 * PAGE_SIZE) || !is_power_of_2(secs->size))
+		return -EINVAL;
+
+	if (secs->base & (secs->size - 1))
+		return -EINVAL;
+
+	if (secs->miscselect & sgx_misc_reserved_mask ||
+	    secs->attributes & sgx_attributes_reserved_mask ||
+	    secs->xfrm & sgx_xfrm_reserved_mask)
+		return -EINVAL;
+
+	if (secs->attributes & SGX_ATTR_MODE64BIT) {
+		if (secs->size > sgx_encl_size_max_64)
+			return -EINVAL;
+	} else if (secs->size > sgx_encl_size_max_32)
+		return -EINVAL;
+
+	if (!(secs->xfrm & XFEATURE_MASK_FP) ||
+	    !(secs->xfrm & XFEATURE_MASK_SSE) ||
+	    (((secs->xfrm >> XFEATURE_BNDREGS) & 1) !=
+	     ((secs->xfrm >> XFEATURE_BNDCSR) & 1)))
+		return -EINVAL;
+
+	if (!secs->ssa_frame_size || ssaframesize > secs->ssa_frame_size)
+		return -EINVAL;
+
+	if (memchr_inv(secs->reserved1, 0, sizeof(secs->reserved1)) ||
+	    memchr_inv(secs->reserved2, 0, sizeof(secs->reserved2)) ||
+	    memchr_inv(secs->reserved3, 0, sizeof(secs->reserved3)) ||
+	    memchr_inv(secs->reserved4, 0, sizeof(secs->reserved4)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static struct sgx_encl_page *sgx_encl_page_alloc(struct sgx_encl *encl,
+						 unsigned long offset,
+						 u64 secinfo_flags)
+{
+	struct sgx_encl_page *encl_page;
+	unsigned long prot;
+
+	encl_page = kzalloc(sizeof(*encl_page), GFP_KERNEL);
+	if (!encl_page)
+		return ERR_PTR(-ENOMEM);
+
+	encl_page->desc = encl->base + offset;
+	encl_page->encl = encl;
+
+	prot = _calc_vm_trans(secinfo_flags, SGX_SECINFO_R, PROT_READ)  |
+	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_W, PROT_WRITE) |
+	       _calc_vm_trans(secinfo_flags, SGX_SECINFO_X, PROT_EXEC);
+
+	/*
+	 * TCS pages must always RW set for CPU access while the SECINFO
+	 * permissions are *always* zero - the CPU ignores the user provided
+	 * values and silently overwrites them with zero permissions.
+	 */
+	if ((secinfo_flags & SGX_SECINFO_PAGE_TYPE_MASK) == SGX_SECINFO_TCS)
+		prot |= PROT_READ | PROT_WRITE;
+
+	/* Calculate maximum of the VM flags for the page. */
+	encl_page->vm_max_prot_bits = calc_vm_prot_bits(prot, 0);
+
+	return encl_page;
+}
+
+static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
+{
+	unsigned long encl_size = secs->size + PAGE_SIZE;
+	struct sgx_epc_page *secs_epc;
+	unsigned long ssaframesize;
+	struct sgx_pageinfo pginfo;
+	struct sgx_secinfo secinfo;
+	struct file *backing;
+	long ret;
+
+	if (atomic_read(&encl->flags) & SGX_ENCL_CREATED)
+		return -EINVAL;
+
+	ssaframesize = sgx_calc_ssaframesize(secs->miscselect, secs->xfrm);
+	if (sgx_validate_secs(secs, ssaframesize)) {
+		pr_debug("invalid SECS\n");
+		return -EINVAL;
+	}
+
+	backing = shmem_file_setup("SGX backing", encl_size + (encl_size >> 5),
+				   VM_NORESERVE);
+	if (IS_ERR(backing))
+		return PTR_ERR(backing);
+
+	encl->backing = backing;
+
+	secs_epc = sgx_try_alloc_page();
+	if (IS_ERR(secs_epc)) {
+		ret = PTR_ERR(secs_epc);
+		goto err_out_backing;
+	}
+
+	encl->secs.epc_page = secs_epc;
+
+	pginfo.addr = 0;
+	pginfo.contents = (unsigned long)secs;
+	pginfo.metadata = (unsigned long)&secinfo;
+	pginfo.secs = 0;
+	memset(&secinfo, 0, sizeof(secinfo));
+
+	ret = __ecreate((void *)&pginfo, sgx_epc_addr(secs_epc));
+	if (ret) {
+		pr_debug("ECREATE returned %ld\n", ret);
+		goto err_out;
+	}
+
+	if (secs->attributes & SGX_ATTR_DEBUG)
+		atomic_or(SGX_ENCL_DEBUG, &encl->flags);
+
+	encl->secs.encl = encl;
+	encl->secs_attributes = secs->attributes;
+	encl->allowed_attributes |= SGX_ATTR_ALLOWED_MASK;
+	encl->base = secs->base;
+	encl->size = secs->size;
+	encl->ssaframesize = secs->ssa_frame_size;
+
+	/*
+	 * Set SGX_ENCL_CREATED only after the enclave is fully prepped.  This
+	 * allows setting and checking enclave creation without having to take
+	 * encl->lock.
+	 */
+	atomic_or(SGX_ENCL_CREATED, &encl->flags);
+
+	return 0;
+
+err_out:
+	sgx_free_page(encl->secs.epc_page);
+	encl->secs.epc_page = NULL;
+
+err_out_backing:
+	fput(encl->backing);
+	encl->backing = NULL;
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_create - handler for %SGX_IOC_ENCLAVE_CREATE
+ * @filep:	open file to /dev/sgx
+ * @arg:	userspace pointer to a struct sgx_enclave_create instance
+ *
+ * Allocate kernel data structures for a new enclave and execute ECREATE after
+ * verifying the correctness of the provided SECS.
+ *
+ * Note, enforcement of restricted and disallowed attributes is deferred until
+ * sgx_ioc_enclave_init(), only the architectural correctness of the SECS is
+ * checked by sgx_ioc_enclave_create().
+ *
+ * Return:
+ *   0 on success,
+ *   -errno otherwise
+ */
+static long sgx_ioc_enclave_create(struct sgx_encl *encl, void __user *arg)
+{
+	struct sgx_enclave_create ecreate;
+	struct page *secs_page;
+	struct sgx_secs *secs;
+	int ret;
+
+	if (copy_from_user(&ecreate, arg, sizeof(ecreate)))
+		return -EFAULT;
+
+	secs_page = alloc_page(GFP_KERNEL);
+	if (!secs_page)
+		return -ENOMEM;
+
+	secs = kmap(secs_page);
+	if (copy_from_user(secs, (void __user *)ecreate.src, sizeof(*secs))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = sgx_encl_create(encl, secs);
+
+out:
+	kunmap(secs_page);
+	__free_page(secs_page);
+	return ret;
+}
+
+static int sgx_validate_secinfo(struct sgx_secinfo *secinfo)
+{
+	u64 perm = secinfo->flags & SGX_SECINFO_PERMISSION_MASK;
+	u64 pt = secinfo->flags & SGX_SECINFO_PAGE_TYPE_MASK;
+
+	if (pt != SGX_SECINFO_REG && pt != SGX_SECINFO_TCS)
+		return -EINVAL;
+
+	if ((perm & SGX_SECINFO_W) && !(perm & SGX_SECINFO_R))
+		return -EINVAL;
+
+	/*
+	 * CPU will silently overwrite the permissions as zero, which means
+	 * that we need to validate it ourselves.
+	 */
+	if (pt == SGX_SECINFO_TCS && perm)
+		return -EINVAL;
+
+	if (secinfo->flags & SGX_SECINFO_RESERVED_MASK)
+		return -EINVAL;
+
+	if (memchr_inv(secinfo->reserved, 0, sizeof(secinfo->reserved)))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int __sgx_encl_add_page(struct sgx_encl *encl,
+			       struct sgx_encl_page *encl_page,
+			       struct sgx_epc_page *epc_page,
+			       struct sgx_secinfo *secinfo, unsigned long src)
+{
+	struct sgx_pageinfo pginfo;
+	struct vm_area_struct *vma;
+	struct page *src_page;
+	int ret;
+
+	/* Query vma's VM_MAYEXEC as an indirect path_noexec() check. */
+	if (encl_page->vm_max_prot_bits & VM_EXEC) {
+		vma = find_vma(current->mm, src);
+		if (!vma)
+			return -EFAULT;
+
+		if (!(vma->vm_flags & VM_MAYEXEC))
+			return -EACCES;
+	}
+
+	ret = get_user_pages(src, 1, 0, &src_page, NULL);
+	if (ret < 1)
+		return ret;
+
+	pginfo.secs = (unsigned long)sgx_epc_addr(encl->secs.epc_page);
+	pginfo.addr = SGX_ENCL_PAGE_ADDR(encl_page);
+	pginfo.metadata = (unsigned long)secinfo;
+	pginfo.contents = (unsigned long)kmap_atomic(src_page);
+
+	ret = __eadd(&pginfo, sgx_epc_addr(epc_page));
+
+	kunmap_atomic((void *)pginfo.contents);
+	put_page(src_page);
+
+	return ret ? -EIO : 0;
+}
+
+static int __sgx_encl_extend(struct sgx_encl *encl,
+			     struct sgx_epc_page *epc_page)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < 16; i++) {
+		ret = __eextend(sgx_epc_addr(encl->secs.epc_page),
+				sgx_epc_addr(epc_page) + (i * 0x100));
+		if (ret) {
+			if (encls_failed(ret))
+				ENCLS_WARN(ret, "EEXTEND");
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static int sgx_encl_add_page(struct sgx_encl *encl, unsigned long src,
+			     unsigned long offset, unsigned long length,
+			     struct sgx_secinfo *secinfo, unsigned long flags)
+{
+	struct sgx_encl_page *encl_page;
+	struct sgx_epc_page *epc_page;
+	int ret;
+
+	encl_page = sgx_encl_page_alloc(encl, offset, secinfo->flags);
+	if (IS_ERR(encl_page))
+		return PTR_ERR(encl_page);
+
+	epc_page = sgx_try_alloc_page();
+	if (IS_ERR(epc_page)) {
+		kfree(encl_page);
+		return PTR_ERR(epc_page);
+	}
+
+	if (atomic_read(&encl->flags) &
+	    (SGX_ENCL_INITIALIZED | SGX_ENCL_DEAD)) {
+		ret = -EFAULT;
+		goto err_out_free;
+	}
+
+	down_read(&current->mm->mmap_sem);
+	mutex_lock(&encl->lock);
+
+	/*
+	 * Insert prior to EADD in case of OOM.  EADD modifies MRENCLAVE, i.e.
+	 * can't be gracefully unwound, while failure on EADD/EXTEND is limited
+	 * to userspace errors (or kernel/hardware bugs).
+	 */
+	ret = radix_tree_insert(&encl->page_tree, PFN_DOWN(encl_page->desc),
+				encl_page);
+	if (ret)
+		goto err_out_unlock;
+
+	ret = __sgx_encl_add_page(encl, encl_page, epc_page, secinfo,
+				  src);
+	if (ret)
+		goto err_out;
+
+	/*
+	 * Complete the "add" before doing the "extend" so that the "add"
+	 * isn't in a half-baked state in the extremely unlikely scenario the
+	 * the enclave will be destroyed in response to EEXTEND failure.
+	 */
+	encl_page->encl = encl;
+	encl_page->epc_page = epc_page;
+	encl->secs_child_cnt++;
+
+	if (flags & SGX_PAGE_MEASURE) {
+		ret = __sgx_encl_extend(encl, epc_page);
+		if (ret)
+			goto err_out;
+	}
+
+	mutex_unlock(&encl->lock);
+	up_read(&current->mm->mmap_sem);
+	return ret;
+
+err_out:
+	radix_tree_delete(&encl_page->encl->page_tree,
+			  PFN_DOWN(encl_page->desc));
+
+err_out_unlock:
+	mutex_unlock(&encl->lock);
+	up_read(&current->mm->mmap_sem);
+
+err_out_free:
+	sgx_free_page(epc_page);
+	kfree(encl_page);
+
+	/*
+	 * Destroy enclave on ENCLS failure as this means that EPC has been
+	 * invalidated.
+	 */
+	if (ret == -EIO)
+		sgx_encl_destroy(encl);
+
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_add_pages() - The handler for %SGX_IOC_ENCLAVE_ADD_PAGES
+ * @encl:       pointer to an enclave instance (via ioctl() file pointer)
+ * @arg:	a user pointer to a struct sgx_enclave_add_pages instance
+ *
+ * Add one or more pages to an uninitialized enclave, and optionally extend the
+ * measurement with the contents of the page. The address range of pages must
+ * be contiguous. The SECINFO and measurement mask are applied to all pages.
+ *
+ * A SECINFO for a TCS is required to always contain zero permissions because
+ * CPU silently zeros them. Allowing anything else would cause a mismatch in
+ * the measurement.
+ *
+ * mmap()'s protection bits are capped by the page permissions. For each page
+ * address, the maximum protection bits are computed with the following
+ * heuristics:
+ *
+ * 1. A regular page: PROT_R, PROT_W and PROT_X match the SECINFO permissions.
+ * 2. A TCS page: PROT_R | PROT_W.
+ * 3. No page: PROT_NONE.
+ *
+ * mmap() is not allowed to surpass the minimum of the maximum protection bits
+ * within the given address range.
+ *
+ * As stated above, a non-existent page is interpreted as a page with no
+ * permissions. In effect, this allows mmap() with PROT_NONE to be used to seek
+ * an address range for the enclave that can be then populated into SECS.
+ *
+ * If ENCLS opcode fails, that effectively means that EPC has been invalidated.
+ * When this happens the enclave is destroyed and -EIO is returned to the
+ * caller.
+ *
+ * Return:
+ *   0 on success,
+ *   -EACCES if an executable source page is located in a noexec partition,
+ *   -EIO if either ENCLS[EADD] or ENCLS[EEXTEND] fails
+ *   -errno otherwise
+ */
+static long sgx_ioc_enclave_add_pages(struct sgx_encl *encl, void __user *arg)
+{
+	struct sgx_enclave_add_pages addp;
+	struct sgx_secinfo secinfo;
+	unsigned long c;
+	int ret;
+
+	if (!(atomic_read(&encl->flags) & SGX_ENCL_CREATED))
+		return -EINVAL;
+
+	if (copy_from_user(&addp, arg, sizeof(addp)))
+		return -EFAULT;
+
+	if (!IS_ALIGNED(addp.offset, PAGE_SIZE) ||
+	    !IS_ALIGNED(addp.src, PAGE_SIZE))
+		return -EINVAL;
+
+	if (!(access_ok(addp.src, PAGE_SIZE)))
+		return -EFAULT;
+
+	if (addp.length & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	if (addp.offset + addp.length - PAGE_SIZE >= encl->size)
+		return -EINVAL;
+
+	if (copy_from_user(&secinfo, (void __user *)addp.secinfo,
+			   sizeof(secinfo)))
+		return -EFAULT;
+
+	if (sgx_validate_secinfo(&secinfo))
+		return -EINVAL;
+
+	for (c = 0 ; c < addp.length; c += PAGE_SIZE) {
+		if (signal_pending(current)) {
+			ret = -EINTR;
+			break;
+		}
+
+		if (need_resched())
+			cond_resched();
+
+		ret = sgx_encl_add_page(encl, addp.src + c, addp.offset + c,
+					addp.length - c, &secinfo, addp.flags);
+		if (ret)
+			break;
+	}
+
+	addp.count = c;
+
+	if (copy_to_user(arg, &addp, sizeof(addp)))
+		return -EFAULT;
+
+	return ret;
+}
+
+static int __sgx_get_key_hash(struct crypto_shash *tfm, const void *modulus,
+			      void *hash)
+{
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tfm;
+
+	return crypto_shash_digest(shash, modulus, SGX_MODULUS_SIZE, hash);
+}
+
+static int sgx_get_key_hash(const void *modulus, void *hash)
+{
+	struct crypto_shash *tfm;
+	int ret;
+
+	tfm = crypto_alloc_shash("sha256", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	ret = __sgx_get_key_hash(tfm, modulus, hash);
+
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+static void sgx_update_lepubkeyhash_msrs(u64 *lepubkeyhash, bool enforce)
+{
+	u64 *cache;
+	int i;
+
+	cache = per_cpu(sgx_lepubkeyhash_cache, smp_processor_id());
+	for (i = 0; i < 4; i++) {
+		if (enforce || (lepubkeyhash[i] != cache[i])) {
+			wrmsrl(MSR_IA32_SGXLEPUBKEYHASH0 + i, lepubkeyhash[i]);
+			cache[i] = lepubkeyhash[i];
+		}
+	}
+}
+
+static int sgx_einit(struct sgx_sigstruct *sigstruct, void *token,
+		     struct sgx_epc_page *secs, u64 *lepubkeyhash)
+{
+	int ret;
+
+	preempt_disable();
+	sgx_update_lepubkeyhash_msrs(lepubkeyhash, false);
+	ret = __einit(sigstruct, token, sgx_epc_addr(secs));
+	if (ret == SGX_INVALID_EINITTOKEN) {
+		sgx_update_lepubkeyhash_msrs(lepubkeyhash, true);
+		ret = __einit(sigstruct, token, sgx_epc_addr(secs));
+	}
+	preempt_enable();
+	return ret;
+}
+
+static int sgx_encl_init(struct sgx_encl *encl, struct sgx_sigstruct *sigstruct,
+			 void *token)
+{
+	u64 mrsigner[4];
+	int ret;
+	int i;
+	int j;
+
+	/* Check that the required attributes have been authorized. */
+	if (encl->secs_attributes & ~encl->allowed_attributes)
+		return -EACCES;
+
+	ret = sgx_get_key_hash(sigstruct->modulus, mrsigner);
+	if (ret)
+		return ret;
+
+	mutex_lock(&encl->lock);
+
+	if (atomic_read(&encl->flags) & SGX_ENCL_INITIALIZED) {
+		ret = -EFAULT;
+		goto err_out;
+	}
+
+	for (i = 0; i < SGX_EINIT_SLEEP_COUNT; i++) {
+		for (j = 0; j < SGX_EINIT_SPIN_COUNT; j++) {
+			ret = sgx_einit(sigstruct, token, encl->secs.epc_page,
+					mrsigner);
+			if (ret == SGX_UNMASKED_EVENT)
+				continue;
+			else
+				break;
+		}
+
+		if (ret != SGX_UNMASKED_EVENT)
+			break;
+
+		msleep_interruptible(SGX_EINIT_SLEEP_TIME);
+
+		if (signal_pending(current)) {
+			ret = -ERESTARTSYS;
+			goto err_out;
+		}
+	}
+
+	if (ret & ENCLS_FAULT_FLAG) {
+		if (encls_failed(ret))
+			ENCLS_WARN(ret, "EINIT");
+
+		sgx_encl_destroy(encl);
+		ret = -EFAULT;
+	} else if (ret) {
+		pr_debug("EINIT returned %d\n", ret);
+		ret = -EPERM;
+	} else {
+		atomic_or(SGX_ENCL_INITIALIZED, &encl->flags);
+	}
+
+err_out:
+	mutex_unlock(&encl->lock);
+	return ret;
+}
+
+/**
+ * sgx_ioc_enclave_init - handler for %SGX_IOC_ENCLAVE_INIT
+ *
+ * @filep:	open file to /dev/sgx
+ * @arg:	userspace pointer to a struct sgx_enclave_init instance
+ *
+ * Flush any outstanding enqueued EADD operations and perform EINIT.  The
+ * Launch Enclave Public Key Hash MSRs are rewritten as necessary to match
+ * the enclave's MRSIGNER, which is caculated from the provided sigstruct.
+ *
+ * Return:
+ *   0 on success,
+ *   SGX error code on EINIT failure,
+ *   -errno otherwise
+ */
+static long sgx_ioc_enclave_init(struct sgx_encl *encl, void __user *arg)
+{
+	struct sgx_sigstruct *sigstruct;
+	struct sgx_enclave_init einit;
+	struct page *initp_page;
+	void *token;
+	int ret;
+
+	if (!(atomic_read(&encl->flags) & SGX_ENCL_CREATED))
+		return -EINVAL;
+
+	if (copy_from_user(&einit, arg, sizeof(einit)))
+		return -EFAULT;
+
+	initp_page = alloc_page(GFP_KERNEL);
+	if (!initp_page)
+		return -ENOMEM;
+
+	sigstruct = kmap(initp_page);
+	token = (void *)((unsigned long)sigstruct + PAGE_SIZE / 2);
+	memset(token, 0, SGX_LAUNCH_TOKEN_SIZE);
+
+	if (copy_from_user(sigstruct, (void __user *)einit.sigstruct,
+			   sizeof(*sigstruct))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = sgx_encl_init(encl, sigstruct, token);
+
+out:
+	kunmap(initp_page);
+	__free_page(initp_page);
+	return ret;
+}
+
+
+long sgx_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
+{
+	struct sgx_encl *encl = filep->private_data;
+	int ret, encl_flags;
+
+	encl_flags = atomic_fetch_or(SGX_ENCL_IOCTL, &encl->flags);
+	if (encl_flags & SGX_ENCL_IOCTL)
+		return -EBUSY;
+
+	if (encl_flags & SGX_ENCL_DEAD)
+		return -EFAULT;
+
+	switch (cmd) {
+	case SGX_IOC_ENCLAVE_CREATE:
+		ret = sgx_ioc_enclave_create(encl, (void __user *)arg);
+		break;
+	case SGX_IOC_ENCLAVE_ADD_PAGES:
+		ret = sgx_ioc_enclave_add_pages(encl, (void __user *)arg);
+		break;
+	case SGX_IOC_ENCLAVE_INIT:
+		ret = sgx_ioc_enclave_init(encl, (void __user *)arg);
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+		break;
+	}
+
+	atomic_andnot(SGX_ENCL_IOCTL, &encl->flags);
+
+	return ret;
+}
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 60d82e7537c8..842f9abba1c0 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -8,6 +8,7 @@
 #include <linux/ratelimit.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
+#include "driver.h"
 #include "encls.h"
 
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
@@ -193,6 +194,8 @@ static bool __init sgx_page_cache_init(void)
 
 static void __init sgx_init(void)
 {
+	int ret;
+
 	if (!boot_cpu_has(X86_FEATURE_SGX))
 		return;
 
@@ -202,10 +205,17 @@ static void __init sgx_init(void)
 	if (!sgx_page_reclaimer_init())
 		goto err_page_cache;
 
+	ret = sgx_drv_init();
+	if (ret)
+		goto err_kthread;
+
 	return;
 
+err_kthread:
+	kthread_stop(ksgxswapd_tsk);
+
 err_page_cache:
 	sgx_page_cache_teardown();
 }
 
-arch_initcall(sgx_init);
+device_initcall(sgx_init);
diff --git a/arch/x86/kernel/cpu/sgx/reclaim.c b/arch/x86/kernel/cpu/sgx/reclaim.c
index 215371588a25..9e6d3e147aa2 100644
--- a/arch/x86/kernel/cpu/sgx/reclaim.c
+++ b/arch/x86/kernel/cpu/sgx/reclaim.c
@@ -10,6 +10,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include "encls.h"
+#include "driver.h"
 
 struct task_struct *ksgxswapd_tsk;
 
-- 
2.25.0

