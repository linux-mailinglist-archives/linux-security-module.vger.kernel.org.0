Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32883465BC3
	for <lists+linux-security-module@lfdr.de>; Thu,  2 Dec 2021 02:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhLBBms (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 1 Dec 2021 20:42:48 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:36793
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344264AbhLBBms (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 1 Dec 2021 20:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638409166; bh=0BeTqQmmTbQXDREO3JqFddZ/IR9sxG35RtOXnvDhf8M=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=KbXbvIvXBmN1HvDXjo1gpIiLbjZUveujKpQ/aqzHB7PT47W6XwAJgmdgNRQRZYZCMakGxYmP3lKH7nojuO/fMOFqAT3uf28UjBJ8I1I5DVdGbhnyGFXsUELMPHYvLSnZ/6tnIn9mTK9S+h4ZZTksfMQ8xVMqXpdmVncnA4vMVffaqlzLotHkxIERSudl6lD6U3lzcn85quDaUEDkp2oVG0S8pIa4Q6eLoWq5C8FG63qqeHX3bnkKPceWGyZgqR/DYrCQ2hBuEdTlzZIrNrTV2KRJtd8FJtooZ3TsINalkhpka/TjBidjq+4BGc+PntFMVaPdvPHZM3ndcfVAaA3img==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1638409166; bh=6vU+k89/x/g3IgT8skvl0jS3zHEkXf5SsXTlZsI7raj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VEkzXSvnIz7/bKAb3+LWyzs1BAQmWsfL9wtMgnUhj0O+llxTqXxkk314CEqSc2/JW4a4maPMOT7bzHUTKiM69LptL7fK9iomM5mfnKQ1xuyGPEvdJZiAXVrQUpHEhi4xLOp3gW4Kyhu/Eyor2lxajkLhEB7SasluumoCVVpHtN/7nTO4+c1expGT79Lrddz3tt0X+9EML2hvLB4KOTdAwfQZFjD9bOGSOxQrmZ8vBzxOJvIwuy0/Lbmiol2ywoMdkaGKEf4gCamun+PtOpUThB7KXAMbcICPJX5X/tL4UV3GM99K9fDr3qKWw2Lu4Ppu3xjhCrst6qeK6a3bdJrvaw==
X-YMail-OSG: .OHIRaMVM1l9W4hnvKAgEotWJY94LMlwYyJFHa.ADg0VviYvrcMPwSE_zgUY.XO
 5E0f1g5rgaelx.hbev3A1reFyOooN.rgNXdB8KE9J3HE26HgToAOB4q.iLJ_YMknWHRVVBnu9JsX
 zd86QTAkIcQiY1VP.pJA.Dvgd0VkuagDKn9X6syrFapv3H1NRR65zlAvAbrG8Q6dIaerFfFkMEBX
 H..X1BkqTqW_34kTWgQy3gS8q5PAjdlYH0avcS8VTmEcD8v35DPZa8ua1rtuld2TNMHX.lV7JCNN
 Rc0l853OU8ndEczrvPUaqpPpGO2fngElZj_gryTRfZfheT0G5SdvTCiuXLy6PASFtABT.8emVYLw
 Hz5Tk.mpimSf3VElQeF0CwCh03MScy4oqESM.1T5uzNX8jM.PDmG6zxDxj.ynwz8kyVBd2BVJN58
 _cJ6Zh5f.x5q1jGmrUK.A2IhYeY2nUw0Xi2JIdk7VdaNqRz5scw4cldVMDKf.DM_RHi88RWPh4iW
 BatVCAGvpHVux.vBAcTiWyxzq1xMdakghobU2fnCqWdFPV05zsNyInEIQUxKPxSzkAHyU4vAXnuH
 OaY9flJ0yLg2ZjhYP1BASIyGzF_mLU5QUKvsTDzfsF0gIe8JRV3MIUJ1IKpcpiseVDzr5nDhDhWl
 tIMCozJynGihUD7DQXmXDDV83Po4j4UPLWEIjrXdnuKtdJ3AUl1Sy7.MEeipncvFGEQj2.XuZnJM
 CbUR3on2ycT1rYBtct08EGk5ACS2ogPjzgoreu47IRLQSLNuUhNBra7vNyzXqmcOpmVuz14IDXek
 F0dByi1_FlbEgdU59Dm4protczgh3MyM5YZpZyfklGxxb5Fcqnjt6fYdXORTmXXk1ZY2ojpkS5bV
 FfGg8QbDmbv80Vj2pJzrK148N9O5DGL8keOmn5QAQYLSQb2ONvt3gVUUu8Q6BlQ5AOPZhSWicXYN
 JqdK6WW0IOaDvyihrMt6knwXQwfHN7rAPtHPCB6UO41AM1i4ITE9sQAlbLlut5Et__rCNl2yxiS.
 eYqBpaz_S_wxJuq4aQjgMPU.qheThwXicuzxZZNuLvzBhnidn4GU76vfCWeDRAJEKqnz3dk7L2tt
 FgeZg0P7W7XCnZWiYXaDYxClpccODcZ6Z6awxZtWh5SPV1Uag2wyksFQMxYfU15a.HrfnLmUxYof
 hyl0mjVucY5.SFyQlg1GHCoMGrk76BW0s.S.9T4Ojsg7RVTBJdH80y6KK3WOcFc4spSK36q.9G9H
 resm7rqeXj1ajYQXs9SsJui7k18cpTxA13b6lQHlJwGV3PlNLqhqjBb4u4RY29hWG_NHBPWXOj7U
 esb7b6WKGBXhrUI52s33slso5QqQFoM2UPCB25uUDiMQsNNuVi7yOIGtju28oOiU81.M7OyX3gN0
 zmeklLrjnyaf5js9X_zCdp3dsgA0MWpKU6AK6MH2E8L7eEXvhs8KOUXR6BosRNruwatliIofTnov
 KhOOtYlMl6fJkglz0vqxwP8MewDU2kjnIk3BpNQlHv3P6F66GbAkcGkVXRvImniw6dfcEQ0R9HBy
 cj5wuVm4koY2ENuXWEo6HTwHQB_gaqzgfileS4RNfITiRHrhgU9Ihe.GlIZcWTt.AJlaA9h6gp78
 61RP7flECQ41XEtkX71WkcBzWrQoltLinDN5.JKbVHkgLk8EkZe3mkmihPNj3yBCKQuadwij5K4R
 pn8qVqjLUBEnUFFvurPPkJlfchyG2TL3_QRbLN_KQZLc_RYDq.60QWxar8tykvdKll4JWToG1Yu1
 PqYlE_wn_NP5CyIf1zjsYIQ_uPo5Ozmcg.yHpwVHm07sjGCb_hjJ3Alx2aNdE8H7gPQ6L2njI9R3
 Y2KZuo_ZJo9RyF4duxs6F0TmwnWkAytoHHuLy7YJk8GWkBLQqzrguw7Wm4za..oAgDkvSPl7NfGX
 EThhnNTpPWy8CSWOMIWHkmNxg3JYB_fOAi9Yh6B.uABj2w9w0VUsif5Jx2IO3Wyi8RNoT0i5f4xN
 wRXPbPzJQXm2SI12QFjfkZxMCcyVRYS7yUsqBe_Hw202pFKLFtJ4QqJS4LTKDfxmIJSE_.KbAZDp
 RbqghlwPpuuEHZRjacqct1PgjxutuQ2ohEogy0zwAB38hAIJw_NLosx2TQ4.MP189R4nK8ln9GVV
 d8HxPE5ZDCwEBZdt9wfBE3RQHSxSb6mWxG0GrXI4W0UV7AFzaXGDH_yQgjuVMX0UXbx6zdxTitbw
 3TXAIZ3iKrcoU9ksPlFXdgCUCT5ZPZj7iZHINK9U.mnLHol0cIw0vIyPDwJurRlI3QXreYA4rH5P
 YicFv
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Thu, 2 Dec 2021 01:39:26 +0000
Received: by kubenode511.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID bdaef0ef34b025effa6bea3f4bb0a21c;
          Thu, 02 Dec 2021 01:39:20 +0000 (UTC)
Message-ID: <e7f08e37-514e-c817-491e-7a1b8f373708@schaufler-ca.com>
Date:   Wed, 1 Dec 2021 17:39:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] Add GlowSlayer Explicit Access Control from Cory Craig
 <gs.cory.craig@gmail.com>
Content-Language: en-US
To:     Cory Craig <gs.cory.craig@gmail.com>,
        linux-security-module@vger.kernel.org
References: <20211202004505.230526-1-gs.cory.craig@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20211202004505.230526-1-gs.cory.craig@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.19306 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 12/1/2021 4:45 PM, Cory Craig wrote:
> Add GlowSlayer Security System with Tinfoil Pre-Init check
> Add GlowSlayer Security System with Slowboot Post-Init check
> Add GlowSlayer Resilient Return Value Holder struct pbit
> Add GlowSlayer gs_tinfoil_slowboot shared code
> Add Makefiles/KConfigs
> Updated security/{Kconfig, Makefile} to allow for enabling
> GlowSlayer Security System
> Add conditional compilation in init/main.c for calling tinfoil_verify
>
> Signed-off-by: Cory Craig <gs.cory.craig@gmail.com>

You *must*:
	- Adhere to the Linux kernel coding conventions
	- Explain what GlowSlayer does, and why it is relevant

You really should:
	- Break this into a set of smaller patches for review
	- Refactor it as an LSM

> ---
> This could prevent a physical access backdoor from being trivially
> exploited via a poisoned init program placed by the attacker.
> This also helps	prevent	a successful hack of a computer	while
> running	from putting in a poisoned init causing LUKS encryption
> password from being disclosed to the adversary since the only
> component trusted is the kernel and a reboot into the UEFI console
> is required to add additional MOK certificates. This is also resistant
> to tampering of the files being validated since it doesn't depend on
> atributes set on the file. The administration is also extremely simple.
> This would prove very helpful in areas of the world that are less than
> free where state level actors may target journalists via the purchase
> or development of zero day attacks because it accounts for the scenario
> where uncontained root is obtained and the attacker may add any keys
> or run any commands. Ideally this will be combined with an external
> booloader carried with the user, removed from the computer when in use
> that validates the kernel in a zero trust manner with an unencrypted
> boot partition. This would serve as a honeypot for attackers that obtain
> physical access to the system so the user might know if someone has
> attempted to compromise their system and has the resources to alter
> the TPM in some way.
> ---
>   MAINTAINERS                         |    4 +
>   include/linux/gs_pbit.h             |   46 ++
>   include/linux/gs_tinfoil.h          |    5 +
>   include/linux/gs_tinfoil_slowboot.h |  159 ++++
>   init/main.c                         |    7 +
>   security/Kconfig                    |    1 +
>   security/Makefile                   |    1 +
>   security/gs/Kconfig                 |  139 ++++
>   security/gs/Makefile                |   13 +
>   security/gs/gs_pbit.c               |  137 +++
>   security/gs/gs_slowboot.c           |   82 ++
>   security/gs/gs_tinfoil.c            |   72 ++
>   security/gs/gs_tinfoil_slowboot.c   | 1193 +++++++++++++++++++++++++++
>   13 files changed, 1859 insertions(+)
>   create mode 100644 include/linux/gs_pbit.h
>   create mode 100644 include/linux/gs_tinfoil.h
>   create mode 100644 include/linux/gs_tinfoil_slowboot.h
>   create mode 100644 security/gs/Kconfig
>   create mode 100644 security/gs/Makefile
>   create mode 100644 security/gs/gs_pbit.c
>   create mode 100644 security/gs/gs_slowboot.c
>   create mode 100644 security/gs/gs_tinfoil.c
>   create mode 100644 security/gs/gs_tinfoil_slowboot.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a2345c..76a78bb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8046,6 +8046,10 @@ F:	Documentation/filesystems/gfs2*
>   F:	fs/gfs2/
>   F:	include/uapi/linux/gfs2_ondisk.h
>   
> +GLOWSLAYER SECURITY SYSTEM
> +M:	Cory Craig <gs.cory.craig@gmail.com>
> +S:	Maintained
> +
>   GIGABYTE WMI DRIVER
>   M:	Thomas Weißschuh <thomas@weissschuh.net>
>   L:	platform-driver-x86@vger.kernel.org
> diff --git a/include/linux/gs_pbit.h b/include/linux/gs_pbit.h
> new file mode 100644
> index 0000000..599a96b
> --- /dev/null
> +++ b/include/linux/gs_pbit.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _GS_PBIT_H
> +#define _GS_PBIT_H
> +
> +#include <linux/random.h>
> +/*
> + * Tamper Resistant "Paranoid Bit"
> + */
> +
> +struct pbit {
> +	int rs;
> +	int ev1;
> +	int status;
> +	int ev2;
> +	int ms;
> +	int ev3;
> +	int dead;
> +	int ls;
> +};
> +
> +#define PBIT_DST 0xBAAAAAAA
> +#define PBIT_DED 0x5555555D
> +#define PBIT_YES 0x55552AAA
> +#define PBIT_NO 0x81083C1
> +#define PBIT_ERR 0xFFFFFFFF
> +#define PBIT_MGK 0xCF0850F1
> +
> +void pbit_check_no(struct pbit *pc, int ev);
> +void pbit_check_setup(struct pbit *pc, int ev);
> +void pbit_check_yes(struct pbit *pc, int ev, const int *rv);
> +int pbit_check(struct pbit *pc);
> +int pbit_infer(struct pbit *pc);
> +
> +#define PBIT_OK(pc) (pbit_check(&(pc)) == PBIT_YES ? 1 : 0)
> +#define PBIT_FAIL(pc) (pbit_check(&(pc)) == PBIT_NO ? 1 : 0)
> +#define PBIT_DEAD(pc) (pbit_check(&(pc)) == PBIT_ERR ? 1 : 0)
> +#define PBIT_GET(pc) (pbit_infer(&(pc)))
> +#define PBIT_RET(pc) (pbit_infer(&(pc)))
> +#define PBIT_Y(pc, x) do {\
> +	int __PBIT_RV_VAL;\
> +	get_random_bytes(&__PBIT_RV_VAL, sizeof(int));\
> +	pbit_check_yes(&(pc), (x), &__PBIT_RV_VAL);\
> +} while (0)
> +#define PBIT_N(pc, x) pbit_check_no(&(pc), (x))
> +#define PBIT_RECOVER(pc) pbit_check_recover(&(pc))
> +#endif
> diff --git a/include/linux/gs_tinfoil.h b/include/linux/gs_tinfoil.h
> new file mode 100644
> index 0000000..bf9e44f
> --- /dev/null
> +++ b/include/linux/gs_tinfoil.h
> @@ -0,0 +1,5 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _X_GS_TINFOIL_H
> +#define _X_GS_TINFOIL_H
> +void tinfoil_verify(void);
> +#endif
> diff --git a/include/linux/gs_tinfoil_slowboot.h b/include/linux/gs_tinfoil_slowboot.h
> new file mode 100644
> index 0000000..7ee4634
> --- /dev/null
> +++ b/include/linux/gs_tinfoil_slowboot.h
> @@ -0,0 +1,159 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _X_GS_TINFOIL_SLOWBOOT_H
> +#define _X_GS_TINFOIL_SLOWBOOT_H
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <crypto/aead.h>
> +#include <crypto/hash.h>
> +#include <crypto/skcipher.h>
> +#include <crypto/akcipher.h>
> +#include <crypto/public_key.h>
> +#include <linux/err.h>
> +#include <linux/fips.h>
> +#include <linux/gfp.h>
> +#include <linux/scatterlist.h>
> +#include <linux/string.h>
> +#include <linux/moduleparam.h>
> +#include <linux/jiffies.h>
> +#include <linux/timex.h>
> +#include <linux/interrupt.h>
> +#include <linux/limits.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/random.h>
> +#include <linux/gs_pbit.h>
> +
> +#define GS_STRING_BASE 4096
> +
> +/* File Validation item */
> +struct slowboot_validation_item {
> +	char hash[GS_STRING_BASE+2];
> +	u8 b_hash[GS_STRING_BASE+1];
> +	char path[PATH_MAX+1];
> +	struct pbit is_ok;
> +	char *buf;
> +	size_t buf_len;
> +	struct file *fp;
> +	long long pos;
> +};
> +
> +/* Container Struct for the entire process */
> +struct slowboot_tinfoil {
> +	struct kstat *st;
> +	struct slowboot_validation_item *validation_items;
> +	int failures;
> +	int initialized;
> +	int slwbt_ct;
> +	char config_file[PATH_MAX];
> +	char config_file_signature[PATH_MAX];
> +	char config_pkey[GS_STRING_BASE+1];
> +	int error_code;
> +	struct pbit error;
> +};
> +
> +/* shash container struct */
> +struct sdesc {
> +	struct shash_desc shash;
> +	char ctx[];
> +};
> +
> +/* Container for a single item check */
> +struct tinfoil_check {
> +	struct slowboot_validation_item *item;
> +	struct crypto_shash *alg;
> +	struct sdesc *sd;
> +	unsigned char *digest;
> +};
> +
> +/* Initialization Container Holding initial signature verification items */
> +struct slowboot_init_container {
> +	struct file *fp;
> +	struct file *sfp;
> +	struct crypto_shash *halg;
> +	struct sdesc *hsd;
> +	size_t file_size;
> +	size_t sfp_file_size;
> +	loff_t pos;
> +	loff_t remaining;
> +	loff_t sfp_pos;
> +	int num_read;
> +	int sfp_num_read;
> +	long num_items;
> +	char *buf;
> +	char *sfp_buf;
> +	unsigned char *kernel_key;
> +	unsigned char *digest;
> +	struct slowboot_validation_item *items;
> +	struct slowboot_validation_item *c_item;
> +	int kernel_key_len;
> +	struct public_key_signature sig;
> +	struct public_key rsa_pub_key;
> +};
> +
> +/* Signature Verification Container */
> +struct sig_verify {
> +	struct crypto_wait cwait;
> +	struct crypto_akcipher *tfm;
> +	struct akcipher_request *req;
> +	struct scatterlist src_tab[3];
> +	const char *alg_name;
> +	void *output;
> +	unsigned int outlen;
> +	char alg_name_buf[CRYPTO_MAX_ALG_NAME];
> +};
> +
> +char *__gs_read_file_to_memory(struct file *fp,
> +			       size_t file_size,
> +			       loff_t *pos,
> +			       int ignore_size);
> +size_t __gs_get_file_size(struct file *fp);
> +int __gs_memmem_sp(const char *s1, size_t s1_len,
> +		   const char *s2, size_t s2_len);
> +struct sdesc *__gs_init_sdesc(struct crypto_shash *alg);
> +int __gs_pk_sig_verify_init(struct sig_verify *sv,
> +			    const struct public_key *pkey,
> +			    const struct public_key_signature *sig,
> +			    const char *pkalgopd);
> +/*
> + * Perform entire test
> + * @config_tinfoil_cf: path for the configuration file
> + * @config_tinfoil_cfs: path for the configuration file checksum file
> + * @config_tinfoil_pk: correctly (DER for RSA) encoded public key in HEX
> + * @config_tinfoil_pklen: strlen of @tinfoil_pk
> + * @config_tinfoil_dglen: number of bytes in digest 64 for sha512
> + * @config_tinfoil_hslen: strlen of hex representation of digest, 128 for sha512
> + * @tinfoil_pkalgo: algorithm used, likely "rsa"
> + * @tinfoil_pkalgopd: algorithm padding, likely "pkcs1pad(rsa,sha512)" can be ""
> + * @tinfoil_hsalgo: digest used, likely "sha512"
> + * @config_tinfoil_idtype: public_key.id_type likely "X509"
> + * @gs_irq_killer: Nullable spinlock_t to block IRQ during test
> + * @config_tinfoil_new_line: char for new line '\n'
> + * @config_tinfoil_override: magic cmdline value to bypass test
> + * @config_tinfoil_version: logic version to use likely 1
> + * @config_tinfoil_reserved: future use
> + * @config_tinfoil_unused: future use
> + * @config_bug_on_fail: BUG(); if errors occur
> + */
> +int __gs_tfsb_go(const char *config_tinfoil_cf,
> +		 const char *config_tinfoil_cfs,
> +		 const char *config_tinfoil_pk,
> +		 int config_tinfoil_pklen,
> +		 int config_tinfoil_dglen,
> +		 int config_tinfoil_hslen,
> +		 const char *config_tinfoil_pkalgo,
> +		 const char *config_tinfoil_pkalgopd,
> +		 const char *config_tinfoil_hsalgo,
> +		 const char *config_tinfoil_idtype,
> +		 spinlock_t *gs_irq_killer,
> +		 char config_tinfoil_new_line,
> +		 const char *config_tinfoil_override,
> +		 int config_tinfoil_version,
> +		 const char *config_tinfoil_reserved,
> +		 const void *config_tinfoil_unused,
> +		 int config_bug_on_fail);
> +
> +#endif
> diff --git a/init/main.c b/init/main.c
> index bb984ed..a2bd8e7 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -99,6 +99,9 @@
>   #include <linux/kcsan.h>
>   #include <linux/init_syscalls.h>
>   #include <linux/stackdepot.h>
> +#ifdef CONFIG_TINFOIL
> +#include <linux/gs_tinfoil.h>
> +#endif
>   
>   #include <asm/io.h>
>   #include <asm/bugs.h>
> @@ -1521,6 +1524,10 @@ static int __ref kernel_init(void *unused)
>   
>   	do_sysctl_args();
>   
> +#ifdef CONFIG_TINFOIL
> +	tinfoil_verify();
> +#endif
> +
>   	if (ramdisk_execute_command) {
>   		ret = run_init_process(ramdisk_execute_command);
>   		if (!ret)
> diff --git a/security/Kconfig b/security/Kconfig
> index 0b847f4..3508094 100644
> --- a/security/Kconfig
> +++ b/security/Kconfig
> @@ -228,6 +228,7 @@ source "security/yama/Kconfig"
>   source "security/safesetid/Kconfig"
>   source "security/lockdown/Kconfig"
>   source "security/landlock/Kconfig"
> +source "security/gs/Kconfig"
>   
>   source "security/integrity/Kconfig"
>   
> diff --git a/security/Makefile b/security/Makefile
> index 18121f8..b79402b 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
>   obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
>   obj-$(CONFIG_BPF_LSM)			+= bpf/
>   obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
> +obj-$(CONFIG_GS_BASE)			+= gs/
>   
>   # Object integrity file lists
>   obj-$(CONFIG_INTEGRITY)			+= integrity/
> diff --git a/security/gs/Kconfig b/security/gs/Kconfig
> new file mode 100644
> index 0000000..b6dc784
> --- /dev/null
> +++ b/security/gs/Kconfig
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config GS_BASE
> +	prompt "GlowSlayer Base Code"
> +	bool
> +	default n
> +	help
> +	  This enables GS Security Enhancements for cryptographic checks of files
> +	  at times when the check is useful to create a form of explicit access
> +	  control. Tinfoil is Pre-Init. Slowboot is Post-Init and controlled by
> +	  the init process
> +menu "Tinfoil Cryptographic Init Verification"
> +	config TINFOIL
> +		prompt "Enable Tinfoil Init Verification"
> +		bool
> +		default n
> +		depends on GS_BASE
> +	config TINFOIL_CF
> +		prompt "Tinfoil Config File(must be visible at boot)"
> +		string
> +		default "/etc/gs/tinfoil" if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_CFS
> +		prompt "Tinfoil Config File Signature File (must be visible at boot)"
> +		string
> +		default "/etc/gs/tinfoil.sig" if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_PK
> +		prompt "Tinfoil Public Key (Hex String Literal)"
> +		string
> +		default "" if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_PKLEN
> +		prompt "Tinfoil Public Key Length (Of Hex, maybe <1052>)"
> +		int
> +		default 1052 if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_DGLEN
> +		prompt "Digest Length for validation (sha512 is <64>)"
> +		int
> +		default 64 if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_HSLEN
> +		prompt "Digest Has Length in Hex (sha512 is <128>)"
> +		int
> +		default 128 if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_PKALGO
> +		prompt "Algorithm used for verification <rsa>"
> +		string
> +		default "rsa" if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_PKALGOPD
> +		prompt "Algorithm with padding <pkcs1pad(rsa,sha512)>"
> +		string
> +		default "pkcs1pad(rsa,sha512)" if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_HSALGO
> +		prompt "Hash Algorithm <sha512>"
> +		string
> +		default "sha512" if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_IDTYPE
> +		prompt "Signature ID Type <X509>"
> +		string
> +		default "X509" if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_BUG
> +		prompt "Bug on Fail"
> +		int
> +		default 0 if TINFOIL
> +		depends on TINFOIL
> +	config TINFOIL_OVERRIDE
> +		prompt "Override Parameter"
> +		string
> +		default "tinfoil_override" if TINFOIL
> +		depends on TINFOIL
> +endmenu
> +menu "Slowboot Cryptographic PostInit Verification"
> +	config SLOWBOOT
> +		prompt "Enable Slowboot PostInit Verification"
> +		bool
> +		default n
> +		depends on GS_BASE
> +	config SLOWBOOT_CF
> +		prompt "Slowboot Config File(must be visible at boot)"
> +		string
> +		default "/etc/gs/slowboot" if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_CFS
> +		prompt "Slowboot Config File Signature File (must be visible at boot)"
> +		string
> +		default "/etc/gs/slowboot.sig" if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_PK
> +		prompt "Slowboot Public Key (Hex String Literal)"
> +		string
> +		default "" if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_PKLEN
> +		prompt "Slowboot Public Key Length (Of Hex, maybe <1052>)"
> +		int
> +		default 1052 if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_DGLEN
> +		prompt "Digest Length for validation (sha512 is <64>)"
> +		int
> +		default 64 if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_HSLEN
> +		prompt "Digest Has Length in Hex (sha512 is <128>)"
> +		int
> +		default 128 if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_PKALGO
> +		prompt "Algorithm used for verification <rsa>"
> +		string
> +		default "rsa" if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_PKALGOPD
> +		prompt "Algorithm with padding <pkcs1pad(rsa,sha512)>"
> +		string
> +		default "pkcs1pad(rsa,sha512)" if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_HSALGO
> +		prompt "Hash Algorithm <sha512>"
> +		string
> +		default "sha512" if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_IDTYPE
> +		prompt "Signature ID Type <X509>"
> +		string
> +		default "X509" if SLOWBOOT
> +		depends on SLOWBOOT
> +	config SLOWBOOT_BUG
> +		prompt "Bug on Fail"
> +		int
> +		default 0 if SLOWBOOT
> +		depends on SLOWBOOT
> +endmenu
> diff --git a/security/gs/Makefile b/security/gs/Makefile
> new file mode 100644
> index 0000000..db59bdc
> --- /dev/null
> +++ b/security/gs/Makefile
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for building the GS Security Items
> +#
> +obj-$(CONFIG_GS_BASE) += gs_pbit.o gs_tinfoil_slowboot.o
> +
> +ifdef CONFIG_TINFOIL
> +obj-y += gs_tinfoil.o
> +endif
> +
> +ifdef CONFIG_SLOWBOOT
> +obj-m += gs_slowboot.o
> +endif
> diff --git a/security/gs/gs_pbit.c b/security/gs/gs_pbit.c
> new file mode 100644
> index 0000000..d4eca49
> --- /dev/null
> +++ b/security/gs/gs_pbit.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/gs_pbit.h>
> +
> +/*
> + * Copyright Cory Craig <gs.cory.craig@gmail.com> 2021
> + *
> + * 'Paranoid Bit'
> + *
> + * The pbit data type should provide a mitigation for rowhammer as well
> + * as other situations where the processor/memory cannot be trusted completely
> + * such as unintentional or intentional radiation energizing a bit(s)
> + * This can be useful when you set a status for a permission check and then
> + * have cleanup to perform and an attacker my try to flip a status variable
> + */
> +
> +/*
> + * Set the status to NO
> + * @pc: paranoid bit
> + */
> +void pbit_check_no(struct pbit *pc, int ev)
> +{
> +	if (!pc)
> +		return;
> +	pc->status = PBIT_DST;
> +	pc->dead = PBIT_DED;
> +	pc->ls = PBIT_NO;
> +	pc->ms = PBIT_NO;
> +	pc->rs = PBIT_NO;
> +	pc->ev1 = ev;
> +	pc->ev2 = ev;
> +	pc->ev3 = ev;
> +}
> +/*
> + * Initialize the state to ERR
> + * @pc: paranoid bit
> + */
> +void pbit_check_setup(struct pbit *pc, int ev)
> +{
> +	if (!pc)
> +		return;
> +	pc->status = PBIT_DST;
> +	pc->dead = PBIT_DED;
> +	pc->ls = PBIT_YES;
> +	pc->ms = PBIT_ERR;
> +	pc->rs = PBIT_NO;
> +	pc->ev1 = ev;
> +	pc->ev2 = ev;
> +	pc->ev3 = ev;
> +}
> +
> +/*
> + * Set the status to YES
> + * @pc: paranoid bit
> + */
> +void pbit_check_yes(struct pbit *pc, int ev, const int *rv)
> +{
> +	if (!pc)
> +		return;
> +	if (rv)
> +		pc->dead = *rv;
> +	else
> +		pc->dead = PBIT_MGK;
> +	pc->status = pc->dead;
> +	pc->ls = PBIT_YES;
> +	pc->ms = PBIT_YES;
> +	pc->rs = PBIT_YES;
> +	pc->ev1 = ev;
> +	pc->ev2 = ev;
> +	pc->ev3 = ev;
> +}
> +
> +/*
> + * Check current status of paranoid bit, any alterations since a set status
> + * should return a PBIT_ERR
> + * @pc: paranoid bit
> + */
> +int pbit_check(struct pbit *pc)
> +{
> +	struct pbit pc_copy;
> +
> +	if (!pc)
> +		return PBIT_ERR;
> +	pc_copy = *pc;
> +	if (pc_copy.status == pc_copy.dead && pc_copy.ls == PBIT_YES
> +	    && pc_copy.ms == PBIT_YES && pc_copy.rs == PBIT_YES
> +	    && pc_copy.status != PBIT_ERR && pc_copy.ev1 == pc_copy.ev2
> +	    && pc_copy.ev1 == pc_copy.ev3) {
> +		*pc = pc_copy;
> +		return PBIT_YES;
> +	} else if (pc_copy.status == PBIT_DST && pc_copy.dead == PBIT_DED
> +		   && pc_copy.ls == PBIT_NO && pc_copy.ms == PBIT_NO
> +		   && pc_copy.rs == PBIT_NO && pc_copy.ev1 == pc_copy.ev2
> +		   && pc_copy.ev1 == pc_copy.ev3) {
> +		*pc = pc_copy;
> +		return PBIT_NO;
> +	}
> +	*pc = pc_copy;
> +	return PBIT_ERR;
> +}
> +
> +/*
> + * Infer the value out of the pbit, failure is always -EINVAL
> + * @pc: paranoid bit
> + */
> +int pbit_infer(struct pbit *pc)
> +{
> +	struct pbit pc_copy;
> +
> +	pc_copy = *pc;
> +	switch (pbit_check(&pc_copy)) {
> +	case PBIT_ERR:
> +		return PBIT_ERR;
> +	default:
> +		*pc = pc_copy;
> +		return pc_copy.ev2;
> +	}
> +}
> +
> +/*
> + * Attempt to recover the value, sets pbit value to PBIT_ERR
> + * @pc: paranoid bit
> + */
> +void pbit_check_recover(struct pbit *pc)
> +{
> +	struct pbit pc_copy;
> +
> +	pc_copy = *pc;
> +	if (pc_copy.ev1 == pc_copy.ev2 && pc_copy.ev3 == pc_copy.ev1)
> +		pbit_check_setup(&pc_copy, pc_copy.ev1);
> +	else if (pc_copy.ev1 == pc_copy.ev2 || pc_copy.ev1 == pc_copy.ev3)
> +		pbit_check_setup(&pc_copy, pc_copy.ev1);
> +	else if (pc_copy.ev2 == pc_copy.ev3)
> +		pbit_check_setup(&pc_copy, pc_copy.ev3);
> +	else
> +		pbit_check_setup(&pc_copy, PBIT_ERR);
> +	*pc = pc_copy;
> +}
> diff --git a/security/gs/gs_slowboot.c b/security/gs/gs_slowboot.c
> new file mode 100644
> index 0000000..e0dd1f2
> --- /dev/null
> +++ b/security/gs/gs_slowboot.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GS Slowboot PostInit Integrity Check
> + * Copyright (C) 2021 Cory Craig
> + */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <crypto/aead.h>
> +#include <crypto/hash.h>
> +#include <crypto/skcipher.h>
> +#include <crypto/akcipher.h>
> +#include <crypto/public_key.h>
> +#include <linux/err.h>
> +#include <linux/fips.h>
> +#include <linux/gfp.h>
> +#include <linux/scatterlist.h>
> +#include <linux/string.h>
> +#include <linux/moduleparam.h>
> +#include <linux/jiffies.h>
> +#include <linux/timex.h>
> +#include <linux/interrupt.h>
> +#include <linux/limits.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/random.h>
> +#include <linux/gs_pbit.h>
> +#include <linux/gs_tinfoil_slowboot.h>
> +
> +DEFINE_SPINLOCK(gs_s_irq_killer);
> +
> +#ifndef CONFIG_SLOWBOOT_NEW_LINE
> +#define CONFIG_SLOWBOOT_NEW_LINE '\n'
> +#endif
> +
> +#ifndef CONFIG_SLOWBOOT_OVERRIDE
> +#define CONFIG_SLOWBOOT_OVERRIDE "not_applicable_no_gssb_override"
> +#endif
> +
> +#ifndef CONFIG_SLOWBOOT_VERSION
> +#define CONFIG_SLOWBOOT_VERSION 1
> +#endif
> +
> +#ifndef CONFIG_SLOWBOOT_BUG
> +#define CONFIG_SLOWBOOT_BUG 0
> +#endif
> +
> +/*
> + * Main function for validation
> + */
> +static int __init slowboot_mod_init(void)
> +{
> +	return __gs_tfsb_go(CONFIG_SLOWBOOT_CF,
> +			    CONFIG_SLOWBOOT_CFS,
> +			    CONFIG_SLOWBOOT_PK,
> +			    CONFIG_SLOWBOOT_PKLEN,
> +			    CONFIG_SLOWBOOT_DGLEN,
> +			    CONFIG_SLOWBOOT_HSLEN,
> +			    CONFIG_SLOWBOOT_PKALGO,
> +			    CONFIG_SLOWBOOT_PKALGOPD,
> +			    CONFIG_SLOWBOOT_HSALGO,
> +			    CONFIG_SLOWBOOT_IDTYPE,
> +			    &gs_s_irq_killer,
> +			    CONFIG_SLOWBOOT_NEW_LINE,
> +			    CONFIG_SLOWBOOT_OVERRIDE,
> +			    CONFIG_SLOWBOOT_VERSION,
> +			    NULL,
> +			    NULL,
> +			    CONFIG_SLOWBOOT_BUG);
> +}
> +
> +static void __exit slowboot_mod_exit(void) { }
> +
> +module_init(slowboot_mod_init);
> +module_exit(slowboot_mod_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("GS Slowboot");
> +MODULE_AUTHOR("Cory Craig <gs.cory.craig@gmail.com>");
> +MODULE_VERSION("1.0");
> diff --git a/security/gs/gs_tinfoil.c b/security/gs/gs_tinfoil.c
> new file mode 100644
> index 0000000..917aa1f
> --- /dev/null
> +++ b/security/gs/gs_tinfoil.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GS Tinfoil Pre Init Integrity Check
> + * Copyright (C) 2021 Cory Craig
> + */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <crypto/aead.h>
> +#include <crypto/hash.h>
> +#include <crypto/skcipher.h>
> +#include <crypto/akcipher.h>
> +#include <crypto/public_key.h>
> +#include <linux/err.h>
> +#include <linux/fips.h>
> +#include <linux/gfp.h>
> +#include <linux/scatterlist.h>
> +#include <linux/string.h>
> +#include <linux/moduleparam.h>
> +#include <linux/jiffies.h>
> +#include <linux/timex.h>
> +#include <linux/interrupt.h>
> +#include <linux/limits.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/random.h>
> +#include <linux/gs_pbit.h>
> +#include <linux/gs_tinfoil_slowboot.h>
> +#include <linux/gs_tinfoil.h>
> +
> +#ifndef CONFIG_TINFOIL_NEW_LINE
> +#define CONFIG_TINFOIL_NEW_LINE '\n'
> +#endif
> +
> +#ifndef CONFIG_TINFOIL_VERSION
> +#define CONFIG_TINFOIL_VERSION 1
> +#endif
> +
> +#ifndef CONFIG_TINFOIL_BUG
> +#define CONFIG_TINFOIL_BUG 0
> +#endif
> +
> +DEFINE_SPINLOCK(gs_irq_killer);
> +
> +/*
> + * Verify boot files chaining off a trusted kernel
> + * There should be an LSM hook for this to avoid
> + * conditional compilation
> + */
> +void tinfoil_verify(void)
> +{
> +	pr_err("GS TFSB tinfoil verify finished with status: %d\n",
> +	       __gs_tfsb_go(CONFIG_TINFOIL_CF,
> +			    CONFIG_TINFOIL_CFS,
> +			    CONFIG_TINFOIL_PK,
> +			    CONFIG_TINFOIL_PKLEN,
> +			    CONFIG_TINFOIL_DGLEN,
> +			    CONFIG_TINFOIL_HSLEN,
> +			    CONFIG_TINFOIL_PKALGO,
> +			    CONFIG_TINFOIL_PKALGOPD,
> +			    CONFIG_TINFOIL_HSALGO,
> +			    CONFIG_TINFOIL_IDTYPE,
> +			    &gs_irq_killer,
> +			    CONFIG_TINFOIL_NEW_LINE,
> +			    CONFIG_TINFOIL_OVERRIDE,
> +			    CONFIG_TINFOIL_VERSION,
> +			    NULL,
> +			    NULL,
> +			    CONFIG_TINFOIL_BUG));
> +}
> diff --git a/security/gs/gs_tinfoil_slowboot.c b/security/gs/gs_tinfoil_slowboot.c
> new file mode 100644
> index 0000000..8b605f9
> --- /dev/null
> +++ b/security/gs/gs_tinfoil_slowboot.c
> @@ -0,0 +1,1193 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * GlowSlayer Tinfoil/Slowboot Shared
> + * Copyright (C) 2021 Cory Craig
> + */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <crypto/aead.h>
> +#include <crypto/hash.h>
> +#include <crypto/skcipher.h>
> +#include <crypto/akcipher.h>
> +#include <crypto/public_key.h>
> +#include <linux/err.h>
> +#include <linux/fips.h>
> +#include <linux/gfp.h>
> +#include <linux/scatterlist.h>
> +#include <linux/string.h>
> +#include <linux/moduleparam.h>
> +#include <linux/jiffies.h>
> +#include <linux/timex.h>
> +#include <linux/interrupt.h>
> +#include <linux/limits.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/stat.h>
> +#include <linux/random.h>
> +#include <linux/gs_pbit.h>
> +#include <linux/gs_tinfoil_slowboot.h>
> +/*******************************************************************************
> + *         ___   _                  ___   _                                    *
> + *        / __| | |  ___  __ __ __ / __| | |  __ _   _  _   ___   _ _          *
> + *       | (_-\ | | / _ \ \ V  V / \__ \ | | / _` | | || | / -_) | '_|         *
> + *        \___| |_| \___/  \_/\_/  |___/ |_| \__,_|  \_, | \___| |_|           *
> + *                                                   |__/                      *
> + *                        Dedicated to Terry A. Davis                          *
> + ******************************************************************************/
> +#define GLOW(code, spot, FUNC) pr_err("GS TFSB Fail ErrorCode: %d @ %s.%s\n",\
> +				code, spot, FUNC)
> +////////////////////////////////////////////////////////////////////////////////
> +
> +/*
> + * Failure Option to simply alert
> + * @tf: slowboot_tinfoil struct
> + */
> +static void __gs_tinfoil_fail_alert(struct slowboot_tinfoil **tf, int is_bug)
> +{
> +	pr_err("GS TFSB FAIL\n");
> +	if (is_bug) {
> +		if (*tf != NULL)
> +			kfree(*tf);
> +		*tf = NULL;
> +		BUG_ON(is_bug);
> +	}
> +}
> +
> +/*
> + * Allocate data for public key signature validation
> + * @sv: sig verify container
> + * @pk: public key
> + */
> +static int pk_sig_verify_alloc(struct sig_verify *sv,
> +			       const struct public_key *pkey)
> +{
> +	struct pbit pc;
> +
> +	sv->tfm = crypto_alloc_akcipher(sv->alg_name, 0, 0);
> +	if (IS_ERR(sv->tfm)) {
> +		PBIT_Y(pc, (int)(long)sv->tfm);
> +		sv->tfm = NULL;
> +		GLOW(PBIT_GET(pc), __func__, "crypto_alloc_akcipher");
> +		return PBIT_RET(pc);
> +	}
> +
> +	sv->req = akcipher_request_alloc(sv->tfm, GFP_KERNEL);
> +	if (!sv->req) {
> +		GLOW(-ENOMEM, __func__, "akcipher_request_alloc");
> +		return -ENOMEM;
> +	}
> +
> +	if (crypto_akcipher_set_pub_key(sv->tfm, pkey->key, pkey->keylen)) {
> +		GLOW(-ENOMEM,
> +		     __func__, "crypto_akcipher_set_pub_key");
> +		return -EINVAL;
> +	}
> +
> +	sv->outlen = crypto_akcipher_maxsize(sv->tfm);
> +	sv->output = kmalloc(sv->outlen, GFP_KERNEL);
> +	if (!sv->output) {
> +		GLOW(-ENOMEM, __func__, "kmalloc(sv->output)");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Perform signature verification of the config file
> + * @sv: sig verify container
> + * @sig: public key signature
> + */
> +static int pk_sig_verify_validate(struct sig_verify *sv,
> +				  const struct public_key_signature *sig)
> +{
> +	akcipher_request_set_crypt(sv->req, sv->src_tab, NULL, sig->s_size,
> +				   sig->digest_size);
> +
> +	crypto_init_wait(&sv->cwait);
> +	akcipher_request_set_callback(sv->req,
> +		CRYPTO_TFM_REQ_MAY_BACKLOG|CRYPTO_TFM_REQ_MAY_SLEEP,
> +				      crypto_req_done, &sv->cwait);
> +
> +	return crypto_wait_req(crypto_akcipher_verify(sv->req), &sv->cwait);
> +}
> +
> +/*
> + * Deallocate signature verification data
> + * @sv: sig verify container
> + */
> +static void pk_sig_verify_free(struct sig_verify *sv)
> +{
> +	if (sv->output != NULL)
> +		kfree(sv->output);
> +	if (sv->req != NULL)
> +		akcipher_request_free(sv->req);
> +	if (sv->tfm != NULL)
> +		crypto_free_akcipher(sv->tfm);
> +
> +	sv->output = NULL;
> +	sv->req = NULL;
> +	sv->tfm = NULL;
> +}
> +
> +/*
> + * Perform signature verification
> + * @pkey: public key struct
> + * @sig: public key signature struct
> + */
> +int local_public_key_verify_signature(const struct public_key *pkey,
> +				      const struct public_key_signature *sig,
> +				      const char *XCFG_TINFOIL_PKALGOPD)
> +{
> +	struct sig_verify sv;
> +	struct pbit pc;
> +
> +	if (!pkey || !sig || !sig->s || !sig->digest)
> +		return -ENOPKG;
> +
> +	PBIT_N(pc, -EINVAL);
> +
> +	if (__gs_pk_sig_verify_init(&sv, pkey, sig, XCFG_TINFOIL_PKALGOPD)) {
> +		GLOW(-EINVAL,
> +		   __func__, "__gs_pk_sig_verify_init");
> +		goto err;
> +	}
> +
> +	if (pk_sig_verify_alloc(&sv, pkey)) {
> +		GLOW(-EINVAL,
> +		     __func__, "pk_sig_verify_alloc");
> +		goto err;
> +	}
> +
> +	if (pk_sig_verify_validate(&sv, sig) == 0) {
> +		PBIT_Y(pc, 0);
> +		goto out;
> +	}
> +
> +err:
> +	PBIT_N(pc, -EINVAL);
> +out:
> +	pk_sig_verify_free(&sv);
> +	return PBIT_RET(pc);
> +}
> +
> +/*
> + * Open file related to current item
> + * @item: slow boot validation item
> + */
> +static int tinfoil_open(struct slowboot_validation_item *item)
> +{
> +	struct pbit pc;
> +
> +	item->fp = filp_open(item->path, O_RDONLY, 0);
> +	if (IS_ERR(item->fp) || item->fp == NULL) {
> +		PBIT_N(pc, (int)(long)item->fp);
> +		item->fp = NULL;
> +		pr_err("GS TFSB Fail:%s:%s:%d @ %s.filp_open\n",
> +		       item->hash,
> +		       item->path,
> +		       PBIT_OK(item->is_ok),
> +		       __func__);
> +		return PBIT_RET(pc);
> +	}
> +	item->pos = 0;
> +	return 0;
> +}
> +
> +/*
> + * Stat file to get size
> + * @item: slow boot validation item
> + */
> +static int tinfoil_stat_alloc(struct slowboot_tinfoil *tinfoil,
> +			      struct slowboot_validation_item *item)
> +{
> +	if (
> +		vfs_getattr(&(item->fp->f_path),
> +			tinfoil->st,
> +			STATX_SIZE,
> +			AT_STATX_SYNC_AS_STAT
> +		) != 0) {
> +		pr_err("GS TFSB Fail: Cannot Stat:%s @ %s.vfs_getattr\n",
> +		       item->path,
> +		       __func__);
> +		return -EINVAL;
> +	}
> +
> +	item->buf_len = tinfoil->st->size;
> +
> +	return 0;
> +}
> +
> +/*
> + * Close file
> + * @item: slowboot validation item
> + */
> +static void tinfoil_close(struct slowboot_validation_item *item)
> +{
> +	if (item->fp != NULL)
> +		filp_close(item->fp, NULL);
> +}
> +
> +/*
> + * read file into buffer
> + * @item: slowboot validation item
> + */
> +static int tinfoil_read(struct slowboot_tinfoil *tinfoil,
> +			struct slowboot_validation_item *item)
> +{
> +	struct pbit pc;
> +	size_t number_read;
> +
> +	number_read = 0;
> +	PBIT_N(pc, -EINVAL);
> +
> +	if (item->fp == NULL)
> +		goto fail;
> +
> +	item->buf = vmalloc(item->buf_len+1);
> +	if (!item->buf) {
> +		PBIT_N(pc, -ENOMEM);
> +		goto fail;
> +	}
> +	memset(item->buf, 0, item->buf_len+1);
> +
> +	item->pos = 0;
> +	number_read = kernel_read(item->fp,
> +				  item->buf,
> +				  tinfoil->st->size,
> +				  &(item->pos));
> +
> +	if (number_read != item->buf_len)
> +		goto fail;
> +
> +	if (hex2bin(item->b_hash, item->hash, 64) != 0) {
> +		pr_err("GS TFSB Fail: StoredHashFail:%s @ %s.hex2bin\n",
> +		       item->path, __func__);
> +		goto fail;
> +	}
> +
> +	PBIT_Y(pc, 0);
> +	goto out;
> +fail:
> +	if (item->buf != NULL) {
> +		vfree(item->buf);
> +		item->buf = NULL;
> +	}
> +out:
> +	return PBIT_RET(pc);
> +}
> +
> +/*
> + * Zero tinfoil_check and set the item
> + * @c: struct tinfoil check
> + * @item: slowboot validation item
> + */
> +static int tinfoil_check_init(struct tinfoil_check *c,
> +			      struct slowboot_validation_item *item)
> +{
> +	memset(c, 0, sizeof(struct tinfoil_check));
> +
> +	if (item == NULL || item->buf == NULL || item->buf_len == 0)
> +		return -EINVAL;
> +
> +	c->item = item;
> +
> +	return 0;
> +}
> +
> +/*
> + * Allocate everyting needed to check one item
> + * @c: tinfoil check
> + */
> +static int tinfoil_check_allocate(struct tinfoil_check *c,
> +				  const char *XCFG_TINFOIL_HSALGO,
> +				  int XCFG_TINFOIL_DGLEN)
> +{
> +	struct pbit pc;
> +
> +	c->alg = crypto_alloc_shash(XCFG_TINFOIL_HSALGO, 0, 0);
> +	if (IS_ERR(c->alg)) {
> +		PBIT_N(pc, (int)(long)c->alg);
> +		c->alg = NULL;
> +		GLOW(PBIT_GET(pc), __func__, "crypto_alloc_shash");
> +		return PBIT_RET(pc);
> +	}
> +
> +	c->digest = kmalloc(XCFG_TINFOIL_DGLEN+1, GFP_KERNEL);
> +	if (!c->digest) {
> +		c->digest = NULL;
> +		GLOW(PBIT_GET(pc), __func__, "kmalloc");
> +		return -ENOMEM;
> +	}
> +
> +	memset(c->digest, 0, XCFG_TINFOIL_DGLEN+1);
> +
> +	c->sd = __gs_init_sdesc(c->alg);
> +	if (!c->sd) {
> +		c->sd = NULL;
> +		GLOW(-EINVAL, __func__, "__gs_init_sdesc");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Hash and validate the hash
> + * @c: tinfoil check
> + */
> +static void tinfoil_check_validate(struct tinfoil_check *c,
> +				   int XCFG_TINFOIL_DGLEN)
> +{
> +	int i;
> +
> +	crypto_shash_digest(&(c->sd->shash), c->item->buf, c->item->buf_len,
> +			    c->digest);
> +
> +	PBIT_Y(c->item->is_ok, 0);
> +	for (i = 0; i < XCFG_TINFOIL_DGLEN; i++) {
> +		if (c->item->b_hash[i] != c->digest[i]) {
> +			PBIT_N(c->item->is_ok, 0);
> +			return;
> +		}
> +	}
> +}
> +
> +/*
> + * Free Items realted to a tinfoil check
> + * @c: tinfoil check
> + */
> +static void tinfoil_check_free(struct tinfoil_check *c)
> +{
> +	if (c->item != NULL && c->item->buf != NULL) {
> +		vfree(c->item->buf);
> +		c->item->buf = NULL;
> +	}
> +	if (c->sd != NULL)
> +		kfree(c->sd);
> +	if (c->digest != NULL)
> +		kfree(c->digest);
> +	if (c->alg != NULL)
> +		crypto_free_shash(c->alg);
> +}
> +
> +/*
> + * Check a single item for validity
> + * @item: slowboot validation item
> + * consumes item->buf
> + */
> +static void tinfoil_check(struct slowboot_validation_item *item,
> +			  const char *XCFG_TINFOIL_HSALGO,
> +			  int XCFG_TINFOIL_DGLEN)
> +{
> +
> +	struct tinfoil_check check;
> +
> +	if (tinfoil_check_init(&check, item)) {
> +		GLOW(-EINVAL, __func__, "tinfoil_check_init");
> +		goto err;
> +	}
> +
> +	if (tinfoil_check_allocate(&check,
> +				   XCFG_TINFOIL_HSALGO,
> +				   XCFG_TINFOIL_DGLEN)) {
> +		GLOW(-EINVAL, __func__, "tinfoil_check_allocate");
> +		goto err;
> +	}
> +
> +	tinfoil_check_validate(&check, XCFG_TINFOIL_DGLEN);
> +	goto std_return;
> +err:
> +	PBIT_N(item->is_ok, 0);
> +std_return:
> +	tinfoil_check_free(&check);
> +}
> +
> +/*
> + * Validate an item (file against it's hash)
> + * The functions will log the failure
> + * This must return 0 or 1 because it adds to a failure count
> + * @item: slowboot validation item
> + */
> +static int tinfoil_unwrap(struct slowboot_tinfoil *tinfoil,
> +			  struct slowboot_validation_item *item,
> +			  const char *XCFG_TINFOIL_HSALGO,
> +			  int XCFG_TINFOIL_DGLEN)
> +{
> +	if (tinfoil_open(item) != 0) {
> +		GLOW(1, __func__, "tinfoil_open");
> +		return 1;
> +	}
> +
> +	if (tinfoil_stat_alloc(tinfoil, item) != 0) {
> +		GLOW(1, __func__, "tinfoil_close");
> +		tinfoil_close(item);
> +		return 1;
> +	}
> +
> +	// Do not access item->buf after this
> +	if (tinfoil_read(tinfoil, item) != 0) {
> +		GLOW(1, __func__, "tinfoil_read");
> +		tinfoil_close(item);
> +		return 1;
> +	}
> +
> +	tinfoil_check(item, XCFG_TINFOIL_HSALGO, XCFG_TINFOIL_DGLEN);
> +	if (!PBIT_OK(item->is_ok)) {
> +		pr_err("GS TFSB Fail:%s:%s @ %s.tinfoil_check\n",
> +		       item->path,
> +		       "Fail",
> +		       __func__);
> +	}
> +	tinfoil_close(item);
> +	if (PBIT_OK(item->is_ok))
> +		return 0;
> +	else
> +		return 1;
> +}
> +
> +/*
> + * Parse one line, fill in the item
> + * @item: slowboot validation item
> + * @line: start of current line
> + * @remaining: remaining bytes
> + */
> +static loff_t fill_in_item(struct slowboot_validation_item *item,
> +			   char *line, loff_t *remaining,
> +			   const char XCFG_TINFOIL_NEW_LINE,
> +			   int XCFG_TINFOIL_HSLEN)
> +{
> +	loff_t pos, off, rem;
> +
> +	if (line == NULL) {
> +		if (remaining != NULL)
> +			*remaining = 0;
> +		return 0;
> +	}
> +
> +	pos = 0;
> +	off = 0;
> +	rem = *remaining;
> +
> +	while (rem > 0) {
> +		if (line[pos] == ' ' && off == 0 && rem > 1)
> +			off = pos+1;
> +
> +		if (line[pos] == XCFG_TINFOIL_NEW_LINE)
> +			break;
> +
> +		pos++;
> +		rem--;
> +	}
> +
> +	if (item->path != NULL && item->hash != NULL) {
> +		memset(item->path, 0, PATH_MAX+1);
> +		memset(item->hash, 0, XCFG_TINFOIL_HSLEN+2);
> +
> +		// Make sure we have a good item
> +		// This should not happen because who
> +		// would sign something malicous?
> +		if (pos > (XCFG_TINFOIL_HSLEN+5) && (pos-off-1) > 0) {
> +			memcpy(item->hash, line, XCFG_TINFOIL_HSLEN);
> +			memcpy(item->path, line+off, pos-off);
> +		}
> +	}
> +
> +	if (rem > 0) {
> +		pos++;
> +		rem--;
> +	}
> +	*remaining = rem;
> +	return pos;
> +}
> +
> +/*
> + * initialize slowboot init container items
> + * @sic: slowboot init container
> + */
> +static void slowboot_init_setup(struct slowboot_init_container *sic,
> +				const char *XCFG_TINFOIL_PKALGO,
> +				const char *XCFG_TINFOIL_IDTYPE,
> +				int XCFG_TINFOIL_DGLEN,
> +				const char *XCFG_TINFOIL_HSALGO,
> +				int XCFG_TINFOIL_PKLEN)
> +{
> +	memset(sic, 0, sizeof(struct slowboot_init_container));
> +
> +	sic->rsa_pub_key.pkey_algo = XCFG_TINFOIL_PKALGO;
> +	sic->rsa_pub_key.id_type = XCFG_TINFOIL_IDTYPE;
> +	sic->rsa_pub_key.keylen = -1;
> +	sic->sig.digest_size = XCFG_TINFOIL_DGLEN;
> +	sic->sig.pkey_algo = XCFG_TINFOIL_PKALGO;
> +	sic->sig.hash_algo = XCFG_TINFOIL_HSALGO;
> +	sic->kernel_key_len = XCFG_TINFOIL_PKLEN/2; // Hex/2
> +}
> +
> +/*
> + * Set up keys
> + * @sic: slowboot init container
> + * @config_pkey: hex representation of DER encoded public key
> + */
> +static int slowboot_init_setup_keys(struct slowboot_init_container *sic,
> +				    const char *config_pkey)
> +{
> +
> +	if (sic->kernel_key_len <= 0 || config_pkey == NULL)
> +		return -EINVAL;
> +
> +	sic->kernel_key = (unsigned char *)
> +			  kmalloc(sic->kernel_key_len+1, GFP_KERNEL);
> +	if (!sic->kernel_key)
> +		return -ENOMEM;
> +
> +	if (hex2bin(sic->kernel_key, config_pkey, sic->kernel_key_len) == 0)
> +		sic->kernel_key[sic->kernel_key_len] = '\0';
> +	else
> +		return -EINVAL;
> +
> +	sic->rsa_pub_key.key = sic->kernel_key;
> +	sic->rsa_pub_key.keylen = sic->kernel_key_len;
> +
> +	return 0;
> +}
> +
> +/*
> + * Open config files, read them into memory
> + * @sic: slowboot init container
> + * @config_file: hash path\n format config file
> + * @config_file_signature: raw binary checksum file of @config_file
> + */
> +static int slowboot_init_open_files(struct slowboot_init_container *sic,
> +				    const char *config_file,
> +				    const char *config_file_signature)
> +{
> +	struct pbit pc;
> +
> +	if (config_file == NULL || config_file_signature == NULL)
> +		return -EINVAL;
> +
> +	sic->fp = filp_open(config_file, O_RDONLY, 0);
> +	if (IS_ERR(sic->fp)) {
> +		PBIT_N(pc, (int)(long)sic->fp);
> +		sic->fp = NULL;
> +		GLOW(PBIT_GET(pc), __func__, "config_file");
> +		return PBIT_RET(pc);
> +	}
> +
> +	sic->sfp = filp_open(config_file_signature, O_RDONLY, 0);
> +	if (IS_ERR(sic->sfp)) {
> +		PBIT_N(pc, (int)(long)sic->sfp);
> +		sic->sfp = NULL;
> +		GLOW(PBIT_GET(pc), __func__, "config_file_signature");
> +		return PBIT_RET(pc);
> +	}
> +
> +	sic->file_size = __gs_get_file_size(sic->fp);
> +	sic->sfp_file_size = __gs_get_file_size(sic->sfp);
> +
> +	if (sic->file_size <= 0 || sic->sfp_file_size <= 0) {
> +		GLOW(-EINVAL, __func__, "invalid file size");
> +		return -EINVAL;
> +	}
> +
> +	sic->pos = 0;
> +	sic->buf = __gs_read_file_to_memory(sic->fp, sic->file_size,
> +					    &sic->pos, 0);
> +	if (!sic->buf) {
> +		pr_err("GS TFSB File Read Error:%s @ %s.config_file\n",
> +		       config_file,
> +		       __func__);
> +		return -EINVAL;
> +	}
> +
> +	sic->sfp_pos = 0;
> +	sic->sfp_buf = __gs_read_file_to_memory(sic->sfp, sic->sfp_file_size,
> +						&sic->sfp_pos, 0);
> +	if (!sic->sfp_buf) {
> +		pr_err("GS TFSB File Read Error:%s @ %s.config_file_signature\n",
> +			config_file_signature,
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Intiatilize and perform hash digest of the config file
> + * @sic: slowboot init container
> + */
> +static int slowboot_init_digest(struct slowboot_init_container *sic,
> +				int XCFG_TINFOIL_DGLEN,
> +				const char *XCFG_TINFOIL_HSALGO)
> +{
> +	struct pbit pc;
> +
> +	sic->halg = crypto_alloc_shash(XCFG_TINFOIL_HSALGO, 0, 0);
> +	if (IS_ERR(sic->halg)) {
> +		PBIT_N(pc, (int)(long)sic->halg);
> +		GLOW(PBIT_GET(pc), __func__, "crypto_alloc_shash");
> +		sic->halg = NULL;
> +		return PBIT_RET(pc);
> +	}
> +
> +	sic->digest = kmalloc(XCFG_TINFOIL_DGLEN+1, GFP_KERNEL);
> +	if (!sic->digest) {
> +		GLOW(-ENOMEM, __func__, "kmalloc~digest");
> +		return -ENOMEM;
> +	}
> +
> +	memset(sic->digest, 0, XCFG_TINFOIL_DGLEN+1);
> +
> +	sic->hsd = __gs_init_sdesc(sic->halg);
> +	if (!sic->hsd) {
> +		GLOW(-EINVAL, __func__, "__gs_init_sdesc");
> +		return -EINVAL;
> +	}
> +
> +	if (sic->buf == NULL || sic->file_size <= 0) {
> +		GLOW(-EINVAL, __func__, "~invalid buffer or file_size");
> +		return -EINVAL;
> +	}
> +
> +	crypto_shash_digest(&(sic->hsd->shash), sic->buf, sic->file_size,
> +			    sic->digest);
> +
> +	sic->sig.s = sic->sfp_buf; // Raw signature file data
> +	sic->sig.s_size = sic->sfp_file_size; // Length of Signature File
> +	sic->sig.digest = sic->digest; // Hash of the config file
> +
> +	return 0;
> +}
> +
> +/*
> + * Free slowboot init container items
> + * @sic: slowboot init container
> + */
> +static void slowboot_init_free(struct slowboot_init_container *sic)
> +{
> +	if (sic->fp != NULL)
> +		filp_close(sic->fp, NULL);
> +	if (sic->sfp != NULL)
> +		filp_close(sic->sfp, NULL);
> +	if (sic->halg != NULL)
> +		kfree(sic->halg);
> +	if (sic->buf != NULL)
> +		vfree(sic->buf);
> +	if (sic->sfp_buf != NULL)
> +		vfree(sic->sfp_buf);
> +	if (sic->kernel_key != NULL)
> +		kfree(sic->kernel_key);
> +	if (sic->digest != NULL)
> +		kfree(sic->digest);
> +	sic->c_item = NULL;
> +}
> +
> +/*
> + * Determine the number of lines, allocate enough space for all items
> + * parse all the lines, update values to reflect
> + * @sic: slowboot init container
> + * @item_ref: ** to array of items, set to not null by function on success
> + * @item-ct: * to item count, updated by function
> + */
> +static int slowboot_init_process(struct slowboot_init_container *sic,
> +				 struct slowboot_validation_item **item_ref,
> +				 int *item_ct,
> +				 const char XCFG_TINFOIL_NEW_LINE,
> +				 int XCFG_TINFOIL_HSLEN)
> +{
> +
> +	if (sic->file_size <= 0) {
> +		GLOW(-EINVAL, __func__, "~invalid file size");
> +		return -EINVAL;
> +	}
> +
> +	for (sic->pos = 0; sic->pos < sic->file_size; sic->pos++) {
> +		if (sic->buf[sic->pos] == XCFG_TINFOIL_NEW_LINE)
> +			sic->num_items++;
> +	}
> +
> +	if (sic->num_items == 0) {
> +		GLOW(-EINVAL, __func__, "~no items");
> +		return -EINVAL;
> +	}
> +
> +	sic->c_item = sic->items = (struct slowboot_validation_item *)
> +				vmalloc(sizeof(struct slowboot_validation_item)
> +					*sic->num_items);
> +
> +	if (!sic->c_item) {
> +		GLOW(-ENOMEM, __func__, "vmalloc~c_item");
> +		return -ENOMEM;
> +	}
> +
> +	sic->pos = 0; // reusing
> +	sic->remaining = sic->file_size;
> +	while (sic->remaining) {
> +		sic->pos += fill_in_item(sic->c_item, &sic->buf[sic->pos],
> +					 &sic->remaining,
> +					 XCFG_TINFOIL_NEW_LINE,
> +					 XCFG_TINFOIL_HSLEN);
> +		sic->c_item++;
> +	}
> +
> +	*item_ref = sic->items;
> +	*item_ct = sic->num_items;
> +	return 0;
> +}
> +
> +/*
> + * Signature check the config file and initialize all the data
> + * The functions called will log the error so no need to store/check
> + * @tinfoil: slowboot tinfoil
> + */
> +static int slowboot_init(struct slowboot_tinfoil *tinfoil,
> +			 const char *XCFG_TINFOIL_PKALGOPD,
> +			 const char *XCFG_TINFOIL_PKALGO,
> +			 const char *XCFG_TINFOIL_IDTYPE,
> +			 int XCFG_TINFOIL_DGLEN,
> +			 const char *XCFG_TINFOIL_HSALGO,
> +			 int XCFG_TINFOIL_PKLEN,
> +			 const char XCFG_TINFOIL_NEW_LINE,
> +			 int XCFG_TINFOIL_HSLEN)
> +{
> +	struct slowboot_init_container sic;
> +	struct pbit pc;
> +
> +	PBIT_N(pc, -EINVAL);
> +
> +	slowboot_init_setup(&sic,
> +			    XCFG_TINFOIL_PKALGO,
> +			    XCFG_TINFOIL_IDTYPE,
> +			    XCFG_TINFOIL_DGLEN,
> +			    XCFG_TINFOIL_HSALGO,
> +			    XCFG_TINFOIL_PKLEN);
> +
> +	if (slowboot_init_setup_keys(&sic, tinfoil->config_pkey))
> +		goto fail;
> +
> +	if (slowboot_init_open_files(&sic, tinfoil->config_file,
> +				     tinfoil->config_file_signature))
> +		goto fail;
> +
> +	if (slowboot_init_digest(&sic,
> +				 XCFG_TINFOIL_DGLEN,
> +				 XCFG_TINFOIL_HSALGO))
> +		goto fail;
> +
> +	if (local_public_key_verify_signature(&sic.rsa_pub_key,
> +					      &sic.sig,
> +					      XCFG_TINFOIL_PKALGOPD))
> +		goto fail;
> +
> +	if (slowboot_init_process(&sic, &tinfoil->validation_items,
> +				  &tinfoil->slwbt_ct,
> +				  XCFG_TINFOIL_NEW_LINE,
> +				  XCFG_TINFOIL_HSLEN))
> +		goto fail;
> +
> +	PBIT_Y(pc, 0);
> +	goto out;
> +
> +fail:
> +	PBIT_N(pc, -EINVAL);
> +	GLOW(PBIT_GET(pc), __func__, "~^^^^^^///////////>");
> +	tinfoil->slwbt_ct = 0;
> +	if (!sic.items)
> +		vfree(sic.items);
> +
> +	tinfoil->validation_items = NULL;
> +out:
> +	slowboot_init_free(&sic);
> +	return PBIT_RET(pc);
> +}
> +
> +/*
> + * Check for /proc/cmdlin override
> + */
> +static int slowboot_enabled(const char *XCFG_TINFOIL_OVERRIDE)
> +{
> +	struct file *fp;
> +	size_t file_size;
> +	char *buf;
> +	loff_t pos;
> +	struct pbit pc;
> +
> +	fp = NULL;
> +	file_size = 0;
> +	buf = NULL;
> +	pos = 0;
> +
> +	PBIT_N(pc, 0);
> +
> +	fp = filp_open("/proc/cmdline", O_RDONLY, 0);
> +	if (IS_ERR(fp)) {
> +		fp = NULL;
> +		PBIT_N(pc, (int)(long)fp);
> +		goto out;
> +	}
> +
> +	file_size = PAGE_SIZE;
> +	buf = __gs_read_file_to_memory(fp, file_size, &pos, 1);
> +
> +	if (!buf) {
> +		PBIT_N(pc, -ENOMEM);
> +		goto out;
> +	}
> +
> +	if (__gs_memmem_sp(buf, file_size,
> +			   XCFG_TINFOIL_OVERRIDE,
> +			   strlen(XCFG_TINFOIL_OVERRIDE)) == 0)
> +		PBIT_Y(pc, 0);
> +
> +out:
> +	if (fp != NULL)
> +		filp_close(fp, NULL);
> +	if (buf != NULL)
> +		vfree(buf);
> +
> +	if (!PBIT_FAIL(pc) || PBIT_GET(pc) != 0)
> +		GLOW(PBIT_GET(pc), __func__, "~???");
> +
> +	if (PBIT_OK(pc) && PBIT_GET(pc) == 0)
> +		return 0;
> +	else
> +		return 1;
> +
> +}
> +
> +/*
> + * Run validation test
> + * @tinfoil: slowboot tinfoil struct
> + */
> +static void slowboot_run_test(struct slowboot_tinfoil *tinfoil,
> +			      const char *XCFG_TINFOIL_PKALGOPD,
> +			      const char *XCFG_TINFOIL_PKALGO,
> +			      const char *XCFG_TINFOIL_IDTYPE,
> +			      int XCFG_TINFOIL_DGLEN,
> +			      const char *XCFG_TINFOIL_HSALGO,
> +			      int XCFG_TINFOIL_PKLEN,
> +			      const char XCFG_TINFOIL_NEW_LINE,
> +			      int XCFG_TINFOIL_HSLEN,
> +			      spinlock_t *gs_irq_killer)
> +{
> +	int j;
> +	unsigned long flags;
> +	struct pbit hard_fail;
> +
> +	WARN_ON(!tinfoil);
> +	if (!tinfoil)
> +		return;
> +
> +	PBIT_Y(hard_fail, 0);
> +	PBIT_N(tinfoil->error, -EINVAL);
> +
> +	spin_lock_irqsave(gs_irq_killer, flags); // Occupy all threads?
> +	if (tinfoil->initialized != 0) {
> +		tinfoil->initialized = 0;
> +		tinfoil->validation_items = NULL;
> +		if (slowboot_init(tinfoil,
> +				  XCFG_TINFOIL_PKALGOPD,
> +				  XCFG_TINFOIL_PKALGO,
> +				  XCFG_TINFOIL_IDTYPE,
> +				  XCFG_TINFOIL_DGLEN,
> +				  XCFG_TINFOIL_HSALGO,
> +				  XCFG_TINFOIL_PKLEN,
> +				  XCFG_TINFOIL_NEW_LINE,
> +				  XCFG_TINFOIL_HSLEN) != 0) {
> +			PBIT_N(hard_fail, 0);
> +			goto out;
> +		}
> +	}
> +
> +	for (j = 0; j < tinfoil->slwbt_ct; j++) {
> +		tinfoil->failures += tinfoil_unwrap(tinfoil,
> +					&(tinfoil->validation_items[j]),
> +					XCFG_TINFOIL_HSALGO,
> +					XCFG_TINFOIL_DGLEN);
> +	}
> +out:
> +		if (tinfoil->validation_items != NULL) {
> +			vfree(tinfoil->validation_items);
> +			tinfoil->validation_items = NULL;
> +			tinfoil->initialized = 1;
> +		}
> +
> +	if (tinfoil->failures != 0 || tinfoil->slwbt_ct == 0 ||
> +	    !PBIT_OK(hard_fail))
> +		PBIT_N(tinfoil->error, -EINVAL);
> +	else
> +		PBIT_Y(tinfoil->error, 0);
> +	spin_unlock_irqrestore(gs_irq_killer, flags);
> +}
> +
> +/*
> + * Initialize data for verification process
> + * @tinfoil: slowboot tinfoil struct
> + */
> +static int slowboot_tinfoil_init(struct slowboot_tinfoil *tinfoil,
> +				 const char *XCFG_TINFOIL_CF,
> +				 const char *XCFG_TINFOIL_CFS,
> +				 const char *XCFG_TINFOIL_PK,
> +				 int XCFG_TINFOIL_PKLEN)
> +{
> +	if (tinfoil == NULL)
> +		return -EINVAL;
> +
> +	memset(tinfoil, 0, sizeof(struct slowboot_tinfoil));
> +	strncpy(tinfoil->config_file, XCFG_TINFOIL_CF, PATH_MAX);
> +	strncpy(tinfoil->config_file_signature, XCFG_TINFOIL_CFS, PATH_MAX);
> +	strncpy(tinfoil->config_pkey, XCFG_TINFOIL_PK, XCFG_TINFOIL_PKLEN);
> +	tinfoil->initialized = 1;
> +	tinfoil->failures = 0;
> +	PBIT_Y(tinfoil->error, 0);
> +	tinfoil->st = kmalloc(sizeof(struct kstat), GFP_KERNEL);
> +	if (!tinfoil->st) {
> +		PBIT_N(tinfoil->error, -ENOMEM);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Deallocate data
> + * @tinfoil: slowboot tinfoil struct
> + */
> +static void slowboot_tinfoil_free(struct slowboot_tinfoil *tinfoil)
> +{
> +	if (tinfoil->st != NULL) {
> +		kfree(tinfoil->st);
> +		tinfoil->st = NULL;
> +	}
> +}
> +
> +////////////////////////////////////////////////////////////////////////////////
> +/*
> + * Obtain size of file via seeking
> + * @fp: struct file
> + */
> +size_t __gs_get_file_size(struct file *fp)
> +{
> +	size_t file_size;
> +
> +	file_size = 0;
> +	if (fp == NULL)
> +		goto out;
> +
> +	default_llseek(fp, 0, SEEK_END);
> +	file_size = fp->f_pos;
> +	default_llseek(fp, fp->f_pos * -1, SEEK_CUR);
> +
> +out:
> +	return file_size;
> +}
> +
> +/*
> + * Read file into memory, check every thing
> + * @fp: file structure
> + * @file_size: stated size of file
> + * @pos: position offset return value
> + */
> +char *__gs_read_file_to_memory(struct file *fp,
> +			       size_t file_size,
> +			       loff_t *pos,
> +			       int ignore_size)
> +{
> +	char *buf;
> +	size_t num_read;
> +
> +	buf = NULL;
> +
> +	if (!fp || file_size < 1)
> +		goto out;
> +
> +	buf = vmalloc(file_size+1);
> +
> +	if (!buf)
> +		goto out;
> +
> +	*pos = 0;
> +
> +	default_llseek(fp, 0, SEEK_END);
> +	default_llseek(fp, fp->f_pos * -1, SEEK_CUR);
> +	num_read = kernel_read(fp, buf, file_size, pos);
> +
> +	if (num_read != file_size && !ignore_size) {
> +		vfree(buf);
> +		buf = NULL;
> +	}
> +
> +out:
> +	return buf;
> +}
> +
> +/*
> + * Check string for string, 0 is true
> + * @s1: big string
> + * @s1_len: length of big_string
> + * @s2: little string
> + * @s2_len: length of little string
> + */
> +int __gs_memmem_sp(const char *s1, size_t s1_len, const char *s2, size_t s2_len)
> +{
> +	while (s1_len >= s2_len) {
> +		s1_len--;
> +		if (!memcmp(s1, s2, s2_len))
> +			return 0;
> +		s1++;
> +	}
> +	return 1;
> +}
> +
> +/*
> + * Initialize sdesc struct for digest measuring
> + * @alg: crypto_shash structure
> + */
> +struct sdesc *__gs_init_sdesc(struct crypto_shash *alg)
> +{
> +	struct sdesc *sdesc;
> +	int size;
> +
> +	size = sizeof(struct shash_desc) + crypto_shash_descsize(alg);
> +	sdesc = kmalloc(size, GFP_KERNEL);
> +	if (!sdesc)
> +		return NULL;
> +	sdesc->shash.tfm = alg;
> +	return sdesc;
> +}
> +
> +/*
> + * Initialize public key signature verification
> + * @sv: sig verify container
> + * @pkey: public key
> + * @sig: public key signature
> + * @pkalgopd: padding string
> + */
> +int __gs_pk_sig_verify_init(struct sig_verify *sv,
> +			    const struct public_key *pkey,
> +			    const struct public_key_signature *sig,
> +			    const char *pkalgopd)
> +{
> +	memset(sv, 0, sizeof(struct sig_verify));
> +
> +	if (pkalgopd != NULL && strlen(pkalgopd) > 0) {
> +		snprintf(sv->alg_name_buf, CRYPTO_MAX_ALG_NAME,
> +				pkalgopd);
> +		sv->alg_name = sv->alg_name_buf;
> +	} else
> +		sv->alg_name = sig->pkey_algo;
> +
> +	sg_init_table(sv->src_tab, 3);
> +	sg_set_buf(&sv->src_tab[1], sig->digest, sig->digest_size);
> +	sg_set_buf(&sv->src_tab[0], sig->s, sig->s_size);
> +	return 0;
> +}
> +
> +/*
> + * Perform entire test
> + * @config_tinfoil_cf: path for the configuration file
> + * @config_tinfoil_cfs: path for the configuration file checksum file
> + * @config_tinfoil_pk: correctly (DER for RSA) encoded public key in HEX
> + * @config_tinfoil_pklen: strlen of @tinfoil_pk
> + * @config_tinfoil_dglen: number of bytes in digest 64 for sha512
> + * @config_tinfoil_hslen: strlen of hex representation of digest, 128 for sha512
> + * @tinfoil_pkalgo: algorithm used, likely "rsa"
> + * @tinfoil_pkalgopd: algorithm padding, likely "pkcs1pad(rsa,sha512)" can be ""
> + * @tinfoil_hsalgo: digest used, likely "sha512"
> + * @config_tinfoil_idtype: public_key.id_type likely "X509"
> + * @gs_irq_killer: Nullable spinlock_t to block IRQ during test
> + * @config_tinfoil_new_line: char for new line '\n'
> + * @config_tinfoil_override: magic cmdline value to bypass test
> + * @config_tinfoil_version: logic version to use likely 1
> + * @config_tinfoil_reserved: future use
> + * @config_tinfoil_unused: future use
> + * @config_bug_on_fail: BUG(); if errors occur
> + */
> +int __gs_tfsb_go(const char *config_tinfoil_cf,
> +		 const char *config_tinfoil_cfs,
> +		 const char *config_tinfoil_pk,
> +		 int config_tinfoil_pklen,
> +		 int config_tinfoil_dglen,
> +		 int config_tinfoil_hslen,
> +		 const char *config_tinfoil_pkalgo,
> +		 const char *config_tinfoil_pkalgopd,
> +		 const char *config_tinfoil_hsalgo,
> +		 const char *config_tinfoil_idtype,
> +		 spinlock_t *gs_irq_killer,
> +		 char config_tinfoil_new_line,
> +		 const char *config_tinfoil_override,
> +		 int config_tinfoil_version,
> +		 const char *config_tinfoil_reserved,
> +		 const void *config_tinfoil_unused,
> +		 int config_bug_on_fail)
> +{
> +	struct slowboot_tinfoil *tinfoil;
> +	struct pbit pc;
> +
> +	if (!slowboot_enabled(config_tinfoil_override)) {
> +		pr_err("GS TFSB: disabled\n");
> +		return 0;
> +	}
> +
> +	PBIT_N(pc, -EINVAL);
> +	pr_info("GS TFSB START\n");
> +
> +	tinfoil = kmalloc(sizeof(struct slowboot_tinfoil), GFP_KERNEL);
> +	if (!tinfoil) {
> +		PBIT_N(pc, -ENOMEM);
> +		goto out;
> +	}
> +
> +
> +	if (slowboot_tinfoil_init(tinfoil,
> +				 config_tinfoil_cf,
> +				 config_tinfoil_cfs,
> +				 config_tinfoil_pk,
> +				 config_tinfoil_pklen)) {
> +		PBIT_N(pc, -EINVAL);
> +		goto out;
> +	}
> +
> +	slowboot_run_test(tinfoil,
> +			  config_tinfoil_pkalgopd,
> +			  config_tinfoil_pkalgo,
> +			  config_tinfoil_idtype,
> +			  config_tinfoil_dglen,
> +			  config_tinfoil_hsalgo,
> +			  config_tinfoil_pklen,
> +			  config_tinfoil_new_line,
> +			  config_tinfoil_hslen,
> +			  gs_irq_killer);
> +
> +out:
> +	if (tinfoil) {
> +		slowboot_tinfoil_free(tinfoil);
> +
> +		pr_info("GS TFSB Audit: {Total:%d/Failures:%d}\n",
> +			tinfoil->slwbt_ct, tinfoil->failures);
> +
> +		if (!PBIT_OK(tinfoil->error) || PBIT_GET(tinfoil->error) != 0) {
> +			PBIT_N(pc, PBIT_GET(tinfoil->error));
> +			if (PBIT_GET(tinfoil->error) == 0)
> +				PBIT_N(pc, -EINVAL);
> +		} else
> +			PBIT_Y(pc, 0);
> +
> +	} else {
> +		PBIT_N(pc, -EINVAL);
> +	}
> +
> +
> +	if (PBIT_GET(pc) != 0 || !PBIT_OK(pc)) {
> +		__gs_tinfoil_fail_alert(&tinfoil, config_bug_on_fail);
> +		if (tinfoil != NULL) {
> +			kfree(tinfoil);
> +			tinfoil = NULL;
> +		}
> +		return PBIT_RET(pc);
> +	} else
> +		return PBIT_RET(pc);
> +
> +}
> +EXPORT_SYMBOL_GPL(__gs_tfsb_go);
