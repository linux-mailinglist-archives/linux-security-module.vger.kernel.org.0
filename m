Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B200B26F651
	for <lists+linux-security-module@lfdr.de>; Fri, 18 Sep 2020 08:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgIRGva (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 18 Sep 2020 02:51:30 -0400
Received: from sonic302-20.consmr.mail.ne1.yahoo.com ([66.163.186.146]:34466
        "EHLO sonic302-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgIRGva (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 18 Sep 2020 02:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600411889; bh=OCp2NQ1DG8WDrE2HT9ykXjnTFISlxhUILAf78oJl1As=; h=Date:From:Reply-To:Subject:References:From:Subject; b=aELtn3XrjJ1SjxGQ6wKyrFHFDmxzfQKJZ/X0kms9jj3jG7arZw7hKkrq7O6BGlqN2ChYSWiEUOUikcSW8Kg42uy0mY0IDXc6r+xc4icTpHXqQvk7b5yCpXaOUA90SNTvoJ2qu/jG5o+7cRpdUjXEKEEhX619K8rGoO+fkkHboH1unwciziT4nQCru7kgBlENn7YaQ3NLalR5XRpFU6zslckYZlZet5tvcmkO40NK8JYR+VzcFxNy1TD0mej0tha+ERQ1d7Mfjk32tErqdtglwMpUqJc0jz/H08d3nfjQnd3R6/sV0DQ4HK2XgQ2qXSLtchVLvakfwh1PZc/Dglw0sg==
X-YMail-OSG: 8Qd_RWgVM1lfb5czY_nqA7.A_blhGvNjPpyMXDro7bJM7xhKoOSQXICnUPMsBBe
 .0X5o_Qw.XRJUmwCgg_dCo4fOLybKXCFwJzvqIyPHtbUX1WTGiUGvJI4r0rMsHI7GaJrRLZ2zj_J
 ohH8QDydvPrItl2vrcGFaUN49ceeuIx12sTT1C2G_mMYr80baaEOAES.hjR5Gay.lMY4HBj.Vtxs
 My7BCWqLukRZTrwl9_1nJw1klfnwt9Ax8iMce1OtGxc5TP5X78XkZADsQs7XPZniWWz7fH.LahPz
 3Y2VZ1Tl3szPmDa9WHSQo1OGLYuqF8XlHhugKhksnJ_EEY5kytNgOSmwT8rU1K0tF0AkgQdoar1M
 T5poAwP7yQYEooIbuRdAe.mmcbpfbIgA6eL26ZC.JTbGo_.q_KRxPFUUQj24C3dU88F5ajKp1DIU
 N.7xbjj5XTVLhnkA7lwTbHk5PAOGBE27a8sYIiNA0L2X.7bzC4zhlr938ptpTCytLJmrbi6Hwkh2
 73W2oj.VuVEHe2nz6ZbHtFT_5P1Ypavg4tI86xNgpKKB_Hh5fm5TyXCeu7lUKzpjYYLSuYxQMWKj
 eH04xo.b4aQcZn6RFVBYjqI6zxay8ftPLrmEqRR6SYQrAYNOLCwXHt0Dhx6pWIKmkuEWlcvxWjDC
 yTWivlbnxKtYOLzmqz3TITJ2lFRx27XTPjOSJQYjxAcLQHJnXWoEGwIQXK9jC6aWz0TxXCkN5A0n
 AsvICdLBkFFw53chOiEqyDoU5nfR84ndEBM1qbU3mWGg6ucewXlIa_E0ht66qXGlgDRcpILq.c_j
 rxw3UaOldW0JcB7khOz_nCsemKlaqdEa9B8UEC7LQvwOs3tLHRXz85FKMDpDSz.hPHo7yj.NbAO_
 B0Il0DgVTMMZfzCBm7Gm0.BZWIdsvj2E5ztq1k09TmenrBU9AVT1YcAx9M_0FsEzISkWsITUIzna
 WNgZDmjiwMg5MTUh1N4w0XE7CeSchxh5IwkzdxBBdpA5SkCPrcdDhrUAF8JCv6qg7IeCSW36DwRC
 MRmK4L0wJT4QqpQoxYineljnlB2h3rEijEO13yC9CVLzv6QfWbvT6owhhsDC01fp6_7r3hs3XBnL
 XQOxtFyWX79f4LsWeeDFPtcGRtmRxISA32xgDgf9tPGyXv2zCR_lkg1by0.wxvjbvXcEG2C9Ocz.
 J7eOhqEnqWXUoztoajcRHcgJYdRE86_7JkdPQkyYmjjzkiquENcoWK6Ymm5QMrCieFucVFCrVu_r
 akrWC9aM2129N9TKkQ.6w5mckble.7Ol0fCrIBg8DtihJnZCpG7pAEjng.9DfIk9iWebe9JYx4_b
 y2pAmkyd0.m_Tcmd82i2n5cIvL6iIhTaSySg90gsrkk90hEFOUc_SXvJO3c.vGm3Ob5V9JcvQ5zP
 bVOhVaNwcE1gTVjuYnPSkT0V58W.tzgqqs82pdzpI0dtxUUMRorGveGJgHrFYczkO1LOqq6FBI2g
 a96k-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Fri, 18 Sep 2020 06:51:29 +0000
Date:   Fri, 18 Sep 2020 06:51:15 +0000 (UTC)
From:   Mrs Elodie Antoine <eodieantoine@gmail.com>
Reply-To: elodieantoin678@yahoo.com
Message-ID: <840775940.3781068.1600411875390@mail.yahoo.com>
Subject: Greetings from Mrs Elodie Antoine,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <840775940.3781068.1600411875390.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



Greetings from Mrs Elodie Antoine,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS CHRIST the giver of every good thing. Good day,i know this letter will definitely come to you as a huge surprise, but I implore you to take the time to go through it carefully as the decision you make will go off a long way to determine my future and continued existence. I am Mrs Elodie Antoine
aging widow of 59 years old suffering from long time illness. I have some funds I inherited from my late husband,

The sum of (US$4.5 Million Dollars) and I needed a very honest and God fearing who can withdraw this money then use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR CHARITY WORKS. I found your email address from the internet after honest prayers to the LORD to bring me a helper and i decided to contact you if you may be willing and interested to handle these trust funds in good faith before anything happens to me.
I accept this decision because I do not have any child who will inherit this money after I die. I want your urgent reply to me so that I will give you the deposit receipt which the COMPANY issued to me as next of kin for immediate transfer of the money to your account in your country, to start the good work of God, I want you to use the 15/percent of the total amount to help yourself in doing the project.


I am desperately in keen need of assistance and I have summoned up courage to contact you for this task, you must not fail me and the millions of the poor people in our todays WORLD. This is no stolen money and there are no dangers involved,100% RISK FREE with full legal proof. Please if you would be able to use the funds for the Charity works kindly let me know immediately.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish. I want you to take 15 percent of the total money for your personal use while 85% of the money will go to charity.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish.


kindly respond for further details.

Thanks and God bless you,

Mrs Elodie Antoine
