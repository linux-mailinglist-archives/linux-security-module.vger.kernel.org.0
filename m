Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7E457675F
	for <lists+linux-security-module@lfdr.de>; Fri, 15 Jul 2022 21:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiGOT2l (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 15 Jul 2022 15:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGOT2k (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 15 Jul 2022 15:28:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E235271E
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 12:28:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v7so5495991pfb.0
        for <linux-security-module@vger.kernel.org>; Fri, 15 Jul 2022 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qLmffwl75hgVbG2gk0tD6CR2NK/r5FWbW6d2Hfhvklw=;
        b=tBNflhJG39NNOtRJAnSsZf0Mz1s7O9xDQiesgT8qsidLnFtuOTSk+TbYvdMNItHTPn
         PpvmA9kGK70VxNP2LiF7AZMV54w4qphldr0uoS4HsMGePDL/vlr9tA9u8C4ZK4y32zEw
         PtcAWB08G5Jq81PsYzRlscnqOQS3yK9+qdTF+iuBD7cGbbqJ+Zpd4YK4HaS5xL/JivC2
         XNkTdf+HGR3BkV91vPU3dMChnCOTzOB6tJ2dWRqvkEFLhhrt/wAlYBG6XuNJ9++fM/Eh
         X2Mmem6tjHdZ0kL0PWeVBukomdpxpIvJ7NaBhRPAB2OacrCq48ujcQYvFG9AqBbw8bkB
         4KIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qLmffwl75hgVbG2gk0tD6CR2NK/r5FWbW6d2Hfhvklw=;
        b=JKUy2ooDcm8C8wumuNCo7RsgFihk5N8lQAK/7RH+ACAzI+1B3u7gXdMyfTXRQKPYE5
         J3R2gdca/LbaSu+p3qTN6UbbcokzZ5otC5r3rwFHn367bwjLJlxP5cCEpENT6ZMORBKE
         1dar13zSrPXDyZHHKb1mtfRoM8WaoMqKmkpUWJ7JdBmMA5AWjMw7OcSvzo/t82+Waa7y
         gkQiMehR1NNutk2XF+/WUYxmBFNy8q8s+n5g8yHhNxWEfSVvCfQquPCOtHZ98ZI1T7uV
         3gjy8fR/h9I+Xp9rzy2n6kG6K0TECmQlg7tjdWkJbyr42R25/WDqi87eRIoF+j21iy3s
         zxUQ==
X-Gm-Message-State: AJIora+LWwIQA/0lFG+soes+tlzC5JV9EH0LK628jZImabIJBDfH7xoZ
        530cUiVLIPVLwuP+HGg+2hKmoQ==
X-Google-Smtp-Source: AGRyM1sguRsI0CLbyOSQx7uqFMEBO/+wa1uRdB/NxjvCJYWu8rLyJIPfD1UcG2YEKSuCOARPIH+ROg==
X-Received: by 2002:a65:5605:0:b0:419:d863:8d94 with SMTP id l5-20020a655605000000b00419d8638d94mr5229267pgs.359.1657913317875;
        Fri, 15 Jul 2022 12:28:37 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001641b2d61d4sm3967075plh.30.2022.07.15.12.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 12:28:37 -0700 (PDT)
Message-ID: <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
Date:   Fri, 15 Jul 2022 13:28:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file
 op
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, casey@schaufler-ca.com,
        paul@paul-moore.com, joshi.k@samsung.com,
        linux-security-module@vger.kernel.org, io-uring@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        a.manzanares@samsung.com, javier@javigon.com
References: <20220715191622.2310436-1-mcgrof@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220715191622.2310436-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> add infrastructure for uring-cmd"), this extended the struct
> file_operations to allow a new command which each subsystem can use
> to enable command passthrough. Add an LSM specific for the command
> passthrough which enables LSMs to inspect the command details.
> 
> This was discussed long ago without no clear pointer for something
> conclusive, so this enables LSMs to at least reject this new file
> operation.

From an io_uring perspective, this looks fine to me. It may be easier if
I take this through my tree due to the moving of the files, or the
security side can do it but it'd have to then wait for merge window (and
post io_uring branch merge) to do so. Just let me know. If done outside
of my tree, feel free to add:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

