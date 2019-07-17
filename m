Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BED16B598
	for <lists+linux-security-module@lfdr.de>; Wed, 17 Jul 2019 06:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfGQEgy (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 17 Jul 2019 00:36:54 -0400
Received: from namei.org ([65.99.196.166]:35644 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQEgy (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 17 Jul 2019 00:36:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x6H4akJr002791;
        Wed, 17 Jul 2019 04:36:46 GMT
Date:   Wed, 17 Jul 2019 14:36:46 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Paul Moore <paul@paul-moore.com>
cc:     Steve Grubb <sgrubb@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: Preferred subj= with multiple LSMs
In-Reply-To: <CAHC9VhS-WGuKYzG5AU01BN8tk8nzp+7qxk7Sz-hbHQGL+UXOfg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1907171435200.2314@namei.org>
References: <f824828c-5c9d-b91e-5cec-70ee7a45e760@schaufler-ca.com> <d1a237d3-4b72-48b0-27d6-fb168354ad31@schaufler-ca.com> <CAHC9VhTQLihNQ1iGjJB=LAn=C6BQokFsjsRcj8O_O9AjqQ7HBg@mail.gmail.com> <2517266.eHZzEmjMsX@x2>
 <CAHC9VhS-WGuKYzG5AU01BN8tk8nzp+7qxk7Sz-hbHQGL+UXOfg@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, 16 Jul 2019, Paul Moore wrote:

> The subj_X approach is still backwards compatible, the difference is
> that old versions of the tools get a "?" for the LSM creds which is a
> rather sane way of indicating something is different.

This will still break existing userspace, right?  We can't do that.

> Once again, I believe that the subj_X approach is going to be faster
> than safely parsing the multiplexed format.

What about emitting one audit record for each LSM?

-- 
James Morris
<jmorris@namei.org>

