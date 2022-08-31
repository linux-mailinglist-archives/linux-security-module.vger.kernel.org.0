Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BCE5A87BD
	for <lists+linux-security-module@lfdr.de>; Wed, 31 Aug 2022 22:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiHaUwc (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Wed, 31 Aug 2022 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiHaUwb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 31 Aug 2022 16:52:31 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F170ED004
        for <linux-security-module@vger.kernel.org>; Wed, 31 Aug 2022 13:52:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s7so4878936wro.2
        for <linux-security-module@vger.kernel.org>; Wed, 31 Aug 2022 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=O041gsmRo9OIv6PV/tHdQSQHlk8a4KIhiJkJ6KRPN6o=;
        b=mKODFzGoqdpjN7skUGnfOCx7p5vn/lFycyI2HvHHRA9/n38gBsDMiXo+ZCll9pFuCz
         P6SCJrBOs54fYrXiwXwJRInvFSGAojgBOpMVLvXlbO+NwLgDA8NTFIc49Vub/QBHoWTo
         DF7EjdDyJW8EE53rk83BPVqJFpdVkWeSvnDvkFFBoFIudfXZXCjDH68kAGxTGCXXxO29
         +MY3ZgpvKBgkbrLXN6BoOysSbjamfSztuY/XTO47qHEmzMlO8bjdc+FyY+ZpZilqqzkb
         S3W/Wyqd5M18EytXTJn2gd7lkWS7kZ75JkEF9rU+MVMLMfoNbs4CPnkEuf5MrYLBnmn+
         EB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=O041gsmRo9OIv6PV/tHdQSQHlk8a4KIhiJkJ6KRPN6o=;
        b=MIO9Fpe3NV7fhTH7Ryf27v9meFKE9/8cGcAB+bajLduG+C31mrTVnAbdF3hd6lWXL2
         D6xwpoTlQcYE7eGAMzBCZLH5g7OrB1n3bvZb36s99f5x8/XYZ3RXmcqdUSHZWJ6D0uJT
         imVoV4QwpZ6AEGKHUADohxLRKmwunRf9+IkgCCVqE5lKY93guIzPRgi2eH0m5vc7JRzn
         93VsGI12tyeRAzuXpiCRbaZCYUSQ+jJ3Dya1hw9eHch5zuLBKEp9m1/PNRDiSJEvSlC+
         nAhcnmRwH/MvR6wjnVGwcN2BQRBErhFyd4ppppJtFiAG8MhRNu93jwLUvnzlGVyFmSOu
         O/fQ==
X-Gm-Message-State: ACgBeo2SHxZFiQEbEAygk40jy9WRZNDWhN3vTSuTbsJZVgqYry9klrup
        6WprJlWqFXiDvGfuPYOpe24=
X-Google-Smtp-Source: AA6agR5d48RRSp2zFxbchyCO4/r06UsyPSiYoR56c5CPOtAqmkcaeqIbqFOVT5ehZBGs5OGeQsEzVQ==
X-Received: by 2002:adf:fdcf:0:b0:225:65c8:7b7f with SMTP id i15-20020adffdcf000000b0022565c87b7fmr13064711wrs.217.1661979147749;
        Wed, 31 Aug 2022 13:52:27 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4108000000b0021eed2414c9sm12874898wrp.40.2022.08.31.13.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 13:52:27 -0700 (PDT)
Date:   Wed, 31 Aug 2022 22:52:25 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2] landlock: Fix file reparenting without explicit
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <Yw/KCWOQnyehq9wn@nuc>
References: <20220831203840.1370732-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220831203840.1370732-1-mic@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Looks good!

Reviewed-by: G�nther Noack <gnoack3000@gmail.com>

