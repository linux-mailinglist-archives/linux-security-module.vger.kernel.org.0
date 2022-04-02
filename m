Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4714F011E
	for <lists+linux-security-module@lfdr.de>; Sat,  2 Apr 2022 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiDBLd4 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sat, 2 Apr 2022 07:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiDBLd4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sat, 2 Apr 2022 07:33:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BFA1427EC
        for <linux-security-module@vger.kernel.org>; Sat,  2 Apr 2022 04:32:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so10829201ejd.5
        for <linux-security-module@vger.kernel.org>; Sat, 02 Apr 2022 04:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Zu8eKPzRskdlQlbramfPaoD/f1fGti5TmNsQY/hQanM=;
        b=CIIQzK8rbC+RcFX9f3W8RVw/coWcTYcu5ya9tWYCqSJ0KdqeCTRKztFEKDK7EIB3f6
         M0gN98TIM+vbQipg965NiAMwkYHnUjIEv7Ms+CsryAcLVfTj7jptnEEtjHSatQaNfNB4
         uKh/72W912V8+ox54/gGnIsiuCQRrjl0Yw6Gq/X+74OX0KeaUmf0rIDGXbtTpmhSG1M7
         BZHfLNPI7m21UmALjfkpls26VwaFynoE1lD59hmmdBW/cjZ3c9q3QYJ7NSxgi4ZhZHOo
         M5OAUQoYLzk7uy1vzy7uLkGsSpDsMd+KthSE6Xztvt1oWaeBm/ljmtNJ89VlxGr0ev8h
         icZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Zu8eKPzRskdlQlbramfPaoD/f1fGti5TmNsQY/hQanM=;
        b=ApLZA6XrlBA4A96iwYMRgMKG67/vLZdG4sUDyMi23JaGf2pfgWMVKwPCRgFIGfYBmn
         qStNBHH2KhHtqkuJ3eBo/G5YqrcU01UXXj+XZd7kSGz6LoqxTs1mAJHAp0+1ZisR4XEW
         N9CU3e7k1hGWAPp/RnrQ/CGFjr7Q7ltSv8CutssfM3EV7yjAyL//0n6hvGRkE7eUd+DS
         h/0aw3tUml6Z8in/b58BudrvV/8sbFqC1nFLr4KRn9VxaHJ7QAKaHdInj/JYDTO/DPAh
         JYQn9U5aqtw5D+WqQ5M6vgVUg9X+r8Ytu7Z9FjHnfaxYsZ8Yjt3L1c2u05aZD6qHIcrE
         0PkA==
X-Gm-Message-State: AOAM5328dE+2YYIn/6CgDSyS5z6E2XLGCB+xr+Imsjsl0m6TnKswcvXq
        FFj228f33XUvdBXO9Jlv+rTW7alaYVKYX6Bg3IFufbkPPpj0Wq3/
X-Google-Smtp-Source: ABdhPJzStAksb/egRmfGjkKwyuVRy05cibbNUQ0oIYy22xL/Wff/xxZl4pQSBS+cp9XuyavlKtoeT2E5XKP8LjpLaAQ=
X-Received: by 2002:a17:906:1e94:b0:6cc:4382:f12e with SMTP id
 e20-20020a1709061e9400b006cc4382f12emr3451709ejj.482.1648899121194; Sat, 02
 Apr 2022 04:32:01 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Sat, 2 Apr 2022 12:32:02 +0100
Message-ID: <CAHpNFcNqhL2TZLJenRqUKP6d1wTCGjZ9VA=d2TnDpKZxbSH4Vw@mail.gmail.com>
Subject: VecSR is really good for secondary loading of sprites & text; In
 these terms very good for pre loading on for example the X86, RISC, AMIGA &
 Famicon type devices, With appropriate loading into Sprite buffers or
 Emulated Secondaries (Special Animations) or Font Buffers. RS
To:     bill@vesa.org
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
