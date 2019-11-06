Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C10DF1C43
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Nov 2019 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbfKFRSb (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 6 Nov 2019 12:18:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41265 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbfKFRSa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Nov 2019 12:18:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id l3so17571208pgr.8
        for <linux-security-module@vger.kernel.org>; Wed, 06 Nov 2019 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kqep8XBz+ob9m9HgLeaELks6sa5oaorHLu84jPUpdI0=;
        b=Tfm+AIKzVLe4DKvn7S7UE7TTNFzSpLQpGOJ0dbBICYYiDkzHHhPep0L3G96Vp0HLkn
         3iFEtU69J8jfFGl/vrroJ5cmlLPPZ/jEFJYPh5Iiuzsg9xZmv+vWYtIEUnvnADfAz+O0
         6EHPI8OypMmHrVeVHx6LKUwBIdRVeHrA8kypc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kqep8XBz+ob9m9HgLeaELks6sa5oaorHLu84jPUpdI0=;
        b=poHJ+JcNqv/rzttDcz4d0oz6jeozClhxLwrVKm/McZmbssUj7Btk0npyQ0i1ohnRjk
         M5zplMB4MghUsrZQX4zW/b0IbWG5/S5uc4CIqgAPOAz1jfwyhTKe8/q8ulG1mJgyPJoZ
         /tlicfY+uIfmcBIr4dh5BQvvl9Eq7YT5r07SsVFBhD5bM+sf2wZA3LsIwc+fVeEYXX8m
         8TrqT9jpMO9vHWZbcDUAPNWVhgiUdeIRjgGSz83XwpE+mV7mmBjJxIxzD9ZKVbh76fwb
         mkMK8e/payNqwxaJ0kxDk2wZhahDK6rKsbIVOthwnzsLFsixqvimdVXxLfxVt6F1xFk2
         d7+Q==
X-Gm-Message-State: APjAAAW14yFOUJ+6QVeE/4x8mtnWqUy8nYONBEjqCNsfBNua3bTH8hkW
        u8lI10x6zRXeYk3zhjU8Zh7+3g==
X-Google-Smtp-Source: APXvYqyZHHZJMCCOAUO2Q7fAPKf5j8qTcabKvqS3xUm4Nyrs58kWQPudNMOakH9O8x+5MrgTLl1e+w==
X-Received: by 2002:a63:d452:: with SMTP id i18mr4222869pgj.76.1573060709773;
        Wed, 06 Nov 2019 09:18:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s5sm3084844pjn.24.2019.11.06.09.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 09:18:28 -0800 (PST)
Date:   Wed, 6 Nov 2019 09:18:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, john.johansen@canonical.com, jmorris@namei.org,
        serge@hallyn.com, alan.maguire@oracle.com, yzaikin@google.com,
        davidgow@google.com, mcgrof@kernel.org, tytso@mit.edu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v2] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <201911060916.AC9E14B@keescook>
References: <20191106004329.16991-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106004329.16991-1-brendanhiggins@google.com>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Nov 05, 2019 at 04:43:29PM -0800, Brendan Higgins wrote:
> From: Mike Salvatore <mike.salvatore@canonical.com>
> 
> Add KUnit tests to test AppArmor unpacking of userspace policies.
> AppArmor uses a serialized binary format for loading policies. To find
> policy format documentation see
> Documentation/admin-guide/LSM/apparmor.rst.
> 
> In order to write the tests against the policy unpacking code, some
> static functions needed to be exposed for testing purposes. One of the
> goals of this patch is to establish a pattern for which testing these
> kinds of functions should be done in the future.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Mike Salvatore <mike.salvatore@canonical.com>
> ---
>  security/apparmor/Kconfig              |  16 +
>  security/apparmor/policy_unpack.c      |   4 +
>  security/apparmor/policy_unpack_test.c | 607 +++++++++++++++++++++++++
>  3 files changed, 627 insertions(+)
>  create mode 100644 security/apparmor/policy_unpack_test.c
> 
> diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
> index d8b1a360a6368..78a33ccac2574 100644
> --- a/security/apparmor/Kconfig
> +++ b/security/apparmor/Kconfig
> @@ -66,3 +66,19 @@ config SECURITY_APPARMOR_DEBUG_MESSAGES
>  	  Set the default value of the apparmor.debug kernel parameter.
>  	  When enabled, various debug messages will be logged to
>  	  the kernel message buffer.
> +
> +config SECURITY_APPARMOR_KUNIT_TEST
> +	bool "Build KUnit tests for policy_unpack.c"
> +	depends on KUNIT && SECURITY_APPARMOR
> +	help
> +	  This builds the AppArmor KUnit tests.
> +
> +	  KUnit tests run during boot and output the results to the debug log
> +	  in TAP format (http://testanything.org/). Only useful for kernel devs
> +	  running KUnit test harness and are not for inclusion into a
> +	  production build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
> index 8cfc9493eefc7..37c1dd3178fc0 100644
> --- a/security/apparmor/policy_unpack.c
> +++ b/security/apparmor/policy_unpack.c
> @@ -1120,3 +1120,7 @@ int aa_unpack(struct aa_loaddata *udata, struct list_head *lh,
>  
>  	return error;
>  }
> +
> +#ifdef CONFIG_SECURITY_APPARMOR_KUNIT_TEST
> +#include "policy_unpack_test.c"
> +#endif /* CONFIG_SECURITY_APPARMOR_KUNIT_TEST */

To make this even LESS intrusive, the ifdefs could live in ..._test.c.

Also, while I *think* the kernel build system will correctly track this
dependency, can you double-check that changes to ..._test.c correctly
trigger a recompile of policy_unpack.c?

-- 
Kees Cook
