Return-Path: <linux-security-module+bounces-12018-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0737B865FA
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 20:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099A91CC4711
	for <lists+linux-security-module@lfdr.de>; Thu, 18 Sep 2025 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0D928B3E2;
	Thu, 18 Sep 2025 18:05:49 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from sub0000529476.hmk-temp.com (mail.btob-mail.work [180.222.184.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FEF2C028D
	for <linux-security-module@vger.kernel.org>; Thu, 18 Sep 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.222.184.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218749; cv=none; b=ot28ov/aPa9oVbkp6tkFDSqoIJ9nYpgymVwSvHZHTnsR3a46FFLWAYiSLlnXHVrj3Dl87igrZLceSK8UYMXt1k0R/duvEwcAsCj18Yjq8WGWmfsE88NOnXvd1OjbbA6pmtUVdapT/HXJGYnJFhCTmCS/VySELDRJ8x3mVqRjH6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218749; c=relaxed/simple;
	bh=XWhwz5XfX6dcp6E8MvIbZWFetA2FciHeSNylbn60qUY=;
	h=From:To:Subject:Content-Type:Date:Message-ID; b=C62wwBr9FBYY093t7MpQnHF2nYJSYKkK+WpLUIGH8+yaDq8XF1BCyzpS5z8QwduHK3BAZJjSy1UXpiZVpaDwtdA889PvrHg4kuVYWM8u2xoYe1xNbNC85pAf71cTwyHtMHcOJmgzx/QBuXG+niAMrAB9JHb3dfmIl32ND4VLueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=headmint.biz; spf=fail smtp.mailfrom=headmint.biz; arc=none smtp.client-ip=180.222.184.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=headmint.biz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=headmint.biz
Received: (qmail 17755 invoked from network); 18 Sep 2025 19:39:57 +0900
Received: from softbank060111101004.bbtec.net (HELO MailD-4) (60.111.101.4)
  by mail.btob-mail.work with ESMTPSA (DHE-RSA-AES256-GCM-SHA384 encrypted, authenticated); 18 Sep 2025 19:39:57 +0900
From: =?iso-2022-jp?B?GyRCJVglQyVJJV8lcyVIGyhC?= <info@headmint.biz>
To: linux-security-module@vger.kernel.org
Subject: =?iso-2022-jp?B?GyRCJCIkPyReQGxMZyROJGIkXyRbJDAkN0U5GyhCIA==?==?iso-2022-jp?B?GyRCPH0xV0AtRXkhPzM1TVc7cU5BGyhC?=
X-Mailer: Mail Magic Professional Version 16
Content-Type: text/plain;
	charset=iso-2022-jp
Date: Thu, 18 Sep 2025 20:41:43 +0900
Message-ID: <202509182041430043.2CCF147C52FC43C9B23876A9A9B6EEBF@btob-mail.work>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>

$B$*@$OC$K$J$j$^$9!#(B


$B%3%s%Q%/%H$K%9%?!<%H$G$-$F<j7x$/<}1W$r$"$2$k$3$H$N$G$-$k(B
$B%U%i%s%A%c%$%:%S%8%M%9$N;v6H35MW;qNA$r$40FFb?=$7>e$2$^$9!#(B


$B!!!!!!(B $B>.;qK\!?>.%9%Z!<%9!?>/?M?t$N(B
$B!!!!!!!!%3%s%Q%/%H!&%U%i%s%A%c%$%:(B

$B!!!!!!!!!!%I%i%$%X%C%I%9%Q@lLgE9(B
$B!!!!!!!!!!!!(B $B!H%X%C%I%_%s%H!I(B

$B!!!!!!!!!!!!!!!&<}1W%b%G%k(B
$B!!!!!!!!!!!!!!!&3+6H$KI,MW$J;q6b(B
$B!!!!!!!!!!!!!!!&%m%$%d%j%F%#(B
$B!!!!!!!!!!!!!!!&%9%1%8%e!<%k!!(Betc
$B!!!!(B $B!!!!(B $B"-!!(B FC$B;v6H35MW;qNA(B $B!!"-(B
  $B!!(B $B!!(B https://dryheadspa-hm.biz/fc/


$B%I%i%$%X%C%I%9%Q$H$O!!!=!=!=!!?e$r;H$o$J$$%X%C%I%9%Q$G$9!#(B


$BB-$D$\$d<*$D$\$J$I!"@lLg$N$b$_$[$0$7E9$,$"$j$^$9$,(B
$B$4>R2p$9$k%5%m%s$O!V!!F,$KFC2=$7$?$b$_$[$0$7E9!!!W$G$9!#(B


$B%I%i%$%X%C%I%9%Q$H$$$&%8%c%s%k$NG'CNEY$O!"(B
$B8=;~E@$G$O$=$l$[$I9b$/$"$j$^$;$s!#(B


$B$K$b4X$o$i$:!";d$I$b$,%U%i%s%A%c%$%:E83+$9$k!H%X%C%I%_%s%H!I$N(B
$BE9J^$K$O7n4V(B450$B?M0J>e$N?75,5R$,MhE9$7!"K~@J$,B3$$$F$$$^$9!#(B


$B$3$l$+$i@h!"G'CNEY$,9b$^$k$3$H$G(B
$BGzH/E*$K?-$S$k%]%F%s%7%c%k$rHk$a$F$$$^$9!#(B


$B%U%i%s%A%c%$%:$K$h$k;v6H$rE83+$7$F$$$^$9$N$G!"(B
$B?7$?$J<}1W$E$/$j$r$*9M$($NJ}$O!"$^$:$O35MW;qNA$r$4Mw$/$@$5$$!#(B


$B!!!!!!!!!!%I%i%$%X%C%I%9%Q@lLgE9(B
$B!!!!!!!!!!!!!!!!%X%C%I%_%s%H(B
$B!!!!!!(B
$B!!!!(B $B!!!!(B $B"-!!(B FC$B;v6H35MW;qNA(B $B!!"-(B
  $B!!(B $B!!(B https://dryheadspa-hm.biz/fc/


$B$h$m$7$/$*4j$$$7$^$9!#(B


------------------------------------------
$B!!3t<02q<R$8$`$d(B
$B!!0&CN8)L>8E20;TCf6hBg?\(B3-26-41$BKYED%S%k(B
$B!!(BTEL$B!'(B052-263-4688
------------------------------------------
$B!!K\>pJs$,$4ITMW$JJ}$K$O$4LBOG$r$*$+$1$7?=$7Lu$4$6$$$^$;$s!#(B
$B!!%a!<%k%^%,%8%s$N2r=|$O!"2<5-(BURL$B$K$F>5$C$F$*$j$^$9!#(B
$B!!(B https://dryheadspa-hm.biz/mail/
$B!!$*<j?t$*3]$1$7$^$9$,$h$m$7$/$*4j$$$7$^$9!#(B

