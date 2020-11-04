Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF51A2A66D7
	for <lists+linux-security-module@lfdr.de>; Wed,  4 Nov 2020 15:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgKDOzt (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 4 Nov 2020 09:55:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730444AbgKDOzt (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Nov 2020 09:55:49 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7979222456;
        Wed,  4 Nov 2020 14:55:40 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-security-module@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Chunyang Hui <sanqian.hcy@antfin.com>,
        Jordan Hand <jorhand@linux.microsoft.com>,
        Nathaniel McCallum <npmccallum@redhat.com>,
        Seth Moore <sethmo@google.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com,
        mikko.ylinen@intel.com
Subject: [PATCH v40 11/24] x86/sgx: Add SGX misc driver interface
Date:   Wed,  4 Nov 2020 16:54:17 +0200
Message-Id: <20201104145430.300542-12-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Intel(R) SGX is new hardware functionality that can be used by applications
to set aside private regions of code and data called enclaves. New hardware
protects enclave code and data from outside access and modification.

Add a driver that presents a device file and ioctl API to build and manage
enclaves.  Subsequent patches will expend the ioctl()’s functionality.

Cc: linux-security-module@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Acked-by: Jethro Beekman <jethro@fortanix.com>
Tested-by: Jethro Beekman <jethro@fortanix.com>
Tested-by: Haitao Huang <haitao.huang@linux.intel.com>
Tested-by: Chunyang Hui <sanqian.hcy@antfin.com>
Tested-by: Jordan Hand <jorhand@linux.microsoft.com>
Tested-by: Nathaniel McCallum <npmccallum@redhat.com>
Tested-by: Seth Moore <sethmo@google.com>
Tested-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
Changes from v39:
* Rename /dev/sgx/enclave as /dev/sgx_enclave.
* In the page fault handler, do not check for SGX_ENCL_DEAD. This allows
  to do forensics to the memory of debug enclaves.

 arch/x86/kernel/cpu/sgx/Makefile |   2 +
 arch/x86/kernel/cpu/sgx/driver.c | 112 ++++++++++++++++++
 arch/x86/kernel/cpu/sgx/driver.h |  16 +++
 arch/x86/kernel/cpu/sgx/encl.c   | 188 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.h   |  46 ++++++++
 arch/x86/kernel/cpu/sgx/main.c   |  12 +-
 6 files changed, 375 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/cpu/sgx/driver.c
 create mode 100644 arch/x86/kernel/cpu/sgx/driver.h
 create mode 100644 arch/x86/kernel/cpu/sgx/encl.c
 create mode 100644 arch/x86/kernel/cpu/sgx/encl.h

diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makefile
index 79510ce01b3b..3fc451120735 100644
--- a/arch/x86/kernel/cpu/sgx/Makefile
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -1,2 +1,4 @@
 obj-y += \
+	driver.o \
+	encl.o \
 	main.o
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
new file mode 100644
index 000000000000..248213dea78e
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Copyright(c) 2016-20 Intel Corporation. */
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
+static int sgx_open(struct inode *inode, struct file *file)
+{
+	struct sgx_encl *encl;
+
+	encl = kzalloc(sizeof(*encl), GFP_KERNEL);
+	if (!encl)
+		return -ENOMEM;
+
+	xa_init(&encl->page_array);
+	mutex_init(&encl->lock);
+
+	file->private_data = encl;
+
+	return 0;
+}
+
+static int sgx_release(struct inode *inode, struct file *file)
+{
+	struct sgx_encl *encl = file->private_data;
+	struct sgx_encl_page *entry;
+	unsigned long index;
+
+	xa_for_each(&encl->page_array, index, entry) {
+		if (entry->epc_page) {
+			sgx_free_epc_page(entry->epc_page);
+			encl->secs_child_cnt--;
+			entry->epc_page = NULL;
+		}
+
+		kfree(entry);
+	}
+
+	xa_destroy(&encl->page_array);
+
+	if (!encl->secs_child_cnt && encl->secs.epc_page) {
+		sgx_free_epc_page(encl->secs.epc_page);
+		encl->secs.epc_page = NULL;
+	}
+
+	/* Detect EPC page leak's. */
+	WARN_ON_ONCE(encl->secs_child_cnt);
+	WARN_ON_ONCE(encl->secs.epc_page);
+
+	kfree(encl);
+	return 0;
+}
+
+static int sgx_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct sgx_encl *encl = file->private_data;
+	int ret;
+
+	ret = sgx_encl_may_map(encl, vma->vm_start, vma->vm_end, vma->vm_flags);
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
+	if ((flags & MAP_TYPE) == MAP_PRIVATE)
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
+	.mmap			= sgx_mmap,
+	.get_unmapped_area	= sgx_get_unmapped_area,
+};
+
+static struct miscdevice sgx_dev_enclave = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "sgx_enclave",
+	.nodename = "sgx_enclave",
+	.fops = &sgx_encl_fops,
+};
+
+int __init sgx_drv_init(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
+		return -ENODEV;
+
+	return misc_register(&sgx_dev_enclave);
+}
diff --git a/arch/x86/kernel/cpu/sgx/driver.h b/arch/x86/kernel/cpu/sgx/driver.h
new file mode 100644
index 000000000000..cda9c43b7543
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/driver.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+#include "sgx.h"
+
+int sgx_drv_init(void);
+
+#endif /* __ARCH_X86_SGX_DRIVER_H__ */
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
new file mode 100644
index 000000000000..d47caa106350
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Copyright(c) 2016-20 Intel Corporation. */
+
+#include <linux/lockdep.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/shmem_fs.h>
+#include <linux/suspend.h>
+#include <linux/sched/mm.h>
+#include "arch.h"
+#include "encl.h"
+#include "encls.h"
+#include "sgx.h"
+
+static struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
+						unsigned long addr,
+						unsigned long vm_flags)
+{
+	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
+	struct sgx_encl_page *entry;
+
+	entry = xa_load(&encl->page_array, PFN_DOWN(addr));
+	if (!entry)
+		return ERR_PTR(-EFAULT);
+
+	/*
+	 * Verify that the faulted page has equal or higher build time
+	 * permissions than the VMA permissions (i.e. the subset of {VM_READ,
+	 * VM_WRITE, VM_EXECUTE} in vma->vm_flags).
+	 */
+	if ((entry->vm_max_prot_bits & vm_prot_bits) != vm_prot_bits)
+		return ERR_PTR(-EFAULT);
+
+	/* No page found. */
+	if (!entry->epc_page)
+		return ERR_PTR(-EFAULT);
+
+	/* Entry successfully located. */
+	return entry;
+}
+
+static vm_fault_t sgx_vma_fault(struct vm_fault *vmf)
+{
+	unsigned long addr = (unsigned long)vmf->address;
+	struct vm_area_struct *vma = vmf->vma;
+	struct sgx_encl_page *entry;
+	unsigned long phys_addr;
+	struct sgx_encl *encl;
+	vm_fault_t ret;
+
+	encl = vma->vm_private_data;
+
+	mutex_lock(&encl->lock);
+
+	entry = sgx_encl_load_page(encl, addr, vma->vm_flags);
+	if (IS_ERR(entry)) {
+		mutex_unlock(&encl->lock);
+
+		return VM_FAULT_SIGBUS;
+	}
+
+	phys_addr = sgx_get_epc_phys_addr(entry->epc_page);
+
+	ret = vmf_insert_pfn(vma, addr, PFN_DOWN(phys_addr));
+	if (ret != VM_FAULT_NOPAGE) {
+		mutex_unlock(&encl->lock);
+
+		return VM_FAULT_SIGBUS;
+	}
+
+	mutex_unlock(&encl->lock);
+
+	return VM_FAULT_NOPAGE;
+}
+
+/**
+ * sgx_encl_may_map() - Check if a requested VMA mapping is allowed
+ * @encl:		an enclave pointer
+ * @start:		lower bound of the address range, inclusive
+ * @end:		upper bound of the address range, exclusive
+ * @vm_flags:		VMA flags
+ *
+ * Iterate through the enclave pages contained within [@start, @end) to verify
+ * that the permissions requested by a subset of {VM_READ, VM_WRITE, VM_EXEC}
+ * does not contain any permissions that are not contained in the build time
+ * permissions of any of the enclave pages within the given address range.
+ *
+ * An enclave creator must declare the strongest permissions that will be
+ * needed for each enclave page  This ensures that mappings  have the identical
+ * or weaker permissions that the earlier declared permissions.
+ *
+ * Return: 0 on success, -EACCES otherwise
+ */
+int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
+		     unsigned long end, unsigned long vm_flags)
+{
+	unsigned long vm_prot_bits = vm_flags & (VM_READ | VM_WRITE | VM_EXEC);
+	struct sgx_encl_page *page;
+	unsigned long count = 0;
+	int ret = 0;
+
+	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
+
+	/*
+	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
+	 * conflict with the enclave page permissions.
+	 */
+	if (current->personality & READ_IMPLIES_EXEC)
+		return -EACCES;
+
+	mutex_lock(&encl->lock);
+	xas_lock(&xas);
+	xas_for_each(&xas, page, PFN_DOWN(end - 1)) {
+		if (!page)
+			break;
+
+		if (~page->vm_max_prot_bits & vm_prot_bits) {
+			ret = -EACCES;
+			break;
+		}
+
+		/* Reschedule on every XA_CHECK_SCHED iteration. */
+		if (!(++count % XA_CHECK_SCHED)) {
+			xas_pause(&xas);
+			xas_unlock(&xas);
+			mutex_unlock(&encl->lock);
+
+			cond_resched();
+
+			mutex_lock(&encl->lock);
+			xas_lock(&xas);
+		}
+	}
+	xas_unlock(&xas);
+	mutex_unlock(&encl->lock);
+
+	return ret;
+}
+
+static int sgx_vma_mprotect(struct vm_area_struct *vma,
+			    struct vm_area_struct **pprev, unsigned long start,
+			    unsigned long end, unsigned long newflags)
+{
+	int ret;
+
+	ret = sgx_encl_may_map(vma->vm_private_data, start, end, newflags);
+	if (ret)
+		return ret;
+
+	return mprotect_fixup(vma, pprev, start, end, newflags);
+}
+
+const struct vm_operations_struct sgx_vm_ops = {
+	.fault = sgx_vma_fault,
+	.mprotect = sgx_vma_mprotect,
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
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
new file mode 100644
index 000000000000..8eb34e95feda
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/**
+ * Copyright(c) 2016-20 Intel Corporation.
+ *
+ * Contains the software defined data structures for enclaves.
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
+#include <linux/srcu.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+#include "sgx.h"
+
+struct sgx_encl_page {
+	unsigned long desc;
+	unsigned long vm_max_prot_bits;
+	struct sgx_epc_page *epc_page;
+	struct sgx_encl *encl;
+};
+
+struct sgx_encl {
+	unsigned long base;
+	unsigned long size;
+	unsigned int page_cnt;
+	unsigned int secs_child_cnt;
+	struct mutex lock;
+	struct xarray page_array;
+	struct sgx_encl_page secs;
+};
+
+extern const struct vm_operations_struct sgx_vm_ops;
+
+int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
+		  struct vm_area_struct **vma);
+int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
+		     unsigned long end, unsigned long vm_flags);
+
+#endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index b9ac438a13a4..c2740e0630d1 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -9,6 +9,8 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
+#include "driver.h"
+#include "encl.h"
 #include "encls.h"
 
 struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
@@ -229,9 +231,10 @@ static bool __init sgx_page_cache_init(void)
 
 static void __init sgx_init(void)
 {
+	int ret;
 	int i;
 
-	if (!boot_cpu_has(X86_FEATURE_SGX))
+	if (!cpu_feature_enabled(X86_FEATURE_SGX))
 		return;
 
 	if (!sgx_page_cache_init())
@@ -240,8 +243,15 @@ static void __init sgx_init(void)
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
 	for (i = 0; i < sgx_nr_epc_sections; i++) {
 		vfree(sgx_epc_sections[i].pages);
-- 
2.27.0

