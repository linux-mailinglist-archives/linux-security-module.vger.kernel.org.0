Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84DD1A66F9
	for <lists+linux-security-module@lfdr.de>; Mon, 13 Apr 2020 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgDMNah (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 13 Apr 2020 09:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgDMNa3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 13 Apr 2020 09:30:29 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA06C008769
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2020 06:30:29 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g14so813624otg.10
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2020 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=6jXC2UTWF/SUxZW/pWxyCF4hxNCly+ey/YhKERzLlbQ=;
        b=iP/ULyy8lWG1nhEGn0gppspS4F2JhILJ4nTAtiYGhdrZL51cxqVWhs6D3Y9wyc2ADf
         A2rwUCP45WAPoWNbSBZGTGVFxJmmDPHe19L3gxm7+w8E5f22GKJOLIMHoMQQI7v3c5XY
         DlMUV5+ZlbBmFxdLOO2VDbc7W9ESDWYt4QtLLqRZFkEOi9gTP3STkSTcSJo+WdBU2ZMP
         cbKcszDV9RPwFi/D+lHgC6golJOLYJdAkURkw7hbGoqznT8eWbtFkjjpTaIqirsxJh7L
         wdqYlNLP395ub4iQIUl47edMIk3+i+NAk1eC0wEHnaBVffHHOQq3Dv9hRllCWWuEG7fQ
         v+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6jXC2UTWF/SUxZW/pWxyCF4hxNCly+ey/YhKERzLlbQ=;
        b=c7nfL9hwhlanB7w0dg+f/RUj3ii9BWTpjq8bGGK+GMmEUkNcfUaZkJyPJih7+tco0s
         30BNYGGvC7HbWZppI0DwqnMfsqnfQPcSM+MspFupS6J8yMwvhmKQ+e07O19gnI5NniSX
         5p1Ha/LZlCAoMwJZC4cHH+0sI14fB3ZdV3tlAbjup5aB0cOXBipPJZlRvo82tVb4O+Zp
         brjpJ9Eu9iGjkcnJKMdHt7Sd8n5hN4iFzvtHbvgi8e3dEVP1+p2pHFcIMg2dk2jhNFjJ
         ivPS8HL4C3fhqLlhHtpFb6SSdpeRbKj+dC93vxuyUX/QixwqUKSO56MQQnGvXBEUW8Eg
         xkFA==
X-Gm-Message-State: AGi0Pub4HAXAcK4CyRR9EMK8eizOgv8Of9jPZIDgslS7BdqJBbrPrq2j
        nSN9ybdoyO0WKC8iL7qd2DKHfM/NpwV26Dk5eGmp+iuAPSU=
X-Google-Smtp-Source: APiQypLFU/9OTkw8I8yoSnsZBoCJl2kmbnPrqcYyRtFa4kS0eBylKtgliJY99Emg2IXzWabr7J0d9UY0bd1bcIemaS0=
X-Received: by 2002:a4a:da55:: with SMTP id f21mr14363752oou.34.1586784627519;
 Mon, 13 Apr 2020 06:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200326200634.222009-1-dancol@google.com> <20200401213903.182112-1-dancol@google.com>
In-Reply-To: <20200401213903.182112-1-dancol@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 13 Apr 2020 06:29:50 -0700
Message-ID: <CAKOZueuu=bGt4O0xjiV=9_PC_8Ey8pa3NjtJ7+O-nHCcYbLnEg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] SELinux support for anonymous inodes and UFFD
To:     Tim Murray <timmurray@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Paul Moore <paul@paul-moore.com>,
        Nick Kralevich <nnk@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Lokesh Gidra <lokeshgidra@google.com>, jmorris@namei.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Apr 1, 2020 at 2:39 PM Daniel Colascione <dancol@google.com> wrote:
>
> Changes from the fourth version of the patch:


Is there anything else that needs to be done before merging this patch series?
