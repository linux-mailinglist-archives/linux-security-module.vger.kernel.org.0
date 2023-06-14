Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04A372980B
	for <lists+linux-security-module@lfdr.de>; Fri,  9 Jun 2023 13:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbjFILSO (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 9 Jun 2023 07:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbjFILSB (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 9 Jun 2023 07:18:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41030D7
        for <linux-security-module@vger.kernel.org>; Fri,  9 Jun 2023 04:17:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E8FA65717
        for <linux-security-module@vger.kernel.org>; Fri,  9 Jun 2023 11:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A37C433D2;
        Fri,  9 Jun 2023 11:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686309465;
        bh=iWMSUkwP8jqT1WeI2sUyI0XDZi814J9HOjsS1S4hhmw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=upzuP6r+dDzuSqI7givQAjwL/enqTIGmRsCuk47Nb2iDZNZfifPYMMyqm8i6/poBp
         K3gN9nSkh4fJHNeNTa4psZf0LAtK6XRMrv3bUuctzYM7fhYxdY01yinrtW7GRbczaJ
         8CzsCjlTsQ6GrNnMI3YS3Rk/r3k19HJS9hIuJ9KkOAzVa7IS27keUdv57iV1UEZ24h
         whMmJX5aQ8/p6oTIzzLX5OoeUkWNjU6joQIMuaqC98/GNby0kQab/q/T3dkgysPCuJ
         C567OAEpX6fvXQE8wP6B2VFyVe9g4ESLyMXE3ZE6eaNZmu0ccUjpCaMWB+wNWh5bp1
         y2pCqPjzPmFow==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2EDE3BBE2E9; Fri,  9 Jun 2023 13:17:43 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, cyphar@cyphar.com,
        luto@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/18] BPF token
In-Reply-To: <20230607235352.1723243-1-andrii@kernel.org>
References: <20230607235352.1723243-1-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 09 Jun 2023 13:17:43 +0200
Message-ID: <871qik28bs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Andrii Nakryiko <andrii@kernel.org> writes:

> This patch set introduces new BPF object, BPF token, which allows to delegate
> a subset of BPF functionality from privileged system-wide daemon (e.g.,
> systemd or any other container manager) to a *trusted* unprivileged
> application. Trust is the key here. This functionality is not about allowing
> unconditional unprivileged BPF usage. Establishing trust, though, is
> completely up to the discretion of respective privileged application that
> would create a BPF token.

I am not convinced that this token-based approach is a good way to solve
this: having the delegation mechanism be one where you can basically
only grant a perpetual delegation with no way to retract it, no way to
check what exactly it's being used for, and that is transitive (can be
passed on to others with no restrictions) seems like a recipe for
disaster. I believe this was basically the point Casey was making as
well in response to v1.

If the goal is to enable a privileged application (such as a container
manager) to grant another unprivileged application the permission to
perform certain bpf() operations, why not just proxy the operations
themselves over some RPC mechanism? That way the granting application
can perform authentication checks on every operation and ensure its
origins are sound at the time it is being made. Instead of just writing
a blank check (in the form of a token) and hoping the receiver of it is
not compromised...

-Toke
