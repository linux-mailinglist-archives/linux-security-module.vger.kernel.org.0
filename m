Return-Path: <linux-security-module+bounces-12573-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7542FC12FC0
	for <lists+linux-security-module@lfdr.de>; Tue, 28 Oct 2025 06:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81713400771
	for <lists+linux-security-module@lfdr.de>; Tue, 28 Oct 2025 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD321D5CFB;
	Tue, 28 Oct 2025 05:36:29 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from r9133.ps.combzmail.jp (r9133.ps.combzmail.jp [49.212.13.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E3E1DDA24
	for <linux-security-module@vger.kernel.org>; Tue, 28 Oct 2025 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.13.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629789; cv=none; b=jFQlhz+t3KLfa3kgsA6c8JaiThO2jc52UGFa7Ju8u3eNjl3ATxJ9I/jNy+JCK6KbFw0GsNCKGq0A5OazQy72qO/W1G5DPZW8SuUuYKUrcGpd/GVBjclJyCO4hf0gWFiFzhi1lOIM+9iewbeEDG80L3sjcne0QxUWD6CU9urQUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629789; c=relaxed/simple;
	bh=o3A7v4kMMbHvg5RU+QbHhF1eHCgCiTquvnwrBxm1rkI=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=nQDpsv9ABjJ+g89SwbGZiQodGQvyWa+YXIPqTFJDw/QjCp5hY0OqWsNH/IElH570Qpsc15e7AzrY9TLrpKjYpzctxvIrTLmvXnzhbEWxopS9ZTvT6I47hF8BGmFCUVX2DDg29bOg6s4k/wBLgewtMIuzHZWAzN9sNb1oQxpStzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=k-villageinc.jp; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=49.212.13.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=k-villageinc.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9133.ps.combzmail.jp (Postfix, from userid 99)
	id 11C9186A9B; Tue, 28 Oct 2025 14:35:57 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9133.ps.combzmail.jp 11C9186A9B
To: linux-security-module@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCM3Q8MDJxPFIbKEI=?= K Village<info@k-villageinc.jp>
X-Ip: 656592954890474
X-Ip-source: k85gj7ri48dnsax5u0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCMk4hJiVAJXMlOUV5JE4lOSUvITwlazt2GyhC?=
 =?ISO-2022-JP?B?GyRCNkgbKEIgRkMbJEJAYkxAMnEbKEI=?=
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: rix5
X-uId: 6763316643485966814650421007
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20251028053619.11C9186A9B@r9133.ps.combzmail.jp>
Date: Tue, 28 Oct 2025 14:35:57 +0900 (JST)

$B!!(B
$B!!$*@$OC$K$J$j$^$9!#(B
$B!!(B
$B!!?7$?$J;v6HE83+$r$*9M$($N7P1D<TMM$X!"(B
$B!!MD;y$+$i3X@8!"<R2q?M!"%7%K%"$^$G(B
$B!!I}9-$$@$Be$rBP>]$K$7$?%\%$%H%l!&%@%s%9%9%/!<%k;v6H$N(B
$B!!%U%i%s%A%c%$%:%7%9%F%`@bL@2q$r$40FFb?=$7>e$2$^$9!#(B

$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B
$B!!!!!!(B
$B!!!!!!(B10$B7n(B30$BF|!JLZ!K(B13:00$B!A(B14:00
$B!!!!!!(B11$B7n(B6$BF|!JLZ!K(B13:00$B!A(B14:00
$B!!!!!!(B11$B7n(B8$BF|!JEZ!K(B13:00$B!A(B14:00

$B!!"!!!%U%i%s%A%c%$%:@bL@2q(B
$B!!!!!!MD;y$+$i3X@8!"<R2q?M!"%7%K%"$^$G!*(B

$B!!!!!!%\%$%H%l!&%@%s%9$N%^%s%D!<%^%s@)%9%/!<%k;v6H(B
$B!!!!!!!H!!(BNAYUTAS$B!J%J%f%?%9!K!!!I(B

$B!!"(!!%*!<%J!<MM$K%\%$%H%l$d6H3&CN<1$J$I$OITMW$G!"(B
$B!!!!!!L$7P83$+$i3+6H$9$k$3$H$,$G$-$^$9!#(B

$B!!"!!!>\:Y!u?=9~$O$3$A$i(B
$B!!!!!!(Bhttps://nayutas-voice.biz/2500/

$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B

------------------------------------------------

$B!!(BNAYUTAS$B!J%J%f%?%9!K$O%\%$%H%l$r$O$8$a!"(B
$B!!3Z4o$d%@%s%9!"%W%m%0%i%_%s%0!"F02hJT=8$J$I!"(B
$B!!9%$-$J$3$H!&6=L#$,$"$k$3$H$rK\3JE*$K3X$Y$k(B
$B!!40A4%^%s%D!<%^%s@)%l%C%9%s$N%9%/!<%k;v6H$G$9!#(B

------------------------------------------------

$B!!3X=,=N$N$h$&$K;R$I$b$d3X@8$N$_$,BP>]$K$J$k$N$G$O$J$/!"(B
$B!!<R2q?M$d%7%K%"$b4^$a!"(B3$B:P!A(B80$B:P$NJ}$,@8EL$H$7$FDL$o$l$F$$$^$9!#(B

$B!!<}1W%b%G%k$O!V@8EL?t!_7n3[<x6HNA!W$,Gd>e$K$J$k%5%V%9%/7?$G!"(B
$B!!@8EL?t$,A}$($k$3$H$K$h$C$F!"Gd>e!&Mx1W$,3HBg$7$F$$$-$^$9!#(B

$B!!9V;U$N:NMQ$d!"3+9;8e$N@8EL=85R$N3N$+$J%N%&%O%&$b$"$k$?$a!"%*!<%J!<MM$K(B
$B!!%\%$%H%l$d6H3&CN<1$,L5$/$H$b!"L$7P83$+$i3+6H$9$k$3$H$,2DG=$G$9!#(B

$B!!%U%i%s%A%c%$%:@bL@2q$r3+:E$$$?$7$^$9$N$G!"(B
$B!!$46=L#$,$"$j$^$7$?$i$4;22C$/$@$5$$$^$;!#(B

$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B

$B!!"#!!3+:EF|Dx(B
$B!!!!!!(B10$B7n(B30$BF|!JLZ!K(B13:00$B!A(B14:00
$B!!!!!!(B11$B7n(B6$BF|!JLZ!K(B13:00$B!A(B14:00
$B!!!!!!(B11$B7n(B8$BF|!JEZ!K(B13:00$B!A(B14:00$B!!"(N>F|!"F1$8FbMF$G$9!#(B

$B!!"#!!3+:EJ}<0(B
$B!!!!!!!&%*%s%i%$%s3+:E(B

$B!!"#!!%3%s%F%s%D(B
$B!!!!!!!&F~2q<T?t$N?d0\(B
$B!!!!!!!&%J%f%?%9$NFCD'$HA*$P$l$k(B3$B$D$NM}M3(B
$B!!!!!!!&%U%i%s%A%c%$%:%7%9%F%`>\:Y(B
$B!!!!!!!&3+6HHqMQNc!?<}1WNc(B

$B!!"#!!<g:E(B
$B!!!!!!!&3t<02q<R(B K Village$B!J%J%f%?%91?1DK\It!K(B

$B!!"#!!Dj0w(B
$B!!!!!!!&(B5$B<R!?3F2s(B

$B!!"#!!;22CHq(B
$B!!!!!!!&ITMW$G$9(B

$B!!"#!!>\:Y!u?=9~$O$3$A$i(B
$B!!!!!!(Bhttps://nayutas-voice.biz/2500/

$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B
$BK\%a!<%k$,ITMW$NJ}$K$OBgJQ<:Ni$7$^$7$?!#(B
$B:#8e$40FFb$,ITMW$J:]$O!"2<5-(BURL$B$K$FG[?.Dd;_$r>5$C$F$$$^$9!#(B
https://nayutas-voice.biz/mail/
$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B
$B3t<02q<R(B K Village$B!J%J%f%?%91?1DK\It!K(B
$BEl5~ET?7=I6h@>?7=I(B2-4-1 $B?7=I(BNS$B%S%k(B7F
$B(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(,(B

