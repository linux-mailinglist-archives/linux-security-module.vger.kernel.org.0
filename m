Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA19764EDB6
	for <lists+linux-security-module@lfdr.de>; Fri, 16 Dec 2022 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLPPTZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 16 Dec 2022 10:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiLPPTX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 16 Dec 2022 10:19:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0622E2B248
        for <linux-security-module@vger.kernel.org>; Fri, 16 Dec 2022 07:19:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id l10so2610166plb.8
        for <linux-security-module@vger.kernel.org>; Fri, 16 Dec 2022 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FD+CYH5O+Fi6d8N2pMh/BghET6L6n2t7fk/CJNPmRE=;
        b=B/R16SmKzy9AGkFvCiICSsnlxiJnRrC3UG5jElLTWF6JdhKxnN7t2wCu5Zi8fc0NRj
         eR4hQYgXJtU+37DmM7RT4zqua0Wo5cIf4v46R/xNc0cn5PdfOVEtSedlujMmhExa9u0s
         m9BD35iaC/VPc4gQEY+ylrEveiuR3N4ylRL1l+2n9GYQsMVmesRAZsENdiKTrktdC68u
         SOeZAzwhJ42goxHQaUCRVdkWKKllyBvmxUQGJsqr4HzC+FsZIz3JW3qMeJqKxulFrn4Z
         RTZVw7LxTYoe+Ezfd9lFunwgsuGgxsxKOC8YTYq5nj8YYqqEGKYqPaqJwABSm+faojeI
         R39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FD+CYH5O+Fi6d8N2pMh/BghET6L6n2t7fk/CJNPmRE=;
        b=XRn8/3t453AROiJk0mCNZmoIPs5ocz8+fedP7owaL9mhc6Hd0S95tFEFj8gZ3XQiyf
         TKGWEeWC2FGJHdPYWvvRltFJUTstSBxLp1kEw/bL49i7I1dRdL3L0aC/WzJSf0p480km
         5L5iIv3p51CJGzV7+UO9IpvS66BEWNZvnbs5A5b1IuOL8hBr2K+Id6YyPz9gM0On2eoB
         6XtHEcVw6GTqzaDjBzFOBa8YjGoDh/eyytx0WB9lKj38oMtHI5/DOPxSnTZQfNLJdqu3
         3crTEXq18QrKUntwbRstMSmus6QJC0gVzJ6k72ZDvwkFBFUlPQQLUhQ0QUsOXlJGMouR
         rCPw==
X-Gm-Message-State: ANoB5pnJngY7jxLOgfLjgft0mXx0r7QSzNS/K2iD+yOcrtNc4XjbSqrN
        JDNm5/Fo4vmHE4vqfvErFzeyiykVdhZS5vxnTW9D4Q==
X-Google-Smtp-Source: AA0mqf60O9yjhMzt5jpOfhR1KKFxE071t58lenyn62AiPJiGJ+wXynIQown51MbpdR0t1W11k0m0Q0qd+PDyjS8E4ds=
X-Received: by 2002:a17:902:ec04:b0:189:894c:6b58 with SMTP id
 l4-20020a170902ec0400b00189894c6b58mr54728647pld.172.1671203960110; Fri, 16
 Dec 2022 07:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20221213185816.3942853-1-jeffxu@chromium.org> <20221213185816.3942853-2-jeffxu@chromium.org>
 <43c925e3-ce72-3ba1-15cf-6fbb34c485f1@digikod.net> <CALmYWFurtUhVqibcPyBXF=pcWRDtDfe3HxMJRGKe29dEAOtVLg@mail.gmail.com>
 <48358983-6224-a1fd-07fa-8ddd81392201@digikod.net>
In-Reply-To: <48358983-6224-a1fd-07fa-8ddd81392201@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 16 Dec 2022 07:18:43 -0800
Message-ID: <CALmYWFtvkXSo0N44=Q2NYpq+w5r=mOD86A+gECnmXDDB8tKOmw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selftests/landlock: skip ptrace_test according to YAMA
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     jeffxu@chromium.org, jorgelo@chromium.org, keescook@chromium.org,
        linux-security-module@vger.kernel.org, groeck@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Fri, Dec 16, 2022 at 2:15 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
