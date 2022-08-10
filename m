Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48CA58EAAC
	for <lists+linux-security-module@lfdr.de>; Wed, 10 Aug 2022 12:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiHJKrw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 10 Aug 2022 06:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHJKru (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 10 Aug 2022 06:47:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1C585FAF;
        Wed, 10 Aug 2022 03:47:48 -0700 (PDT)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M2mqM0h5Hz67qSS;
        Wed, 10 Aug 2022 18:47:43 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 10 Aug 2022 12:47:46 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Wed, 10 Aug 2022 12:47:46 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 00/10] bpf: Add kfuncs for PKCS#7 signature
 verification
Thread-Topic: [PATCH v9 00/10] bpf: Add kfuncs for PKCS#7 signature
 verification
Thread-Index: AQHYq/ZxvSq1kKhJ80GMpi61nzH0dK2mp4mAgAFNcKA=
Date:   Wed, 10 Aug 2022 10:47:46 +0000
Message-ID: <5ed88c6209a1435dbe6cd479edc1cacd@huawei.com>
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <YvKQ8WWJgWSJB9FC@kernel.org>
In-Reply-To: <YvKQ8WWJgWSJB9FC@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.210.169]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

> From: Jarkko Sakkinen [mailto:jarkko@kernel.org]
> Sent: Tuesday, August 9, 2022 6:53 PM
> On Tue, Aug 09, 2022 at 03:45:53PM +0200, Roberto Sassu wrote:
> > One of the desirable features in security is the ability to restrict import
> > of data to a given system based on data authenticity. If data import can be
> > restricted, it would be possible to enforce a system-wide policy based on
> > the signing keys the system owner trusts.
> >
> > This feature is widely used in the kernel. For example, if the restriction
> > is enabled, kernel modules can be plugged in only if they are signed with a
> > key whose public part is in the primary or secondary keyring.
> >
> > For eBPF, it can be useful as well. For example, it might be useful to
> > authenticate data an eBPF program makes security decisions on.
> 
> Security decision in LSM BPF?

Yes, based on the eBPF programs attached to it.

Roberto