On Wed, Aug 31, 2022 at 10:38:40PM +0200, Micka�l Sala�n wrote:
> This change fixes a mis-handling of the LANDLOCK_ACCESS_FS_REFER right
> when multiple rulesets/domains are stacked. The expected behaviour was
> that an additional ruleset can only restrict the set of permitted
> operations, but in this particular case, it was potentially possible to
> re-gain the LANDLOCK_ACCESS_FS_REFER right.
>
> With the introduction of LANDLOCK_ACCESS_FS_REFER, we added the first
> globally denied-by-default access right.  Indeed, this lifted an initial
> Landlock limitation to rename and link files, which was initially always
> denied when the source or the destination were different directories.
>
> This led to an inconsistent backward compatibility behavior which was
> only taken into account if no domain layer were using the new
> LANDLOCK_ACCESS_FS_REFER right. However, when restricting a thread with
> a new ruleset handling LANDLOCK_ACCESS_FS_REFER, all inherited parent
> rulesets/layers not explicitly handling LANDLOCK_ACCESS_FS_REFER would
> behave as if they were handling this access right and with all their
> rules allowing it. This means that renaming and linking files could
> became allowed by these parent layers, but all the other required
> accesses must also be granted: all layers must allow file removal or
> creation, and renaming and linking operations cannot lead to privilege
> escalation according to the Landlock policy.  See detailed explanation
> in commit b91c3e4ea756 ("landlock: Add support for file reparenting with
> LANDLOCK_ACCESS_FS_REFER").
>
> To say it another way, this bug may lift the renaming and linking
> limitations of the initial Landlock version, and a same ruleset can
> enforce different restrictions depending on previous or next enforced
> ruleset (i.e. inconsistent behavior). The LANDLOCK_ACCESS_FS_REFER right
> cannot give access to data not already allowed, but this doesn't follow
> the contract of the first Landlock ABI. This fix puts back the
> limitation for sandboxes that didn't opt-in for this additional right.
>
> For instance, if a first ruleset allows LANDLOCK_ACCESS_FS_MAKE_REG on
> /dst and LANDLOCK_ACCESS_FS_REMOVE_FILE on /src, renaming /src/file to
> /dst/file is denied. However, without this fix, stacking a new ruleset
> which allows LANDLOCK_ACCESS_FS_REFER on / would now permit the
> sandboxed thread to rename /src/file to /dst/file .
>
> This change fixes the (absolute) rule access rights, which now always
> forbid LANDLOCK_ACCESS_FS_REFER except when it is explicitly allowed
> when creating a rule.
>
> Making all domain handle LANDLOCK_ACCESS_FS_REFER was an initial
> approach but there is two downsides:
> * it makes the code more complex because we still want to check that a
>   rule allowing LANDLOCK_ACCESS_FS_REFER is legitimate according to the
>   ruleset's handled access rights (i.e. ABI v1 != ABI v2);
> * it would not allow to identify if the user created a ruleset
>   explicitly handling LANDLOCK_ACCESS_FS_REFER or not, which will be an
>   issue to audit Landlock.
>
> Instead, this change adds an ACCESS_INITIALLY_DENIED list of
> denied-by-default rights, which (only) contains
> LANDLOCK_ACCESS_FS_REFER.  All domains are treated as if they are also
> handling this list, but without modifying their fs_access_masks field.
>
> A side effect is that the errno code returned by rename(2) or link(2)
> *may* be changed from EXDEV to EACCES according to the enforced
> restrictions.  Indeed, we now have the mechanic to identify if an access
> is denied because of a required right (e.g. LANDLOCK_ACCESS_FS_MAKE_REG,
> LANDLOCK_ACCESS_FS_REMOVE_FILE) or if it is denied because of missing
> LANDLOCK_ACCESS_FS_REFER rights.  This may result in different errno
> codes than for the initial Landlock version, but this approach is more
> consistent and better for rename/link compatibility reasons, and it
> wasn't possible before (hence no backport to ABI v1).  The
> layout1.rename_file test reflects this change.
>
> Add the layout1.refer_denied_by_default* tests to check that the
> behavior of a ruleset not handling LANDLOCK_ACCESS_FS_REFER (ABI v1) is
> unchanged even if another layer handles LANDLOCK_ACCESS_FS_REFER (i.e.
> ABI v1 precedence).  Make sure rule's absolute access rights are correct
> by testing with and without a matching path.  Add test_rename() and
> test_exchange() helpers.
>
> Extend layout1.inval tests to check that a denied-by-default access
> right is not necessarily part of a domain's handled access rights.
>
> Test coverage for security/landlock is 95.3% of 599 lines according to
> gcc/gcov-11.
>
> Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
> Cc: G�nther Noack <gnoack3000@gmail.com>
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Micka�l Sala�n <mic@digikod.net>
> Link: https://lore.kernel.org/r/20220831203840.1370732-1-mic@digikod.net
> ---
>
> Changes since v1:
> https://lore.kernel.org/r/20220823144123.633721-1-mic@digikod.net
> * Improved commit description (suggested by Paul Moore and G�nther Noack).
> * Improved code comments (suggested by G�nther Noack).
> * Simplify get_handled_accesses() (suggested by G�nther Noack).
> * Add and use test_rename() and test_exchange() helpers.
> * Make refer_denied_by_default() more generic and add two more tests to
>   check with a first layer not handling LANDLOCK_ACCESS_FS_REFER
>   (suggested by G�nther Noack).
> ---
>  security/landlock/fs.c                     |  48 ++++---
>  tools/testing/selftests/landlock/fs_test.c | 156 +++++++++++++++++++--
>  2 files changed, 171 insertions(+), 33 deletions(-)
>
> diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> index ec5a6247cd3e..a9dbd99d9ee7 100644
> --- a/security/landlock/fs.c
> +++ b/security/landlock/fs.c
> @@ -149,6 +149,16 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
>  	LANDLOCK_ACCESS_FS_READ_FILE)
>  /* clang-format on */
>
> +/*
> + * All access rights that are denied by default whether they are handled or not
> + * by a ruleset/layer.  This must be ORed with all ruleset->fs_access_masks[]
> + * entries when we need to get the absolute handled access masks.
> + */
> +/* clang-format off */
> +#define ACCESS_INITIALLY_DENIED ( \
> +	LANDLOCK_ACCESS_FS_REFER)
> +/* clang-format on */
> +
>  /*
>   * @path: Should have been checked by get_path_from_fd().
>   */
> @@ -167,7 +177,9 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
>  		return -EINVAL;
>
>  	/* Transforms relative access rights to absolute ones. */
> -	access_rights |= LANDLOCK_MASK_ACCESS_FS & ~ruleset->fs_access_masks[0];
> +	access_rights |=
> +		LANDLOCK_MASK_ACCESS_FS &
> +		~(ruleset->fs_access_masks[0] | ACCESS_INITIALLY_DENIED);
>  	object = get_inode_object(d_backing_inode(path->dentry));
>  	if (IS_ERR(object))
>  		return PTR_ERR(object);
> @@ -277,23 +289,12 @@ static inline bool is_nouser_or_private(const struct dentry *dentry)
>  static inline access_mask_t
>  get_handled_accesses(const struct landlock_ruleset *const domain)
>  {
> -	access_mask_t access_dom = 0;
> -	unsigned long access_bit;
> -
> -	for (access_bit = 0; access_bit < LANDLOCK_NUM_ACCESS_FS;
> -	     access_bit++) {
> -		size_t layer_level;
> +	access_mask_t access_dom = ACCESS_INITIALLY_DENIED;
> +	size_t layer_level;
>
> -		for (layer_level = 0; layer_level < domain->num_layers;
> -		     layer_level++) {
> -			if (domain->fs_access_masks[layer_level] &
> -			    BIT_ULL(access_bit)) {
> -				access_dom |= BIT_ULL(access_bit);
> -				break;
> -			}
> -		}
> -	}
> -	return access_dom;
> +	for (layer_level = 0; layer_level < domain->num_layers; layer_level++)
> +		access_dom |= domain->fs_access_masks[layer_level];
> +	return access_dom & LANDLOCK_MASK_ACCESS_FS;
>  }
>
>  static inline access_mask_t
> @@ -316,8 +317,13 @@ init_layer_masks(const struct landlock_ruleset *const domain,
>
>  		for_each_set_bit(access_bit, &access_req,
>  				 ARRAY_SIZE(*layer_masks)) {
> -			if (domain->fs_access_masks[layer_level] &
> -			    BIT_ULL(access_bit)) {
> +			/*
> +			 * Artificially handles all initially denied by default
> +			 * access rights.
> +			 */
> +			if (BIT_ULL(access_bit) &
> +			    (domain->fs_access_masks[layer_level] |
> +			     ACCESS_INITIALLY_DENIED)) {
>  				(*layer_masks)[access_bit] |=
>  					BIT_ULL(layer_level);
>  				handled_accesses |= BIT_ULL(access_bit);
> @@ -857,10 +863,6 @@ static int current_check_refer_path(struct dentry *const old_dentry,
>  					      NULL, NULL);
>  	}
>
> -	/* Backward compatibility: no reparenting support. */
> -	if (!(get_handled_accesses(dom) & LANDLOCK_ACCESS_FS_REFER))
> -		return -EXDEV;
> -
>  	access_request_parent1 |= LANDLOCK_ACCESS_FS_REFER;
>  	access_request_parent2 |= LANDLOCK_ACCESS_FS_REFER;
>
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 21a2ce8fa739..b4a523bce1b1 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -4,7 +4,7 @@
>   *
>   * Copyright � 2017-2020 Micka�l Sala�n <mic@digikod.net>
>   * Copyright � 2020 ANSSI
> - * Copyright � 2020-2021 Microsoft Corporation
> + * Copyright � 2020-2022 Microsoft Corporation
>   */
>
>  #define _GNU_SOURCE
> @@ -371,6 +371,13 @@ TEST_F_FORK(layout1, inval)
>  	ASSERT_EQ(EINVAL, errno);
>  	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_EXECUTE;
>
> +	/* Tests with denied-by-default access right. */
> +	path_beneath.allowed_access |= LANDLOCK_ACCESS_FS_REFER;
> +	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> +					&path_beneath, 0));
> +	ASSERT_EQ(EINVAL, errno);
> +	path_beneath.allowed_access &= ~LANDLOCK_ACCESS_FS_REFER;
> +
>  	/* Test with unknown (64-bits) value. */
>  	path_beneath.allowed_access |= (1ULL << 60);
>  	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
> @@ -1826,6 +1833,21 @@ TEST_F_FORK(layout1, link)
>  	ASSERT_EQ(0, link(file1_s1d3, file2_s1d3));
>  }
>
> +static int test_rename(const char *oldpath, const char *newpath)
> +{
> +	if (rename(oldpath, newpath) != 0)
> +		return errno;
> +	return 0;
> +}
> +
> +static int test_exchange(const char *oldpath, const char *newpath)
> +{
> +	if (renameat2(AT_FDCWD, oldpath, AT_FDCWD, newpath, RENAME_EXCHANGE) !=
> +	    0)
> +		return errno;
> +	return 0;
> +}
> +
>  TEST_F_FORK(layout1, rename_file)
>  {
>  	const struct rule rules[] = {
> @@ -1867,10 +1889,10 @@ TEST_F_FORK(layout1, rename_file)
>  	 * to a different directory (which allows file removal).
>  	 */
>  	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
> -	ASSERT_EQ(EXDEV, errno);
> +	ASSERT_EQ(EACCES, errno);
>  	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, file1_s1d3,
>  				RENAME_EXCHANGE));
> -	ASSERT_EQ(EXDEV, errno);
> +	ASSERT_EQ(EACCES, errno);
>  	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s1d3,
>  				RENAME_EXCHANGE));
>  	ASSERT_EQ(EXDEV, errno);
> @@ -1894,7 +1916,7 @@ TEST_F_FORK(layout1, rename_file)
>  	ASSERT_EQ(EXDEV, errno);
>  	ASSERT_EQ(0, unlink(file1_s1d3));
>  	ASSERT_EQ(-1, rename(file1_s2d1, file1_s1d3));
> -	ASSERT_EQ(EXDEV, errno);
> +	ASSERT_EQ(EACCES, errno);
>
>  	/* Exchanges and renames files with same parent. */
>  	ASSERT_EQ(0, renameat2(AT_FDCWD, file2_s2d3, AT_FDCWD, file1_s2d3,
> @@ -2014,6 +2036,115 @@ TEST_F_FORK(layout1, reparent_refer)
>  	ASSERT_EQ(0, rename(dir_s1d3, dir_s2d3));
>  }
>
> +/* Checks renames beneath dir_s1d1. */
> +static void refer_denied_by_default(struct __test_metadata *const _metadata,
> +				    const struct rule layer1[],
> +				    const int layer1_err,
> +				    const struct rule layer2[])
> +{
> +	int ruleset_fd;
> +
> +	ASSERT_EQ(0, unlink(file1_s1d2));
> +
> +	ruleset_fd = create_ruleset(_metadata, layer1[0].access, layer1);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * If the first layer handles LANDLOCK_ACCESS_FS_REFER (according to
> +	 * layer1_err), then it allows some different-parent renames and links.
> +	 */
> +	ASSERT_EQ(layer1_err, test_rename(file1_s1d1, file1_s1d2));
> +	if (layer1_err == 0)
> +		ASSERT_EQ(layer1_err, test_rename(file1_s1d2, file1_s1d1));
> +	ASSERT_EQ(layer1_err, test_exchange(file2_s1d1, file2_s1d2));
> +	ASSERT_EQ(layer1_err, test_exchange(file2_s1d2, file2_s1d1));
> +
> +	ruleset_fd = create_ruleset(_metadata, layer2[0].access, layer2);
> +	ASSERT_LE(0, ruleset_fd);
> +	enforce_ruleset(_metadata, ruleset_fd);
> +	ASSERT_EQ(0, close(ruleset_fd));
> +
> +	/*
> +	 * Now, either the first or the second layer does not handle
> +	 * LANDLOCK_ACCESS_FS_REFER, which means that any different-parent
> +	 * renames and links are denied, thus making the layer handling
> +	 * LANDLOCK_ACCESS_FS_REFER null and void.
> +	 */
> +	ASSERT_EQ(EXDEV, test_rename(file1_s1d1, file1_s1d2));
> +	ASSERT_EQ(EXDEV, test_exchange(file2_s1d1, file2_s1d2));
> +	ASSERT_EQ(EXDEV, test_exchange(file2_s1d2, file2_s1d1));
> +}
> +
> +const struct rule layer_dir_s1d1_refer[] = {
> +	{
> +		.path = dir_s1d1,
> +		.access = LANDLOCK_ACCESS_FS_REFER,
> +	},
> +	{},
> +};
> +
> +const struct rule layer_dir_s1d1_execute[] = {
> +	{
> +		/* Matches a parent directory. */
> +		.path = dir_s1d1,
> +		.access = LANDLOCK_ACCESS_FS_EXECUTE,
> +	},
> +	{},
> +};
> +
> +const struct rule layer_dir_s2d1_execute[] = {
> +	{
> +		/* Does not match a parent directory. */
> +		.path = dir_s2d1,
> +		.access = LANDLOCK_ACCESS_FS_EXECUTE,
> +	},
> +	{},
> +};
> +
> +/*
> + * Tests precedence over renames: denied by default for different parent
> + * directories, *with* a rule matching a parent directory, but not directly
> + * denying access (with MAKE_REG nor REMOVE).
> + */
> +TEST_F_FORK(layout1, refer_denied_by_default1)
> +{
> +	refer_denied_by_default(_metadata, layer_dir_s1d1_refer, 0,
> +				layer_dir_s1d1_execute);
> +}
> +
> +/*
> + * Same test but this time turning around the ABI version order: the first
> + * layer does not handle LANDLOCK_ACCESS_FS_REFER.
> + */
> +TEST_F_FORK(layout1, refer_denied_by_default2)
> +{
> +	refer_denied_by_default(_metadata, layer_dir_s1d1_execute, EXDEV,
> +				layer_dir_s1d1_refer);
> +}
> +
> +/*
> + * Tests precedence over renames: denied by default for different parent
> + * directories, *without* a rule matching a parent directory, but not directly
> + * denying access (with MAKE_REG nor REMOVE).
> + */
> +TEST_F_FORK(layout1, refer_denied_by_default3)
> +{
> +	refer_denied_by_default(_metadata, layer_dir_s1d1_refer, 0,
> +				layer_dir_s2d1_execute);
> +}
> +
> +/*
> + * Same test but this time turning around the ABI version order: the first
> + * layer does not handle LANDLOCK_ACCESS_FS_REFER.
> + */
> +TEST_F_FORK(layout1, refer_denied_by_default4)
> +{
> +	refer_denied_by_default(_metadata, layer_dir_s2d1_execute, EXDEV,
> +				layer_dir_s1d1_refer);
> +}
> +
>  TEST_F_FORK(layout1, reparent_link)
>  {
>  	const struct rule layer1[] = {
> @@ -2336,11 +2467,12 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename1)
>  	ASSERT_EQ(EXDEV, errno);
>
>  	/*
> -	 * However, moving the file2_s1d3 file below dir_s2d3 is allowed
> -	 * because it cannot inherit MAKE_REG nor MAKE_DIR rights (which are
> -	 * dedicated to directories).
> +	 * Moving the file2_s1d3 file below dir_s2d3 is denied because the
> +	 * second layer does not handle REFER, which is always denied by
> +	 * default.
>  	 */
> -	ASSERT_EQ(0, rename(file2_s1d3, file1_s2d3));
> +	ASSERT_EQ(-1, rename(file2_s1d3, file1_s2d3));
> +	ASSERT_EQ(EXDEV, errno);
>  }
>
>  TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
> @@ -2373,8 +2505,12 @@ TEST_F_FORK(layout1, reparent_exdev_layers_rename2)
>  	ASSERT_EQ(EACCES, errno);
>  	ASSERT_EQ(-1, rename(file1_s1d1, file1_s2d3));
>  	ASSERT_EQ(EXDEV, errno);
> -	/* Modify layout! */
> -	ASSERT_EQ(0, rename(file2_s1d2, file1_s2d3));
> +	/*
> +	 * Modifying the layout is now denied because the second layer does not
> +	 * handle REFER, which is always denied by default.
> +	 */
> +	ASSERT_EQ(-1, rename(file2_s1d2, file1_s2d3));
> +	ASSERT_EQ(EXDEV, errno);
>
>  	/* Without REFER source, EACCES wins over EXDEV. */
>  	ASSERT_EQ(-1, rename(dir_s1d1, file1_s2d2));
>
> base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
> --
> 2.37.2
>

--