>
> On 15/12/2022 21:34, Jeff Xu wrote:
> > Hi Micka=C3=ABl
> > Thanks for reviewing.
> >
> > On Thu, Dec 15, 2022 at 10:34 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
> >>
> >> This is much better! We can tailor a bit more the tests though.
> >>
> >> On 13/12/2022 19:58, jeffxu@chromium.org wrote:
> >>> From: Jeff Xu <jeffxu@google.com>
> >>>
> >>> Add check for yama setting for ptrace_test.
> >>>
> >>> Signed-off-by: Jeff Xu <jeffxu@google.com>
> >>> ---
> >>>    .../testing/selftests/landlock/ptrace_test.c  | 34 +++++++++++++++=
++++
> >>>    1 file changed, 34 insertions(+)
> >>>
> >>> diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/t=
esting/selftests/landlock/ptrace_test.c
> >>> index c28ef98ff3ac..8565a25a9587 100644
> >>> --- a/tools/testing/selftests/landlock/ptrace_test.c
> >>> +++ b/tools/testing/selftests/landlock/ptrace_test.c
> >>> @@ -60,6 +60,24 @@ static int test_ptrace_read(const pid_t pid)
> >>>        return 0;
> >>>    }
> >>>
> >>> +static int get_ptrace_scope(void)
> >>
> >> Please rename to get_yama_ptrace_scope().
> >>
> > Done.
> >
> >>> +{
> >>> +     int ret =3D -1;
> >>> +     char buf[2];
> >>> +     int fd =3D open("/proc/sys/kernel/yama/ptrace_scope", O_RDONLY)=
;
> >>> +
> >>> +     if (fd < 0)
> >>> +             return 0;
> >>> +
> >>> +     if (read(fd, &buf, 1) < 0)
> >>> +             return -1;
> >>> +
> >>> +     buf[1] =3D '\0';
> >>
> >> You can replace that with `char buf[2] =3D {};`
> >>
> > Done.
> > The Compiler seems to be getting a lot smarter :) Thanks.
> >
> >>
> >>> +     ret =3D atoi(buf);
> >>> +     close(fd);
> >>> +     return ret;
> >>> +}
> >>> +
> >>>    /* clang-format off */
> >>>    FIXTURE(hierarchy) {};
> >>>    /* clang-format on */
> >>> @@ -69,6 +87,7 @@ FIXTURE_VARIANT(hierarchy)
> >>>        const bool domain_both;
> >>>        const bool domain_parent;
> >>>        const bool domain_child;
> >>> +     const int  yama_value;
> >>
> >> Please rename to yama_ptrace_scope_max and remove the extra space.
> >>
> > why _max ?  yama_ptrace_scope_current is more proporate ?
> > FYI: This is the current sysctl setting.
>
> In response to your other email, yama_ptrace_scope_max_supported looks
> good too.
>
> >
> >>>    };
> >>>
> >>>    /*
> >>> @@ -93,6 +112,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_without_domai=
n) {
> >>>        .domain_both =3D false,
> >>>        .domain_parent =3D false,
> >>>        .domain_child =3D false,
> >>> +     .yama_value =3D 0,
> >>>    };
> >>>
> >>>    /*
> >>> @@ -110,6 +130,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_one_dom=
ain) {
> >>>        .domain_both =3D false,
> >>>        .domain_parent =3D false,
> >>>        .domain_child =3D true,
> >>> +     .yama_value =3D 1,
> >>>    };
> >>>
> >>>    /*
> >>> @@ -126,6 +147,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_parent_d=
omain) {
> >>>        .domain_both =3D false,
> >>>        .domain_parent =3D true,
> >>>        .domain_child =3D false,
> >>> +     .yama_value =3D 0,
> >>>    };
> >>>
> >>>    /*
> >>> @@ -143,6 +165,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_sibling_=
domain) {
> >>>        .domain_both =3D false,
> >>>        .domain_parent =3D true,
> >>>        .domain_child =3D true,
> >>> +     .yama_value =3D 2,
> >>>    };
> >>>
> >>>    /*
> >>> @@ -160,6 +183,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_sibling_doma=
in) {
> >>>        .domain_both =3D true,
> >>>        .domain_parent =3D false,
> >>>        .domain_child =3D false,
> >>> +     .yama_value =3D 0,
> >>>    };
> >>>
> >>>    /*
> >>> @@ -178,6 +202,7 @@ FIXTURE_VARIANT_ADD(hierarchy, allow_with_nested_=
domain) {
> >>>        .domain_both =3D true,
> >>>        .domain_parent =3D false,
> >>>        .domain_child =3D true,
> >>> +     .yama_value =3D 1,
> >>>    };
> >>>
> >>>    /*
> >>> @@ -196,6 +221,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_nested_a=
nd_parent_domain) {
> >>>        .domain_both =3D true,
> >>>        .domain_parent =3D true,
> >>>        .domain_child =3D false,
> >>> +     .yama_value =3D 0,
> >>>    };
> >>>
> >>>    /*
> >>> @@ -216,6 +242,7 @@ FIXTURE_VARIANT_ADD(hierarchy, deny_with_forked_d=
omain) {
> >>>        .domain_both =3D true,
> >>>        .domain_parent =3D true,
> >>>        .domain_child =3D true,
> >>> +     .yama_value =3D 2,
> >>>    };
> >>>
> >>>    FIXTURE_SETUP(hierarchy)
> >>> @@ -232,9 +259,16 @@ TEST_F(hierarchy, trace)
> >>>        pid_t child, parent;
> >>>        int status, err_proc_read;
> >>>        int pipe_child[2], pipe_parent[2];
> >>> +     int yama;
> >>
> >> Please rename to yama_ptrace_scope.
> >>
> > Done.
> >
> >
> >>
> >>>        char buf_parent;
> >>>        long ret;
> >>>
> >>> +     yama =3D get_ptrace_scope();
> >>> +     ASSERT_LE(0, yama);
> >>> +
> >>> +     if (variant->yama_value < yama)
> >>
> >> if (yama_ptrace_scope >=3D 3)
> >>
> >>> +             SKIP(return, "unsupported yama value %d", yama);
> >>
> >> "Yama forbids any ptrace use (scope 3)"
> >>
> >>
> > why comparing with  3?  the test will  skip particular hierarchy,
> > according to current
> > sysctl yama_ptrace setting.
>
> The idea is to run the tests as much as possible, but in the case of a
> scope of 3, any ptrace is denied. However, it would indeed be better to
> integrate this third value in the following `if (variant->domain_*`
> checks, like for the other scopes.
>
>
> >
> > For example: when kernel.yama.ptrace_scope =3D 1 the result will be lik=
e:
> > localhost /usr/local/bin # ./ptrace_test
> > TAP version 13
> > 1..8
> > # Starting 8 tests from 9 test cases.
> > #  RUN           hierarchy.allow_without_domain.trace ...
> > #      SKIP      unsupported yama value 1
> > #            OK  hierarchy.allow_without_domain.trace
> > ok 1 # SKIP unsupported yama value 1
> > #  RUN           hierarchy.allow_with_one_domain.trace ...
> > #            OK  hierarchy.allow_with_one_domain.trace
> > ok 2 hierarchy.allow_with_one_domain.trace
> > #  RUN           hierarchy.deny_with_parent_domain.trace ...
> > #      SKIP      unsupported yama value 1
> > #            OK  hierarchy.deny_with_parent_domain.trace
> > ok 3 # SKIP unsupported yama value 1
> > #  RUN           hierarchy.deny_with_sibling_domain.trace ...
> > #            OK  hierarchy.deny_with_sibling_domain.trace
> > ok 4 hierarchy.deny_with_sibling_domain.trace
> > #  RUN           hierarchy.allow_sibling_domain.trace ...
> > #      SKIP      unsupported yama value 1
> > #            OK  hierarchy.allow_sibling_domain.trace
> > ok 5 # SKIP unsupported yama value 1
> > #  RUN           hierarchy.allow_with_nested_domain.trace ...
> > #            OK  hierarchy.allow_with_nested_domain.trace
> > ok 6 hierarchy.allow_with_nested_domain.trace
> > #  RUN           hierarchy.deny_with_nested_and_parent_domain.trace ...
> > #      SKIP      unsupported yama value 1
> > #            OK  hierarchy.deny_with_nested_and_parent_domain.trace
> > ok 7 # SKIP unsupported yama value 1
> > #  RUN           hierarchy.deny_with_forked_domain.trace ...
> > #            OK  hierarchy.deny_with_forked_domain.trace
> > ok 8 hierarchy.deny_with_forked_domain.trace
> > # PASSED: 8 / 8 tests passed.
> > # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:4 error:0
> >
> > when yama.ptrace_scope is 2:
> > localhost /usr/local/bin # sysctl kernel.yama.ptrace_scope=3D2
> > kernel.yama.ptrace_scope =3D 2
> > localhost /usr/local/bin # ./ptrace_test
> > TAP version 13
> > 1..8
> > # Starting 8 tests from 9 test cases.
> > #  RUN           hierarchy.allow_without_domain.trace ...
> > #      SKIP      unsupported yama value 2
> > #            OK  hierarchy.allow_without_domain.trace
> > ok 1 # SKIP unsupported yama value 2
> > #  RUN           hierarchy.allow_with_one_domain.trace ...
> > #      SKIP      unsupported yama value 2
> > #            OK  hierarchy.allow_with_one_domain.trace
> > ok 2 # SKIP unsupported yama value 2
> > #  RUN           hierarchy.deny_with_parent_domain.trace ...
> > #      SKIP      unsupported yama value 2
> > #            OK  hierarchy.deny_with_parent_domain.trace
> > ok 3 # SKIP unsupported yama value 2
> > #  RUN           hierarchy.deny_with_sibling_domain.trace ...
> > #            OK  hierarchy.deny_with_sibling_domain.trace
> > ok 4 hierarchy.deny_with_sibling_domain.trace
> > #  RUN           hierarchy.allow_sibling_domain.trace ...
> > #      SKIP      unsupported yama value 2
> > #            OK  hierarchy.allow_sibling_domain.trace
> > ok 5 # SKIP unsupported yama value 2
> > #  RUN           hierarchy.allow_with_nested_domain.trace ...
> > #      SKIP      unsupported yama value 2
> > #            OK  hierarchy.allow_with_nested_domain.trace
> > ok 6 # SKIP unsupported yama value 2
> > #  RUN           hierarchy.deny_with_nested_and_parent_domain.trace ...
> > #      SKIP      unsupported yama value 2
> > #            OK  hierarchy.deny_with_nested_and_parent_domain.trace
> > ok 7 # SKIP unsupported yama value 2
> > #  RUN           hierarchy.deny_with_forked_domain.trace ...
> > #            OK  hierarchy.deny_with_forked_domain.trace
> > ok 8 hierarchy.deny_with_forked_domain.trace
> > # PASSED: 8 / 8 tests passed.
> > # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:6 error:0
> >
> >> This check skips the whole test, whereas the issues with Yama are abou=
t:
> >> - a child process tracing its parent;
> >> - the PTRACE_TRACEME case.
> >>
> >> I think the main remaining parts to change is the `if
> >> (variant->domain_*` checks to extend with the yama_ptrace_scope_max ch=
eck.
> >>
> >> However, it is useful to highlight that a test didn't fully cover
> >> Landlock checks. I think the best approach is to call SKIP() at the en=
d
> >> of TEST_F(hierarchy, trace) if yama_ptrace_scope >=3D 1 . This way, we
> >> test as much as possible (Landlock and Yama) and we mark the "tampered=
"
> >> tests as skipped.
> >>
> > I believe the test case should not have a lot of branches and logic
> > (if/else), which makes
> > the test case more complex and harder to read.  By that reason, SKIP()
> > is better at beginning
> > of the testcase.
>
> I agree in a general case, but here all the branches already exist to
> test all possible Landlock combinations. Adding Yama's ptrace scope will
> only update the existing branch conditions.
>
>
> >
> > Another reason is resource cleanup.  When SKIP() is not at the
> > beginning of tests,
> > the cleanup logic can get much more complicated because there are more
> > combinations of resource cleanup to
> > to be dealt with, after SKIP().
>
> All the logic for resource cleanup is already in place.
>
> >
> > Therefore I do not believe in "tests as much as possible" in a single
> > test, I would rather have a
> > dedicated test for the situation.
>
> The current test code already covers all possible combinations, so it is
> just a matter of extending the branch conditions. You can update these
> checks using dedicated booleans:
> - can_trace_child =3D !variant->domain_parent && (yama_ptrace_scope < 2);
> - can_trace_parent =3D !variant->domain_child && (yama_ptrace_scope < 1);
>
> =E2=80=A6and at the end of all the hierarchy.trace tests add:
> if (yama_ptrace_scope > 0)
>         SKIP(return, "Incomplete tests due to Yama restrictions (ptrace_s=
cope:
> %d)", yama_ptrace_scope);

OKey, I will update and send a new one.

Thanks
Jeff