> > After a discussion in the eBPF mailing list, it was decided that the stated
> > goal should be accomplished by introducing four new kfuncs:
> > bpf_lookup_user_key() and bpf_lookup_system_key(), for retrieving a keyring
> > with keys trusted for signature verification, respectively from its serial
> > and from a pre-determined ID; bpf_key_put(), to release the reference
> > obtained with the former two kfuncs, bpf_verify_pkcs7_signature(), for
> > verifying PKCS#7 signatures.
> >
> > Other than the key serial, bpf_lookup_user_key() also accepts key lookup
> > flags, that influence the behavior of the lookup. bpf_lookup_system_key()
> > accepts pre-determined IDs defined in include/linux/verification.h.
> >
> > bpf_key_put() accepts the new bpf_key structure, introduced to tell whether
> > the other structure member, a key pointer, is valid or not. The reason is
> > that verify_pkcs7_signature() also accepts invalid pointers, set with the
> > pre-determined ID, to select a system-defined keyring. key_put() must be
> > called only for valid key pointers.
> >
> > Since the two key lookup functions allocate memory and one increments a key
> > reference count, they must be used in conjunction with bpf_key_put(). The
> > latter must be called only if the lookup functions returned a non-NULL
> > pointer. The verifier denies the execution of eBPF programs that don't
> > respect this rule.
> >
> > The two key lookup functions should be used in alternative, depending on
> > the use case. While bpf_lookup_user_key() provides great flexibility, it
> > seems suboptimal in terms of security guarantees, as even if the eBPF
> > program is assumed to be trusted, the serial used to obtain the key pointer
> > might come from untrusted user space not choosing one that the system
> > administrator approves to enforce a mandatory policy.
> >
> > bpf_lookup_system_key() instead provides much stronger guarantees,
> > especially if the pre-determined ID is not passed by user space but is
> > hardcoded in the eBPF program, and that program is signed. In this case,
> > bpf_verify_pkcs7_signature() will always perform signature verification
> > with a key that the system administrator approves, i.e. the primary,
> > secondary or platform keyring.
> >
> > Nevertheless, key permission checks need to be done accurately. Since
> > bpf_lookup_user_key() cannot determine how a key will be used by other
> > kfuncs, it has to defer the permission check to the actual kfunc using the
> > key. It does it by calling lookup_user_key() with KEY_DEFER_PERM_CHECK as
> > needed permission. Later, bpf_verify_pkcs7_signature(), if called,
> > completes the permission check by calling key_validate(). It does not need
> > to call key_task_permission() with permission KEY_NEED_SEARCH, as it is
> > already done elsewhere by the key subsystem. Future kfuncs using the
> > bpf_key structure need to implement the proper checks as well.
> >
> > Finally, the last kfunc, bpf_verify_pkcs7_signature(), accepts the data and
> > signature to verify as eBPF dynamic pointers, to minimize the number of
> > kfunc parameters, and the keyring with keys for signature verification as a
> > bpf_key structure, returned by one of the two key lookup functions.
> >
> > All kfuncs except bpf_key_put() can be called only from sleepable programs,
> > because of memory allocation and crypto operations. For example, the
> > lsm.s/bpf attach point is suitable, fexit/array_map_update_elem is not.
> >
> > The correctness of implementation of the new kfuncs and of their usage is
> > checked with the introduced tests.
> >
> > The patch set includes patches from other authors (dependencies) for sake
> > of completeness. It is organized as follows.
> >
> > Patch 1 from Benjamin Tissoires introduces the new KF_SLEEPABLE kfunc flag.
> > Patch 2 from KP Singh allows kfuncs to be used by LSM programs. Patch 3
> > allows dynamic pointers to be used as kfunc parameters. Patch 4 exports
> > bpf_dynptr_get_size(), to obtain the real size of data carried by a dynamic
> > pointer. Patch 5 makes available for new eBPF kfuncs some key-related
> > definitions. Patch 6 introduces the bpf_lookup_*_key() and bpf_key_put()
> > kfuncs. Patch 7 introduces the bpf_verify_pkcs7_signature() kfunc. Finally,
> > patches 8-10 introduce the tests.
> >
> > Changelog
> >
> > v8:
> >  - Define the new bpf_key structure to carry the key pointer and whether
> >    that pointer is valid or not (suggested by Daniel)
> >  - Drop patch to mark a kfunc parameter with the __maybe_null suffix
> >  - Improve documentation of kfuncs
> >  - Introduce bpf_lookup_system_key() to obtain a key pointer suitable for
> >    verify_pkcs7_signature() (suggested by Daniel)
> >  - Use the new kfunc registration API
> >  - Drop patch to test the __maybe_null suffix
> >  - Add tests for bpf_lookup_system_key()
> >
> > v7:
> >  - Add support for using dynamic and NULL pointers in kfunc (suggested by
> >    Alexei)
> >  - Add new kfunc-related tests
> >
> > v6:
> >  - Switch back to key lookup helpers + signature verification (until v5),
> >    and defer permission check from bpf_lookup_user_key() to
> >    bpf_verify_pkcs7_signature()
> >  - Add additional key lookup test to illustrate the usage of the
> >    KEY_LOOKUP_CREATE flag and validate the flags (suggested by Daniel)
> >  - Make description of flags of bpf_lookup_user_key() more user-friendly
> >    (suggested by Daniel)
> >  - Fix validation of flags parameter in bpf_lookup_user_key() (reported by
> >    Daniel)
> >  - Rename bpf_verify_pkcs7_signature() keyring-related parameters to
> >    user_keyring and system_keyring to make their purpose more clear
> >  - Accept keyring-related parameters of bpf_verify_pkcs7_signature() as
> >    alternatives (suggested by KP)
> >  - Replace unsigned long type with u64 in helper declaration (suggested by
> >    Daniel)
> >  - Extend the bpf_verify_pkcs7_signature() test by calling the helper
> >    without data, by ensuring that the helper enforces the keyring-related
> >    parameters as alternatives, by ensuring that the helper rejects
> >    inaccessible and expired keyrings, and by checking all system keyrings
> >  - Move bpf_lookup_user_key() and bpf_key_put() usage tests to
> >    ref_tracking.c (suggested by John)
> >  - Call bpf_lookup_user_key() and bpf_key_put() only in sleepable programs
> >
> > v5:
> >  - Move KEY_LOOKUP_ to include/linux/key.h
> >    for validation of bpf_verify_pkcs7_signature() parameter
> >  - Remove bpf_lookup_user_key() and bpf_key_put() helpers, and the
> >    corresponding tests
> >  - Replace struct key parameter of bpf_verify_pkcs7_signature() with the
> >    keyring serial and lookup flags
> >  - Call lookup_user_key() and key_put() in bpf_verify_pkcs7_signature()
> >    code, to ensure that the retrieved key is used according to the
> >    permission requested at lookup time
> >  - Clarified keyring precedence in the description of
> >    bpf_verify_pkcs7_signature() (suggested by John)
> >  - Remove newline in the second argument of ASSERT_
> >  - Fix helper prototype regular expression in bpf_doc.py
> >
> > v4:
> >  - Remove bpf_request_key_by_id(), don't return an invalid pointer that
> >    other helpers can use
> >  - Pass the keyring ID (without ULONG_MAX, suggested by Alexei) to
> >    bpf_verify_pkcs7_signature()
> >  - Introduce bpf_lookup_user_key() and bpf_key_put() helpers (suggested by
> >    Alexei)
> >  - Add lookup_key_norelease test, to ensure that the verifier blocks eBPF
> >    programs which don't decrement the key reference count
> >  - Parse raw PKCS#7 signature instead of module-style signature in the
> >    verify_pkcs7_signature test (suggested by Alexei)
> >  - Parse kernel module in user space and pass raw PKCS#7 signature to the
> >    eBPF program for signature verification
> >
> > v3:
> >  - Rename bpf_verify_signature() back to bpf_verify_pkcs7_signature() to
> >    avoid managing different parameters for each signature verification
> >    function in one helper (suggested by Daniel)
> >  - Use dynamic pointers and export bpf_dynptr_get_size() (suggested by
> >    Alexei)
> >  - Introduce bpf_request_key_by_id() to give more flexibility to the caller
> >    of bpf_verify_pkcs7_signature() to retrieve the appropriate keyring
> >    (suggested by Alexei)
> >  - Fix test by reordering the gcc command line, always compile sign-file
> >  - Improve helper support check mechanism in the test
> >
> > v2:
> >  - Rename bpf_verify_pkcs7_signature() to a more generic
> >    bpf_verify_signature() and pass the signature type (suggested by KP)
> >  - Move the helper and prototype declaration under #ifdef so that user
> >    space can probe for support for the helper (suggested by Daniel)
> >  - Describe better the keyring types (suggested by Daniel)
> >  - Include linux/bpf.h instead of vmlinux.h to avoid implicit or
> >    redeclaration
> >  - Make the test selfcontained (suggested by Alexei)
> >
> > v1:
> >  - Don't define new map flag but introduce simple wrapper of
> >    verify_pkcs7_signature() (suggested by Alexei and KP)
> >
> > Benjamin Tissoires (1):
> >   btf: Add a new kfunc flag which allows to mark a function to be
> >     sleepable
> >
> > KP Singh (1):
> >   bpf: Allow kfuncs to be used in LSM programs
> >
> > Roberto Sassu (8):
> >   btf: Handle dynamic pointer parameter in kfuncs
> >   bpf: Export bpf_dynptr_get_size()
> >   KEYS: Move KEY_LOOKUP_ to include/linux/key.h
> >   bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
> >   bpf: Add bpf_verify_pkcs7_signature() kfunc
> >   selftests/bpf: Add verifier tests for bpf_lookup_*_key() and
> >     bpf_key_put()
> >   selftests/bpf: Add additional tests for bpf_lookup_*_key()
> >   selftests/bpf: Add test for bpf_verify_pkcs7_signature() kfunc
> >
> >  Documentation/bpf/kfuncs.rst                  |   6 +
> >  include/linux/bpf.h                           |   7 +
> >  include/linux/bpf_verifier.h                  |   3 +
> >  include/linux/btf.h                           |   1 +
> >  include/linux/key.h                           |   3 +
> >  kernel/bpf/btf.c                              |  27 ++
> >  kernel/bpf/helpers.c                          |   2 +-
> >  kernel/bpf/verifier.c                         |   4 +-
> >  kernel/trace/bpf_trace.c                      | 207 +++++++++
> >  security/keys/internal.h                      |   2 -
> >  tools/testing/selftests/bpf/Makefile          |  14 +-
> >  tools/testing/selftests/bpf/config            |   2 +
> >  .../selftests/bpf/prog_tests/lookup_key.c     | 112 +++++
> >  .../bpf/prog_tests/verify_pkcs7_sig.c         | 399 ++++++++++++++++++
> >  .../selftests/bpf/progs/test_lookup_key.c     |  46 ++
> >  .../bpf/progs/test_verify_pkcs7_sig.c         | 100 +++++
> >  tools/testing/selftests/bpf/test_verifier.c   |   3 +-
> >  .../selftests/bpf/verifier/ref_tracking.c     | 139 ++++++
> >  .../testing/selftests/bpf/verify_sig_setup.sh | 104 +++++
> >  19 files changed, 1172 insertions(+), 9 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_key.c
> >  create mode 100644
> tools/testing/selftests/bpf/prog_tests/verify_pkcs7_sig.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_key.c
> >  create mode 100644
> tools/testing/selftests/bpf/progs/test_verify_pkcs7_sig.c
> >  create mode 100755 tools/testing/selftests/bpf/verify_sig_setup.sh
> >
> > --
> > 2.25.1
> 
> BR, Jarkko
