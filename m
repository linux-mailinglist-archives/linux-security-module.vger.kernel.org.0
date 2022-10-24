Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E917460B71A
	for <lists+linux-security-module@lfdr.de>; Mon, 24 Oct 2022 21:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJXTTj (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 24 Oct 2022 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiJXTTI (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Oct 2022 15:19:08 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [IPv6:2001:4b98:dc4:8::240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FBCB3B32;
        Mon, 24 Oct 2022 10:55:23 -0700 (PDT)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id D1441C0F9D;
        Mon, 24 Oct 2022 12:29:11 +0000 (UTC)
Received: (Authenticated sender: nicolas.bouchinet@clip-os.org)
        by mail.gandi.net (Postfix) with ESMTPSA id E1D09C0005;
        Mon, 24 Oct 2022 12:28:24 +0000 (UTC)
Date:   Mon, 24 Oct 2022 14:28:23 +0200
From:   Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        davem@davemloft.net, lucien.xin@gmail.com, vgoyal@redhat.com,
        omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] evm: Correct inode_init_security hooks behaviors
Message-ID: <Y1aE5/Svp009noud@archlinux>
References: <Y1K3bf+dtNnVe7DG@archlinux>
 <3336d699-a73d-5112-4bf7-95a92f0fcc28@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3336d699-a73d-5112-4bf7-95a92f0fcc28@schaufler-ca.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Hi Casey, thanks again for your time,

On Fri, Oct 21, 2022 at 08:42:20AM -0700, Casey Schaufler wrote:
> On 10/21/2022 8:14 AM, Nicolas Bouchinet wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> >
> > Fixes a NULL pointer dereference occurring in the
> > `evm_protected_xattr_common` function of the EVM LSM. The bug is
> > triggered if a `inode_init_security` hook returns 0 without initializing
> > the given `struct xattr` fields (which is the case of BPF) and if no
> > other LSM overrides thoses fields after. This also leads to memory
> > leaks.
> >
> > Adds a `call_int_hook_xattr` macro that fetches and feed the
> > `new_xattrs` array with every called hook xattr values.
> >
> > Adds a `evm_init_hmacs` function which init the EVM hmac using every
> > entry of the array contrary to `evm_init_hmac`.
> >
> > Fixes the `evm_inode_init_security` function to use `evm_init_hmacs`.
> >
> > The `MAX_LSM_EVM_XATTR` value has been raised to 5 which gives room for
> > SMACK, SELinux, Apparmor, BPF and IMA/EVM security attributes.
> 
> This does not match the code, which sets the value based on the
> security modules compiled in rather than the constant 5.
> 
Sorry for this, I think I will wait a day before sending patch v3.
> >
> > Changes the default return value of the `inode_init_security` hook
> > definition to `-EOPNOTSUPP`.
> >
> > Changes the hook documentation to match the behavior of the LSMs using
> > it (only xattr->value is initialised with kmalloc and thus is the only
> > one that should be kfreed by the caller).
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >
> > Changes since v1:
> > https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> > * The `call_int_hook_xattr` macro has been inlined into the
> >   `security_inode_init_security` hook (as suggested by Paul Moor,
> >   Micka�l Sala�n and Casey Schaufler).
> > * The MAX_LSM_EVM_XATTR value is processed based on compiled LSMs (as
> >   proposed by Casey Schaufler).
> > * Various typos and cosmetic changes has been fixed (as suggested by
> >   Micka�l Sala�n)
> > * A MAX_LSM_EVM_XATTR test has been wrapped in a WAN_ON_ONCE macro (as
> >   suggested by Micka�l Sala�n).
> > ---
> >  include/linux/lsm_hook_defs.h       |  2 +-
> >  include/linux/lsm_hooks.h           |  4 ++--
> >  security/integrity/evm/evm.h        |  2 ++
> >  security/integrity/evm/evm_crypto.c | 22 ++++++++++++++++++++++
> >  security/integrity/evm/evm_main.c   |  9 +++++----
> >  security/security.c                 | 28 +++++++++++++++++++++-------
> >  6 files changed, 53 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > index 806448173033..e5dd0c0f6345 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -111,7 +111,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
> >  	 unsigned int obj_type)
> >  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
> >  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> > -LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> > +LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
> >  	 struct inode *dir, const struct qstr *qstr, const char **name,
> >  	 void **value, size_t *len)
> >  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index 84a0d7e02176..95aff9383de1 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -229,8 +229,8 @@
> >   *	This hook is called by the fs code as part of the inode creation
> >   *	transaction and provides for atomic labeling of the inode, unlike
> >   *	the post_create/mkdir/... hooks called by the VFS.  The hook function
> > - *	is expected to allocate the name and value via kmalloc, with the caller
> > - *	being responsible for calling kfree after using them.
> > + *	is expected to allocate the value via kmalloc, with the caller
> > + *	being responsible for calling kfree after using it.
> >   *	If the security module does not use security attributes or does
> >   *	not wish to put a security attribute on this particular inode,
> >   *	then it should return -EOPNOTSUPP to skip this processing.
> > diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
> > index f8b8c5004fc7..a2f9886e924d 100644
> > --- a/security/integrity/evm/evm.h
> > +++ b/security/integrity/evm/evm.h
> > @@ -60,6 +60,8 @@ int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
> >  		  struct evm_digest *data);
> >  int evm_init_hmac(struct inode *inode, const struct xattr *xattr,
> >  		  char *hmac_val);
> > +int evm_init_hmacs(struct inode *inode, const struct xattr *xattrs,
> > +		  char *hmac_val);
> >  int evm_init_secfs(void);
> >  
> >  #endif
> > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > index 708de9656bbd..db6868875e09 100644
> > --- a/security/integrity/evm/evm_crypto.c
> > +++ b/security/integrity/evm/evm_crypto.c
> > @@ -385,6 +385,28 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
> >  	return rc;
> >  }
> >  
> > +int evm_protected_xattr(const char *req_xattr_name);
> > +
> > +int evm_init_hmacs(struct inode *inode, const struct xattr *lsm_xattrs,
> > +		  char *hmac_val)
> > +{
> > +	struct shash_desc *desc;
> > +
> > +	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
> > +	if (IS_ERR(desc)) {
> > +		pr_info("init_desc failed\n");
> > +		return PTR_ERR(desc);
> > +	}
> > +
> > +	for (int i = 0; lsm_xattrs[i].value != NULL; i++) {
> > +		if (evm_protected_xattr(lsm_xattrs[i].name))
> > +			crypto_shash_update(desc, lsm_xattrs[i].value, lsm_xattrs[i].value_len);
> > +	}
> > +	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
> > +	kfree(desc);
> > +	return 0;
> > +}
> > +
> >  int evm_init_hmac(struct inode *inode, const struct xattr *lsm_xattr,
> >  		  char *hmac_val)
> >  {
> > diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> > index 2e6fb6e2ffd2..4f89b9eaf028 100644
> > --- a/security/integrity/evm/evm_main.c
> > +++ b/security/integrity/evm/evm_main.c
> > @@ -284,6 +284,8 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
> >  	int found = 0;
> >  	struct xattr_list *xattr;
> >  
> > +	if (!req_xattr_name)
> > +		return found;
> >  	namelen = strlen(req_xattr_name);
> >  	list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
> >  		if (!all_xattrs && !xattr->enabled)
> > @@ -305,7 +307,7 @@ static int evm_protected_xattr_common(const char *req_xattr_name,
> >  	return found;
> >  }
> >  
> > -static int evm_protected_xattr(const char *req_xattr_name)
> > +int evm_protected_xattr(const char *req_xattr_name)
> >  {
> >  	return evm_protected_xattr_common(req_xattr_name, false);
> >  }
> > @@ -841,8 +843,7 @@ int evm_inode_init_security(struct inode *inode,
> >  	struct evm_xattr *xattr_data;
> >  	int rc;
> >  
> > -	if (!(evm_initialized & EVM_INIT_HMAC) ||
> > -	    !evm_protected_xattr(lsm_xattr->name))
> > +	if (!(evm_initialized & EVM_INIT_HMAC))
> >  		return 0;
> >  
> >  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
> > @@ -850,7 +851,7 @@ int evm_inode_init_security(struct inode *inode,
> >  		return -ENOMEM;
> >  
> >  	xattr_data->data.type = EVM_XATTR_HMAC;
> > -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> > +	rc = evm_init_hmacs(inode, lsm_xattr, xattr_data->digest);
> >  	if (rc < 0)
> >  		goto out;
> >  
> > diff --git a/security/security.c b/security/security.c
> > index 14d30fec8a00..cf11bd7d6a1b 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -30,7 +30,11 @@
> >  #include <linux/msg.h>
> >  #include <net/flow.h>
> >  
> > -#define MAX_LSM_EVM_XATTR	2
> > +#define MAX_LSM_EVM_XATTR                                \
> > +	((IS_ENABLED(CONFIG_EVM) ? 1 : 0) +              \
> > +	 (IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> > +	 (IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) +   \
> > +	 (IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0))
> >  
> >  /* How many LSMs were built into the kernel? */
> >  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> > @@ -1091,9 +1095,11 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> >  				 const struct qstr *qstr,
> >  				 const initxattrs initxattrs, void *fs_data)
> >  {
> > +	int i = 0;
> > +	int ret = -EOPNOTSUPP;
> >  	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> >  	struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > -	int ret;
> > +	struct security_hook_list *hook_ptr;
> >  
> >  	if (unlikely(IS_PRIVATE(inode)))
> >  		return 0;
> > @@ -1103,15 +1109,23 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> >  				     dir, qstr, NULL, NULL, NULL);
> >  	memset(new_xattrs, 0, sizeof(new_xattrs));
> >  	lsm_xattr = new_xattrs;
> > -	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> > -						&lsm_xattr->name,
> > -						&lsm_xattr->value,
> > -						&lsm_xattr->value_len);
> > +	hlist_for_each_entry(hook_ptr, &security_hook_heads.inode_init_security, list) {
> > +		ret = hook_ptr->hook.inode_init_security(inode, dir, qstr, &lsm_xattr->name,
> > +				&lsm_xattr->value, &lsm_xattr->value_len);
> > +		if (ret == -EOPNOTSUPP)
> > +			continue;
> > +		if (WARN_ON_ONCE(i >= MAX_LSM_EVM_XATTR))
> > +			ret = -ENOMEM;
> > +		if (ret != 0)
> > +			break;
> > +		lsm_xattr++;
> > +		i++;
> > +	}
> >  	if (ret)
> >  		goto out;
> >  
> >  	evm_xattr = lsm_xattr + 1;
> > -	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> > +	ret = evm_inode_init_security(inode, new_xattrs, evm_xattr);
> >  	if (ret)
> >  		goto out;
> >  	ret = initxattrs(inode, new_xattrs, fs_data);

Best regards,

Nicolas Bouchinet
