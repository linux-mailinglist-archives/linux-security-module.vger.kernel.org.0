Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2731738F30
	for <lists+linux-security-module@lfdr.de>; Fri,  7 Jun 2019 17:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfFGPfp (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 7 Jun 2019 11:35:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40374 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbfFGPfp (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 7 Jun 2019 11:35:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so971761pla.7
        for <linux-security-module@vger.kernel.org>; Fri, 07 Jun 2019 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rMn+KK/+/vKIITpmVYk3t/A5lzW1s3V3VN8uxsCf9bI=;
        b=Qr2bXb/rPbjHR5W24GxZg0GFCgx/nV17NNjk335upAGobJW/NPtxnYjlQ7o8FcSmT7
         cj6/uqPsjn93KfrpGj9wOuAIfl+KRKxQbT+xW39oxM/HP+LOHlBDaTzJUPo8Z3B55G/K
         Od0bSrpc40XNpkJXQh0Z7BbRG2t4kZKR8kPU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rMn+KK/+/vKIITpmVYk3t/A5lzW1s3V3VN8uxsCf9bI=;
        b=JKxOAnvhdyNeZ2H0TGfoTo+2rT8xx6fnn2xOL8/gybrxObxtovJsIGWrha02ATqqvb
         fFXJzHdPwKemZus2U6ASxZJm8MU3Szl7ehbaRpsABnukiuhTzxRhxAhv+ucOOyklAwCl
         Crnl+J20X2s0fz74df6NcpNZVWGY8+5dVwJTe7Xaqp6JQY9q7wvbsSYADq00+1DTgp1G
         WL8t/wMF/WFzMHFxm326G5izMS3XfyUWAFu80kob4pulsQTf5VnpGbbuwb6rP3Q7wedv
         F41tmoSIRzEWVHZVl+SBaIR5sNNwbEkqpnh4T2y0cgEe6JrfnkmAgsygsl6VR1nGGs2h
         1Gag==
X-Gm-Message-State: APjAAAUheP3ztUTwldfCeR3JwF9QCVOzcOtqoM+sD68IAwol25E7WglU
        +d7XWiBQQlQGK50V/QeZsHcdSQ==
X-Google-Smtp-Source: APXvYqw054aTQzsZjBDfzH78jJKXgD1KGE6ib+0E0JaSGrok7MZROstpxgyRZFQTk9BJ6WThQ2BcjQ==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr19850750plm.96.1559921744201;
        Fri, 07 Jun 2019 08:35:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm7340333pjb.26.2019.06.07.08.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 08:35:43 -0700 (PDT)
Date:   Fri, 7 Jun 2019 08:35:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v6 3/3] lib: introduce test_meminit module
Message-ID: <201906070835.EA9D8C100@keescook>
References: <20190606164845.179427-1-glider@google.com>
 <20190606164845.179427-4-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606164845.179427-4-glider@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Thu, Jun 06, 2019 at 06:48:45PM +0200, Alexander Potapenko wrote:
> Add tests for heap and pagealloc initialization.
> These can be used to check init_on_alloc and init_on_free implementations
> as well as other approaches to initialization.
> 
> Expected test output in the case the kernel provides heap initialization
> (e.g. when running with either init_on_alloc=1 or init_on_free=1):
> 
>   test_meminit: all 10 tests in test_pages passed
>   test_meminit: all 40 tests in test_kvmalloc passed
>   test_meminit: all 60 tests in test_kmemcache passed
>   test_meminit: all 10 tests in test_rcu_persistent passed
>   test_meminit: all 120 tests passed!
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> To: Kees Cook <keescook@chromium.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Christoph Lameter <cl@linux.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Kostya Serebryany <kcc@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Sandeep Patil <sspatil@android.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-security-module@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> ---
>  v3:
>   - added example test output to the description
>   - fixed a missing include spotted by kbuild test robot <lkp@intel.com>
>   - added a missing MODULE_LICENSE
>   - call do_kmem_cache_size() with size >= sizeof(void*) to unbreak
>   debug builds
>  v5:
>   - added tests for RCU slabs and __GFP_ZERO
> ---
>  lib/Kconfig.debug  |   8 +
>  lib/Makefile       |   1 +
>  lib/test_meminit.c | 362 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 371 insertions(+)
>  create mode 100644 lib/test_meminit.c
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index cbdfae379896..085711f14abf 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2040,6 +2040,14 @@ config TEST_STACKINIT
>  
>  	  If unsure, say N.
>  
> +config TEST_MEMINIT
> +	tristate "Test heap/page initialization"
> +	help
> +	  Test if the kernel is zero-initializing heap and page allocations.
> +	  This can be useful to test init_on_alloc and init_on_free features.
> +
> +	  If unsure, say N.
> +
>  endif # RUNTIME_TESTING_MENU
>  
>  config MEMTEST
> diff --git a/lib/Makefile b/lib/Makefile
> index fb7697031a79..05980c802500 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -91,6 +91,7 @@ obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
>  obj-$(CONFIG_TEST_MEMCAT_P) += test_memcat_p.o
>  obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
>  obj-$(CONFIG_TEST_STACKINIT) += test_stackinit.o
> +obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
>  
>  obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
>  
> diff --git a/lib/test_meminit.c b/lib/test_meminit.c
> new file mode 100644
> index 000000000000..ed7efec1387b
> --- /dev/null
> +++ b/lib/test_meminit.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test cases for SL[AOU]B/page initialization at alloc/free time.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/vmalloc.h>
> +
> +#define GARBAGE_INT (0x09A7BA9E)
> +#define GARBAGE_BYTE (0x9E)
> +
> +#define REPORT_FAILURES_IN_FN() \
> +	do {	\
> +		if (failures)	\
> +			pr_info("%s failed %d out of %d times\n",	\
> +				__func__, failures, num_tests);		\
> +		else		\
> +			pr_info("all %d tests in %s passed\n",		\
> +				num_tests, __func__);			\
> +	} while (0)
> +
> +/* Calculate the number of uninitialized bytes in the buffer. */
> +static int __init count_nonzero_bytes(void *ptr, size_t size)
> +{
> +	int i, ret = 0;
> +	unsigned char *p = (unsigned char *)ptr;
> +
> +	for (i = 0; i < size; i++)
> +		if (p[i])
> +			ret++;
> +	return ret;
> +}
> +
> +/* Fill a buffer with garbage, skipping |skip| first bytes. */
> +static void __init fill_with_garbage_skip(void *ptr, size_t size, size_t skip)
> +{
> +	unsigned int *p = (unsigned int *)ptr;
> +	int i = 0;
> +
> +	if (skip) {
> +		WARN_ON(skip > size);
> +		p += skip;
> +	}
> +	while (size >= sizeof(*p)) {
> +		p[i] = GARBAGE_INT;
> +		i++;
> +		size -= sizeof(*p);
> +	}
> +	if (size)
> +		memset(&p[i], GARBAGE_BYTE, size);
> +}
> +
> +static void __init fill_with_garbage(void *ptr, size_t size)
> +{
> +	fill_with_garbage_skip(ptr, size, 0);
> +}
> +
> +static int __init do_alloc_pages_order(int order, int *total_failures)
> +{
> +	struct page *page;
> +	void *buf;
> +	size_t size = PAGE_SIZE << order;
> +
> +	page = alloc_pages(GFP_KERNEL, order);
> +	buf = page_address(page);
> +	fill_with_garbage(buf, size);
> +	__free_pages(page, order);
> +
> +	page = alloc_pages(GFP_KERNEL, order);
> +	buf = page_address(page);
> +	if (count_nonzero_bytes(buf, size))
> +		(*total_failures)++;
> +	fill_with_garbage(buf, size);
> +	__free_pages(page, order);
> +	return 1;
> +}
> +
> +/* Test the page allocator by calling alloc_pages with different orders. */
> +static int __init test_pages(int *total_failures)
> +{
> +	int failures = 0, num_tests = 0;
> +	int i;
> +
> +	for (i = 0; i < 10; i++)
> +		num_tests += do_alloc_pages_order(i, &failures);
> +
> +	REPORT_FAILURES_IN_FN();
> +	*total_failures += failures;
> +	return num_tests;
> +}
> +
> +/* Test kmalloc() with given parameters. */
> +static int __init do_kmalloc_size(size_t size, int *total_failures)
> +{
> +	void *buf;
> +
> +	buf = kmalloc(size, GFP_KERNEL);
> +	fill_with_garbage(buf, size);
> +	kfree(buf);
> +
> +	buf = kmalloc(size, GFP_KERNEL);
> +	if (count_nonzero_bytes(buf, size))
> +		(*total_failures)++;
> +	fill_with_garbage(buf, size);
> +	kfree(buf);
> +	return 1;
> +}
> +
> +/* Test vmalloc() with given parameters. */
> +static int __init do_vmalloc_size(size_t size, int *total_failures)
> +{
> +	void *buf;
> +
> +	buf = vmalloc(size);
> +	fill_with_garbage(buf, size);
> +	vfree(buf);
> +
> +	buf = vmalloc(size);
> +	if (count_nonzero_bytes(buf, size))
> +		(*total_failures)++;
> +	fill_with_garbage(buf, size);
> +	vfree(buf);
> +	return 1;
> +}
> +
> +/* Test kmalloc()/vmalloc() by allocating objects of different sizes. */
> +static int __init test_kvmalloc(int *total_failures)
> +{
> +	int failures = 0, num_tests = 0;
> +	int i, size;
> +
> +	for (i = 0; i < 20; i++) {
> +		size = 1 << i;
> +		num_tests += do_kmalloc_size(size, &failures);
> +		num_tests += do_vmalloc_size(size, &failures);
> +	}
> +
> +	REPORT_FAILURES_IN_FN();
> +	*total_failures += failures;
> +	return num_tests;
> +}
> +
> +#define CTOR_BYTES (sizeof(unsigned int))
> +#define CTOR_PATTERN (0x41414141)
> +/* Initialize the first 4 bytes of the object. */
> +static void test_ctor(void *obj)
> +{
> +	*(unsigned int *)obj = CTOR_PATTERN;
> +}
> +
> +/*
> + * Check the invariants for the buffer allocated from a slab cache.
> + * If the cache has a test constructor, the first 4 bytes of the object must
> + * always remain equal to CTOR_PATTERN.
> + * If the cache isn't an RCU-typesafe one, or if the allocation is done with
> + * __GFP_ZERO, then the object contents must be zeroed after allocation.
> + * If the cache is an RCU-typesafe one, the object contents must never be
> + * zeroed after the first use. This is checked by memcmp() in
> + * do_kmem_cache_size().
> + */
> +static bool __init check_buf(void *buf, int size, bool want_ctor,
> +			     bool want_rcu, bool want_zero)
> +{
> +	int bytes;
> +	bool fail = false;
> +
> +	bytes = count_nonzero_bytes(buf, size);
> +	WARN_ON(want_ctor && want_zero);
> +	if (want_zero)
> +		return bytes;
> +	if (want_ctor) {
> +		if (*(unsigned int *)buf != CTOR_PATTERN)
> +			fail = 1;
> +	} else {
> +		if (bytes)
> +			fail = !want_rcu;
> +	}
> +	return fail;
> +}
> +
> +/*
> + * Test kmem_cache with given parameters:
> + *  want_ctor - use a constructor;
> + *  want_rcu - use SLAB_TYPESAFE_BY_RCU;
> + *  want_zero - use __GFP_ZERO.
> + */
> +static int __init do_kmem_cache_size(size_t size, bool want_ctor,
> +				     bool want_rcu, bool want_zero,
> +				     int *total_failures)
> +{
> +	struct kmem_cache *c;
> +	int iter;
> +	bool fail = false;
> +	gfp_t alloc_mask = GFP_KERNEL | (want_zero ? __GFP_ZERO : 0);
> +	void *buf, *buf_copy;
> +
> +	c = kmem_cache_create("test_cache", size, 1,
> +			      want_rcu ? SLAB_TYPESAFE_BY_RCU : 0,
> +			      want_ctor ? test_ctor : NULL);
> +	for (iter = 0; iter < 10; iter++) {
> +		buf = kmem_cache_alloc(c, alloc_mask);
> +		/* Check that buf is zeroed, if it must be. */
> +		fail = check_buf(buf, size, want_ctor, want_rcu, want_zero);
> +		fill_with_garbage_skip(buf, size, want_ctor ? CTOR_BYTES : 0);
> +		/*
> +		 * If this is an RCU cache, use a critical section to ensure we
> +		 * can touch objects after they're freed.
> +		 */
> +		if (want_rcu) {
> +			rcu_read_lock();
> +			/*
> +			 * Copy the buffer to check that it's not wiped on
> +			 * free().
> +			 */
> +			buf_copy = kmalloc(size, GFP_KERNEL);
> +			if (buf_copy)
> +				memcpy(buf_copy, buf, size);
> +		}
> +		kmem_cache_free(c, buf);
> +		if (want_rcu) {
> +			/*
> +			 * Check that |buf| is intact after kmem_cache_free().
> +			 * |want_zero| is false, because we wrote garbage to
> +			 * the buffer already.
> +			 */
> +			fail |= check_buf(buf, size, want_ctor, want_rcu,
> +					  false);
> +			if (buf_copy) {
> +				fail |= (bool)memcmp(buf, buf_copy, size);
> +				kfree(buf_copy);
> +			}
> +			rcu_read_unlock();
> +		}
> +	}
> +	kmem_cache_destroy(c);
> +
> +	*total_failures += fail;
> +	return 1;
> +}
> +
> +/*
> + * Check that the data written to an RCU-allocated object survives
> + * reallocation.
> + */
> +static int __init do_kmem_cache_rcu_persistent(int size, int *total_failures)
> +{
> +	struct kmem_cache *c;
> +	void *buf, *buf_contents, *saved_ptr;
> +	void **used_objects;
> +	int i, iter, maxiter = 1024;
> +	bool fail = false;
> +
> +	c = kmem_cache_create("test_cache", size, size, SLAB_TYPESAFE_BY_RCU,
> +			      NULL);
> +	buf = kmem_cache_alloc(c, GFP_KERNEL);
> +	saved_ptr = buf;
> +	fill_with_garbage(buf, size);
> +	buf_contents = kmalloc(size, GFP_KERNEL);
> +	if (!buf_contents)
> +		goto out;
> +	used_objects = kmalloc_array(maxiter, sizeof(void *), GFP_KERNEL);
> +	if (!used_objects) {
> +		kfree(buf_contents);
> +		goto out;
> +	}
> +	memcpy(buf_contents, buf, size);
> +	kmem_cache_free(c, buf);
> +	/*
> +	 * Run for a fixed number of iterations. If we never hit saved_ptr,
> +	 * assume the test passes.
> +	 */
> +	for (iter = 0; iter < maxiter; iter++) {
> +		buf = kmem_cache_alloc(c, GFP_KERNEL);
> +		used_objects[iter] = buf;
> +		if (buf == saved_ptr) {
> +			fail = memcmp(buf_contents, buf, size);
> +			for (i = 0; i <= iter; i++)
> +				kmem_cache_free(c, used_objects[i]);
> +			goto free_out;
> +		}
> +	}
> +
> +free_out:
> +	kmem_cache_destroy(c);
> +	kfree(buf_contents);
> +	kfree(used_objects);
> +out:
> +	*total_failures += fail;
> +	return 1;
> +}
> +
> +/*
> + * Test kmem_cache allocation by creating caches of different sizes, with and
> + * without constructors, with and without SLAB_TYPESAFE_BY_RCU.
> + */
> +static int __init test_kmemcache(int *total_failures)
> +{
> +	int failures = 0, num_tests = 0;
> +	int i, flags, size;
> +	bool ctor, rcu, zero;
> +
> +	for (i = 0; i < 10; i++) {
> +		size = 8 << i;
> +		for (flags = 0; flags < 8; flags++) {
> +			ctor = flags & 1;
> +			rcu = flags & 2;
> +			zero = flags & 4;
> +			if (ctor & zero)
> +				continue;
> +			num_tests += do_kmem_cache_size(size, ctor, rcu, zero,
> +							&failures);
> +		}
> +	}
> +	REPORT_FAILURES_IN_FN();
> +	*total_failures += failures;
> +	return num_tests;
> +}
> +
> +/* Test the behavior of SLAB_TYPESAFE_BY_RCU caches of different sizes. */
> +static int __init test_rcu_persistent(int *total_failures)
> +{
> +	int failures = 0, num_tests = 0;
> +	int i, size;
> +
> +	for (i = 0; i < 10; i++) {
> +		size = 8 << i;
> +		num_tests += do_kmem_cache_rcu_persistent(size, &failures);
> +	}
> +	REPORT_FAILURES_IN_FN();
> +	*total_failures += failures;
> +	return num_tests;
> +}
> +
> +/*
> + * Run the tests. Each test function returns the number of executed tests and
> + * updates |failures| with the number of failed tests.
> + */
> +static int __init test_meminit_init(void)
> +{
> +	int failures = 0, num_tests = 0;
> +
> +	num_tests += test_pages(&failures);
> +	num_tests += test_kvmalloc(&failures);
> +	num_tests += test_kmemcache(&failures);
> +	num_tests += test_rcu_persistent(&failures);
> +
> +	if (failures == 0)
> +		pr_info("all %d tests passed!\n", num_tests);
> +	else
> +		pr_info("failures: %d out of %d\n", failures, num_tests);
> +
> +	return failures ? -EINVAL : 0;
> +}
> +module_init(test_meminit_init);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.22.0.rc1.311.g5d7573a151-goog
> 

-- 
Kees Cook
