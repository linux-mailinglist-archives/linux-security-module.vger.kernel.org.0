Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456F172877C
	for <lists+linux-security-module@lfdr.de>; Thu,  8 Jun 2023 20:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjFHStP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Thu, 8 Jun 2023 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjFHStO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 8 Jun 2023 14:49:14 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69A02680
        for <linux-security-module@vger.kernel.org>; Thu,  8 Jun 2023 11:49:12 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-66227292952so839721b3a.3
        for <linux-security-module@vger.kernel.org>; Thu, 08 Jun 2023 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686250152; x=1688842152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9X4Uo12NdQ70wxKCdJzisAzz7VwIv0m81ldSTLtM2/E=;
        b=NkACu8QFig+zxCzj271zQ3eHgxDC9p1G7b8NrAhi4OCRVfWq/nBnnzonvgtz9J1/aF
         j4gjbgMZ0CjCPrWNXVX3zu3+WTuamp8Boc+QJR0NsjMD5WrA6jdfhgiG86sSyyH7I9RD
         LBXgzBcZjWrZEUpA/m78S0tMqYRgwgf3+d1tvf8UdwwbtGzoN1xoGs7/OF6ztKdyM29b
         N1bqfMfRBVzEc17aszPi4X4uGMHLVUxl8xrfZBLpQX0lENG0EcfsoBBOkjuISKiTr7dX
         os5DsHLJvyCgR7qp2a0EwPw9CPjAqoxkCvIErmGbAKGgvcdPOXUwBXgPrVaRlho3s5vD
         V5zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686250152; x=1688842152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9X4Uo12NdQ70wxKCdJzisAzz7VwIv0m81ldSTLtM2/E=;
        b=fGr/bSOdkUR6JbVIvs///KNXilCO+mt3LyWhclJbcKRJG7eZ8qziKROnmNHoxLlShU
         LpoJO+1RUZoVXAVC5U/vLxQndZqGpK5RibqVt50AloYlgGdzWJZ/LHOfBUKaSfBQXSvP
         OGGgLHm+L5FV6zUjmTV6TyGAMcaKeoR4tppVIX8hJlnBwWKnD4YyBQTlKG3bimSLQQcM
         AkdpMtH/TxKI9H9kxjWImDZqOhE6S1AbKKt23Gh0Fb85375t7+wQZGHSrwfGKU3sduhp
         G87If5RKQAwM8qcMgeoJrW2V0TdI9uT8S1iuyy0ykxGPKkNFpiG3bmhqQGUVBElaVAG9
         Tx5w==
X-Gm-Message-State: AC+VfDyWp3ZkMbxck3UViCLU0Jp6kNhTUQCQ4jFkqxftY0L5qFLG9e4A
        ycT+m2/8IMbryV+4UsVz2Hp+qgQ=
X-Google-Smtp-Source: ACHHUZ75keCeBlMTJ91lhRgvKzQFDPC6fBtVhljj+OEQpEOG5Ecze4/kAj8F+9yxnfyuYQZ9rR6wYaw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:13a6:b0:657:f26e:b025 with SMTP id
 t38-20020a056a0013a600b00657f26eb025mr4000650pfg.6.1686250152318; Thu, 08 Jun
 2023 11:49:12 -0700 (PDT)
Date:   Thu, 8 Jun 2023 11:49:11 -0700
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
Mime-Version: 1.0
References: <20230607235352.1723243-1-andrii@kernel.org>
Message-ID: <ZIIipx1NhKYQq7T/@google.com>
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
From:   Stanislav Fomichev <sdf@google.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        keescook@chromium.org, brauner@kernel.org, lennart@poettering.net,
        cyphar@cyphar.com, luto@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 06/07, Andrii Nakryiko wrote:
