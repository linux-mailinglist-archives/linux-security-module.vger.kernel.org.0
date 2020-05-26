Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF641A0D60
	for <lists+linux-security-module@lfdr.de>; Tue,  7 Apr 2020 14:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGMN7 (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 7 Apr 2020 08:13:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45913 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgDGMN4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 7 Apr 2020 08:13:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id t17so3386484ljc.12
        for <linux-security-module@vger.kernel.org>; Tue, 07 Apr 2020 05:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4RF1YD/5sqADQCPTZv6CvJWJFYXQRD5sE8C1DFw19g=;
        b=uMEXygrPcEDbB5FEYNml3M2+jHDd8ImUbvyp99bm5VacssP4+gPnlhzIcBgzsPqNLY
         TVZnFKP7wUryHDTTL2hEsbDauTZ40LESZVZ/9NWOZuPQpbveUE/SzhhCySUUQfeOfZ91
         GdoZbEdWbTiOThTdSrjCN91H1zEHKrwkvDAyIlUtBQQ3OKBHK6F7oHkX5U5be6cJZher
         aTy2hyxxRDGjikI6HHAOkQnc5h6hk03DufS4qi8lZK9yJnKR6ujwMYgAQ5CyOuSAd8GD
         tGLaYp3HUdnC0vl2ivdhfXJXKrG/OpTr895YplbJkIkTvEXRHG7UEQMlWfqcT2Y9qUp7
         vslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4RF1YD/5sqADQCPTZv6CvJWJFYXQRD5sE8C1DFw19g=;
        b=pfgycWlRwYt9dxPqlyhogMNnNYF/CyFrvdkvuNvCWy2rdi6ITqbvV9hzTTZx7FnI9a
         9YTXJ/aVMjJGFRxronYjr7FtMJmqch7KZCWcmQuGvL13t+RU5MwxCQNEPRHiEzVge4TC
         3Mu3tXZtl7GNUeRoztqEt1fgFi/G1h58d+EEPBjvEhtLX04wH++FQ7RwXCq5M6+12ItG
         snEEeeV150jTyNdejWJWN1O73U0HmExl0BjJ18v06C6Nc4q7M6jI1wpzHi1Yknz+gR9c
         A89xZFQLTyjfwJjs7JZI6/GeWBTHwGDVa2tz9Odp5LS/FhWKRDEk/1oUj9f4mcrludSa
         p/dw==
X-Gm-Message-State: AGi0PuYbh61aLJvh1u0K7vee/FeCDdrT2M46lALthBgTD9FGPE/1kAjW
        QBlci/Ywm9cJHS/Nu7RDZzVuo+4SJAp2fvspGf9D9g==
X-Google-Smtp-Source: APiQypLKald8DmWBLVrdztvPIHxinp+Zm+ABMx+AP5EyBEYxee1o/AQHTA+xjCYdm1dNuzEp6le22WwBHQ9zFUNapf0=
X-Received: by 2002:a2e:7513:: with SMTP id q19mr1607544ljc.221.1586261630756;
 Tue, 07 Apr 2020 05:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200406221439.1469862-1-deven.desai@linux.microsoft.com> <20200406221439.1469862-3-deven.desai@linux.microsoft.com>
In-Reply-To: <20200406221439.1469862-3-deven.desai@linux.microsoft.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 7 Apr 2020 14:13:24 +0200
Message-ID: <CAG48ez3oT4PvLThTqyruoTaNuYRcM_-dy5Vtdpugk2-7zJ8bXw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/12] security: add ipe lsm evaluation loop and
 audit system
To:     deven.desai@linux.microsoft.com
Cc:     agk@redhat.com, Jens Axboe <axboe@kernel.dk>, snitzer@redhat.com,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        tyhicks@linux.microsoft.com,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Sasha Levin <sashal@kernel.org>,
        jaskarankhurana@linux.microsoft.com, nramas@linux.microsoft.com,
        mdsakib@linux.microsoft.com,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Tue, Apr 7, 2020 at 12:14 AM <deven.desai@linux.microsoft.com> wrote:
> Add the core logic of the IPE LSM, the evaluation loop (engine),
> the audit system, and the skeleton of the policy structure.

Here's a first review pass for this patch without really understanding
your data structures yet:

