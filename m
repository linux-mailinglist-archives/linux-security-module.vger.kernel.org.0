Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF80846A90A
	for <lists+linux-security-module@lfdr.de>; Mon,  6 Dec 2021 22:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhLFVIT (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 6 Dec 2021 16:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbhLFVIT (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 6 Dec 2021 16:08:19 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2984EC061746
        for <linux-security-module@vger.kernel.org>; Mon,  6 Dec 2021 13:04:50 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id h1so7831985vkh.0
        for <linux-security-module@vger.kernel.org>; Mon, 06 Dec 2021 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/hcukEIQaCcxirCJNZ+x6aCBixMJlSux/MsYQVb+1D4=;
        b=Sfm3ZR0AF9gFYUmTfD180jkSzwb85O8K1kyIlUkmwwHdFRFX06HQjh4SRpYnckdvxH
         KSHU6BaoUOBLeM2AXkqYwMRwZpxgavB39fc2MwcDy9NipzdYBBsLcEaEFBBxkQFrUMxF
         /p1t7K9nEh4cu5YieHx/BTIHKxniAKR94MuZOCG/JrWolzP1nheht5XaEgrocNsXJVEC
         bKKPR61K5qolQdvbY69CUH63kHawWTWqe8sd6PkY8qyrhb9A1avwSZ8HuBL2cam3i11o
         MBnFhMa5wC4O8Huk+Th0ejHTHAYowbHe0hK/pU2zh/yrlmwWuSVKsY+3hEbzIfkjff16
         VHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=/hcukEIQaCcxirCJNZ+x6aCBixMJlSux/MsYQVb+1D4=;
        b=gCfsEeNmCK3Fiy19xLr9Ucp2GA0gKeFgpsKSGqRDTTIYCmTWmMPzpZY5uov1PQ1Cib
         lAZ3iZRFbfhFmtpKb5lhD07wkKYgK3WdEbxbAqiaTZWgEzs7AYNUVRW7kSHnZ9yREKrn
         LOpV+kgG3I8Pbq/b2Ap7Ikcf622c+m4mW93xVrG8GQ91y89TWe052wXCbSaSrqsjnVAf
         v4Q83C4f0BYbGEl/XMhwoPWhdfz/WpI4j96TNGLyyKsIBQN7RGNuV9lKa3Iqztgc0Zvy
         rLOGs2MmjcB8+Nzl4vjc35UnKteuPOPcxdDoGO7iZhMiqZ2z/Sbb2K3AOAXazTFXbvK2
         OlmQ==
X-Gm-Message-State: AOAM530N3MH+6uuz8CXxTuZlctuANeMdJFj7TIdCm8rqUJ9S1lIZHxoS
        Klvb7o9PUxQPzY9rNvoLnpfjXp3oX8ZEbSu4Q9A=
X-Google-Smtp-Source: ABdhPJz1jU4bq4pop5uLlUf3lWuzx47rLeBHi35/2vUl8e2SlBxDGs38ih/eu8aCLFoWHWhgPZez7DFgTcELK6DeYko=
X-Received: by 2002:a05:6122:d09:: with SMTP id az9mr45925416vkb.23.1638824689128;
 Mon, 06 Dec 2021 13:04:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:b990:0:b0:245:f612:e087 with HTTP; Mon, 6 Dec 2021
 13:04:48 -0800 (PST)
Reply-To: mk83770911@gmail.com
From:   Margaret Ko May Leung <rg201866@gmail.com>
Date:   Tue, 7 Dec 2021 00:04:48 +0300
Message-ID: <CAJusTCZp+cYU7j4YAS6LT8-fTD=OCmOMtZiJ42TdVpQLsPyuqA@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

--=20
Ich habe einen vorteilhaften Gesch=C3=A4ftsvorschlag f=C3=BCr Sie
