Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454EA455A83
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Nov 2021 12:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbhKRLhq (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 18 Nov 2021 06:37:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343958AbhKRLhd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 18 Nov 2021 06:37:33 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AI9liBL035144;
        Thu, 18 Nov 2021 11:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=kLdQR6Rnbkk3HhgdrLGD6gw4qSi5mO8D55WKWsjodbc=;
 b=dq0AXpGgiOU4AemQ1tAjVv5wtjoDeozZnX3ul8z15/lB9r+ORJy1Av7D906wyq5ANDGX
 McbmoSSdddBlVoXlOPqIU9ZbgPd6ePDqsMQGMJVLJTAOASRvaxbnxBhGJlpnZ3S+izJT
 ASMD8ZMJyWdJ5pwUJvn7a3DwOsoNbG8dlhcJwGoZaHjUKRQf8F48bnkGW/pItrufXdlm
 Xw6kkHWxfhYgPAZ8QwEh4RYbfl4Juw+uuYzvU0iQY2Oio/n6IL6NiZxobkGC9hD8u4xr
 AuxNsTUe0f1YEpG5HXRPiLM8FszWaEbT/8EcQi8uUZ14KEorB4v+4F3MLuXGPH7Ncc8v eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdmgy2ahm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:10 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AIAewlw032491;
        Thu, 18 Nov 2021 11:34:10 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cdmgy2ah1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:09 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AIBTQ8p022352;
        Thu, 18 Nov 2021 11:34:08 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03wdc.us.ibm.com with ESMTP id 3ca50c2bcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 11:34:08 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AIBY5YW16449810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 11:34:05 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEE3CAE05C;
        Thu, 18 Nov 2021 11:34:04 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A52DAE063;
        Thu, 18 Nov 2021 11:34:04 +0000 (GMT)
Received: from amdrome3.watson.ibm.com (unknown [9.2.130.16])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 11:34:04 +0000 (GMT)
From:   Dov Murik <dovmurik@linux.ibm.com>
To:     linux-efi@vger.kernel.org
Cc:     Dov Murik <dovmurik@linux.ibm.com>, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Allow guest access to EFI confidential computing secret area
Date:   Thu, 18 Nov 2021 11:33:55 +0000
Message-Id: <20211118113359.642571-1-dovmurik@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UQOJ25NSbDTbgdc5HFomto6OHy0SzWEO
X-Proofpoint-ORIG-GUID: wxcSa_IC8ZufmHYBHZaBVWzpf-M0Nr5X
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_05,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180067
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Confidential computing (coco) hardware such as AMD SEV (Secure Encrypted
Virtualization) allows guest owners to inject secrets into the VMs
memory without the host/hypervisor being able to read them.  In SEV,
secret injection is performed early in the VM launch process, before the
guest starts running.

OVMF already reserves designated area for secret injection (in its
AmdSev package; see edk2 commit 01726b6d23d4 "OvmfPkg/AmdSev: Expose the
Sev Secret area using a configuration table" [1]), but the secrets were
not available in the guest kernel.

The patch series keeps the address of the EFI-provided memory for
injected secrets, and optionally exposes the secrets to userspace via
securityfs using a new efi_secret kernel module.

The first patch in EFI keeps the address of the secret area as passed in
the EFI configuration table.  The second patch is a quirk fix for older
firmwares didn't mark the secrets page as EFI_RESERVED_TYPE.  The third
patch introduces the new efi_secret module that exposes the content of
the secret entries as securityfs files, and allows clearing out secrets
with a file unlink interface.  The last patch documents the data flow of
confidential computing secret injection.

As a usage example, consider a guest performing computations on
encrypted files.  The Guest Owner provides the decryption key (= secret)
using the secret injection mechanism.  The guest application reads the
secret from the efi_secret filesystem and proceeds to decrypt the files
into memory and then performs the needed computations on the content.

In this example, the host can't read the files from the disk image
because they are encrypted.  Host can't read the decryption key because
it is passed using the secret injection mechanism (= secure channel).
Host can't read the decrypted content from memory because it's a
confidential (memory-encrypted) guest.

This has been tested with AMD SEV and SEV-ES guests, but the kernel side
of handling the secret area has no SEV-specific dependencies, and
therefore might be usable (perhaps with minor changes) for any
confidential computing hardware that can publish the secret area via the
standard EFI config table entry.

To enable this functionality, set CONFIG_EFI_SECRET=m when building the
guest kernel.

Here is a simple example for usage of the efi_secret module in a guest
to which an EFI secret area with 4 secrets was injected during launch:

# modprobe efi_secret
# ls -la /sys/kernel/security/coco/efi_secret
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:54 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2
-r--r----- 1 root root 0 Jun 28 11:54 e6f5a162-d67f-4750-a67c-5d065f2a9910

# xxd /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910
00000000: 7468 6573 652d 6172 652d 7468 652d 6b61  these-are-the-ka
00000010: 7461 2d73 6563 7265 7473 0001 0203 0405  ta-secrets......
00000020: 0607                                     ..

# rm /sys/kernel/security/coco/efi_secret/e6f5a162-d67f-4750-a67c-5d065f2a9910

# ls -la /sys/kernel/security/coco/efi_secret
total 0
drwxr-xr-x 2 root root 0 Jun 28 11:55 .
drwxr-xr-x 3 root root 0 Jun 28 11:54 ..
-r--r----- 1 root root 0 Jun 28 11:54 736870e5-84f0-4973-92ec-06879ce3da0b
-r--r----- 1 root root 0 Jun 28 11:54 83c83f7f-1356-4975-8b7e-d3a0b54312c6
-r--r----- 1 root root 0 Jun 28 11:54 9553f55d-3da2-43ee-ab5d-ff17f78864d2


[1] https://github.com/tianocore/edk2/commit/01726b6d23d4

---

v5 changes:
 - Simplify EFI code: instead of copying the secret area, the firmware
   marks the secret area as EFI_RESERVED_TYPE, and then the uefi_init()
   code just keeps the pointer as it appears in the EFI configuration
   table.  The use of reserved pages is similar to the AMD SEV-SNP
   patches for handling SNP-Secrets and SNP-CPUID pages.
 - In order to handle OVMF releases out there which mark the
   confidential computing secrets page as EFI_BOOT_SERVICES_DATA, add
   efi/libstub code that detects this and fixes the E820 map to reserve
   this page.
 - In the efi_secret module code, map the secrets page using
   ioremap_encrypted (again, similar to the AMD SEV-SNP guest patches
   for accessing SNP-Secrets and SNP-CPUID pages).
 - Add documentation in Documentation/security/coco/efi_secret.

v4: https://lore.kernel.org/linux-coco/20211020061408.3447533-1-dovmurik@linux.ibm.com/
v4 changes:
 - Guard all the new EFI and efi-stub code (patches 1+2) with #ifdef
   CONFIG_EFI_COCO_SECRET (thanks Greg KH).  Selecting
   CONFIG_EFI_SECRET=m (patch 3) will enable the EFI parts as well.
 - Guard call to clflush_cache_range() with #ifdef CONFIG_X86
   (Reported-by: kernel test robot <lkp@intel.com>)

v3: https://lore.kernel.org/linux-coco/20211014130848.592611-1-dovmurik@linux.ibm.com/
v3 changes:
 - Rename the module to efi_secret
 - Remove the exporting of clean_cache_range
 - Use clflush_cache_range in wipe_memory
 - Document function wipe_memory
 - Initialize efi.coco_secret to EFI_INVALID_TABLE_ADDR to correctly detect
   when there's no secret area published in the EFI configuration tables

v2: https://lore.kernel.org/linux-coco/20211007061838.1381129-1-dovmurik@linux.ibm.com
v2 changes:
 - Export clean_cache_range()
 - When deleteing a secret, call clean_cache_range() after explicit_memzero
 - Add Documentation/ABI/testing/securityfs-coco-sev_secret

v1: https://lore.kernel.org/linux-coco/20210809190157.279332-1-dovmurik@linux.ibm.com/

RFC: https://lore.kernel.org/linux-coco/20210628183431.953934-1-dovmurik@linux.ibm.com/




Dov Murik (4):
  efi: Save location of EFI confidential computing area
  efi/libstub: Reserve confidential computing secret area
  virt: Add efi_secret module to expose confidential computing secrets
  docs: security: Add coco/efi_secret documentation

 .../ABI/testing/securityfs-coco-efi_secret    |  50 +++
 Documentation/security/coco/efi_secret.rst    | 103 ++++++
 Documentation/security/coco/index.rst         |   9 +
 Documentation/security/index.rst              |   1 +
 arch/x86/platform/efi/efi.c                   |   3 +
 drivers/firmware/efi/Kconfig                  |  16 +
 drivers/firmware/efi/efi.c                    |   6 +
 drivers/firmware/efi/libstub/x86-stub.c       |  28 ++
 drivers/virt/Kconfig                          |   3 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/coco/efi_secret/Kconfig          |  11 +
 drivers/virt/coco/efi_secret/Makefile         |   2 +
 drivers/virt/coco/efi_secret/efi_secret.c     | 341 ++++++++++++++++++
 include/linux/efi.h                           |   7 +
 14 files changed, 581 insertions(+)
 create mode 100644 Documentation/ABI/testing/securityfs-coco-efi_secret
 create mode 100644 Documentation/security/coco/efi_secret.rst
 create mode 100644 Documentation/security/coco/index.rst
 create mode 100644 drivers/virt/coco/efi_secret/Kconfig
 create mode 100644 drivers/virt/coco/efi_secret/Makefile
 create mode 100644 drivers/virt/coco/efi_secret/efi_secret.c


base-commit: 42eb8fdac2fc5d62392dcfcf0253753e821a97b0
-- 
2.25.1

