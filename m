Return-Path: <linux-security-module+bounces-4443-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9909938A51
	for <lists+linux-security-module@lfdr.de>; Mon, 22 Jul 2024 09:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8510F2816CF
	for <lists+linux-security-module@lfdr.de>; Mon, 22 Jul 2024 07:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4569513D8B0;
	Mon, 22 Jul 2024 07:42:24 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from r9204.ps.combzmail.jp (r9204.ps.combzmail.jp [160.16.62.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142012B63
	for <linux-security-module@vger.kernel.org>; Mon, 22 Jul 2024 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.16.62.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721634144; cv=none; b=eI5NZd+3IDTMrk4Puu1VU/MTzQUUfU4Ba8kED3kTMK4KAfk4Q6/aJPJItOHGM/vxRmRc737epDuuta/1pWObucq1acHZuPj9rKclVcRosq7qg/Wl5oHQEruztitOjMz/nNKhKFzy/1+mzuDrAZLutP01h0cPb3LzCGB2btMWAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721634144; c=relaxed/simple;
	bh=bRnKA1Qcfy1z90LiBUXZMV7ptIgCu4NUBAo9hBW3BGg=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=BHFt8NLgHl0liJ9NoXZ+Eucj1sBZ/Ojf665+o12OleZg/lDWEZMG9lF8rDtxUxSqfq1GD+GgOqJqKE39efG9D1Gv+CZ5DInnFCeTYDnTmcfzQcfmUFeEeC4M6nKN21k4to197u1gOOFQops4I/wuqbjVyWQKTbC7YjnPi5N1auU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c-united-coffee.jp; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=160.16.62.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c-united-coffee.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9204.ps.combzmail.jp (Postfix, from userid 99)
	id B5588103670; Mon, 22 Jul 2024 16:30:53 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9204.ps.combzmail.jp B5588103670
To: linux-security-module@vger.kernel.org
From: info@c-united-coffee.jp<info@c-united-coffee.jp>
X-Ip: 782267939100313
X-Ip-source: k85gj72648dnsa00u0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCMzkkTjpiOzokSyRKJGs1SkNjRTk7djZIGyhC?=
 =?ISO-2022-JP?B?GyRCISEbKEJGQxskQiVRITwlSCVKITxKZz04GyhC?=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: 2600
X-uId: 6762286045485863754554561029
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20240722073110.B5588103670@r9204.ps.combzmail.jp>
Date: Mon, 22 Jul 2024 16:30:53 +0900 (JST)

$B!=!!AO6H(B54$BG/!!@N2{$+$7$$L#$o$$$N5JCcE9(B
$B!!!!!H!!`]`j4[!!!I(B
$B!!!!$K$F!"%U%i%s%A%c%$%:2CLAE9$rJg=8$7$F$$$^$9!#(B



$B$$$D$b$*@$OC$K$J$j$^$9!#(B


$B?75,;v6H$r$48!F$$N%S%8%M%9%*!<%J!<MM8~$1$K(B
$B%U%i%s%A%c%$%:;v6H$N%;%_%J!<$r$40FFb?=$7>e$2$^$9!#(B


$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B



$B!!AO6H(B54$BG/!!@N2{$+$7$$L#$o$$$N5JCcE9(B
$B!!!H!!`]`j4[!!!I(B

$B!!%U%i%s%A%c%$%:%Q%C%1!<%8(B $B!C(B $B%*%s%i%$%s@bL@2q(B



$B!!"'!!>\:Y!u?=9~%Z!<%8(B
$B!!(Bhttps://coffee-kan-fc.jp/seminar/


$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B


$B!!"#3+:EF|Dx!!!!!'!!(B8$B7n(B29$BF|!JLZ!K(B14$B;~!A(B15$B;~(B
$B!!"#3+:EJ}<0!!!!!'!!%*%s%i%$%s!J(BZoom$B!K(B
$B!!"#;22CHq!!!!!!!'!!L5NA(B
$B!!"#Dj0w!!!!!!!!!'!!(B30$B<R(B
$B!!"#%W%l%<%s%?!<!'!!(BC-United$B3t<02q<R!J`]`j4[(BFC$BK\It!K(B


$B!!"'!!>\:Y!u?=9~%Z!<%8(B
$B!!(Bhttps://coffee-kan-fc.jp/seminar/


$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B



$B!=!!39$N:b;:$H$J$k!"@N2{$+$7$$L#$o$$$N5JCcE9$r;O$a$^$;$s$+!)!!!=(B


$B$f$C$/$j$H$7$?FI=q$N;~4V$r2a$4$7$?$$J}(B
$BM'?M$H$N8l$i$$$N;~4V$r3Z$7$_$?$$J}(B
$B%b!<%K%s%0$d%i%s%A$G$7$C$+$j?);v$r$7$?$$J}(B
$B$=$7$F!"<gLr$N%3!<%R!<$r3Z$7$_$?$$J}(B


$B!V`]`j4[!W$O(B50$BG/0J>e$b$N4V!"0lGU$N%3!<%R!<$rDL$8$F(B
$B$?$/$5$s$N$*5RMM$N!"$"$i$f$k%7!<%s$r$40l=o$5$;$F$$$?$@$-$^$7$?!#(B


$B!H39$N:b;:$H$J$k$*E9$E$/$j!I(B


$B$"$J$?$NCO85$K!"!V`]`jJ82=!W$r46$8!"(B
$B<u$17Q$,$l$F$$$/B8:_!a:b;:$r:,IU$+$;$^$;$s$+!)(B


$B;d$?$A(BC-United$B$O!"$3$NA[$$$K6&46$$$?$@$1$k4k6HMM$N(B
$B%U%i%s%A%c%$%:2CLA$rJg=8$7$F$$$^$9!#(B


$B`]`j4[$K$O!"(B50$BG/0J>e$K$o$?$C$FC_@Q$5$l$?!V@.8y$N%N%&%O%&!W$,$"$j!"(B
$B0{?)6HL$7P83$N4k6HMM$G$b!"3+E9=`Hw$+$i1?1D$K;j$k$^$G(B
$B@lB0%A!<%`$K$h$k6(NO$J%5%]!<%H$r<u$1!"0B?4$7$F3+E9$r7^$($i$l$^$9!#(B


$B$3$N@bL@2q$G$O!"(BC-United$B$,Ds6!$9$k`]`j4[$N(B
$B%U%i%s%A%c%$%:%Q%C%1!<%8$r$*EA$($7$^$9!#(B


$B?75,;v6H$r8!F$$7$?$$(B
$B4{B8;v6H$K5JCc;v6H$r!\&A$7$FAj>h8z2L$rF@$?$$(B
$BM75YITF0;:$r3hMQ$7$?$$(B
$BCO0h9W8%$N0Y$N5JCcE9$r=PE9$7$?$$(B


$B$H$*9M$($N4k6H%*!<%J!<MM$O!"$3$N5!2q$K$<$R@bL@2q$X$4;22C$/$@$5$$!#(B



$B!!"'!!>\:Y!u?=9~%Z!<%8(B
$B!!(Bhttps://coffee-kan-fc.jp/seminar/



$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B
$BK\%a!<%k$,ITMW$NJ}$K$OBgJQ<:Ni$7$^$7$?!#(B
$B:#8e$40FFb$,ITMW$J:]$O!"2<5-(BURL$B$K$FG[?.Dd;_$r>5$C$F$$$^$9!#(B
https://coffee-kan-fc.jp/mail/
$B$^$?!"K\%a!<%k$K$=$N$^$^!"7oL>$K!VG[?.Dd;_!W$H$4F~NO$N$&$((B
$B$4JV?.$$$?$@$1$l$PG[?.Dd;_EPO?$r$$$?$7$^$9!#(B
$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B
C-United$B3t<02q<R(B
$BEl5~ET9A6h<GBgLg(B2$BCzL\(B10$BHV(B12$B9f(B KDX$B<GBgLg%S%k(B 1$B3,!&(B9$B3,(B
TEL: 03-6206-0347
$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B

