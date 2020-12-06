Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840E82D0693
	for <lists+linux-security-module@lfdr.de>; Sun,  6 Dec 2020 19:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgLFSw6 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 6 Dec 2020 13:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgLFSw5 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 6 Dec 2020 13:52:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255E8C0613D0;
        Sun,  6 Dec 2020 10:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XCCbncmiTf57bM+s9gdso7Z2F4RHT3zecZaFR9NPTF0=; b=3OqMtzuZyBAh+0IUfRtwUjVp2j
        vTYGUzaMapoxkR7d34DP2R9VPpNOS4coUcCmZuJ0vhi91pWvlaIJaXbRedcOCwcwvBZYdjRCdIkee
        oidpuRg+bKFZwKNA4Nt/HxODzCVDqmlJa4cjNOfx0v9KUkMMm1AzXtPYxC5H33bjCaRIUnq8cerd2
        4c22zhhNnyd9zwYxRzdk4/IkZ7D9tT12eefeQmW8+Hpeo9TKr7V5BorWVbEi8lVXKFCcA8NtBxJ4I
        RsRU6CqXe+0YgdKwOjuOfAxhimmOmWywSHIPbWWWHX74eDz+FvsLdrCQQc/XHTpjvPsoJ6hcWVomA
        560aoYuA==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1klz8i-0004Ry-Ad; Sun, 06 Dec 2020 18:52:09 +0000
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
To:     Sumit Garg <sumit.garg@linaro.org>,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a13a0e50-2a2d-711e-b547-22d18d776352@infradead.org>
Date:   Sun, 6 Dec 2020 10:51:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi--

Please see doc. comments below.


On 11/3/20 8:01 AM, Sumit Garg wrote:
> Update documentation for Trusted and Encrypted Keys with TEE as a new
> trust source. Following is brief description of updates:
> 
> - Add a section to demostrate a list of supported devices along with

                     demonstrate

>   their security properties/guarantees.
> - Add a key generation section.
> - Updates for usage section including differences specific to a trust
>   source.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++++++++++----
>  1 file changed, 171 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 1da879a..16042c8 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -6,30 +6,161 @@ Trusted and Encrypted Keys are two new key types added to the existing kernel
>  key ring service.  Both of these new types are variable length symmetric keys,
>  and in both cases all keys are created in the kernel, and user space sees,
>  stores, and loads only encrypted blobs.  Trusted Keys require the availability
> -of a Trusted Platform Module (TPM) chip for greater security, while Encrypted
> -Keys can be used on any system.  All user level blobs, are displayed and loaded
> -in hex ascii for convenience, and are integrity verified.
> +of a Trust Source for greater security, while Encrypted Keys can be used on any
> +system. All user level blobs, are displayed and loaded in hex ascii for

s/ascii/ASCII/ please. Yes, I know that it was already there in lower case.

> +convenience, and are integrity verified.
>  
> -Trusted Keys use a TPM both to generate and to seal the keys.  Keys are sealed
> -under a 2048 bit RSA key in the TPM, and optionally sealed to specified PCR
> -(integrity measurement) values, and only unsealed by the TPM, if PCRs and blob
> -integrity verifications match.  A loaded Trusted Key can be updated with new
> -(future) PCR values, so keys are easily migrated to new pcr values, such as
> -when the kernel and initramfs are updated.  The same key can have many saved
> -blobs under different PCR values, so multiple boots are easily supported.
>  
> -TPM 1.2
> --------
> +Trust Source
> +============
>  
> -By default, trusted keys are sealed under the SRK, which has the default
> -authorization value (20 zeros).  This can be set at takeownership time with the
> -trouser's utility: "tpm_takeownership -u -z".
> +Trust Source provides the source of security for the Trusted Keys, on which
> +basis Trusted Keys establishes a Trust model with its user. A Trust Source could
> +differ from one system to another depending on its security requirements. It
> +could be either an off-chip device or an on-chip device. Following section
> +demostrates a list of supported devices along with their security properties/

   demonstrates

