Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9159AD4A67
	for <lists+linux-security-module@lfdr.de>; Sat, 12 Oct 2019 00:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfJKWew (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 11 Oct 2019 18:34:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfJKWev (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 11 Oct 2019 18:34:51 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D43F4862A
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 22:34:51 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id g8so16564870iop.19
        for <linux-security-module@vger.kernel.org>; Fri, 11 Oct 2019 15:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pb2kd2/UeXZLZxX2NPDVZ505qaor0AU6e6HZyZ5Nf/0=;
        b=cCy3LWakBoM45nx2iHN+6KLGvCHUi57rHFUu+pb7RL+FwnJ5S2KqM/p+zqOiV4tLT8
         ngIVT1BeUpaHwbCHlNuTmxs2GeutbM4QHqnKnC3YW5Z7kY1OwHusUehKiBZBXatAfH1Y
         pHrr1wzW2aSFlfawtvwhD4l81xDtGvifzEv6uChcW3QjvwX/ymbSDOmsntHDvVs4Zl4F
         uyauNFh4rfiPOGTgsPNJU/1Fd+LewPxp1eS7p/PsJDEOuBtXPiPic9WvjEQaZSfjM+h8
         us8f5EwM0KLUrNOnrfdnnkvsMY3SYyE52DYKCZQBH/hLLpUCxSjzFpGGIT1g0CnVSkkB
         1hNg==
X-Gm-Message-State: APjAAAWuRhY61d9rK6ooDayY/a1Up5Tubd9H3nTA/vGABtDeQkHbmBUh
        TVfpiRnHHuzoN/hTULTqXpV/elBWbxUk3iOLKRjXMMyqfrKpESfJYkzFpb37MIKcnPDh6QkPTHF
        Q4DJNIP4+oqtY0/CW5T6uzX6C/3ZQI1HONPcF
X-Received: by 2002:a5d:8b12:: with SMTP id k18mr3790083ion.133.1570833291146;
        Fri, 11 Oct 2019 15:34:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwpN+irjTZ41pWeVOF+4kudnO11CT6u7HGkC68Z1Xz7WWUQxPTXop0tLsor9iDJHIHBYs/Qjg==
X-Received: by 2002:a5d:8b12:: with SMTP id k18mr3790056ion.133.1570833290974;
        Fri, 11 Oct 2019 15:34:50 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id u11sm8534708iof.22.2019.10.11.15.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 15:34:50 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:34:49 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, daniel.thompson@linaro.org
Subject: Re: [Patch v7 2/4] KEYS: Use common tpm_buf for trusted and
 asymmetric keys
Message-ID: <20191011223448.7kycskba5mfsbvvw@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Sumit Garg <sumit.garg@linaro.org>,
        jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com, zohar@linux.ibm.com,
        jmorris@namei.org, serge@hallyn.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org
References: <1570425935-7435-1-git-send-email-sumit.garg@linaro.org>
 <1570425935-7435-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1570425935-7435-3-git-send-email-sumit.garg@linaro.org>
User-Agent: NeoMutt/20180716
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon Oct 07 19, Sumit Garg wrote:
>Switch to utilize common heap based tpm_buf code for TPM based trusted
>and asymmetric keys rather than using stack based tpm1_buf code. Also,
>remove tpm1_buf code.
>
>Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