[...]
> diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
> new file mode 100644
> index 000000000000..0c67cd049d0c
> --- /dev/null
> +++ b/security/ipe/Kconfig
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Integrity Policy Enforcement (IPE) configuration
> +#
> +
> +menuconfig SECURITY_IPE
> +       bool "Integrity Policy Enforcement (IPE)"
> +       depends on SECURITY && AUDIT
> +       select SYSTEM_DATA_VERIFICATION
> +       help
> +         This option enables the Integrity Policy Enforcement subsystem,
> +         allowing systems to enforce integrity requirements on various
> +         aspects of user-mode applications. These requirements are
> +         controlled by a policy.

This text is very generic and doesn't really make it clear how IPE is
different from other LSMs; could you perhaps add some more text here
on the parts of IPE that distinguish it from other LSMs?

In the cover letter, you have this stuff at the top:

"""
The type of system for which IPE is designed for use is an embedded device
with a specific purpose (e.g. network firewall device in a data center),
where all software and configuration is built and provisioned by the owner.

Specifically, a system which leverages IPE is not intended for general
purpose computing and does not utilize any software or configuration
built by a third party. An ideal system to leverage IPE has both mutable
and immutable components, however, all binary executable code is immutable.

The scope of IPE is constrained to the OS. It is assumed that platform
firmware verifies the the kernel and optionally the root filesystem (e.g.
via U-Boot verified boot). IPE then utilizes LSM hooks to enforce a
flexible, kernel-resident integrity verification policy.

IPE differs from other LSMs which provide integrity checking (for instance,
IMA), as it has no dependency on the filesystem metadata itself. The
attributes that IPE checks are deterministic properties that exist solely
in the kernel. Additionally, IPE provides no additional mechanisms of
verifying these files (e.g. IMA Signatures) - all of the attributes of
verifying files are existing features within the kernel, such as dm-verity
or fsverity.

IPE provides a policy that allows owners of the system to easily specify
integrity requirements and uses dm-verity signatures to simplify the
authentication of allowed objects like authorized code and data.
"""

Perhaps you could add a summary of that here?

[...]
> diff --git a/security/ipe/ipe-audit.c b/security/ipe/ipe-audit.c
[...]
> +void ipe_audit_mode(void)
> +{
> +       struct audit_buffer *ab;
> +
> +       ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
> +                            AUDIT_INTEGRITY_MODE);

Why is this GFP_ATOMIC? ipe_audit_mode() is used from
ipe_switch_mode(), which is allowed to sleep, right?

> +       if (!ab)
> +               return;
> +
> +       audit_log_format(ab, "IPE mode=%s", (enforce) ? IPE_MODE_ENFORCE :
> +                                                       IPE_MODE_PERMISSIVE);
> +
> +       audit_log_end(ab);
> +}
[...]
> +/**
> + * ipe_audit_ignore_line: Emit a warning that the line was not understood by
> + *                       IPE's parser and the line will be ignored and not
> + *                       parsed.
> + * @line_num: line number that is being ignored.
> + */
> +void ipe_audit_ignore_line(size_t i)
> +{
> +       pr_warn("failed to parse line number %zu, ignoring", i);
> +}

It seems a bit silly to have an extra method just for this?