> +guarantees:
>  
> -TPM 2.0
> --------
> +  *  Root of trust for storage
>  
> -The user must first create a storage key and make it persistent, so the key is
> -available after reboot. This can be done using the following commands.
> +     (1) TPM (Trusted Platform Module: hardware device)
> +
> +         Rooted to Storage Root Key (SRK) which never leaves the TPM that
> +         provides crypto operation to establish root of trust for storage.
> +
> +     (2) TEE (Trusted Execution Environment: OP-TEE based on Arm TrustZone)
> +
> +         Rooted to Hardware Unique Key (HUK) which is generally burnt in on-chip
> +         fuses and is accessible to TEE only.
> +
> +  *  Execution isolation
> +
> +     (1) TPM
> +
> +         Fixed set of operations running in isolated execution environment.
> +
> +     (2) TEE
> +
> +         Customizable set of operations running in isolated execution
> +         environment verified via Secure/Trusted boot process.
> +
> +  * Optional binding to platform integrity state
> +
> +     (1) TPM
> +
> +         Keys can be optionally sealed to specified PCR (integrity measurement)
> +         values, and only unsealed by the TPM, if PCRs and blob integrity
> +         verifications match. A loaded Trusted Key can be updated with new
> +         (future) PCR values, so keys are easily migrated to new PCR values,
> +         such as when the kernel and initramfs are updated. The same key can
> +         have many saved blobs under different PCR values, so multiple boots are
> +         easily supported.
> +
> +     (2) TEE
> +
> +         Relies on Secure/Trusted boot process for platform integrity. It can
> +         be extended with TEE based measured boot process.
> +
> +  *  On-chip versus off-chip
> +
> +     (1) TPM
> +
> +         Off-chip device connected via serial bus (like I2C, SPI etc.) exposing
> +         physical access which represents an attack surface that can be
> +         mitigated via tamper detection.
> +
> +     (2) TEE
> +
> +         On-chip functionality, immune to this attack surface.
> +
> +  *  Memory attacks (DRAM based like attaching a bus monitor etc.)

                        DRAM-based

> +
> +     (1) TPM
> +
> +         Immune to these attacks as it doesn’t make use of system DRAM.
> +
> +     (2) TEE
> +
> +         An implementation based on TrustZone protected DRAM is susceptible to
> +         such attacks. In order to mitigate these attacks one needs to rely on
> +         on-chip secure RAM to store secrets or have the entire TEE
> +         implementation based on on-chip secure RAM. An alternative mitigation
> +         would be to use encrypted DRAM.
> +
> +  *  Side-channel attacks (cache, memory, CPU or time based)
> +
> +     (1) TPM
> +
> +         Immune to side-channel attacks as its resources are isolated from the
> +         main OS.
> +
> +     (2) TEE
> +
> +         A careful implementation is required to mitigate against these attacks
> +         for resources which are shared (eg. shared memory) with the main OS.

	                                    e.g.

> +         Cache and CPU based side-channel attacks can be mitigated via
> +         invalidating caches and CPU registers during context switch to and from
> +         the secure world.
> +         To mitigate against time based attacks, one needs to have time
> +         invariant implementations (like crypto algorithms etc.).
> +
> +  *  Resistance to physical attacks (power analysis, electromagnetic emanation,
> +     probes etc.)
> +
> +     (1) TPM
> +
> +         Provides limited protection utilizing tamper resistance.
> +
> +     (2) TEE
> +
> +         Provides no protection by itself, relies on the underlying platform for
> +         features such as tamper resistance.
> +
> +
> +Key Generation
> +==============
> +
> +Trusted Keys
> +------------
> +
> +New keys are created from trust source generated random numbers, and are
> +encrypted/decrypted using trust source storage root key.
> +
> +  *  TPM (hardware device) based RNG
> +
> +     Strength of random numbers may vary from one device manufacturer to
> +     another.
> +
> +  *  TEE (OP-TEE based on Arm TrustZone) based RNG
> +
> +     RNG is customizable as per platform needs. It can either be direct output
> +     from platform specific hardware RNG or a software based Fortuna CSPRNG
> +     which can be seeded via multiple entropy sources.
> +
> +Encrypted Keys
> +--------------
> +
> +Encrypted keys do not depend on a trust source, and are faster, as they use AES
> +for encryption/decryption. New keys are created from kernel generated random

                                                        kernel-generated