> This patch set introduces new BPF object, BPF token, which allows to delegate
> a subset of BPF functionality from privileged system-wide daemon (e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about allowing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application that
> would create a BPF token.
> 
> The main motivation for BPF token is a desire to enable containerized
> BPF applications to be used together with user namespaces. This is currently
> impossible, as CAP_BPF, required for BPF subsystem usage, cannot be namespaced
> or sandboxed, as a general rule. E.g., tracing BPF programs, thanks to BPF
> helpers like bpf_probe_read_kernel() and bpf_probe_read_user() can safely read
> arbitrary memory, and it's impossible to ensure that they only read memory of
> processes belonging to any given namespace. This means that it's impossible to
> have namespace-aware CAP_BPF capability, and as such another mechanism to
> allow safe usage of BPF functionality is necessary. BPF token and delegation
> of it to a trusted unprivileged applications is such mechanism. Kernel makes
> no assumption about what "trusted" constitutes in any particular case, and
> it's up to specific privileged applications and their surrounding
> infrastructure to decide that. What kernel provides is a set of APIs to create
> and tune BPF token, and pass it around to privileged BPF commands that are
> creating new BPF objects like BPF programs, BPF maps, etc.
> 
> Previous attempt at addressing this very same problem ([0]) attempted to
> utilize authoritative LSM approach, but was conclusively rejected by upstream
> LSM maintainers. BPF token concept is not changing anything about LSM
> approach, but can be combined with LSM hooks for very fine-grained security
> policy. Some ideas about making BPF token more convenient to use with LSM (in
> particular custom BPF LSM programs) was briefly described in recent LSF/MM/BPF
> 2023 presentation ([1]). E.g., an ability to specify user-provided data
> (context), which in combination with BPF LSM would allow implementing a very
> dynamic and fine-granular custom security policies on top of BPF token. In the
> interest of minimizing API surface area discussions this is going to be
> added in follow up patches, as it's not essential to the fundamental concept
> of delegatable BPF token.
> 
> It should be noted that BPF token is conceptually quite similar to the idea of
> /dev/bpf device file, proposed by Song a while ago ([2]). The biggest
> difference is the idea of using virtual anon_inode file to hold BPF token and
> allowing multiple independent instances of them, each with its own set of
> restrictions. BPF pinning solves the problem of exposing such BPF token
> through file system (BPF FS, in this case) for cases where transferring FDs
> over Unix domain sockets is not convenient. And also, crucially, BPF token
> approach is not using any special stateful task-scoped flags. Instead, bpf()
> syscall accepts token_fd parameters explicitly for each relevant BPF command.
> This addresses main concerns brought up during the /dev/bpf discussion, and
> fits better with overall BPF subsystem design.
> 
> This patch set adds a basic minimum of functionality to make BPF token useful
> and to discuss API and functionality. Currently only low-level libbpf APIs
> support passing BPF token around, allowing to test kernel functionality, but
> for the most part is not sufficient for real-world applications, which
> typically use high-level libbpf APIs based on `struct bpf_object` type. This
> was done with the intent to limit the size of patch set and concentrate on
> mostly kernel-side changes. All the necessary plumbing for libbpf will be sent
> as a separate follow up patch set kernel support makes it upstream.
> 
> Another part that should happen once kernel-side BPF token is established, is
> a set of conventions between applications (e.g., systemd), tools (e.g.,
> bpftool), and libraries (e.g., libbpf) about sharing BPF tokens through BPF FS
> at well-defined locations to allow applications take advantage of this in
> automatic fashion without explicit code changes on BPF application's side.
> But I'd like to postpone this discussion to after BPF token concept lands.
> 
>   [0] https://lore.kernel.org/bpf/20230412043300.360803-1-andrii@kernel.org/
>   [1] http://vger.kernel.org/bpfconf2023_material/Trusted_unprivileged_BPF_LSFMM2023.pdf
>   [2] https://lore.kernel.org/bpf/20190627201923.2589391-2-songliubraving@fb.com/
> 
> v1->v2:
>   - fix build failures on Kconfig with CONFIG_BPF_SYSCALL unset;
>   - drop BPF_F_TOKEN_UNKNOWN_* flags and simplify UAPI (Stanislav).
 
I went through v2, everything makes sense, the only thing that is
slightly confusing to me is the bpf_token_capable() call.
The name somehow implies that the token is capable of something
where in reality the function does "return token || capable(x)".

IMO, it would be less confusing if we do something like the following,
explicitly, instead of calling a function:

if (token || {bpf_,perfmon_,}capable(x)) ...

(or rename to something like bpf_token_or_capable(x))

Up to you on whether to take any action on that. OTOH, once you
grasp what bpf_token_capable really does, it's not really a problem.