> +/**
> + * ipe_audit_policy_activation: Emit an audit event that a specific policy
> + *                             was activated as the active policy.
> + * @pol: policy that is being activated
> + */
> +void ipe_audit_policy_activation(const struct ipe_policy *pol)
> +{
> +       struct audit_buffer *ab;
> +
> +       ab = audit_log_start(audit_context(), GFP_ATOMIC | __GFP_NOWARN,
> +                            AUDIT_INTEGRITY_POLICY_ACTIVATE);

Again, this runs in sleepable context and GFP_ATOMIC is unnecessary, right?

> +       if (!ab)
> +               return;
> +
> +       audit_log_format(ab, POLICY_ACTIVATE_STR, pol->policy_name,
> +                        pol->policy_version.major, pol->policy_version.minor,
> +                        pol->policy_version.rev);
> +
> +       audit_log_end(ab);
> +}
[...]
> diff --git a/security/ipe/ipe-engine.c b/security/ipe/ipe-engine.c
[...]
> +/**
> + * get_audit_pathname: Return the absolute path of the file struct passed in
> + * @file: file to derive an absolute path from.
> + *
> + * This function walks past chroots and mount points.
[...]
> + */
> +static char *get_audit_pathname(const struct file *file)
> +{
[...]
> +       sb = file->f_path.dentry->d_sb;
> +
> +       pathbuf = __getname();
> +       if (!pathbuf) {
> +               rc = -ENOMEM;
> +               goto err;
> +       }
> +
> +       pos = d_absolute_path(&file->f_path, pathbuf, PATH_MAX);

Just as an FYI, no change required: d_absolute_path() will also
succeed for files that are not contained within the filesystem root of
the current process; in that case, you'll get stuff like paths rooted
in a different mount namespace.

> +       if (IS_ERR(pos)) {
> +               rc = PTR_ERR(pos);
> +               goto err;
> +       }
> +
> +       temp_path = __getname();
> +       if (!temp_path) {
> +               rc = -ENOMEM;
> +               goto err;
> +       }
> +
> +       strlcpy(temp_path, pos, PATH_MAX);
> +
> +       if (pathbuf)

This check seems superfluous.

> +               __putname(pathbuf);
> +
> +       return temp_path;
> +err:
> +       if (pathbuf)
> +               __putname(pathbuf);
> +       if (temp_path)
> +               __putname(temp_path);
> +
> +       return ERR_PTR(rc);
> +}
[...]
> +/**
> + * prealloc_cache: preallocate the cache tree for all ipe properties, so
> + *                that this data maybe used later in the read side critical

s/maybe/may be/

> + *                section.
> + * @ctx: Ipe engine context structure passed to the property prealloc function.
> + * @cache: Root of the cache tree to insert nodes under.
> + *
> + * Return:
> + * 0 - OK
> + * -ENOMEM - Out of memory
> + * Other - See individual property preallocator functions.
> + */
> +static int prealloc_cache(struct ipe_engine_ctx *ctx,
> +                         struct rb_root *cache)
> +{
> +       int rc = 0;
> +       struct rb_node *node;
> +       struct ipe_prop_reg *reg;
> +       struct ipe_prop_cache *storage;
> +
> +       for (node = rb_first(&ipe_registry_root); node; node = rb_next(node)) {
> +               reg = container_of(node, struct ipe_prop_reg, node);
> +
> +               storage = insert_or_find_cache(cache, reg->prop);
> +               if (IS_ERR(storage))
> +                       return PTR_ERR(storage);
> +
> +               if (reg->prop->prealloc) {
> +                       rc = reg->prop->prealloc(ctx, &storage->storage);
> +                       if (rc != 0)
> +                               return rc;
> +               }
> +       }
> +
> +       return rc;
> +}
> +
> +/**
> + * evaluate: Process an @ctx against IPE's current active policy.
> + * @ctx: the engine ctx to perform an evaluation on.
> + * @cache: the red-black tree root that is used for cache storage.
> + *
> + * This uses a preallocated @cache as storage for the properties to avoid
> + * re-evaulation.
> + *
> + * Return:
> + * -EACCES - A match occurred against a "action=DENY" rule
> + * -ENOMEM - Out of memory
> + */
> +static int evaluate(struct ipe_engine_ctx *ctx, struct rb_root *cache)
> +{
> +       int rc = 0;
> +       bool match = false;
> +       enum ipe_action action;
> +       struct ipe_prop_cache *c;
> +       enum ipe_match match_type;
> +       const struct ipe_rule *rule;
> +       const struct ipe_policy *pol;
> +       const struct ipe_rule_table *rules;
> +       const struct ipe_prop_container *prop;
> +
> +       if (!ipe_active_policy)

Please use rcu_access_pointer() here.

> +               return rc;
> +
> +       rcu_read_lock();
> +
> +       pol = rcu_dereference(ipe_active_policy);
> +
> +       rules = &pol->ops[ctx->op];
> +
> +       list_for_each_entry(rule, &rules->rules, next) {
> +               match = true;
> +
> +               list_for_each_entry(prop, &rule->props, next) {
> +                       void *cache = NULL;
> +
> +                       if (prop->prop->prealloc) {
> +                               c = insert_or_find_cache(cache, prop->prop);

What's going on with the `cache` pointer here? We give
insert_or_find_cache() a NULL cache, and then in
insert_or_find_cache() `new` will be a near-NULL pointer, and it'll
crash immediately at `while (*new)`? Am I missing something?

Also, I think the intent here is that the preceding call to
prealloc_cache() should have allocated memory for us. If so, can you
please add a short comment here, something like "/* won't sleep
because of preceding prealloc_cache() */"?

> +                               if (IS_ERR(c))
> +                                       return PTR_ERR(c);
> +
> +                               cache = c->storage;
> +                       }
> +
> +                       match = match && prop->prop->eval(ctx, prop->value,
> +                                                         &cache);
> +               }
> +
> +               if (match)
> +                       break;
> +       }
> +
> +       if (match) {
> +               match_type = ipe_match_rule;
> +               action = rule->action;
> +       } else if (rules->def != ipe_action_unset) {
> +               match_type = ipe_match_table;
> +               action = rules->def;
> +               rule = NULL;
> +       } else {
> +               match_type = ipe_match_global;
> +               action = pol->def;
> +               rule = NULL;
> +       }
> +
> +       ipe_audit_match(ctx, cache, match_type, action, rule);
> +
> +       if (action == ipe_action_deny)
> +               rc = -EACCES;
> +
> +       if (enforce == 0)
> +               rc = 0;
> +
> +       rcu_read_unlock();
> +       return rc;
> +}
> +
> +/**
> + * ipe_process_event: Perform an evaluation of @file, @op, and @hook against
> + *                   IPE's current active policy.
> + * @file: File that is being evaluated against IPE policy.
> + * @op: Operation that the file is being evaluated against.
> + * @hook: Specific hook that the file is being evaluated through.
> + *
> + * Return:
> + * -ENOMEM: (No Memory)
> + * -EACCES: (A match occurred against a "action=DENY" rule)
> + */
> +int ipe_process_event(const struct file *file, enum ipe_op op,
> +                     enum ipe_hook hook)
> +{
> +       int rc = 0;
> +       struct ipe_engine_ctx *ctx;
> +       struct rb_root cache = RB_ROOT;
> +
> +       ctx = build_ctx(file, op, hook);
> +       if (IS_ERR(ctx))
> +               goto cleanup;
> +
> +       rc = prealloc_cache(ctx, &cache);
> +       if (rc != 0)
> +               goto cleanup;
> +
> +       rc = evaluate(ctx, &cache);
> +
> +cleanup:
> +       free_ctx(ctx);
> +       destroy_cache(&cache);
> +       return rc;
> +}
[...]
> diff --git a/security/ipe/ipe-hooks.c b/security/ipe/ipe-hooks.c
[..]
> +#define HAS_EXEC(_p, _rp) (((_rp) & PROT_EXEC) || ((_p) & PROT_EXEC))

