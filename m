Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99665A7D00
	for <lists+linux-security-module@lfdr.de>; Wed, 31 Aug 2022 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiHaMN7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 Aug 2022 08:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHaMNz (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Aug 2022 08:13:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E742BD31D1
        for <linux-security-module@vger.kernel.org>; Wed, 31 Aug 2022 05:13:53 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=jLm8WpmqtuKUUJZp7SV5KXcFFOkpIvXzXodL1BfXv+GLCNhufqEJpgB3iSB/qAD/ZUe/JhuIdBhx+BynbZmkp6SZJRh/NGliQZujxiWWU/VXW1fI5kPkL873T5YqwmIdc5c1SDP83rzZe5ghkj8Ko+Q4RqHzIt1VhtJ9aj1h9cwMSoy96Ri7MSo3wWQHGprGcCTEmQyjc9BraGY1NI6IeMpqEvXbjjmQQbP0D5lVOtJEAj26IMwKo6DFISOJBHC5nYeLwzTb0BiB8cxq2HTBzrveGnaSbHIlHrVHUC0I8FII5gOt6yojCnq6vxLuzGVuhhxEjbdmQu1lKgMYs0/Ovg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gKgTXw0dDyYifeLhgt9D4StQJQn3mYwNo0CpZgQ+G8=;
 b=l518CN8r0xz/Ai4tD6Bfy4dDZbYtS1eKw1N0nIXeVVKRWgbeSHr/2i8R5Ua6S9QH5bkxwiFhTGSg6cs7RMG6qcMHr29huJ9AezOKQDZudzbrJC0gzwFYc/qV9/rz4aGZN8t4ieKcHSYoa1O/HmAPA77P3yG2eHy/VDeq3LocaigRQ59DQuwU6NiE837MTj1RA2i71OVm0qus0lYt0A6Nfs7XUAQIvPOsGd8gbQ0pGkYM2udklOKBv+p3O479ZUFjmONCwwrmdnuE3UepDzCP6bU0EiHZfANc8UO0s5O2vSxFxD85kdmSxhw3FkhjtBmwT7kwP4zUWwt5dSPIdr7PGg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 4.79.107.243) smtp.rcpttodomain=schaufler-ca.com
 smtp.mailfrom=elektrobit.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.onmicrosoft.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=elektrobit.com] dkim=[1,1,header.d=elektrobit.com]
 dmarc=[1,1,header.from=elektrobit.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=elektrobit.onmicrosoft.com; s=selector2-elektrobit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gKgTXw0dDyYifeLhgt9D4StQJQn3mYwNo0CpZgQ+G8=;
 b=EgjmduuxUYn8Jyhhfo5P43XsxJz+cjxdnAyZOZW31um/E2ZC9ZxG7QLa/xeLQ8zA2aABdy9mxo+hrDntnrvf3qMfnfSwqsyqvRewtRdvZXlbQDlcW3KaqJjWkuxC5PAZtbVWIfM0htjoibQrYh5MmPKIzQrK1dbCquIRpKs+JeQ=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by CY1PR0801MB2235.namprd08.prod.outlook.com (2a01:111:e400:c614::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 12:13:52 +0000
Received: from MW2NAM12FT062.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::c) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 12:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 4.79.107.243)
 smtp.mailfrom=elektrobit.com; dkim=pass (signature was verified)
 header.d=elektrobit.onmicrosoft.com;dmarc=fail action=none
 header.from=elektrobit.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 elektrobit.com discourages use of 4.79.107.243 as permitted sender)
