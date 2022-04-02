Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB5B4EFDC4
	for <lists+linux-security-module@lfdr.de>; Sat,  2 Apr 2022 03:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiDBBcF (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 1 Apr 2022 21:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiDBBcE (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Apr 2022 21:32:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2BA1A637B
        for <linux-security-module@vger.kernel.org>; Fri,  1 Apr 2022 18:29:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i16so9188837ejk.12
        for <linux-security-module@vger.kernel.org>; Fri, 01 Apr 2022 18:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=28vAyIlWmTWBBzazT2gmuotOzviWJtQdA3dJRL//zKo=;
        b=a874jFrROO8zHRa7BA26IpMaqO6Xu76OpaSsUwKbe0PUjUnD1APv4PQa+fkbTxZmMe
         wwsG35frpXr4OWaNcKhRz8xWLzbYH65CllBGPazcbWqszAE5gPK/TK/hvwgtyNzvCBxG
         8Z2RnILhY69v8jgB6/GUVKbAVd+RAcDzyNlxelH6jPddG3coarO4VJuxYqYKhzBzllY5
         I6dhoM/W9NCAn/VFL1QX2cJ43yREheKoztROsH4gaEl2pJIex9U8x/3RHrjyklaGQwhq
         dVmv58xsImSjK6zdHZS29bT43ov/I7reJUeDpc/SohJcIxVz1xY3qC0ua29AEm90jx3X
         Nw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=28vAyIlWmTWBBzazT2gmuotOzviWJtQdA3dJRL//zKo=;
        b=69FcmSYcOhyHZ6VQRa5SHuaCo8mxaruooTBp9SBPDHGVoZuzA140KlEtjNp7jFqOjE
         5Q5XOrXrvOsIgvrI/Sewqaj7iMuwjJ3r5ttqqCzObz/oUmbiab8LoXqvaBUb7cNyrnrG
         hB2sNc/xKQwHP12zOCVLRte0na90DYmCxqcfhXSBWi7FsokzHdwtkKIbOH5jmuk4gI51
         Z7XQp0kEzPVWgROTqPglvAHBL6q7my7JX6NGPnKpP4iaNUWRs/n0pEi2xaBLN667Jen+
         wXWV6m4kZewLx8KzFlsTK+Q96sTyBLwbFaAOWB0eZUmtLIhvDdo+CYB5C+jkvFcejBVy
         sCWQ==
X-Gm-Message-State: AOAM531J2SkBl+ASeJfACjrKZ8Jswz6FmbLhQvyO0b6Z2fzF8XtRY/qq
        /mL5U8VU/stAgtC8pkYV8OGb1xiKqa40+x4Fvrw=
X-Google-Smtp-Source: ABdhPJwHPDWyec9gn3qg1wh//0mc5kVi1NRCG4JefntpV4CiW1IKbMbPEKzqs1otDaGoQZZvuFBcbqe0QoGlziOmhgY=
X-Received: by 2002:a17:906:d555:b0:6db:148e:5cc with SMTP id
 cr21-20020a170906d55500b006db148e05ccmr2047095ejc.63.1648862997490; Fri, 01
 Apr 2022 18:29:57 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Sat, 2 Apr 2022 02:29:58 +0100
Message-ID: <CAHpNFcMaF-cqoOy7g4Ee2XeG05LoLx60J9WCpRKbumh+J5hKjg@mail.gmail.com>
Subject: Fast/dev/CON 3DText & Audio Almost any CPU & GPU ''SiMD & Float/int"
 Class VESA Console + With Console in VecSR you can 3DText & Audio + VecSR
 Firmware update 2022 For immediate implementation in all operating systems & ROM's
To:     moderator@vesa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Fast/dev/CON 3DText & Audio Almost any CPU & GPU ''SiMD & Float/int"
Class VESA Console + With Console in VecSR you can 3DText & Audio +
VecSR Firmware update 2022 For immediate implementation in all
operating systems & ROM's

Potential is fast & useful

DT

https://lkml.org/lkml/2022/4/1/1451

*****

VecSR - Vector Standard Render

VESA Standards : Vector Graphics, Boxes, Ellipses, Curves & Fonts :
Consolas & other brilliant fonts : (c)RS

SiMD Render - Vector Graphics, Boxes, Ellipses, Curves & Fonts

OT-SVG Fonts & TT-SVG Obviously Rendered in Direct X 9+ & OpenGL 3+
Mode & Desktop Rendering modes

Improve Console & TV & BIOS & General Animated Render

Vector Display Standards with low relative CPU Weight
SiMD Polygon Font Method Render

Default option point scaling (the space) : Metadata Vector Fonts with
Curl mathematical vector :

16 Bit : SiMD 1 width
32 Bit : SiMD Double Width

High precision for AVX 32Bit to 256Bit width precision.

Vectoring with SiMD allows traditional CPU mastered VESA Emulation
desktops & safe mode to be super fast & displays to conform to VESA
render standards with little effort & a 1MB Table ROM.

Though the VESA & HDMI & DisplayPort standards Facilitates direct low
bandwidth transport of and transformation of 3D & 2D graphics & fonts
into directly Rendered Super High Fidelity SiMD & AVX Rendering Vector

Display Standards Vector Render : DSVR-SiMD Can and will be directly
rendered to a Surface for visual element : SfVE-Vec

As such transport of Vectors & transformation onto display (Monitor,
3D Unit, Render, TV, & Though HDMI, PCI Port & DP & RAM)

Directly resolve The total graphics pipeline into high quality output
or input & allow communication of almost infinite Floating point
values for all rendered 3D & 2D Elements on a given surface (RAM
Render Page or Surface)

In high precision that is almost unbeatable & yet consumes many levels
less RAM & Transport Protocol bandwidth,

Further more can also render Vector 3D & 2D Audio & other elements
though Vector 'Fonting' Systems, Examples exist : 3D Wave Tables,
Harmonic reproduction units for example Yamaha and Casio keyboards.

(c)Rupert S

https://science.n-helix.com/2016/04/3d-desktop-virtualization.html

https://science.n-helix.com/2019/06/vulkan-stack.html

https://science.n-helix.com/2019/06/kernel.html

https://science.n-helix.com/2022/03/fsr-focal-length.html

https://science.n-helix.com/2018/01/integer-floats-with-remainder-theory.html

https://bit.ly/VESA_BT

*

*Application of SiMD Polygon Font Method Render
*3D Render method with Console input DEMO : RS

3D Display access to correct display of fonts at angles in games &
apps without Utilizing 3rd Axis maths on a simple Shape polygon Vector
font or shape. (c)Rupert S

3rd dimensional access with vector fonts by a simple method:

Render text to virtual screen layer AKA a fully rendered monochrome, 2
colour or multi colour..

Bitmap/Texture,

Due to latency we have 3 frames ahead to render to bitmap DPT 3 / Dot 5

Can be higher resolution & we can sub sample with closer view priority...

We then rotate the texture on our output polygon & factor size differential.

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize

Why ? Because rotating a polygon is harder than subtracting or adding
width, Hight & direction to fully complex polygon Fonts & Polygon
lines or curves...

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize.

https://science.n-helix.com/2022/04/vecsr.html