> +numbers, and are encrypted/decrypted using a specified ‘master’ key. The
> +‘master’ key can either be a trusted-key or user-key type. The main disadvantage
> +of encrypted keys is that if they are not rooted in a trusted key, they are only
> +as secure as the user key encrypting them. The master user key should therefore
> +be loaded in as secure a way as possible, preferably early in boot.
> +
> +
> +Usage
> +=====
> +
> +Trusted Keys usage: TPM
> +-----------------------
> +
> +TPM 1.2: By default, trusted keys are sealed under the SRK, which has the
> +default authorization value (20 zeros).  This can be set at takeownership time

Does "20 zeros" mean 20 bytes of 0s or 20 bits of 0s or something else?

> +with the TrouSerS utility: "tpm_takeownership -u -z".
> +
> +TPM 2.0: The user must first create a storage key and make it persistent, so the
> +key is available after reboot. This can be done using the following commands.
>  
>  With the IBM TSS 2 stack::
>  
> @@ -78,14 +209,21 @@ TPM_STORED_DATA format.  The key length for new keys are always in bytes.
>  Trusted Keys can be 32 - 128 bytes (256 - 1024 bits), the upper limit is to fit
>  within the 2048 bit SRK (RSA) keylength, with all necessary structure/padding.
>  
> -Encrypted keys do not depend on a TPM, and are faster, as they use AES for
> -encryption/decryption.  New keys are created from kernel generated random
> -numbers, and are encrypted/decrypted using a specified 'master' key.  The
> -'master' key can either be a trusted-key or user-key type.  The main
> -disadvantage of encrypted keys is that if they are not rooted in a trusted key,
> -they are only as secure as the user key encrypting them.  The master user key
> -should therefore be loaded in as secure a way as possible, preferably early in
> -boot.
> +Trusted Keys usage: TEE
> +-----------------------
> +
> +Usage::
> +
> +    keyctl add trusted name "new keylen" ring
> +    keyctl add trusted name "load hex_blob" ring
> +    keyctl print keyid
> +
> +"keyctl print" returns an ascii hex copy of the sealed key, which is in format

                             ASCII

> +specific to TEE device implementation.  The key length for new keys are always

                                                                       is always

> +in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> +
> +Encrypted Keys usage
> +--------------------
>  
>  The decrypted portion of encrypted keys can contain either a simple symmetric
>  key or a more complex structure. The format of the more complex structure is
> @@ -103,8 +241,8 @@ Where::
>  	format:= 'default | ecryptfs | enc32'
>  	key-type:= 'trusted' | 'user'
>  
> -
>  Examples of trusted and encrypted key usage:
> +--------------------------------------------

No colon at end of heading, please.

>  
>  Create and save a trusted key named "kmk" of length 32 bytes.
>  
> @@ -150,7 +288,7 @@ Load a trusted key from the saved blob::
>      f1f8fff03ad0acb083725535636addb08d73dedb9832da198081e5deae84bfaf0409c22b
>      e4a8aea2b607ec96931e6f4d4fe563ba
>  
> -Reseal a trusted key under new pcr values::
> +Reseal (TPM specific) a trusted key under new PCR values::
>  
>      $ keyctl update 268728824 "update pcrinfo=`cat pcr.blob`"
>      $ keyctl print 268728824
> @@ -164,11 +302,12 @@ Reseal a trusted key under new pcr values::
>      7ef6a24defe4846104209bf0c3eced7fa1a672ed5b125fc9d8cd88b476a658a4434644ef
>      df8ae9a178e9f83ba9f08d10fa47e4226b98b0702f06b3b8
>  
> +
>  The initial consumer of trusted keys is EVM, which at boot time needs a high
> -quality symmetric key for HMAC protection of file metadata.  The use of a
> +quality symmetric key for HMAC protection of file metadata. The use of a
>  trusted key provides strong guarantees that the EVM key has not been
> -compromised by a user level problem, and when sealed to specific boot PCR
> -values, protects against boot and offline attacks.  Create and save an
> +compromised by a user level problem, and when sealed to a platform integrity
> +state, protects against boot and offline attacks. Create and save an
>  encrypted key "evm" using the above trusted key "kmk":
>  
>  option 1: omitting 'format'::
> 


thanks.
-- 
~Randy

