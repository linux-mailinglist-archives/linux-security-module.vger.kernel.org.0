Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667EB6D1BB8
	for <lists+linux-security-module@lfdr.de>; Fri, 31 Mar 2023 11:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjCaJQC (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 31 Mar 2023 05:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjCaJPu (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 31 Mar 2023 05:15:50 -0400
X-Greylist: delayed 2792 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 02:15:29 PDT
Received: from mail.arnisdale.pl (mail.arnisdale.pl [151.80.133.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32A76AD
        for <linux-security-module@vger.kernel.org>; Fri, 31 Mar 2023 02:15:29 -0700 (PDT)
Received: by mail.arnisdale.pl (Postfix, from userid 1002)
        id 89DE1298D3; Fri, 31 Mar 2023 07:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=arnisdale.pl; s=mail;
        t=1680248822; bh=6DhEsVYOGxxfetVY3oiVeew+7Cm34ArcvgDq2WQYIRw=;
        h=Date:From:To:Subject:From;
        b=X8ugi4yDgawzOwmQm2CPYSFw3pqw7kpV2zM7jxzvKhdObdu21O9m2hYgVhxKILzIe
         zzo3MxsvtsVWFFtr9E29hE48YtrUIhffYoK0GN+OYAYNRgd4ckkUQJWyoOl6+4TsWE
         6QAS6JS2tAcpkF9nS6SD/FKxdK8TNg7pCFyaMtKWoW9ijggunMKfvHYr4eJW17xCNB
         Y6UZdH8sU88hsvEk71sLSBOt1w9QwSVsZug3ukfFE5vstPDITs4CacaZ67yTDLvV5j
         R7kfsh38rqWB7P3exsiXtC2Cgf1LdLj/hA1SO3TpXIS88gzcqHONOdOAOTEPRsaqUd
         uKOVp4F3kJlrw==
Received: by mail.arnisdale.pl for <linux-security-module@vger.kernel.org>; Fri, 31 Mar 2023 07:45:40 GMT
Message-ID: <20230331064501-0.1.3o.181rc.0.jyj2m2pj5w@arnisdale.pl>
Date:   Fri, 31 Mar 2023 07:45:40 GMT
From:   "Maciej Telka" <maciej.telka@arnisdale.pl>
To:     <linux-security-module@vger.kernel.org>
Subject: =?UTF-8?Q?Nawi=C4=85zanie_wsp=C3=B3=C5=82pracy?=
X-Mailer: mail.arnisdale.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK,URIBL_CSS_A,URIBL_DBL_SPAM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  1.7 URIBL_BLACK Contains an URL listed in the URIBL blacklist
        *      [URIs: arnisdale.pl]
        *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: arnisdale.pl]
        *  3.6 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [151.80.133.87 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: arnisdale.pl]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Dzie=C5=84 dobry,

Czy jest mo=C5=BCliwo=C5=9B=C4=87 nawi=C4=85zania wsp=C3=B3=C5=82pracy z =
Pa=C5=84stwem?

Z ch=C4=99ci=C4=85 porozmawiam z osob=C4=85 zajmuj=C4=85c=C4=85 si=C4=99 =
dzia=C5=82aniami zwi=C4=85zanymi ze sprzeda=C5=BC=C4=85.

Pomagamy skutecznie pozyskiwa=C4=87 nowych klient=C3=B3w.

Zapraszam do kontaktu.


Pozdrawiam serdecznie
Maciej Telka