Received: from usbth1es003.ebgroup.elektrobit.com (4.79.107.243) by
 MW2NAM12FT062.mail.protection.outlook.com (10.13.181.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.3 via Frontend Transport; Wed, 31 Aug 2022 12:13:52 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05lp2110.outbound.protection.outlook.com [104.47.18.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by usbth1es003.ebgroup.elektrobit.com (Postfix) with ESMTPS;
        Wed, 31 Aug 2022 05:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmSCyntsu4ykepZqC2Y2wHUddY1OET8pfi33Rzcdev2O34OqfnTUv/2Dn280vE9nXAZuu5TElHeKUU/4Y/BCN1UOYMDTdnBeazWgikjB5eqYWDObXBBm3ZXaYQfnkevq1sgPo84+Vf0beYFfMQI7nEq3RjG/c7tks03gDOf4tfS8luiHX8atAX5+CjnX6DN0RLjZhgeABfiAQyPqBDuYL6Bp4kIxjiXOIhIVlWhOHABXc+ZEBKY9gHo4cQeQKa/iwv2ExBXTmTl85Aps5PJr3j4jO/kO0xCaXvxesKAF8C7qZvhszjBuq9Yw0bjORNzF0/zQZ4xCXuue43ULg2Q/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gKgTXw0dDyYifeLhgt9D4StQJQn3mYwNo0CpZgQ+G8=;
 b=RWqt5Y4b3CDAf9Gz8pwC9GxCzjl/D2NFUIrZmkXeEa2lin0QjSkbnRloc8DCPGthr1Sx5Ec4JY0yGaS7CE5hxeqXyWS8SgpIjZWSIlrJaYg7sPIiwO7huJtdUWSAwBpkNIGcokSpk2ByJgfPep4VIvS87rRigTw3ConPxkoD8OmdWmutdyYN+Rn3jfHaWEsCoIUNHVLi5KQk36qeHPvcFVNSZH3giIcVR2EywFSQukV+Vkkqj0cOwkL5GpTFvEsax0grZZ9pduWPZWvj4c21LFw+L41jqN9t2kiqjICAIhYRFoo4407bepMXCeiO0Z98C3D8f4XhNieIDgxeGiNpmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=elektrobit.com; dmarc=pass action=none
 header.from=elektrobit.com; dkim=pass header.d=elektrobit.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=elektrobit.onmicrosoft.com; s=selector2-elektrobit-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gKgTXw0dDyYifeLhgt9D4StQJQn3mYwNo0CpZgQ+G8=;
 b=EgjmduuxUYn8Jyhhfo5P43XsxJz+cjxdnAyZOZW31um/E2ZC9ZxG7QLa/xeLQ8zA2aABdy9mxo+hrDntnrvf3qMfnfSwqsyqvRewtRdvZXlbQDlcW3KaqJjWkuxC5PAZtbVWIfM0htjoibQrYh5MmPKIzQrK1dbCquIRpKs+JeQ=
Received: from DU0P195MB1628.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3a4::7) by
 AS4P195MB1573.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4bf::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Wed, 31 Aug 2022 12:13:49 +0000
Received: from DU0P195MB1628.EURP195.PROD.OUTLOOK.COM
 ([fe80::a80c:b4dd:1e36:88f]) by DU0P195MB1628.EURP195.PROD.OUTLOOK.COM
 ([fe80::a80c:b4dd:1e36:88f%7]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 12:13:49 +0000
From:   "Lontke, Michael" <Michael.Lontke@elektrobit.com>
To:     "casey@schaufler-ca.com" <casey@schaufler-ca.com>
CC:     "Ostertag, Martin" <Martin.Ostertag@elektrobit.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        =?utf-8?B?V2Vpw58sIFNpbW9uZQ==?= <Simone.Weiss@elektrobit.com>,
        "Valleru, Yuvarajesh" <Yuvarajesh.Valleru@elektrobit.com>,
        "Irgang, Thomas" <Thomas.Irgang@elektrobit.com>
Subject: Re: SMACK LSM checks wrong object label during ingress network
 traffic
Thread-Topic: SMACK LSM checks wrong object label during ingress network
 traffic
Thread-Index: AQHYuGSajWIvX43eyUywpT/36FKxza2/xo0AgAEXoICAAH8fAIAF2CQAgABNHwCAAXLnAA==
Date:   Wed, 31 Aug 2022 12:13:48 +0000
Message-ID: <6324997ce4fc092c5020a4add075257f9c5f6442.camel@elektrobit.com>
References: <0ff932aeb13400fcbb8b1ce346504e860cb031b9.camel@elektrobit.com>
         <7fabf823-bdac-789a-09fb-325e60e79976@schaufler-ca.com>
         <0e3266a5c93229b29c10a0a7b68232000453aabf.camel@elektrobit.com>
         <2d4958bd-dc67-8244-c688-eed4feb64ba8@schaufler-ca.com>
         <61f18d5513bdb68748e635470a41eb4e2dadb915.camel@elektrobit.com>
         <f6649421-a901-de54-ece6-ae107c0ff1cc@schaufler-ca.com>
In-Reply-To: <f6649421-a901-de54-ece6-ae107c0ff1cc@schaufler-ca.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=elektrobit.com;
X-MS-Office365-Filtering-Correlation-Id: 515e543b-b5e0-4a77-1d5a-08da8b4a44a3
x-ms-traffictypediagnostic: AS4P195MB1573:EE_|MW2NAM12FT062:EE_|CY1PR0801MB2235:EE_
X-SM-outgoing: yes
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: CrD64huelFGE/s+lKUGVJk5HEh41uVPPXKZ8DO5lsAXSvzDV+LPN1mucuZphkrqQsFjLOCLJw1X35ys55zdF2FgEwGBGID/arkHJKkTIqb0DQxEe65+MOLg9q7mBSg8xJXmOkRHV+b6uKAYBAtIKIsoGrC6xBsEBuCnQEn6v/s+iFr3eYL4ZwlaniYrit2iDscClHGPLjgEr4ExCHX9vrY6pvS7L29yvql9eVbAUt7xirr7/mPOtpQ484+08vkdNHPSg+ifPOFT2vLrRC9/GUIRVZrrx0o4zDXt0jj4q1LIpLBEbOQ3eMENgCw1koaZcKWzxzelj40Dlay1IJnipvDGUx89NSIXbdwXT6Bb9eQJGOS/z92SzWFutbNWpU+44fopQxU6KGLaIMDktP1tCQxTRle8v5UGDJJLNt7s4SF4Pl3qu22mROAXiOp/Cb7t1W5+QlcV3Sxsfd+9n70KgFU55xw0aleTTTqQAUGj7CGQuHQM1Mk5qpBzo/qx4C8TKHAnk+lL7eyoqbpHk22Q57uRYsFVPmJlNOqGDhjO2yKRVhqL7TiIRzgJHv4gSym1JQk4h0qv0JyoYko1AlyacbLJqMT4zZsMJ8wkbHH3n5rYY7Bcp/711KJ8TpNyrXeg3TyySe7vXdco9/1622OMC1o2RJ5wHh0YnuOLNWjSMa1ja5bh5ezITuprA7iuhl5hWCVlXYhCGIxc88/H6OssupLuNAtudh8GqSdOc89XpypbYE0Mrn66MapT5IxNG4N8J343XbjG1HHtV/XOBtZknNg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0P195MB1628.EURP195.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39850400004)(366004)(376002)(346002)(396003)(2906002)(38100700002)(86362001)(91956017)(4326008)(66946007)(64756008)(66476007)(66446008)(76116006)(66556008)(8676002)(316002)(38070700005)(6916009)(54906003)(6512007)(2616005)(186003)(83380400001)(107886003)(53546011)(5660300002)(30864003)(478600001)(122000001)(6486002)(71200400001)(6506007)(41300700001)(36756003)(8936002);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <072686E69DE34C42823E37A4339ED54E@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1573
X-SM-smarthost: [elektrobit-com.mail.protection.outlook.com]
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MW2NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 533791d4-6e65-430d-2f68-08da8b4a42b0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFKiokIURl9b1EF7rsi2PF4EOzDgKxnKBjcK/fF/5kqXU9Fz8oERFZS0HRlFnUr6PkQjMGFQqMemt58xVvWJxBLb1Z8WITpKUFdRS1etktmm11CaKe6C8aayt/5q1eFaf3cEsVseBdW0QYFRCO9J/0D1xToUe5i7tsFyoTFiHJEwggbuiGn6wdhwJTqk81c0mIwtvYXnqio2DgNC2ERTQHOVd5TyLa72lA3ipbotZ2ByuokvwzCgtOmAmBZbIKyHjbG1Y3I+ZM7kFjOfDRLodmxgc7eExc4InHz6cNqVtuDYvhOMiD4coQfjflhdT6VGcAfDIFR0kMOI6tI69ugsEgVvTpUwt5wn4o5AHagDfRmgJhntROqlrQC+hpHi5SNhOx1O5O9fNDknBGRchsc/Qqku4uaBgLOaR+0sme385W8pGxkM0oF2N9z1INE4LyhjveGvUncyQuvcia+vEDydRXrNTeIBhKzSXP4wgu/RHLB4y8vSCvUEIJTvhRbiyA6phi1Uhu5q2SKxSO40iM2L5XsProzNDxWSbjJjt+gvsCGo2qqx6Z8HQEVpO4noka/0+SdGBrRCYcgIy9Yk5UHY0fBJ0eJpiAHT9L+TujYcXtFmBU8X2LDujMwkySuL9+dy6YB93FVW0+KaXV3Ehr/86VQ7kgjbAU7jamxFSQHj0JILBdCQGlOgKP2SASnCETjlSVqQR75SASzrmEhAhzW3m197uOiFBQuwk3lVfU0ehUwcuYfErZAVkFd3NHbsX+BY7aVIXRYKbVVsF0N6Ju03Zt17J6KAWHQcPFYpFbHx8zLW4V99/G0z/IzPUMGVsaTJ
X-Forefront-Antispam-Report: CIP:4.79.107.243;CTRY:CA;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usbth1es003.ebgroup.elektrobit.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39850400004)(376002)(346002)(136003)(40470700004)(36840700001)(46966006)(6512007)(82310400005)(356005)(82740400003)(41300700001)(8936002)(81166007)(5660300002)(30864003)(86362001)(40460700003)(478600001)(53546011)(70206006)(2616005)(26005)(8676002)(2906002)(70586007)(4326008)(107886003)(36756003)(6486002)(336012)(40480700001)(186003)(47076005)(54906003)(6506007)(83380400001)(36860700001)(6916009)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: elektrobit.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 12:13:52.1415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515e543b-b5e0-4a77-1d5a-08da8b4a44a3
X-MS-Exchange-CrossTenant-Id: e764c36b-012e-4216-910d-8fd16283182d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e764c36b-012e-4216-910d-8fd16283182d;Ip=[4.79.107.243];Helo=[usbth1es003.ebgroup.elektrobit.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT062.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0801MB2235
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDA3OjA2IC0wNzAwLCBDYXNleSBTY2hhdWZsZXIgd3JvdGU6
DQo+IE9uIDgvMzAvMjAyMiAyOjMwIEFNLCBMb250a2UsIE1pY2hhZWwgd3JvdGU6DQo+ID4gT24g
RnJpLCAyMDIyLTA4LTI2IGF0IDA5OjE1IC0wNzAwLCBDYXNleSBTY2hhdWZsZXIgd3JvdGU6DQo+
ID4gPiBPbiA4LzI2LzIwMjIgMTo0MCBBTSwgTG9udGtlLCBNaWNoYWVsIHdyb3RlOg0KPiA+ID4g
PiBPbiBUaHUsIDIwMjItMDgtMjUgYXQgMDg6NTkgLTA3MDAsIENhc2V5IFNjaGF1ZmxlciB3cm90
ZToNCj4gPiA+ID4gPiBPbiA4LzI1LzIwMjIgMjoyNSBBTSwgTG9udGtlLCBNaWNoYWVsIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gSGVsbG8gTXIuIFNjaGF1ZmxlciwNCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gd2Ugb2JzZXJ2ZWQgdGhlIGZvbGxvd2luZyBiZWhhdmlvciBvZiB0aGUgU01BQ0sgTFNN
IGtlcm5lbA0KPiA+ID4gPiA+ID4gZmVhdHVyZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
UFJPQkxFTTogU01BQ0sgTFNNIGlzIGNoZWNraW5nIHRoZSB3cm9uZyBsYWJlbCB3aGVuDQo+ID4g
PiA+ID4gPiByZWNlaXZpbmcNCj4gPiA+ID4gPiA+IG5ldHdvcmsNCj4gPiA+ID4gPiA+IHBhY2tl
dHMgZHVyaW5nIGhpZ2ggc3lzdGVtIGxvYWQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEZ1
bGwgRGVzY3JwaXRpb24gb2YgdGhlIFByb2JsZW06IER1cmluZyBhIHRlc3Qgc2NlbmFyaW8NCj4g
PiA+ID4gPiA+IGludm9sdmluZw0KPiA+ID4gPiA+ID4gaGlnaA0KPiA+ID4gPiA+ID4gc3lzdGVt
IGxvYWQgKGNwdSwgbWVtb3J5IGFuZCBpbykgaW4gY29tYmluYXRpb24gd2l0aA0KPiA+ID4gPiA+
ID4gaW5ncmVzcw0KPiA+ID4gPiA+ID4gdGNwDQo+ID4gPiA+ID4gPiBuZXR3b3JrIHRyYWZmaWMs
IFNNQUNLIGlzIGNoZWNraW5nIHdyb25nIG9iamVjdCBsYWJlbHMNCj4gPiA+ID4gPiA+IGxlYWRp
bmcNCj4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiBkZW5pZWQgYWNjZXNzIGZvciB2YWxpZCBz
Y2VuYXJpb3MuDQo+ID4gPiA+ID4gPiBJbiBiZWxvdyB0ZXN0IHNjZW5hcmlvIHRoZSBsYWJlbCAn
c3RyZXNzdGVzdCcgaXMgb25seSB1c2VkDQo+ID4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiA+IHRo
ZQ0KPiA+ID4gPiA+ID4gYXBwbGljYXRpb24gJ3N0cmVzcycgYnV0IGFwcGVhcnMgaW4gU01BQ0sg
YXVkaXQgbG9ncyBhcw0KPiA+ID4gPiA+ID4gb2JqZWN0DQo+ID4gPiA+ID4gPiB0b2dldGhlcg0K
PiA+ID4gPiA+ID4gd2l0aCBuZXRsYWJlbHMuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRo
aXMgaXNzdWUgaW5pdGlhbGx5IGFwcGVhcmVkIG9uIGhhcmR3YXJlIHdpdGgga2VybmVsDQo+ID4g
PiA+ID4gPiB2ZXJzaW9uDQo+ID4gPiA+ID4gPiA0LjE0LjIzNw0KPiA+ID4gPiA+ID4gYnV0IHdh
cyBhbHNvIGJlaW5nIHJlcHJvZHVjZWQgd2l0aCBxZW11IGZvciBrZXJuZWwgdmVyc2lvbg0KPiA+
ID4gPiA+ID4gNC4xNC4yOTANCj4gPiA+ID4gPiA+IGFuZA0KPiA+ID4gPiA+ID4gbGF0ZXN0IDYu
MC1yYzIuIFRoZSB1c2VkIHJvb3RmcyB3YXMgZ2VuZXJhdGVkIHZpYSBidWlsZHJvb3QNCj4gPiA+
ID4gPiA+IHZlcnNpb24NCj4gPiA+ID4gPiA+IDIwMjIuMDgtcmMxLg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEtFWVdPUkRTOiBzbWFjaywgbmV0d29ya2luZw0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBLRVJORUwgSU5GT1JNQVRJT046IExpbnV4IHN0YWJsZSBr
ZXJuZWwNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gS0VSTkVMIFZFUlNJT046IDQuMTQuMjM3
LCA0LjE0LjI5MCwgNi4wLXJjMg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IEtFUk5FTCBDT05GSUc6IHNtYWNrIHJlbGF0ZWQga2VybmVsIGNvbmZpZ3VyYXRpb24NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQ09ORklHX05FVExBQkVMPXkNCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gQ09ORklHX1NFQ1VSSVRZX05FVFdPUks9eQ0KPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiBDT05GSUdfU0VDVVJJVFlfU01BQ0s9eQ0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBDT05GSUdfREVGQVVMVF9TRUNVUklUWV9TTUFDSz15DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IENPTkZJR19ERUZBVUxUX1NFQ1VSSVRZPSJzbWFjayINCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBXaGF0IGlzIHRoZSB2YWx1ZSBmb3IgQ09ORklHX1NFQ1VSSVRZX1NNQUNLX05FVEZJTFRFUiA/
DQo+ID4gPiA+IA0KPiA+ID4gPiAjIENPTkZJR19ORVRXT1JLX1NFQ01BUksgaXMgbm90IHNldA0K
PiA+ID4gPiB0aGVyZWZvcmUgQ09ORklHX1NFQ1VSSVRZX1NNQUNLX05FVEZJTFRFUiBpcyBub3Qg
c2V0IGFzIHdlbGwuDQo+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSBpbXBsZW1lbnRhdGlvbiBmb3Ig
SVB2NiBpcyBtdWNoIG1vcmUgcm9idXN0IGZvciB0aGUNCj4gPiA+ID4gPiBuZXRmaWx0ZXIgZW5h
YmxlZCBwYXRoLg0KPiA+ID4gPiANCj4gPiA+ID4gWW91IGFyZSBzdGF0aW5nIHRoYXQNCj4gPiA+
ID4gDQo+ID4gPiA+IENPTkZJR19ORVRXT1JLX1NFQ01BUks9eQ0KPiA+ID4gPiBDT05GSUdfU0VD
VVJJVFlfU01BQ0tfTkVURklMVEVSPXkNCj4gPiA+ID4gDQo+ID4gPiA+IGFuZCB0aGVyZWZvcmUg
dXNpbmcgU01BQ0tfSVBWNl9TRUNNQVJLX0xBQkVMSU5HIGluc3RlYWQgb2YNCj4gPiA+ID4gU01B
Q0tfSVBWNl9QT1JUX0xBQkVMSU5HIHBhdGggaW4ga2VybmVsIGNvZGUgaXMgbW9yZSByZWxpYWJs
ZT8NCj4gPiA+IA0KPiA+ID4gWWVzLiBUaGUgbmV0ZmlsdGVyIHZlcnNpb24gaXMgdXNlZCBpbiBh
bGwga25vd24gY29tbWVyY2lhbA0KPiA+ID4gZGVwbG95bWVudHMNCj4gPiA+IG9mIFNtYWNrLCBh
bmQgaGVuY2UgaGFzIGdvdHRlbiBtb3JlIGF0dGVudGlvbi4gVGhlIHBvcnQgbGFiZWxpbmcNCj4g
PiA+IGNvZGUNCj4gPiA+IGlzIGEgImNsZXZlciBoYWNrIi4gSSBob3BlIHRvIHJlcGxhY2UgaXQg
d2l0aCBDQUxJUFNPIG5vdyB0aGF0DQo+ID4gPiBDQUxJUFNPDQo+ID4gPiBpcyBzdXBwb3J0ZWQg
YnkgbmV3bGFiZWwuDQo+ID4gPiANCj4gPiANCj4gPiBUb2RheSBJIHRlc3RlZCB3aXRoIHlvdXIg
c3VnZ2VzdGVkIGNvbmZpZ3VyYXRpb24gKHNlY21hcmsgKw0KPiA+IG5ldGZpbHRlcikuDQo+ID4g
RXhlY3V0aW5nIHRoZSBzYW1lIHRlc3QgY2FzZSBJIHJ1biBpbnRvIGFsbW9zdCB0aGUgc2FtZSBp
c3N1ZToNCj4gPiANCj4gPiBbICAyODguMjAwMjA2XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE2
NjE4NDQwNjkuMzc2Ojc0Mik6DQo+ID4gbHNtPVNNQUNLDQo+ID4gZm49c21hY2tfc29ja2V0X3Nv
Y2tfcmN2X3NrYiBhY3Rpb249ZGVuaWVkIHN1YmplY3Q9Im5ldF9ob3N0Ig0KPiA+IG9iamVjdD0i
c3RyZXNzdGVzdCIgcmVxdWVzdGVkPXcgcGlkPTE4NSBjb21tPSJzdHJlc3MiIHNhZGRyPTxob3N0
LQ0KPiA+IGlwdjYtDQo+ID4gYWRkcj4gc3JjPTQ5ODEyIGRhZGRyPTxxZW11LWlwdjYtYWRkcj4g
ZGVzdD00MjUxMSBuZXRpZj1lbnMzDQo+ID4gDQo+ID4gSW5zdGVhZCBvZiBkZWZpbmluZyB0aGUg
bmV0bGFiZWwgdmlhIC9zeXMvZnMvc21hY2tmcy9pcDZob3N0cyBJDQo+ID4gYWRkZWQgYQ0KPiA+
IG5laG9zdHRmaWx0ZXIgcnVsZSB0byBtYXJrIHRoZSBwYWNrYWdlIHdpdGggc2VjbWFyazoNCj4g
DQo+IFRoZSBuZXRmaWx0ZXIgcnVsZSBpcyB1bm5lY2Vzc2FyeSBpZiB5b3Ugc2V0IHRoZSBob3N0
IGxhYmVsLiBTbWFjaw0KPiB3aWxsDQo+IHNldCB0aGUgc2VjbWFyayBiYXNlZCBvbiB0aGUgaG9z
dCBsYWJlbC4gVGhlIGFwcHJvYWNoIHlvdSd2ZSB1c2UNCj4gc2hvdWxkDQo+IHdvcmsganVzdCBm
aW5lLiBTZWVpbmcgdGhhdCB0aGUgcHJvYmxlbSBvY2N1cnMgaW4gYm90aCBjYXNlcyB3aWxsDQo+
IGhlbHANCj4gbmFycm93IGRvd24gdGhlIHBvc3NpYmlsaXRpZXMuIFdpdGggdGhlIGNvbmZpZ3Vy
YXRpb24gYW5kIGNhc2VzIHlvdQ0KPiBwcm92aWRlZCBJIGFtIGFibGUgdG8gcmVwcm9kdWNlIHRo
ZSBwcm9ibGVtIHJlbGlhYmx5LiBJIGFtIHdvcmtpbmcgb24NCj4gdHJhY2tpbmcgZG93biB3aGF0
IEkgdGhpbmsgaXMgYSBsYWNrIG9mIGxvY2tpbmcgaXNzdWUuIEFueSBtb3JlDQo+IGluZm9ybWF0
aW9uDQo+IHlvdSBjYW4gcHJvdmlkZSBjb3VsZCBiZSBtb3N0IGhlbHBmdWwuDQoNCkkgYWRkZWQg
c29tZSBkZWJ1ZyBvdXRwdXQgYW5kIHN0YWNrIGR1bXBzOg0KDQpbICAgNDguMDU2Mjk3XSBTTUFD
SyBERUJVRzogc21hY2tfc2tfYWxsb2Nfc2VjdXJpdHk6MjMyMSAtDQpzaz1mZmZmOGZlYjFjYzNh
MjAwIC0gc21rX2luPXN0cmVzc3Rlc3Qgc21rX291dD1zdHJlc3N0ZXN0DQpza3A9ZmZmZjhmZWIx
Y2M1MTAwMA0KWyAgIDQ4LjA1Njc5Ml0gQ1BVOiAwIFBJRDogMTU0NCBDb21tOiBzdHJlc3MgTm90
IHRhaW50ZWQgNC4xNC4wKyAjOQ0KWyAgIDQ4LjA1NzA4NV0gSGFyZHdhcmUgbmFtZTogUUVNVSBT
dGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksDQpCSU9TIDEuMTAuMi0xdWJ1bnR1MSAw
NC8wMS8yMDE0DQpbICAgNDguMDU3NDYzXSBDYWxsIFRyYWNlOg0KWyAgIDQ4LjA1NzYwMF0gIDxJ
UlE+DQpbICAgNDguMDU3NzQxXSAgZHVtcF9zdGFjaysweDRkLzB4NzENClsgICA0OC4wNTc5MzZd
ICBzbWFja19za19hbGxvY19zZWN1cml0eSsweDEwOS8weDExMA0KWyAgIDQ4LjA1ODE2NV0gIHNl
Y3VyaXR5X3NrX2FsbG9jKzB4M2UvMHg2MA0KWyAgIDQ4LjA1ODM2NF0gIHNrX3Byb3RfYWxsb2Mr
MHg1My8weDEzMA0KWyAgIDQ4LjA1ODU1M10gIHNrX2Nsb25lX2xvY2srMHgxOS8weDNkMA0KWyAg
IDQ4LjA1ODczN10gIGluZXRfY3NrX2Nsb25lX2xvY2srMHgxMS8weGUwDQpbICAgNDguMDU4OTUz
XSAgdGNwX2NyZWF0ZV9vcGVucmVxX2NoaWxkKzB4MWUvMHg0MjANClsgICA0OC4wNTkxNzJdICB0
Y3BfdjZfc3luX3JlY3Zfc29jaysweDkxLzB4NzEwDQpbICAgNDguMDU5MzgwXSAgdGNwX2NoZWNr
X3JlcSsweDNiMi8weDUxMA0KWyAgIDQ4LjA1OTU1OF0gID8gdGNwX3Y2X2luYm91bmRfbWQ1X2hh
c2grMHg1NC8weDFjMA0KWyAgIDQ4LjA1OTc4Ml0gIHRjcF92Nl9yY3YrMHg0YzEvMHg5NTANClsg
ICA0OC4wNTk5NTRdICA/IGlwNnRhYmxlX21hbmdsZV9ob29rKzB4NDEvMHgxMjANClsgICA0OC4w
NjAxNzJdICBpcDZfaW5wdXRfZmluaXNoKzB4YjkvMHg0MjANClsgICA0OC4wNjAzNzRdICBpcDZf
aW5wdXQrMHgyYi8weDkwDQpbICAgNDguMDYwNTM1XSAgPyBpcDZfcmN2X2ZpbmlzaCsweGEwLzB4
YTANClsgICA0OC4wNjA3MThdICBpcDZfcmN2X2ZpbmlzaCsweDQxLzB4YTANClsgICA0OC4wNjA4
OTJdICBpcHY2X3JjdisweDMxZC8weDUyMA0KWyAgIDQ4LjA2MTA1M10gID8gaXA2X21ha2Vfc2ti
KzB4MWIwLzB4MWIwDQpbICAgNDguMDYxMjQwXSAgX19uZXRpZl9yZWNlaXZlX3NrYl9jb3JlKzB4
MzNhLzB4YTkwDQpbICAgNDguMDYxNDkwXSAgPyBpcHY2X2dyb19yZWNlaXZlKzB4MWI1LzB4MzUw
DQpbICAgNDguMDYxNjg3XSAgX19uZXRpZl9yZWNlaXZlX3NrYisweDEzLzB4NjANClsgICA0OC4w
NjE4OTVdICA/IF9fbmV0aWZfcmVjZWl2ZV9za2IrMHgxMy8weDYwDQpbICAgNDguMDYyMDg5XSAg
bmV0aWZfcmVjZWl2ZV9za2JfaW50ZXJuYWwrMHgyMy8weGIwDQpbICAgNDguMDYyMzA1XSAgbmFw
aV9ncm9fcmVjZWl2ZSsweGJkLzB4ZTANClsgICA0OC4wNjI0ODVdICBlMTAwMF9jbGVhbl9yeF9p
cnErMHgxYzkvMHg0ZTANClsgICA0OC4wNjI2ODZdICBlMTAwMF9jbGVhbisweDI2MC8weDg2MA0K
WyAgIDQ4LjA2Mjg2MF0gIG5ldF9yeF9hY3Rpb24rMHgxMWIvMHgzNTANClsgICA0OC4wNjMwMzFd
ICA/IGUxMDAwX2ludHIrMHg3OC8weGYwDQpbICAgNDguMDYzMjAyXSAgX19kb19zb2Z0aXJxKzB4
Y2YvMHgyYTgNClsgICA0OC4wNjMzNzZdICBpcnFfZXhpdCsweGFiLzB4YjANClsgICA0OC4wNjM1
MjhdICBkb19JUlErMHg3Yi8weGMwDQpbICAgNDguMDYzNjc5XSAgY29tbW9uX2ludGVycnVwdCsw
eDkwLzB4OTANClsgICA0OC4wNjM4NTRdICA8L0lSUT4NClsgICA0OC4wNjM5NzddIFJJUDogMDAz
MzoweDU2MzA3Y2VmMGJhZg0KWyAgIDQ4LjA2NDEzNV0gUlNQOiAwMDJiOjAwMDA3ZmZjZDk3MzQ1
NDAgRUZMQUdTOiAwMDAwMDIwNiBPUklHX1JBWDoNCmZmZmZmZmZmZmZmZmZmYzQNClsgICA0OC4w
NjQ0NjZdIFJBWDogMDAwMDAwMDAzNzU4MWZhYyBSQlg6IDAwMDAwMDAwMDAwMDNhOTggUkNYOg0K
MDAwMDAwMDAzNzU4MWZhYw0KWyAgIDQ4LjA2NDc2NV0gUkRYOiAwMDAwMDAwMDNiMzg4ZTdkIFJT
STogMDAwMDdmZmNkOTczNDUxYyBSREk6DQowMDAwN2YyMDIzYzYyNjgwDQpbICAgNDguMDY1MDMz
XSBSQlA6IDAwMDAwMDAwMDAwMDAwMDMgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOToNCjAwMDA3
ZjIwMjNjNjIwMjQNClsgICA0OC4wNjUzMjZdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAw
MDAwMDAwMDAwMDAyNDYgUjEyOg0KMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDQ4LjA2NTYyNV0gUjEz
OiAwMDAwMDAwMDAwMDAwMDAzIFIxNDogMDAwMDAwMDAwMDAwMDAwMSBSMTU6DQowMDAwNTYzMDdj
ZWYyMDA0DQpbICAgNDguMDY2NDYyXSBTTUFDSyBERUJVRzogc21hY2tfc29ja2V0X3NvY2tfcmN2
X3NrYjo0MDU3IC0NCnNrPWZmZmY4ZmViMWNjM2EyMDAgc21rX2luPXN0cmVzc3Rlc3QgcmM9LTEz
DQpbICAgNDguMDY2ODUyXSBDUFU6IDAgUElEOiAxNTQ0IENvbW06IHN0cmVzcyBOb3QgdGFpbnRl
ZCA0LjE0LjArICM5DQpbICAgNDguMDY3MTQyXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJk
IFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwNCkJJT1MgMS4xMC4yLTF1YnVudHUxIDA0LzAxLzIw
MTQNClsgICA0OC4wNjc1MDddIENhbGwgVHJhY2U6DQpbICAgNDguMDY3NjIwXSAgPElSUT4NClsg
ICA0OC4wNjc3MzhdICBkdW1wX3N0YWNrKzB4NGQvMHg3MQ0KWyAgIDQ4LjA2Nzg5OF0gIHNtYWNr
X3NvY2tldF9zb2NrX3Jjdl9za2IrMHgyNjkvMHgyNzANClsgICA0OC4wNjgxMDldICA/IGRlZmF1
bHRfd2FrZV9mdW5jdGlvbisweGQvMHgxMA0KWyAgIDQ4LjA2ODMwMV0gID8gcG9sbHdha2UrMHg2
MS8weDcwDQpbICAgNDguMDY4NDY0XSAgPyB3YWtlX3VwX3ErMHg3MC8weDcwDQpbICAgNDguMDY4
NjIxXSAgPyBfX3dha2VfdXBfY29tbW9uKzB4NjgvMHgxMjANClsgICA0OC4wNjg4MDZdICBzZWN1
cml0eV9zb2NrX3Jjdl9za2IrMHgzNi8weDUwDQpbICAgNDguMDY4OTg3XSAgc2tfZmlsdGVyX3Ry
aW1fY2FwKzB4MmMvMHgxNTANClsgICA0OC4wNjkxNTZdICA/IHRjcF92Nl9pbmJvdW5kX21kNV9o
YXNoKzB4NTQvMHgxYzANClsgICA0OC4wNjkzNTZdICB0Y3BfZmlsdGVyKzB4MjYvMHg0MA0KWyAg
IDQ4LjA2OTUxMF0gIHRjcF92Nl9yY3YrMHg4MDUvMHg5NTANClsgICA0OC4wNjk2NjNdICA/IGlw
NnRhYmxlX21hbmdsZV9ob29rKzB4NDEvMHgxMjANClsgICA0OC4wNjk4NTZdICBpcDZfaW5wdXRf
ZmluaXNoKzB4YjkvMHg0MjANClsgICA0OC4wNzAwMjldICBpcDZfaW5wdXQrMHgyYi8weDkwDQpb
ICAgNDguMDcwMTc0XSAgPyBpcDZfcmN2X2ZpbmlzaCsweGEwLzB4YTANClsgICA0OC4wNzAzMzdd
ICBpcDZfcmN2X2ZpbmlzaCsweDlhLzB4YTANClsgICA0OC4wNzA0OThdICBpcHY2X3JjdisweDMx
ZC8weDUyMA0KWyAgIDQ4LjA3MDY1MV0gID8gaXA2X21ha2Vfc2tiKzB4MWIwLzB4MWIwDQpbICAg
NDguMDcwODMyXSAgX19uZXRpZl9yZWNlaXZlX3NrYl9jb3JlKzB4MzNhLzB4YTkwDQpbICAgNDgu
MDcxMDI4XSAgPyBpcHY2X2dyb19yZWNlaXZlKzB4MWI1LzB4MzUwDQpbICAgNDguMDcxMjE0XSAg
X19uZXRpZl9yZWNlaXZlX3NrYisweDEzLzB4NjANClsgICA0OC4wNzEzOTZdICA/IF9fbmV0aWZf
cmVjZWl2ZV9za2IrMHgxMy8weDYwDQpbICAgNDguMDcxNTk1XSAgbmV0aWZfcmVjZWl2ZV9za2Jf
aW50ZXJuYWwrMHgyMy8weGIwDQpbICAgNDguMDcxODA4XSAgbmFwaV9ncm9fcmVjZWl2ZSsweGJk
LzB4ZTANClsgICA0OC4wNzIwMDFdICBlMTAwMF9jbGVhbl9yeF9pcnErMHgxYzkvMHg0ZTANClsg
ICA0OC4wNzIxOTddICBlMTAwMF9jbGVhbisweDI2MC8weDg2MA0KWyAgIDQ4LjA3MjM3Nl0gIG5l
dF9yeF9hY3Rpb24rMHgxMWIvMHgzNTANClsgICA0OC4wNzI1NDJdICA/IGUxMDAwX2ludHIrMHg3
OC8weGYwDQpbICAgNDguMDcyNzA5XSAgX19kb19zb2Z0aXJxKzB4Y2YvMHgyYTgNClsgICA0OC4w
NzI4ODFdICBpcnFfZXhpdCsweGFiLzB4YjANClsgICA0OC4wNzMwNDFdICBkb19JUlErMHg3Yi8w
eGMwDQpbICAgNDguMDczMjMyXSAgY29tbW9uX2ludGVycnVwdCsweDkwLzB4OTANClsgICA0OC4w
NzM0MzNdICA8L0lSUT4NClsgICA0OC4wNzM1NDRdIFJJUDogMDAzMzoweDU2MzA3Y2VmMGJhZg0K
WyAgIDQ4LjA3MzY5N10gUlNQOiAwMDJiOjAwMDA3ZmZjZDk3MzQ1NDAgRUZMQUdTOiAwMDAwMDIw
NiBPUklHX1JBWDoNCmZmZmZmZmZmZmZmZmZmYzQNClsgICA0OC4wNzQwMDddIFJBWDogMDAwMDAw
MDAzNzU4MWZhYyBSQlg6IDAwMDAwMDAwMDAwMDNhOTggUkNYOg0KMDAwMDAwMDAzNzU4MWZhYw0K
WyAgIDQ4LjA3NDI5N10gUkRYOiAwMDAwMDAwMDNiMzg4ZTdkIFJTSTogMDAwMDdmZmNkOTczNDUx
YyBSREk6DQowMDAwN2YyMDIzYzYyNjgwDQpbICAgNDguMDc0NTgwXSBSQlA6IDAwMDAwMDAwMDAw
MDAwMDMgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOToNCjAwMDA3ZjIwMjNjNjIwMjQNClsgICA0
OC4wNzQ4NzVdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyNDYgUjEy
Og0KMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDQ4LjA3NTE1N10gUjEzOiAwMDAwMDAwMDAwMDAwMDAz
IFIxNDogMDAwMDAwMDAwMDAwMDAwMSBSMTU6DQowMDAwNTYzMDdjZWYyMDA0DQpbICAgNDguMDc1
OTAzXSBTTUFDSyBERUJVRzogc21hY2tfc29ja19ncmFmdDo0MTg1IC0gc2s9ZmZmZjhmZWIxY2Mz
YTIwMA0KLSBiZWZvcmUgc21rX2luPXN0cmVzc3Rlc3Qgc21rX291dD1zdHJlc3N0ZXN0DQpbICAg
NDguMDc2NjQzXSBDUFU6IDAgUElEOiAxNjM0IENvbW06IHNvY2F0IE5vdCB0YWludGVkIDQuMTQu
MCsgIzkNClsgICA0OC4wNzY4OTJdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0
NDBGWCArIFBJSVgsIDE5OTYpLA0KQklPUyAxLjEwLjItMXVidW50dTEgMDQvMDEvMjAxNA0KWyAg
IDQ4LjA3NzMyOV0gQ2FsbCBUcmFjZToNClsgICA0OC4wNzc0ODVdICBkdW1wX3N0YWNrKzB4NGQv
MHg3MQ0KWyAgIDQ4LjA3NzY1NF0gIHNtYWNrX3NvY2tfZ3JhZnQrMHhlOS8weGYwDQpbICAgNDgu
MDc3ODM0XSAgc2VjdXJpdHlfc29ja19ncmFmdCsweDI4LzB4NDANClsgICA0OC4wNzgwMjRdICBp
bmV0X2FjY2VwdCsweGE4LzB4MTQwDQpbICAgNDguMDc4MTk4XSAgU1lTQ19hY2NlcHQ0KzB4ZTgv
MHgxZTANClsgICA0OC4wNzgzNzJdICA/IF9fYXVkaXRfc3lzY2FsbF9lbnRyeSsweGJhLzB4MTAw
DQpbICAgNDguMDc4NTgwXSAgPyBzeXNjYWxsX3RyYWNlX2VudGVyKzB4MWMzLzB4MmIwDQpbICAg
NDguMDc4NzgxXSAgU3lTX2FjY2VwdCsweGIvMHgxMA0KWyAgIDQ4LjA3ODkzM10gIGRvX3N5c2Nh
bGxfNjQrMHg0ZS8weDEwMA0KWyAgIDQ4LjA3OTEwNV0gIGVudHJ5X1NZU0NBTEw2NF9zbG93X3Bh
dGgrMHgyNS8weDI1DQpbICAgNDguMDc5MzE0XSBSSVA6IDAwMzM6MHg3ZjhkMTE2Yjg1ZWENClsg
ICA0OC4wNzk0NjVdIFJTUDogMDAyYjowMDAwN2ZmZjg3YzJlZjI4IEVGTEFHUzogMDAwMDAyNDYg
T1JJR19SQVg6DQowMDAwMDAwMDAwMDAwMDJiDQpbICAgNDguMDc5Nzc4XSBSQVg6IGZmZmZmZmZm
ZmZmZmZmZGEgUkJYOiAwMDAwN2ZmZjg3YzJmMTYwIFJDWDoNCjAwMDA3ZjhkMTE2Yjg1ZWENClsg
ICA0OC4wODAwNjNdIFJEWDogMDAwMDdmZmY4N2MyZjEzNCBSU0k6IDAwMDA3ZmZmODdjMmYxNjAg
UkRJOg0KMDAwMDAwMDAwMDAwMDAwNQ0KWyAgIDQ4LjA4MDM2M10gUkJQOiAwMDAwN2ZmZjg3YzJm
MTM0IFIwODogMDAwMDdmZmY4N2MyZjEzNCBSMDk6DQowMDAwMDAwMDAwMDAwMDAwDQpbICAgNDgu
MDgwNjQ4XSBSMTA6IDAwMDAwMDAwMDAwMDAwNDAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjoN
CjAwMDAwMDAwMDAwMDAwMDUNClsgICA0OC4wODA5MDNdIFIxMzogMDAwMDAwMDBmZmZmZmZmZiBS
MTQ6IDAwMDA3ZmZmODdjMmYxNjAgUjE1Og0KMDAwMDdmZmY4N2MyZjFlMA0KWyAgIDQ4LjA4MTIz
Nl0gU01BQ0sgREVCVUc6IHNtYWNrX3NvY2tfZ3JhZnQ6NDE5MyAtIHNrPWZmZmY4ZmViMWNjM2Ey
MDANCi0gYWZ0ZXIgc21rX2luPXRjcF90ZXN0IHNta19vdXQ9dGNwX3Rlc3QNCg0KDQpJdCBsb29r
cyBsaWtlIHRoZSBzb2NrZXQgaXMgYWxyZWFkeSBpbml0aWFsaXplZCB3aXRoIHRoZSB3cm9uZyBz
ZWN1cml0eQ0KY29udGV4dC4gSXQgaXMgbGF0ZXIgY29ycmVjdGVkIGJ5IHNtYWNrX3NvY2tfZ3Jh
ZnQsIGJ1dCB0b29sIGxhdGUgc2luY2UNCml0IGlzIGNhbGxlZCBkdXJpbmcgYWNjZXB0Lg0KDQpX
ZSBsb29rZWQgaW50byBzbWFja19za19hbGxvY19zZWN1cml0eSBhbmQgdGhvdWdodCB0aGlzIGxp
bmUgY291bGQgYmUNCnRoZSBpc3N1ZToNCg0Kc3RydWN0IHNtYWNrX2tub3duICpza3AgPSBzbWtf
b2ZfY3VycmVudCgpOw0KDQpMb29raW5nIGF0IGhvdyBzZWxpbnV4IHNvbHZlZCBpdCwgd2Ugc2F3
IGl0IGluaXRpYWxpemVzIHdpdGggYSBibGFuaw0Kc2VjdXJpdHkgY29udGV4dCBhbmQgbGF0ZXIg
Y29weXMgdGhlIGNvcnJlY3QgY29udGV4dCB3aXRoaW4NCnNlY3VyaXR5X3NrX2Nsb25lIExTTSBo
b29rLg0KQXQgbGVhc3Qgd2l0aCB0aGlzIHBhdGNoIHdlIGRvbid0IHNlZSBvdXIgaXNzdWUgYW55
bW9yZToNCg0KRnJvbTogTG9udGtlIE1pY2hhZWwgPG1pY2hhZWwubG9udGtlQGVsZWt0cm9iaXQu
Y29tPg0KRGF0ZTogV2VkLCAzMSBBdWcgMjAyMiAxNDowMzoyNiArMDIwMA0KU3ViamVjdDogW1BB
VENIXSBTTUFDSzogQWRkIHNrX2Nsb25lX3NlY3VyaXR5IExTTSBob29rDQoNClVzaW5nIHNta19v
Zl9jdXJyZW50KCkgZHVyaW5nIHNrX2FsbG9jX3NlY3VyaXR5IGhvb2sgbGVhZHMgaW4gcmFyZQ0K
Y2FzZXMNCnRvIGEgZmF1bHR5IGluaXRpYWxpemF0aW9uIG9mIHRoZSBzZWN1cml0eSBjb250ZXh0
IG9mIHRoZSBjcmVhdGVkDQpzb2NrZXQuDQoNCkJ5IGFkZGluZyB0aGUgTFNNIGhvb2sgc2tfY2xv
bmVfc2VjdXJpdHkgdG8gU01BQ0sgdGhpcyBpbml0aWFsaXphdGlvbg0KZmF1bHQgaXMgY29ycmVj
dGVkIGJ5IGNvcHlpbmcgdGhlIHNlY3VyaXR5IGNvbnRleHQgb2YgdGhlIG9sZCBzb2NrZXQNCnBv
aW50ZXIgdG8gdGhlIG5ld2x5IGNsb25lZCBvbmUuDQotLS0NCiBzZWN1cml0eS9zbWFjay9zbWFj
a19sc20uYyB8IDE2ICsrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvc2VjdXJpdHkvc21hY2svc21hY2tfbHNtLmMgYi9zZWN1
cml0eS9zbWFjay9zbWFja19sc20uYw0KaW5kZXggMjg2MTcxYTE2ZWQyLi44ZWI0NzM5NjM3NmYg
MTAwNjQ0DQotLS0gYS9zZWN1cml0eS9zbWFjay9zbWFja19sc20uYw0KKysrIGIvc2VjdXJpdHkv
c21hY2svc21hY2tfbHNtLmMNCkBAIC0yMzQ4LDYgKzIzNDgsMjEgQEAgc3RhdGljIHZvaWQgc21h
Y2tfc2tfZnJlZV9zZWN1cml0eShzdHJ1Y3Qgc29jaw0KKnNrKQ0KIAlrZnJlZShzay0+c2tfc2Vj
dXJpdHkpOw0KIH0NCiANCisvKioNCisgKiBzbWFja19za19jbG9uZV9zZWN1cml0eSAtIENvcHkg
c2VjdXJpdHkgY29udGV4dA0KKyAqIEBzazogdGhlIG9sZCBzb2NrZXQNCisgKiBAbmV3c2s6IHRo
ZSBuZXcgc29ja2V0DQorICoNCisgKiBDb3B5IHRoZSBzZWN1cml0eSBjb250ZXh0IG9mIHRoZSBv
bGQgc29ja2V0IHBvaW50ZXIgdG8gdGhlIGNsb25lZA0KKyAqLw0KK3N0YXRpYyB2b2lkIHNtYWNr
X3NrX2Nsb25lX3NlY3VyaXR5KGNvbnN0IHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNvY2sNCipu
ZXdzaykNCit7DQorCXN0cnVjdCBzb2NrZXRfc21hY2sgKnNzcF9vbGQgPSBzay0+c2tfc2VjdXJp
dHk7DQorCXN0cnVjdCBzb2NrZXRfc21hY2sgKnNzcF9uZXcgPSBuZXdzay0+c2tfc2VjdXJpdHk7
DQorDQorCSpzc3BfbmV3ID0gKnNzcF9vbGQ7DQorfQ0KKw0KIC8qKg0KICogc21hY2tfaXB2NGhv
c3RfbGFiZWwgLSBjaGVjayBob3N0IGJhc2VkIHJlc3RyaWN0aW9ucw0KICogQHNpcDogdGhlIG9i
amVjdCBlbmQNCkBAIC00NzEwLDYgKzQ3MjUsNyBAQCBzdGF0aWMgc3RydWN0IHNlY3VyaXR5X2hv
b2tfbGlzdCBzbWFja19ob29rc1tdDQpfX2xzbV9yb19hZnRlcl9pbml0ID0gew0KIAlMU01fSE9P
S19JTklUKHNvY2tldF9nZXRwZWVyc2VjX2RncmFtLA0Kc21hY2tfc29ja2V0X2dldHBlZXJzZWNf
ZGdyYW0pLA0KIAlMU01fSE9PS19JTklUKHNrX2FsbG9jX3NlY3VyaXR5LCBzbWFja19za19hbGxv
Y19zZWN1cml0eSksDQogCUxTTV9IT09LX0lOSVQoc2tfZnJlZV9zZWN1cml0eSwgc21hY2tfc2tf
ZnJlZV9zZWN1cml0eSksDQorCUxTTV9IT09LX0lOSVQoc2tfY2xvbmVfc2VjdXJpdHksIHNtYWNr
X3NrX2Nsb25lX3NlY3VyaXR5KSwNCiAJTFNNX0hPT0tfSU5JVChzb2NrX2dyYWZ0LCBzbWFja19z
b2NrX2dyYWZ0KSwNCiAJTFNNX0hPT0tfSU5JVChpbmV0X2Nvbm5fcmVxdWVzdCwgc21hY2tfaW5l
dF9jb25uX3JlcXVlc3QpLA0KIAlMU01fSE9PS19JTklUKGluZXRfY3NrX2Nsb25lLCBzbWFja19p
bmV0X2Nza19jbG9uZSksDQotLSANCjIuMTcuMQ0KDQoNCldoYXQgaXMgeW91ciBvcGluaW9uIG9u
IHRoaXM/DQoNCj4gDQo+ID4gDQo+ID4gaXA2dGFibGVzIC10IG1hbmdsZSAtQSBJTlBVVCAtcCB0
Y3AgLS1zcmMgPGhvc3QtaXB2Ni1hZGRyPiAtag0KPiA+IFNFQ01BUksNCj4gPiAtLXNlbGN0eCBu
ZXRfaG9zdA0KPiA+IA0K
