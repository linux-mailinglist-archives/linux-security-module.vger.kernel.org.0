Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA97A4F65EA
	for <lists+linux-security-module@lfdr.de>; Wed,  6 Apr 2022 18:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiDFQud (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 6 Apr 2022 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbiDFQuX (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Apr 2022 12:50:23 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8341AD8A
        for <linux-security-module@vger.kernel.org>; Wed,  6 Apr 2022 07:59:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g22so2980546edz.2
        for <linux-security-module@vger.kernel.org>; Wed, 06 Apr 2022 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=O6flvYjHb1+WfUStDB7Vb+WVyJLuR7FAnWyfuVggjRQ=;
        b=E+armmouniLl2sBCjqZqyQddhpGwn3Ziyvs15keiZ2ob4vwFAGATzd5TX1jCW9Lk8S
         lLZUxveMdNHh+WP6D434u+6o06MZvAITK22X3sLqifgSB2Mw/rXok4K1lM7IAnBJweoj
         B0csAC2+gje+vNkXZJOZCspg13i+ozkPnmupWf5+bgmK/bSUswOdhjYrVrw9scnTK6NI
         glDD1o4N4hdFhQCJboMGSp/X0xi8XQGcplizZxpdWBNB45oRS/aCuox8ZNRe/+Z7uAfm
         zY1Q2uRfD4V2pPqUCcadF6XNEPGIynDK4OHDJXbDur+/+C7WWrhclOhM06KOdLVu4Zy0
         MohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=O6flvYjHb1+WfUStDB7Vb+WVyJLuR7FAnWyfuVggjRQ=;
        b=NggBoNMtCBQDr9PEpwLIPXoVl0GY37KkBHhhTq7AXspEt0TVj9Lk/25MGoSleChnGt
         1UJeN43OkrAK5lMw85Xglmb/3t2ZwmsHvY240CjpFjQ1k2SUkvUCXOsaAaD+l1+Hte4U
         2gR4mWW+CeeXSLS6Lnx4vNG2nRrAPmWfnmbzvzk6dXIGQD1jGibHVsqSclGVacCQDwye
         lLoah3T6gNfi0VFGQ8vPekWm4eALQ5AaKzFxfHY+Adkw+YS9gSPYMvGqT7VO/cb11xzF
         wZYNZUFFBYBs1w9BqxNwNtHijKDYeeNOPkzmQpSnKlPYR13OkOBEnJNvSLoVitK12ymt
         +PvA==
X-Gm-Message-State: AOAM532E9LUfFhavgTToSIstVyYyjwXnJvt8Ftf1KC5iThZN59aEpzJJ
        cnzeVlTTPgtyTq16184LFYoClsSWEE4WChcYWPs=
X-Google-Smtp-Source: ABdhPJypAF7r2xCoFQSR6T8KAU4HybByZDFMEGNe9rG4COb3Nm0h5+tJI12q8hOlc9oCYPqKRlOtOzHjEC/adxEkB2w=
X-Received: by 2002:a05:6402:34d6:b0:419:4dc2:91c5 with SMTP id
 w22-20020a05640234d600b004194dc291c5mr9321920edc.329.1649257156492; Wed, 06
 Apr 2022 07:59:16 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 6 Apr 2022 15:59:04 +0100
Message-ID: <CAHpNFcMx23PdHqFcoNcPvTS99h7=yAc0OL69iCyUKoiXpVULxg@mail.gmail.com>
Subject: Display Stream Compression Support - 3D Mux , 3D Mu-X by GPU & CPU
 though SiMD & AVX 32Bit IfNotOR to a Singular planar Frame Buffer
To:     undisclosed-recipients:;
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

Date: Wed, Apr 6, 2022 at 3:13 PM
Display Stream Compression Support - 3D Mux , 3D Mu-X by GPU & CPU
though SiMD & AVX 32Bit IfNotOR to a Singular planar Frame Buffer

https://lkml.org/lkml/2022/4/6/401
https://lkml.org/lkml/2022/4/6/541

*
[PATCH v7 13/14] drm/msm: Update generated headers Vinod Koul
  [PATCH v7 07/14] drm/msm/disp/dpu1: Add support for DSC in encoder Vinod =
Koul
  [PATCH v7 09/14] drm/msm: Add missing num_dspp field documentation Vinod =
Koul
  [PATCH v7 06/14] drm/msm/disp/dpu1: Add DSC support in hw_ctl Vinod Koul
  [PATCH v7 08/14] drm/msm/dpu: don't use merge_3d if DSC merge topo
... Vinod Koul
  [PATCH v7 03/14] drm/msm/disp/dpu1: Add support for DSC Vinod Koul
  [PATCH v7 01/14] drm/msm/dsi: add support for dsc data Vinod Koul
[New] [PATCH v7 00/14] drm/msm: Add Display Stream Compression Support
Vinod Koul
*
3D Mux , 3D Mu-X by GPU & CPU though SiMD & AVX 32Bit IfNotOR to a
Single planar Frame Buffer is logical in the case of Multi Window
desktops,
A Blitter Frame Works well for X-OR.

The relevance is that a Single Frame buffer per Eye does 3D Imagery!
(Google Glass & MS & PS4 VR)

We can and will need more; For this Substance Called Flexibility we
need 2 Details:

ReDirectable DMA & Multi Frame Blitter...

By this method we can literally write every detail if we wish in
Shader, But we do not need to worry!

X-OR Blitter Recovers from Overwrite by detecting details that are new.

Simple is best but keep in mind that CPU Frame Buffer (In RAM & Cache)
& GPU Frame Buffer (in GPU) & Direct Access RAM : ReBAR to
Transparently access GPU RAM!

Allowing ALL.

****

Vector Compression VESA Standard Display protocol 3 +
DSC : Zero compression or low level compression version of DSC
1.2bc

Frame by Frame compression with vector prediction.

X-OR Frame Buffer Compression & Blank Space Compression:

X-OR X=3D1 New Data & X=3D0 being not sent,
Therefore Masking the frame buffer,

A Frame buffer needs a cleared aria; A curve or ellipsoid for example,
Draw the ellipsoid; This is the mask & can be in 3 levels:

X-OR : Draw or not Draw Aria : Blitter XOR
AND : Draw 1 Value & The other : Blitter Additive
Variable Value Resistor : Draw 1 Value +- The other : Blitter + or - Modifi=
er
*

Vector Compression VESA Standard Display protocol 3 : RS

SiMD Render - Vector Graphics, Boxes, Ellipses, Curves & Fonts
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

"QFT a Zero compression or low level compression version of DSC
1.2bc

X-OR Frame Buffer Compression & Blank Space Compression:
Vector Compression VESA Standard Display protocol 3"

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
*

(c)Rupert S

Include vector today *important* RS
https://vesa.org/vesa-display-compression-codecs/

https://science.n-helix.com/2016/04/3d-desktop-virtualization.html

https://science.n-helix.com/2019/06/vulkan-stack.html

https://science.n-helix.com/2019/06/kernel.html

https://science.n-helix.com/2022/03/fsr-focal-length.html

https://science.n-helix.com/2018/01/integer-floats-with-remainder-theory.ht=
ml

https://bit.ly/VESA_BT

Rupert S
