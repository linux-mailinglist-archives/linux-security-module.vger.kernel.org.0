Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4FA4F082D
	for <lists+linux-security-module@lfdr.de>; Sun,  3 Apr 2022 08:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351045AbiDCGtk (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 3 Apr 2022 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiDCGtj (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 3 Apr 2022 02:49:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE4E377FB
        for <linux-security-module@vger.kernel.org>; Sat,  2 Apr 2022 23:47:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d10so2702716edj.0
        for <linux-security-module@vger.kernel.org>; Sat, 02 Apr 2022 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3Xx2ErVMBxvM/FsKeVuUk3St6Mlwp0omh3F7AKnqaSI=;
        b=hfxGHE/neBDBmVHC4B5zXX8I50+6tdLjnoBOV/+10786Ml6c/ZRBOW9tsUnyK+/vr9
         DDWmzeKqnab1OxzsPxOlPmdxMZo5tMPeYTScmT+tnrqLE3JRls/SRwhdOvZb4OmYorO0
         XssO0BYxcHoTOapXYhKKAYCsJefxgNlBPlf0XftY7mTweHpR6fMAAorTeVSNVnd/wUCo
         fEy9SKgT7W8YKoM+Wno1mSqy4spB5D+5rlAXljuDbj8CUvw2g4n8OcUefVW/z7BkBnE4
         FtS3o3gpXpMPx43BxV0iKStp4nxZOZVT86+sYmcwmwbBDVw8AoHrL8DoUPIncvtdk1T4
         9Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3Xx2ErVMBxvM/FsKeVuUk3St6Mlwp0omh3F7AKnqaSI=;
        b=7IVSEbI5eSAjll/8zM65dgD5bWcltXL7BP0dV14W2yDEsRiWAzdcJBRJ/iAgScB1WQ
         IvHNXMUbeKKFaA+dEVNibd2DzgCO6LvTEn60YhgKj81cZyi2yFr00eC0WLB7kfXEVdVK
         e1BkXDhGhOrnkOsgpTwsP1nnoTQmNWOX/eL4+L6/BJ7XoxLiyKFZjedgGOqEtS7qM8lS
         KJNQaeo73QMoiMUsk0WmIwPwymeEn3FHFc9csJbrFDJ7mMpfz4ivmWLdtZ0zYhLnjAFk
         YU8uVYT54q4jFpFA58TfvVmZMoTUyWjiacmtw2rg4NXjhsBWEijNiIgvyfkdQSRagCiO
         H2+A==
X-Gm-Message-State: AOAM530QzrG562rD+TlNeB70RF28vK8D8GYcElnTtdk1mAkdc0j/EXpd
        KNCNp6hmk6m/hmadHoZ2cjdnyiqXeuMB8K21nN8=
X-Google-Smtp-Source: ABdhPJyAYfHCsDtRtmYUKdplrpUZXodzKP8AbCz7kM3pTL1GBkOSBclwEpybeQJULtcGn2j7g+4sdcG4U3P/qAYlbkg=
X-Received: by 2002:a05:6402:1e8b:b0:41c:59f6:2c26 with SMTP id
 f11-20020a0564021e8b00b0041c59f62c26mr10246881edf.156.1648968464448; Sat, 02
 Apr 2022 23:47:44 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Sun, 3 Apr 2022 07:47:47 +0100
Message-ID: <CAHpNFcMywwyb4zaqpfytYUoH=coiPWubKz0q=E61Eo_8Jp3D7Q@mail.gmail.com>
Subject: VecSR Compression (HDMI & DP) & X-OR DSC1.2C & Along with our
 brilliant security features in NTP Folder (Security bat & WebHSM) & Default
 JS https://bit.ly/VESA_BT sure to please all on their servers
To:     do-webmaster@nist.gov
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

VecSR Compression (HDMI  & DP) & X-OR DSC1.2C & Along with our
brilliant security features in NTP Folder (Security bat & WebHSM) &
Default JS https://bit.ly/VESA_BT sure to please all on their servers

is QFT a Zero compression or low level compression version of DSC
1.2b? Maybe X-OR X=3D1 New Data & X=3D0 being not sent ? Therefore Masking
The Frame Buffer!

If not i dually submit it for inclusion in the standard along with
Vector Compression VESA Standard Display protocol 3
https://lkml.org/lkml/2022/4/2/328
https://lkml.org/lkml/2022/4/2/295

Include vector today *important* RS
https://vesa.org/vesa-display-compression-codecs/

"QFT transports each frame at a higher rate to decrease =E2=80=9Cdisplay
latency=E2=80=9D, which is the amount of time between a frame being ready f=
or
transport in the GPU and that frame being completely displayed. This
latency is the sum of the transport time through the source=E2=80=99s outpu=
t
circuits, the transport time across the interface, the processing of
the video data in the display, and the painting of the screen with the
new data. This overall latency affects the responsiveness of games:
how long it appears between a button is pressed to the time at which
the resultant action is observed on the screen.

While there are a lot of variables in this equation, not many are
adjustable from an HDMI specification perspective. QFT operates on the
transport portion of this equation by reducing the time it takes to
send only the active video across the cable. This results in reduced
display latency and increased responsiveness."

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

https://science.n-helix.com/2018/01/integer-floats-with-remainder-theory.ht=
ml

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

We then rotate the texture on our output polygon & factor size differential=
.

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize

Why ? Because rotating a polygon is harder than subtracting or adding
width, Hight & direction to fully complex polygon Fonts & Polygon
lines or curves...

The maths is simple enough to implement in games on an SSE configured
Celeron D (depending on resolution and Bilinear filter & resize.

*

VecSR is really good for secondary loading of sprites & text; In these
terms very good for pre loading on for example the X86, RISC, AMIGA &
Famicon type devices,
With appropriate loading into Sprite buffers or Emulated Secondaries
(Special Animations) or Font Buffers.

Although Large TT-SVG & OT-SVG fonts load well in 8MB Ram on the Amiga
with Integer & Emulated Float (Library); Traditional BitMap fonts work
well in a Set Size & can resize well if cached!

The full process leads upto the terminal & how to optimise CON,
We can & will need to exceed capacities of any system & To improve them!

presenting: Dev-Con-VectorE=C2=B2
Fast/dev/CON 3DText & Audio Almost any CPU & GPU ''SiMD & Float/int"
Class VESA Console +

With Console in VecSR you can 3DText & Audio,

VecSR Firmware update 2022 For immediate implementation in all
operating systems & ROM's

Potential is fast & useful.

*

https://science.n-helix.com/2022/04/vecsr.html
