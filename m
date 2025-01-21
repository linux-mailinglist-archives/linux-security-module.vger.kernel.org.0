Return-Path: <linux-security-module+bounces-7772-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A3BA17A33
	for <lists+linux-security-module@lfdr.de>; Tue, 21 Jan 2025 10:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BF616A37D
	for <lists+linux-security-module@lfdr.de>; Tue, 21 Jan 2025 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535671DFE03;
	Tue, 21 Jan 2025 09:30:07 +0000 (UTC)
X-Original-To: linux-security-module@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74821C1741
	for <linux-security-module@vger.kernel.org>; Tue, 21 Jan 2025 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451807; cv=none; b=JTknKCg8FaaoA8K/Neoaoldc0PsHcxI/tE9hXHLIqGWDCgDqkBKsCDeYOXGbx+LANxv+nPN2KJwnotTqLaAaDLDHjxe8D8hw9x8s1TbnJmImjThVpCDheUE1jH3H0e/LisArNf7KEjBdoD7GGW2A+DiIXctnUq/4AtL2A8BeOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451807; c=relaxed/simple;
	bh=YK3A0x56wCxL4D4B2EDAD8jf9kgkUswidL7QC3zAi8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9l5xUh1Hl6WGmWNN7WkeUODowvQ0zvOrKEoZ+PsKYnWyCSY3cjoA8MBdqQ/P2BatJLHGSnk7lyr+mrzuWKeVkEc3hxrEi3Z+O7c8qCHjrbkM2r+v2dBceRIA7Z3tMeqGYCqZ8YKVSs4PKvnl2KTkUJ2k9dW8st7zO7gxwuG+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1taAZu-0004Ec-FK; Tue, 21 Jan 2025 10:29:46 +0100
Message-ID: <c3a1cc54-0928-419a-ac3d-7a3772918e3d@pengutronix.de>
Date: Tue, 21 Jan 2025 10:29:45 +0100
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] docs: thermal: sync hardware protection doc with
 code
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Fabio Estevam
 <festevam@denx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Serge Hallyn <serge@hallyn.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-security-module@vger.kernel.org, chrome-platform@lists.linux.dev,
 devicetree@vger.kernel.org, kernel@pengutronix.de
References: <20250113-hw_protection-reboot-v2-0-161d3fc734f0@pengutronix.de>
 <20250113-hw_protection-reboot-v2-3-161d3fc734f0@pengutronix.de>
 <Z433CXhyYHqYEn4N@google.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <Z433CXhyYHqYEn4N@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-security-module@vger.kernel.org

On 20.01.25 08:11, Tzung-Bi Shih wrote:
> On Mon, Jan 13, 2025 at 05:25:28PM +0100, Ahmad Fatoum wrote:
>> Originally, the thermal framework's only hardware protection action was
>> to trigger a shutdown. This has been changed a little over a year ago to
>> also support rebooting as alternative hardware protection action.
>>
>> Update the documentation to reflect this.
>>
>> Fixes: 62e79e38b257 ("thermal/thermal_of: Allow rebooting after critical temp")
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> With a possible typo,
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

Thanks.

> 
>> +At first, the kernel will attempt an orderly power-off or reboot, but
>> +accepts a delay after which it proceeds to do a forced power-off or
>> +reboot, respectively. If this fails, ``emergency restart()`` is invoked
>                                                    ^
> s/ /_/?

Typo was there before and didn't notice when reworking the paragraph.
Will fix for v3.

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

