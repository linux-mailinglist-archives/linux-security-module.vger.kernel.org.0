Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3D810E319
	for <lists+linux-security-module@lfdr.de>; Sun,  1 Dec 2019 19:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfLAS2Q (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Sun, 1 Dec 2019 13:28:16 -0500
Received: from mtax.cdmx.gob.mx ([187.141.35.197]:12185 "EHLO mtax.cdmx.gob.mx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfLAS2Q (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 1 Dec 2019 13:28:16 -0500
X-Greylist: delayed 7072 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Dec 2019 13:28:15 EST
X-NAI-Header: Modified by McAfee Email Gateway (4500)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cdmx.gob.mx; s=72359050-3965-11E6-920A-0192F7A2F08E;
        t=1575217636; h=DKIM-Filter:X-Virus-Scanned:
         Content-Type:MIME-Version:Content-Transfer-Encoding:
         Content-Description:Subject:To:From:Date:Message-Id:
         X-AnalysisOut:X-AnalysisOut:X-AnalysisOut:
         X-AnalysisOut:X-AnalysisOut:X-SAAS-TrackingID:
         X-NAI-Spam-Flag:X-NAI-Spam-Threshold:X-NAI-Spam-Score:
         X-NAI-Spam-Rules:X-NAI-Spam-Version; bh=M
        8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs4
        8=; b=fjwJ06VLcaQ+qdmvn3awRq+LGr1B1BJV7doxr8x9GBiE
        nfnqZ7MXcaxUDgccidjDVEKzPTs6hfnYClbglV06DK79F/rFhE
        HbmUBrtu17RO8PdCjklwFchn3PWNb75mvXpW8GZ6Jsoqt+RDSz
        hbtioPfY9QyiJ0mJ58J7+8hV6cI=
Received: from cdmx.gob.mx (correo.cdmx.gob.mx [10.250.108.150]) by mtax.cdmx.gob.mx with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 217f_63f3_20f55a2d_bef2_4048_9893_66ad7c7d3b63;
        Sun, 01 Dec 2019 10:27:16 -0600
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 91D481E21CB;
        Sun,  1 Dec 2019 10:18:50 -0600 (CST)
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id v0p_IgkHLo7b; Sun,  1 Dec 2019 10:18:50 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 4751E1E274D;
        Sun,  1 Dec 2019 10:14:17 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 4751E1E274D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=72359050-3965-11E6-920A-0192F7A2F08E; t=1575216857;
        bh=M8rWdUYQ57RAYAgTWJQ4Rsch0kO0UXllaAVDzocOs48=;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:To:
         From:Date:Message-Id;
        b=sFEblJTR75SnwbaMgVfur9Id8T7F+WHe9/L0+ZBx1oFp5kOAdndWBw1PJz/ptUxqL
         vnvgKmv5YcjZYLDiAxyjTPij+FG5zX51x0Ikv403gQ6ynagbMBg8PmQRnsQa/llvEv
         8qA80KGy50ndLIJTT8o5nbb2+jTmfcbXzV49LG9Q=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yHiivamYxpY1; Sun,  1 Dec 2019 10:14:17 -0600 (CST)
Received: from [192.168.0.104] (unknown [188.125.168.160])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 1AF961E2565;
        Sun,  1 Dec 2019 10:05:20 -0600 (CST)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Congratulations
To:     Recipients <aac-styfe@cdmx.gob.mx>
From:   "Bishop Johnr" <aac-styfe@cdmx.gob.mx>
Date:   Sun, 01 Dec 2019 17:05:13 +0100
Message-Id: <20191201160521.1AF961E2565@cdmx.gob.mx>
X-AnalysisOut: [v=2.2 cv=ONdX5WSB c=1 sm=1 tr=0 p=6K-Ig8iNAUou4E5wYCEA:9 p]
X-AnalysisOut: [=zRI05YRXt28A:10 a=T6zFoIZ12MK39YzkfxrL7A==:117 a=9152RP8M]
X-AnalysisOut: [6GQqDhC/mI/QXQ==:17 a=8nJEP1OIZ-IA:10 a=pxVhFHJ0LMsA:10 a=]
X-AnalysisOut: [pGLkceISAAAA:8 a=wPNLvfGTeEIA:10 a=M8O0W8wq6qAA:10 a=Ygvjr]
X-AnalysisOut: [iKHvHXA2FhpO6d-:22]
X-SAAS-TrackingID: 2e9e3ed5.0.105119256.00-2255.176728427.s12p02m015.mxlogic.net
X-NAI-Spam-Flag: NO
X-NAI-Spam-Threshold: 3
X-NAI-Spam-Score: -5000
X-NAI-Spam-Rules: 1 Rules triggered
        WHITELISTED=-5000
X-NAI-Spam-Version: 2.3.0.9418 : core <6686> : inlines <7165> : streams
 <1840193> : uri <2949750>
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Money was donated to you by Mr and Mrs Allen and Violet Large, just contact=
 them with this email for more information =


EMail: allenandvioletlargeaward@gmail.com