This should be unnecessary; reqprot are the protections requested by
userspace, prot are the possibly expanded protections the kernel is
applying. I think you just want to use prot and ignore reqprot.

[...]
> diff --git a/security/ipe/ipe-policy.h b/security/ipe/ipe-policy.h
[...]
> +extern const char *const ipe_boot_policy;

I don't see anything in the entire patch series that actually sets
this variable. Am I missing something?

> +extern const struct ipe_policy *ipe_active_policy;
[...]
> diff --git a/security/ipe/ipe-property.c b/security/ipe/ipe-property.c
[...]
> +/* global root containing all registered properties */
> +struct rb_root ipe_registry_root = RB_ROOT;
[...]
> +static struct ipe_prop_reg *reg_lookup(const char *key)
> +{
> +       struct rb_node *n = ipe_registry_root.rb_node;
> +
> +       while (n) {
> +               int r;
> +               struct ipe_prop_reg *reg =
> +                       container_of(n, struct ipe_prop_reg, node);
> +
> +               r = strcmp(reg->prop->property_name, key);
> +               if (r == 0)
> +                       return reg;
> +               else if (r > 0)
> +                       n = n->rb_right;
> +               else
> +                       n = n->rb_left;
> +       }
> +
> +       return NULL;
> +}

Where is the locking for ipe_registry_root? I've looked through the
callers and can't find it. Also, please add a lockdep assertion
(`lockdep_assert_held(...)`) here if possible to ensure that when the
kernel is buildt with appropriate debugging options turned on
(CONFIG_LOCKDEP), it will warn about calling this method with
inappropriate locking.

