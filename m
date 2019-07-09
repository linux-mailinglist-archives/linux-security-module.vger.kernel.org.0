Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37FE62D73
	for <lists+linux-security-module@lfdr.de>; Tue,  9 Jul 2019 03:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfGIBdg (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 8 Jul 2019 21:33:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:20752 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfGIBdg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 8 Jul 2019 21:33:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 18:33:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,468,1557212400"; 
   d="scan'208";a="340614089"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.165])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2019 18:33:35 -0700
Date:   Mon, 8 Jul 2019 18:33:35 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Cedric Xing <cedric.xing@intel.com>
Cc:     linux-sgx@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/4] x86/sgx: Implement SGX specific hooks in
 SELinux
Message-ID: <20190709013335.GB24799@linux.intel.com>
References: <cover.1561588012.git.cedric.xing@intel.com>
 <cover.1562542383.git.cedric.xing@intel.com>
 <3a9efc8d3c27490dbcfe802ce3facddd62f47872.1562542383.git.cedric.xing@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9efc8d3c27490dbcfe802ce3facddd62f47872.1562542383.git.cedric.xing@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Sun, Jul 07, 2019 at 04:41:34PM -0700, Cedric Xing wrote:
> +static int enclave_mprotect(struct vm_area_struct *vma, size_t prot)
> +{
> +	struct ema_map *m;
> +	int rc;
> +
> +	/* is vma an enclave vma ? */
> +	if (!vma->vm_file)
> +		return 0;
> +	m = ema_get_map(vma->vm_file);
> +	if (!m)
> +		return 0;
> +
> +	/* WX requires EXECMEM */
> +	if ((prot && PROT_WRITE) && (prot & PROT_EXEC)) {
> +		rc = avc_has_perm(&selinux_state, current_sid(), current_sid(),
> +				  SECCLASS_PROCESS, PROCESS__EXECMEM, NULL);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = ema_lock_map(m);
> +	if (rc)
> +		return rc;
> +
> +	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC))
> +		rc = ema_apply_to_range(m, vma->vm_start, vma->vm_end,
> +					ema__chk_X_cb, vma->vm_file);
> +	if (!rc && (prot & PROT_WRITE) && !(vma->vm_flags & VM_WRITE))
> +		rc = ema_apply_to_range(m, vma->vm_start, vma->vm_end,
> +					ema__set_M_cb, NULL);

Not tracking whether a page has been mapped X and having ema__chk_W_cb()
allows an application to circumvent W^X policies by spinning up a helper
process.

Ignoring that issue, this approach suffers from the same race condition I
pointed out a while back[1].  If process A maps a page W and process B
maps the same page X, then the result of ema__chk_X_cb() depends on the
order of mprotect() calls between A and B.

[1] https://lore.kernel.org/linux-security-module/20190614200123.GA32570@linux.intel.com/

> +	ema_unlock_map(m);
> +
> +	return rc;
> +}
