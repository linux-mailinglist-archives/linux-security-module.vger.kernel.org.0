Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB495BBEF6
	for <lists+linux-security-module@lfdr.de>; Tue, 24 Sep 2019 01:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbfIWXan (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 23 Sep 2019 19:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729152AbfIWXan (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Sep 2019 19:30:43 -0400
Received: from paulmck-ThinkPad-P72 (unknown [170.225.9.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 358092064A;
        Mon, 23 Sep 2019 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569281441;
        bh=sQDrHAdQ3l8FiIGsg2kwACUcZTsLaduecTDDsqnCmS8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nxJQyb7jymP1OSEO8PXXzJh6q5DKzU+pwxN8NscTMKcavORfsVQAyv7fU5B/PjEyP
         C/v8nFzXPBAhTSletQq+gjHN44aLwoSQJZezFa0CX73n9zIZBdgQKnM66Lfkce3dKe
         n9GzoZ1JDML22PYORku4E14XyIXWu7+u52skas2w=
Date:   Mon, 23 Sep 2019 16:30:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Micah Morton <mortonm@chromium.org>, Jann Horn <jannh@google.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] SafeSetID LSM changes for 5.4
Message-ID: <20190923233038.GE7828@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAJ-EccM49yBA+xgkR+3m5pEAJqmH_+FxfuAjijrQxaxxMUAt3Q@mail.gmail.com>
 <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiAsJLw1egFEE=Z7-GGtM6wcvtyytXZA1+BHqta4gg6Hw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Mon, Sep 23, 2019 at 12:01:49PM -0700, Linus Torvalds wrote:
> On Wed, Sep 18, 2019 at 10:41 AM Micah Morton <mortonm@chromium.org> wrote:
> >
> > Fix for SafeSetID bug that was introduced in 5.3
> 
> So this seems to be a good fix, but the bug itself came from the fact that
> 
>     rcu_swap_protected(..)
> 
> is so hard to read, and I don't see *why* it's so pointlessly hard to read.
> 
> Yes, we have some macros that change their arguments, but they have a
> _reason_ to do so (ie they return two different values) and they tend
> to be very special in other ways too.
> 
> But rcu_swap_protected() has no reason for it's odd semantics.
> 
> Looking at that 'handle_policy_update()' function, it's entirely
> reasonable to think "pol cannot possibly be NULL". When I looked at
> the fix patch, that was my initial reaction too, and it's probably the
> reason Jann's commit 03638e62f55f ("LSM: SafeSetID: rewrite userspace
> API to atomic updates") had that bug to begin with.
> 
> I don't see the original discussion at all, it's not on
> Linux-Security-Module for some reason, so I can't tell when/if the
> NULL pointer test got deleted.
> 
> Anyway, this bug would likely had been avoided if rcu_swap_protected()
> just returned the old pointer instead of changing the argument.
> 
> There are only a handful or users of that macro, maybe this could be fixed?

I pushed some (untested) commits out to the dev branch of -rcu, the
overall effect of which is shown in the patch below.  The series
adds a new rcu_replace() to avoid confusion with swap(), replaces
uses of rcu_swap_protected() with rcu_replace(), and finally removes
rcu_swap_protected().

Is this what you had in mind?

Unless you tell me otherwise, I will assume that this change is important
but not violently urgent.  (As in not for the current merge window.)

							Thanx, Paul

------------------------------------------------------------------------
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 46875bb..4c37266 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -416,8 +416,8 @@ int kvm_vm_ioctl_set_pmu_event_filter(struct kvm *kvm, void __user *argp)
 	*filter = tmp;
 
 	mutex_lock(&kvm->lock);
-	rcu_swap_protected(kvm->arch.pmu_event_filter, filter,
-			   mutex_is_locked(&kvm->lock));
+	filter = rcu_replace(kvm->arch.pmu_event_filter, filter,
+			     mutex_is_locked(&kvm->lock));
 	mutex_unlock(&kvm->lock);
 
 	synchronize_srcu_expedited(&kvm->srcu);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 0f2c22a..ebb4f15 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -1683,7 +1683,7 @@ set_engines(struct i915_gem_context *ctx,
 		i915_gem_context_set_user_engines(ctx);
 	else
 		i915_gem_context_clear_user_engines(ctx);
-	rcu_swap_protected(ctx->engines, set.engines, 1);
+	set.engines = rcu_replace(ctx->engines, set.engines, 1);
 	mutex_unlock(&ctx->engines_mutex);
 
 	call_rcu(&set.engines->rcu, free_engines_rcu);
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 1f5b5c8..6a38d4a 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -434,8 +434,8 @@ static void scsi_update_vpd_page(struct scsi_device *sdev, u8 page,
 		return;
 
 	mutex_lock(&sdev->inquiry_mutex);
-	rcu_swap_protected(*sdev_vpd_buf, vpd_buf,
-			   lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_buf = rcu_replace(*sdev_vpd_buf, vpd_buf,
+			      lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_buf)
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 64c96c7..8d17779 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -466,10 +466,10 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 	sdev->request_queue = NULL;
 
 	mutex_lock(&sdev->inquiry_mutex);
-	rcu_swap_protected(sdev->vpd_pg80, vpd_pg80,
-			   lockdep_is_held(&sdev->inquiry_mutex));
-	rcu_swap_protected(sdev->vpd_pg83, vpd_pg83,
-			   lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pg80 = rcu_replace(sdev->vpd_pg80, vpd_pg80,
+			       lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pg83 = rcu_replace(sdev->vpd_pg83, vpd_pg83,
+			       lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_pg83)
diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
index 21eb0c0..e594598 100644
--- a/fs/afs/vl_list.c
+++ b/fs/afs/vl_list.c
@@ -279,8 +279,8 @@ struct afs_vlserver_list *afs_extract_vlserver_list(struct afs_cell *cell,
 			struct afs_addr_list *old = addrs;
 
 			write_lock(&server->lock);
-			rcu_swap_protected(server->addresses, old,
-					   lockdep_is_held(&server->lock));
+			old = rcu_replace(server->addresses, old,
+					  lockdep_is_held(&server->lock));
 			write_unlock(&server->lock);
 			afs_put_addrlist(old);
 		}
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 80d6056..968d258 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -383,20 +383,22 @@ do {									      \
 } while (0)
 
 /**
- * rcu_swap_protected() - swap an RCU and a regular pointer
- * @rcu_ptr: RCU pointer
+ * rcu_replace() - replace an RCU pointer, returning its old value
+ * @rcu_ptr: RCU pointer, whose old value is returned
  * @ptr: regular pointer
- * @c: the conditions under which the dereference will take place
+ * @c: the lockdep conditions under which the dereference will take place
  *
- * Perform swap(@rcu_ptr, @ptr) where @rcu_ptr is an RCU-annotated pointer and
- * @c is the argument that is passed to the rcu_dereference_protected() call
- * used to read that pointer.
+ * Perform a replacement, where @rcu_ptr is an RCU-annotated
+ * pointer and @c is the lockdep argument that is passed to the
+ * rcu_dereference_protected() call used to read that pointer.  The old
+ * value of @rcu_ptr is returned, and @rcu_ptr is set to @ptr.
  */
-#define rcu_swap_protected(rcu_ptr, ptr, c) do {			\
+#define rcu_replace(rcu_ptr, ptr, c)					\
+({									\
 	typeof(ptr) __tmp = rcu_dereference_protected((rcu_ptr), (c));	\
 	rcu_assign_pointer((rcu_ptr), (ptr));				\
-	(ptr) = __tmp;							\
-} while (0)
+	__tmp;								\
+})
 
 /**
  * rcu_access_pointer() - fetch RCU pointer with no dereferencing
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 0a00eac..cee7f08 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -180,8 +180,8 @@ static void activate_effective_progs(struct cgroup *cgrp,
 				     enum bpf_attach_type type,
 				     struct bpf_prog_array *old_array)
 {
-	rcu_swap_protected(cgrp->bpf.effective[type], old_array,
-			   lockdep_is_held(&cgroup_mutex));
+	old_array = rcu_replace(cgrp->bpf.effective[type], old_array,
+				lockdep_is_held(&cgroup_mutex));
 	/* free prog array after grace period, since __cgroup_bpf_run_*()
 	 * might be still walking the array
 	 */
diff --git a/net/core/dev.c b/net/core/dev.c
index fc676b2..c60454d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1288,8 +1288,8 @@ int dev_set_alias(struct net_device *dev, const char *alias, size_t len)
 	}
 
 	mutex_lock(&ifalias_mutex);
-	rcu_swap_protected(dev->ifalias, new_alias,
-			   mutex_is_locked(&ifalias_mutex));
+	new_alias = rcu_replace(dev->ifalias, new_alias,
+				mutex_is_locked(&ifalias_mutex));
 	mutex_unlock(&ifalias_mutex);
 
 	if (new_alias)
diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 9408f92..635d202 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -345,8 +345,8 @@ int reuseport_detach_prog(struct sock *sk)
 	spin_lock_bh(&reuseport_lock);
 	reuse = rcu_dereference_protected(sk->sk_reuseport_cb,
 					  lockdep_is_held(&reuseport_lock));
-	rcu_swap_protected(reuse->prog, old_prog,
-			   lockdep_is_held(&reuseport_lock));
+	old_prog = rcu_replace(reuse->prog, old_prog,
+			       lockdep_is_held(&reuseport_lock));
 	spin_unlock_bh(&reuseport_lock);
 
 	if (!old_prog)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 605a7cf..ea8f7cf 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1456,8 +1456,9 @@ static void nft_chain_stats_replace(struct nft_trans *trans)
 	if (!nft_trans_chain_stats(trans))
 		return;
 
-	rcu_swap_protected(chain->stats, nft_trans_chain_stats(trans),
-			   lockdep_commit_lock_is_held(trans->ctx.net));
+	nft_trans_chain_stats(trans) =
+		rcu_replace(chain->stats, nft_trans_chain_stats(trans),
+			    lockdep_commit_lock_is_held(trans->ctx.net));
 
 	if (!nft_trans_chain_stats(trans))
 		static_branch_inc(&nft_counters_enabled);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3397122..56fe6f8 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -88,7 +88,7 @@ struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 					 struct tcf_chain *goto_chain)
 {
 	a->tcfa_action = action;
-	rcu_swap_protected(a->goto_chain, goto_chain, 1);
+	goto_chain = rcu_replace(a->goto_chain, goto_chain, 1);
 	return goto_chain;
 }
 EXPORT_SYMBOL(tcf_action_set_ctrlact);
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 621fb22..d4c5713 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -100,8 +100,8 @@ static int tcf_csum_init(struct net *net, struct nlattr *nla,
 
 	spin_lock_bh(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
-	rcu_swap_protected(p->params, params_new,
-			   lockdep_is_held(&p->tcf_lock));
+	params_new = rcu_replace(p->params, params_new,
+				 lockdep_is_held(&p->tcf_lock));
 	spin_unlock_bh(&p->tcf_lock);
 
 	if (goto_ch)
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index b501ce0..167baaf 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -721,7 +721,7 @@ static int tcf_ct_init(struct net *net, struct nlattr *nla,
 
 	spin_lock_bh(&c->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
-	rcu_swap_protected(c->params, params, lockdep_is_held(&c->tcf_lock));
+	params = rcu_replace(c->params, params, lockdep_is_held(&c->tcf_lock));
 	spin_unlock_bh(&c->tcf_lock);
 
 	if (goto_ch)
diff --git a/net/sched/act_ctinfo.c b/net/sched/act_ctinfo.c
index 10eb2bb..6d5a34d 100644
--- a/net/sched/act_ctinfo.c
+++ b/net/sched/act_ctinfo.c
@@ -256,8 +256,8 @@ static int tcf_ctinfo_init(struct net *net, struct nlattr *nla,
 
 	spin_lock_bh(&ci->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, actparm->action, goto_ch);
-	rcu_swap_protected(ci->params, cp_new,
-			   lockdep_is_held(&ci->tcf_lock));
+	cp_new = rcu_replace(ci->params, cp_new,
+			     lockdep_is_held(&ci->tcf_lock));
 	spin_unlock_bh(&ci->tcf_lock);
 
 	if (goto_ch)
diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 41d5398..eea4772 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -587,7 +587,7 @@ static int tcf_ife_init(struct net *net, struct nlattr *nla,
 		spin_lock_bh(&ife->tcf_lock);
 	/* protected by tcf_lock when modifying existing action */
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
-	rcu_swap_protected(ife->params, p, 1);
+	p = rcu_replace(ife->params, p, 1);
 
 	if (exists)
 		spin_unlock_bh(&ife->tcf_lock);
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 055faa2..72ec97c 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -177,8 +177,8 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 			goto put_chain;
 		}
 		mac_header_xmit = dev_is_mac_header_xmit(dev);
-		rcu_swap_protected(m->tcfm_dev, dev,
-				   lockdep_is_held(&m->tcf_lock));
+		dev = rcu_replace(m->tcfm_dev, dev,
+				  lockdep_is_held(&m->tcf_lock));
 		if (dev)
 			dev_put(dev);
 		m->tcfm_mac_header_xmit = mac_header_xmit;
diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
index ca2597c..e33ce9c 100644
--- a/net/sched/act_mpls.c
+++ b/net/sched/act_mpls.c
@@ -256,7 +256,7 @@ static int tcf_mpls_init(struct net *net, struct nlattr *nla,
 
 	spin_lock_bh(&m->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
-	rcu_swap_protected(m->mpls_p, p, lockdep_is_held(&m->tcf_lock));
+	p = rcu_replace(m->mpls_p, p, lockdep_is_held(&m->tcf_lock));
 	spin_unlock_bh(&m->tcf_lock);
 
 	if (goto_ch)
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index a065f62..6d4817e 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -182,9 +182,9 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 		police->tcfp_ptoks = new->tcfp_mtu_ptoks;
 	spin_unlock_bh(&police->tcfp_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
-	rcu_swap_protected(police->params,
-			   new,
-			   lockdep_is_held(&police->tcf_lock));
+	new = rcu_replace(police->params,
+			  new,
+			  lockdep_is_held(&police->tcf_lock));
 	spin_unlock_bh(&police->tcf_lock);
 
 	if (goto_ch)
diff --git a/net/sched/act_skbedit.c b/net/sched/act_skbedit.c
index 215a067..8ca1b8a 100644
--- a/net/sched/act_skbedit.c
+++ b/net/sched/act_skbedit.c
@@ -205,8 +205,8 @@ static int tcf_skbedit_init(struct net *net, struct nlattr *nla,
 
 	spin_lock_bh(&d->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
-	rcu_swap_protected(d->params, params_new,
-			   lockdep_is_held(&d->tcf_lock));
+	params_new = rcu_replace(d->params, params_new,
+				 lockdep_is_held(&d->tcf_lock));
 	spin_unlock_bh(&d->tcf_lock);
 	if (params_new)
 		kfree_rcu(params_new, rcu);
diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 10dffda..a1f6ede 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -379,8 +379,8 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
 
 	spin_lock_bh(&t->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
-	rcu_swap_protected(t->params, params_new,
-			   lockdep_is_held(&t->tcf_lock));
+	params_new = rcu_replace(t->params, params_new,
+				 lockdep_is_held(&t->tcf_lock));
 	spin_unlock_bh(&t->tcf_lock);
 	tunnel_key_release_params(params_new);
 	if (goto_ch)
diff --git a/net/sched/act_vlan.c b/net/sched/act_vlan.c
index 9269d35..d5db65f 100644
--- a/net/sched/act_vlan.c
+++ b/net/sched/act_vlan.c
@@ -218,7 +218,7 @@ static int tcf_vlan_init(struct net *net, struct nlattr *nla,
 
 	spin_lock_bh(&v->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
-	rcu_swap_protected(v->vlan_p, p, lockdep_is_held(&v->tcf_lock));
+	p = rcu_replace(v->vlan_p, p, lockdep_is_held(&v->tcf_lock));
 	spin_unlock_bh(&v->tcf_lock);
 
 	if (goto_ch)
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index d568e17..3d5ee77 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -179,15 +179,16 @@ static ssize_t handle_policy_update(struct file *file,
 	 * doesn't currently exist, just use a spinlock for now.
 	 */
 	mutex_lock(&policy_update_lock);
-	rcu_swap_protected(safesetid_setuid_rules, pol,
-			   lockdep_is_held(&policy_update_lock));
+	pol = rcu_replace(safesetid_setuid_rules, pol,
+			  lockdep_is_held(&policy_update_lock));
 	mutex_unlock(&policy_update_lock);
 	err = len;
 
 out_free_buf:
 	kfree(buf);
 out_free_pol:
-	release_ruleset(pol);
+	if (pol)
+		release_ruleset(pol);
 	return err;
 }
 