[...]
> +/**
> + * ipe_register_property: Insert a property into the registration system.
> + * @prop: Read-only property structure containing the property_name, as well
> + *       as the necessary function pointers for a property.
> + *
> + * The caller needs to maintain the lifetime of @prop throughout the life of
> + * the system, after calling ipe_register_property.
> + *
> + * All necessary properties need to be loaded via this method before
> + * loading a policy, otherwise the properties will be ignored as unknown.
> + *
> + * Return:
> + * 0 - OK
> + * -EEXIST - A key exists with the name @prop->property_name
> + * -ENOMEM - Out of memory
> + */
> +int ipe_register_property(const struct ipe_property *prop);

Normal Linux kernel style is to have comments on the definitions of
methods (in the .c files), not in the headers. It looks like you
duplicated the same comment between the header and the .c file -
please don't do that. Same thing in a bunch of other places.

> +#endif /* IPE_PROPERTY_H */
> diff --git a/security/ipe/ipe-sysfs.c b/security/ipe/ipe-sysfs.c
[...]
> +#else /* !CONFIG_SYSCTL */
> +
> +/**
> + * ipe_sysctl_init: Initialize IPE's sysfs entries.
> + *
> + * Return:
> + * 0 - OK
> + * -ENOMEM - Sysctl registration failed
> + */
> +inline int __init ipe_sysctl_init(void)

"inline" doesn't make sense to me if the caller is in a different
compilation unit

[...]
> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
[...]
> +/**
> + * ipe_load_properties: Call the property entry points for all the IPE modules
> + *                     that were selected at kernel build-time.
> + *
> + * Return:
> + * 0 - OK
> + */
> +static int __init ipe_load_properties(void)
> +{
> +       return 0;
> +}

this belongs in patch 4 ("ipe: add property for trust of boot volume")

[...]
> +static int __init ipe_init(void)
> +{
> +       int rc = 0;

useless initialization

> +       rc = ipe_sysctl_init();
> +       if (rc != 0)
> +               pr_err("failed to configure sysctl: %d", -rc);

pr_err() needs to have an explicit \n at the end of the message unless
you're planning to continue printing more text on the same line via
pr_cont(). Same issue in many other places.

> +
> +       pr_info("mode=%s", (enforce == 1) ? IPE_MODE_ENFORCE :
> +                                           IPE_MODE_PERMISSIVE);
> +
> +       RCU_INIT_POINTER(ipe_active_policy, NULL);

Why? Statically allocated variables are zero-initialized by default in C.

> +       security_add_hooks(ipe_hooks, ARRAY_SIZE(ipe_hooks), "IPE");
> +
> +       return rc;
> +}
[...]
> +/**
> + * enforce: Kernel command line parameter to set the permissive mode for IPE
> + *         at system startup. By default, this will always be in enforce mode.
> + *
> + * This is also controlled by the sysctl, "ipe.enforce".
> + */
> +module_param(enforce, int, 0644);
> +MODULE_PARM_DESC(enforce, "enforce/permissive mode switch");
[...]
> +/**
> + * success_audit: Kernel command line parameter to enable success auditing
> + *               (emit an audit event when a file is allowed) at system
> + *               startup. By default, this will be off.
> + *
> + * This is also controlled by the sysctl, "ipe.success_audit".
> + */
> +int success_audit;
> +module_param(success_audit, int, 0644);
> +MODULE_PARM_DESC(success_audit, "audit message on allow");

There is a pending patch series that will allow setting arbitrary
sysctls from the kernel command line
(https://lore.kernel.org/lkml/20200330115535.3215-1-vbabka@suse.cz/);
if that also works for your usecase, you should probably avoid
explicitly adding module parameters here, unless that is necessary
because the pending series sets the sysctls too late.

> diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
[...]
> +extern int enforce;
> +extern int success_audit;

You probably shouldn't be defining global symbols with such broad
names to avoid colliding with global symbols defined elsewhere in the
kernel. Consider adding "ipe_" prefixes to the variable names, or
something like that.
