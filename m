Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57C54EEAC9
	for <lists+linux-security-module@lfdr.de>; Fri,  1 Apr 2022 11:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbiDAJ6K (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 1 Apr 2022 05:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbiDAJ6J (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 1 Apr 2022 05:58:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F341E7A5C
        for <linux-security-module@vger.kernel.org>; Fri,  1 Apr 2022 02:56:18 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b24so2297721edu.10
        for <linux-security-module@vger.kernel.org>; Fri, 01 Apr 2022 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=eqp//V44V+hcbISIvt1lJuK4foZj7CO3yEn40TtD0t8=;
        b=FCPp1/Q0xwCZRmR00bNEYibbjXgURkA37k8/uPpkC0Iuqg70Oj1QLiW3YTIfet3Qy1
         S4rWOFuM02tOs4TlrIDwGGpr8KBRmVE8wZImPgmBIGvjfVLo0BXty9sKj0wQ9rcNSYA/
         NJIp7TMsBZMbN1cOjPZia8z2IhtyN710vNTe6MWzUnWJ0KbH3mY3BRnuEFtLFN05hm2Y
         FxKXq3zyC/edFB9Snr+Z1sWzbm9TLmn/J/1xp/XfEXn7li429/I4lbA4k3BFMo3fBfkR
         DrwG3JwRXUmEJY+FT0eXzNzph+smmXKfOwbLirlqwdgIBi7VGZdmBv112dDSEK2oFlDB
         xK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eqp//V44V+hcbISIvt1lJuK4foZj7CO3yEn40TtD0t8=;
        b=zE7yxjWCqtMVLe0DeLAz9uox4EQwtDBWAq4fyAZMKAQyCJOqzO0ApSSeBt3qNCU4oj
         iviEHh1FihyCvt5ofwSOsnpDiSNL18Hm2BLRsuHzqkB2TTGIBBdmu8KlPHVL82zhxqlR
         dNP1WTMCMZj8Wjgtk4DOpgwMO8WDQjbg4IOFGVar3OUFUKYTWFSEqOtVMv44IWO+ylY3
         HBNm1VPYv9GqQV//wzb/3qo5o7DmFxJTLqnDViGlhNMCgvpSFDwZ7DW/r1hJ7/uXaLk5
         o1NmsREO9+MvEtrGHmlqemU0uH6eZKcw2KBg3SEayJ3gc9VYibjIeZzzjT8a4UhD81Eo
         IGTQ==
X-Gm-Message-State: AOAM532f8eUSdO3JQuWaHAc5KjyJwXWWZYlxvYvaQzpsDHP6pZkP/bPi
        uko5JLUUI71wEMhlXNHlmZduWtLsnxHVwMfMYJA=
X-Google-Smtp-Source: ABdhPJzaHueKtUu7kIF5f9s+gg+fr5zzXike940e/a2j34x6DN5dHRWD/YMxxF+9D4n4fU/Pa3t2M5zICTgbx+ndrvg=
X-Received: by 2002:a50:ab16:0:b0:414:39b0:7fc1 with SMTP id
 s22-20020a50ab16000000b0041439b07fc1mr20111224edc.214.1648806976973; Fri, 01
 Apr 2022 02:56:16 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Fri, 1 Apr 2022 10:56:16 +0100
Message-ID: <CAHpNFcNc0bJDZdd4JsiXZTQSGHuDQ=akDR20jPHu+jHVpTdnRA@mail.gmail.com>
Subject: VecSR Firmware update 2022 For immediate implementation in all
 operating systems, monitors, TV's & equipment such as Mouses, Audio Systems & Webcams
To:     bill@vesa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Date: Fri, Apr 1, 2022 at 9:48 AM

https://lkml.org/lkml/2022/4/1/139

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
