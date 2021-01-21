Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427B72FF395
	for <lists+linux-security-module@lfdr.de>; Thu, 21 Jan 2021 19:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhAUSvc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 21 Jan 2021 13:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbhAUIpC (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 21 Jan 2021 03:45:02 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEDBC0613C1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Jan 2021 00:44:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m2so714098wmm.1
        for <linux-security-module@vger.kernel.org>; Thu, 21 Jan 2021 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kgJUPk7yGIqf40Sm4lEU2xSQtX0D2PZzSJBu2XCc1vs=;
        b=FxlBHJlxjd52tYAdKf9oTYV9VYZwGruEu05v4yJMcLP8gQiJVQ6i8eOQeXjxB5cmWN
         +wcmHIEr5yjchNi1k/67498+IMHAgV5E82BjyXeiIYiOlrE1z5cHf+1WavGv9pJ9Bgq1
         yl2jMT6SXnzTr1lEk+19/9zbOjqInOofljkyTlVT3HNJhyRoevT1ROC8qeHTThyVTpuJ
         ObG8NK/4/AwPsFFM6f7XWb1Zm7DdKklaRgYX6nt3rUVF655FZl0TpUyRO63t5HBkPqK0
         onycRq2aCZDtrmdhVAL7F5Q8Harj47nK8nEjSSPhIc15pEITkaYIdF+2nyroPMmMnXSl
         HmhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kgJUPk7yGIqf40Sm4lEU2xSQtX0D2PZzSJBu2XCc1vs=;
        b=XGIaZ285fIyRQIiEsSZOFPTREXh+WEOU68EikLSD9hfrCoO3Kc9pnQuEfGrOIK3rPj
         ffmMAsVvopLvxT8cU+KpLNU1kGNU8tV+P8oyyHM9WB2JnYX3OBQ/yj7XtWKq7XwIdEtX
         omO0rSLYfIE4v3fhRT+5di0bRMXcOy9lFlytW01qNPGAD3DV0odoZLjw3J6YknpWovOV
         JrxBIyqH5kG/buAxTxqAzZ4c4LkCLSkJN6hbbYDkoPp15h4HU5zhv450MQuXxFcWMp+M
         /Dl/QQFoFkaWpcOrFv9KNEjH53Z3kTLYh1iWSp5rLgcyovBwRiUJDDR4mflVdpD8kD9f
         8s8A==
X-Gm-Message-State: AOAM533GltRDw0eUVFUPHStkobcHGEYlls5DGPW6jhMzJwkQIiFF+mNv
        eZs38T30mpCbKWlw+XddXlENjg==
X-Google-Smtp-Source: ABdhPJxlLNcwPh4OqaGK271yrHw0l1fiON8DIKNpcWGeLGHLjLHsYuz02u3YZuLXPyJg9CqcY4WXGA==
X-Received: by 2002:a1c:1f11:: with SMTP id f17mr7663241wmf.67.1611218649434;
        Thu, 21 Jan 2021 00:44:09 -0800 (PST)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:75c0:d9d5:7529:414c? ([2a01:e0a:3cb:7bb0:75c0:d9d5:7529:414c])
        by smtp.gmail.com with ESMTPSA id 9sm7818374wmb.14.2021.01.21.00.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 00:44:08 -0800 (PST)
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        op-tee@lists.trustedfirmware.org, Jonathan Corbet <corbet@lwn.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-integrity@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-3-git-send-email-sumit.garg@linaro.org>
 <X/x+N0fgrzIZTeNi@kernel.org>
 <CAFA6WYOUvWAZtYfR4q8beZFkX-CtdxqwJaRQM+GHNMDfQiEWOA@mail.gmail.com>
 <X/+m6+m2/snYj9Vc@kernel.org>
 <CAFA6WYNyirit_AFhoE+XR9PHw=OjRgEdXDqz1uanj_SN2NXeMw@mail.gmail.com>
 <YAa0ys4YJcZtKdfF@kernel.org> <YAeH2pb8szQyjusL@kernel.org>
 <CAFA6WYP5G6NfGk96ePOC+2kpD6B+4hz9nywyUM9Nh=dJDYMiuA@mail.gmail.com>
 <01000177223f74d3-1eef7685-4a19-40d2-ace6-d4cd7f35579d-000000@email.amazonses.com>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <dc3979e8-6bf0-adb7-164d-d50e805a048f@forissier.org>
Date:   Thu, 21 Jan 2021 09:44:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <01000177223f74d3-1eef7685-4a19-40d2-ace6-d4cd7f35579d-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



On 1/21/21 1:02 AM, Jarkko Sakkinen via OP-TEE wrote:
> On Wed, Jan 20, 2021 at 12:53:28PM +0530, Sumit Garg wrote:
>> On Wed, 20 Jan 2021 at 07:01, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>
>>> On Tue, Jan 19, 2021 at 12:30:42PM +0200, Jarkko Sakkinen wrote:
>>>> On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wrote:
>>>>> On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>>>
>>>>>> On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg wrote:
>>>>>>> Hi Jarkko,
>>>>>>>
>>>>>>> On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>>>>>>>
>>>>>>>> On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
>>>>>>>>> Add support for TEE based trusted keys where TEE provides the functionality
>>>>>>>>> to seal and unseal trusted keys using hardware unique key.
>>>>>>>>>
>>>>>>>>> Refer to Documentation/tee.txt for detailed information about TEE.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>>>>>>>>
>>>>>>>> I haven't yet got QEMU environment working with aarch64, this produces
>>>>>>>> just a blank screen:
>>>>>>>>
>>>>>>>> ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -serial stdio
>>>>>>>>
>>>>>>>> My BuildRoot fork for TPM and keyring testing is located over here:
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmdd.git/
>>>>>>>>
>>>>>>>> The "ARM version" is at this point in aarch64 branch. Over time I will
>>>>>>>> define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be then
>>>>>>>> in the master branch.
>>>>>>>>
>>>>>>>> To create identical images you just need to
>>>>>>>>
>>>>>>>> $ make tpmdd_defconfig && make
>>>>>>>>
>>>>>>>> Can you check if you see anything obviously wrong? I'm eager to test this
>>>>>>>> patch set, and in bigger picture I really need to have ready to run
>>>>>>>> aarch64 environment available.
>>>>>>>
>>>>>>> I would rather suggest you to follow steps listed here [1] as to test
>>>>>>> this feature on Qemu aarch64 we need to build firmwares such as TF-A,
>>>>>>> OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
>>>>>>> system [2]. And then it would be easier to migrate them to your
>>>>>>> buildroot environment as well.
>>>>>>>
>>>>>>> [1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/000027.html
>>>>>>> [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
>>>>>>>
>>>>>>> -Sumit
>>>>>>
>>>>>> Can you provide 'keyctl_change'? Otherwise, the steps are easy to follow.
>>>>>>
>>>>>
>>>>> $ cat keyctl_change
>>>>> diff --git a/common.mk b/common.mk
>>>>> index aeb7b41..663e528 100644
>>>>> --- a/common.mk
>>>>> +++ b/common.mk
>>>>> @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?= $(OPTEE_OS_TA_DEV_KIT_DIR)
>>>>>  BR2_PACKAGE_OPTEE_TEST_SITE ?= $(OPTEE_TEST_PATH)
>>>>>  BR2_PACKAGE_STRACE ?= y
>>>>>  BR2_TARGET_GENERIC_GETTY_PORT ?= $(if
>>>>> $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),ttyAMA0)
>>>>> +BR2_PACKAGE_KEYUTILS := y
>>>>>
>>>>>  # All BR2_* variables from the makefile or the environment are appended to
>>>>>  # ../out-br/extra.conf. All values are quoted "..." except y and n.
>>>>> diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
>>>>> index 368c18a..832ab74 100644
>>>>> --- a/kconfigs/qemu.conf
>>>>> +++ b/kconfigs/qemu.conf
>>>>> @@ -20,3 +20,5 @@ CONFIG_9P_FS=y
>>>>>  CONFIG_9P_FS_POSIX_ACL=y
>>>>>  CONFIG_HW_RANDOM=y
>>>>>  CONFIG_HW_RANDOM_VIRTIO=y
>>>>> +CONFIG_TRUSTED_KEYS=y
>>>>> +CONFIG_ENCRYPTED_KEYS=y
>>>>>
>>>>>> After I've successfully tested 2/4, I'd suggest that you roll out one more
>>>>>> version and CC the documentation patch to Elaine and Mini, and clearly
>>>>>> remark in the commit message that TEE is a standard, with a link to the
>>>>>> specification.
>>>>>>
>>>>>
>>>>> Sure, I will roll out the next version after your testing.
>>>>
>>>> Thanks, I'll try this at instant, and give my feedback.
>>>
>>> I bump into this:
>>>
>>> $ make run-only
>>> ln -sf /home/jarkko/devel/tpm/optee/build/../out-br/images/rootfs.cpio.gz /home/jarkko/devel/tpm/optee/build/../out/bin/
>>> ln: failed to create symbolic link '/home/jarkko/devel/tpm/optee/build/../out/bin/': No such file or directory
>>> make: *** [Makefile:194: run-only] Error 1
>>>
>>
>> Could you check if the following directory tree is built after
>> executing the below command?
>>
>> $ make -j`nproc`
>> CFG_IN_TREE_EARLY_TAS=trusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c
>>
>> $ tree out/bin/
>> out/bin/
>> ├── bl1.bin -> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl1.bin
>> ├── bl2.bin -> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl2.bin
>> ├── bl31.bin ->
>> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl31.bin
>> ├── bl32.bin ->
>> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-header_v2.bin
>> ├── bl32_extra1.bin ->
>> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pager_v2.bin
>> ├── bl32_extra2.bin ->
>> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pageable_v2.bin
>> ├── bl33.bin ->
>> /home/sumit/build/optee/build/../edk2/Build/ArmVirtQemuKernel-AARCH64/RELEASE_GCC49/FV/QEMU_EFI.fd
>> ├── Image -> /home/sumit/build/optee/build/../linux/arch/arm64/boot/Image
>> └── rootfs.cpio.gz ->
>> /home/sumit/build/optee/build/../out-br/images/rootfs.cpio.gz
>>
>> 0 directories, 9 files
>>
>> -Sumit
> 
> I actually spotted a build error that was unnoticed last time:
> 
> make[2]: Entering directory '/home/jarkko/devel/tpm/optee/edk2/BaseTools/Tests'
> /bin/sh: 1: python: not found
> 
> I'd prefer not to install Python2. It has been EOL over a year.

AFAIK, everything should build fine with Python3. On my Ubuntu 20.04
machine, this is accomplished by installing package "python-is-python3"
(after uninstalling "python-is-python2" if need be).

$ ls -l /usr/bin/python
lrwxrwxrwx 1 root root 7 Apr 15  2020 /usr/bin/python -> python3

-- 
Jerome
