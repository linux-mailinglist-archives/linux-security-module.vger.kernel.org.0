Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6135F74D429
	for <lists+linux-security-module@lfdr.de>; Mon, 10 Jul 2023 13:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjGJLEP (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Mon, 10 Jul 2023 07:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjGJLD4 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 10 Jul 2023 07:03:56 -0400
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2304C10DC;
        Mon, 10 Jul 2023 04:03:21 -0700 (PDT)
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
        by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 36AANSsO019799;
        Mon, 10 Jul 2023 05:23:28 -0500
Received: (from greg@localhost)
        by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 36AANSaB019797;
        Mon, 10 Jul 2023 05:23:28 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From:   "Dr. Greg" <greg@enjellic.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net
Subject: [PATCH 12/13] Implement an internal Trusted Modeling Agent.
Date:   Mon, 10 Jul 2023 05:23:18 -0500
Message-Id: <20230710102319.19716-13-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230710102319.19716-1-greg@enjellic.com>
References: <20230710102319.19716-1-greg@enjellic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

A Trusted Modeling Agent (TMA) is an implementation of a modeling
algorithm that converts a description of a security event (LSM hook)
into a security state coefficient.  The sum of these coefficients is
considered to be the functional value of the security model
implemented in a security modeling namespace.

The current model implemented is the simple deterministic model
used by the Quixote trust orchestrators.  These orchestrators
represent an initial implementation of the support infrastructure
needed to use the TSEM modeling LSM.  It is anticipated that
other in-kernel modeling implementations will be developed.

The TMA takes the mapping of a security state coefficient, as
generated by the tsem_map_event() function, and determines
whether or not the generated coefficient is a valid coefficient
in the security model being implemented for a security modeling
namespace.  If it is a valid coefficient, the process executing
the security event is designated as being trusted, otherwise the
state of the process is set to be untrusted.

By default the TMA runs in free modeling mode where all security
events are considered valid.  In this mode, the security state
coefficient is registered as a valid coefficient and the
description of the event is added to the security execution
trajectory for the model.

The model implementation can be 'sealed' through the TSEM control
plane, a condition that causes any coefficients not registered in
the model to be considered a 'forensics' event.  The description
of such an event is added to the forensics execution trajectory
for the model.  A forensics event does not result in permission
to the event to be denied unless the model is placed in
'enforcing' mode.

While the current in-kernel TMA is largely deterministic, one
approximation method is provided by this model, which is the
notion of a file digest 'pseudonym'.  A pseudonym can be declared
for an inode by registering the value of the following function
with the model:

Pseudonym = HF(PATH_LENGTH || PATHNAME)

Where HF is the hash function that has been selected for the
security modeling namespace.

If a file pseudonym is detected the file digest value used for
the CELL definition is set to the 'zero message' value of the
cryptographic function being used for the model.  The 'zero
message' value is consistent with what would be produced by a
zero length file.

The pseudonym value is model specific.  A separate modeling
namespace, without a pseudonym definition, will use the actual
computed digest of the file.

The TMA implementation also supports the definition of a 'base'
coefficient that is a nonce equal in length to the cryptographic
hash function being used for the model.  This value is used to
extend the security state coefficient before it is added to the
model.  This allows a verifying partner to specify a nonce that
will allow a verifying partner to confirm the 'freshness' of an
attestation of the function state of the model.

The modeling implementation supports two different functional
values for the model being implemented.  The classic linear
extension sum of all the security state coefficients and a value
referred to as the 'state' of the security model.

The 'state' value is designed to make the measurement value
invariant to scheduling variations that cause the classic trusted
system measurement to be non-deterministic between runs of a
workload.  The state value is computed by sorting the security
event state coefficients in the model in big-endian (natural hash
byte order) format and then computing the extension sum over this
sorted vector of coefficients.

Signed-off-by: Greg Wettstein <greg@enjellic.com>
---
 security/tsem/model.c | 714 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 714 insertions(+)
 create mode 100644 security/tsem/model.c

diff --git a/security/tsem/model.c b/security/tsem/model.c
new file mode 100644
index 000000000000..ed06485ef50d
--- /dev/null
+++ b/security/tsem/model.c
@@ -0,0 +1,714 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * Copyright (C) 2023 Enjellic Systems Development, LLC
+ * Author: Dr. Greg Wettstein <greg@enjellic.com>
+ *
+ * Implements the an kernel modeling agent.
+ */
+
+#include <linux/sort.h>
+
+#include "tsem.h"
+
+struct pseudonym {
+	struct list_head list;
+	u8 mapping[HASH_MAX_DIGESTSIZE];
+};
+
+static struct kmem_cache *point_cachep;
+
+static void refill_point_magazine(struct work_struct *work)
+{
+	struct tsem_event_point *tep;
+	struct tsem_work *ws;
+
+	ws = container_of(work, struct tsem_work, work);
+
+	tep = kmem_cache_zalloc(point_cachep, GFP_KERNEL);
+	if (!tep) {
+		pr_warn("tsem: Cannot refill model point magazine.\n");
+		return;
+	}
+
+	spin_lock(&ws->u.model->magazine_lock);
+	ws->u.model->magazine[ws->index] = tep;
+	clear_bit(ws->index, ws->u.model->magazine_index);
+
+	/*
+	 * The following memory barrier is used to cause the magazine
+	 * index to be visible after the refill of the cache slot.
+	 */
+	smp_mb__after_atomic();
+
+	spin_unlock(&ws->u.model->magazine_lock);
+}
+
+static struct tsem_event_point *alloc_event_point(struct tsem_model *model,
+						  bool locked)
+{
+	unsigned int index;
+	struct tsem_event_point *tep = NULL;
+
+	if (!locked)
+		return kmem_cache_zalloc(point_cachep, GFP_KERNEL);
+
+	spin_lock(&model->magazine_lock);
+	index = find_first_zero_bit(model->magazine_index,
+				    model->magazine_size);
+	if (index < model->magazine_size) {
+		tep = model->magazine[index];
+		model->ws[index].index = index;
+		model->ws[index].u.model = model;
+		set_bit(index, model->magazine_index);
+
+		/*
+		 * Similar to the issue noted in the refill_point_magazine(),
+		 * function, this barrier is used to cause the consumption
+		 * of the cache entry to become visible.
+		 */
+		smp_mb__after_atomic();
+	}
+	spin_unlock(&model->magazine_lock);
+
+	if (tep) {
+		INIT_WORK(&model->ws[index].work, refill_point_magazine);
+		queue_work(system_wq, &model->ws[index].work);
+		return tep;
+	}
+
+	pr_warn("tsem: %s in %llu failed point allocation, cache size=%u.\n",
+		current->comm, tsem_context(current)->id,
+		model->magazine_size);
+	return NULL;
+
+}
+
+static int magazine_allocate(struct tsem_model *model, size_t size)
+{
+	unsigned int lp;
+	int retn = -ENOMEM;
+
+	model->magazine_size = size;
+
+	spin_lock_init(&model->magazine_lock);
+
+	model->magazine_index = bitmap_zalloc(model->magazine_size,
+					      GFP_KERNEL);
+	if (!model->magazine_index)
+		return retn;
+
+	model->magazine = kcalloc(model->magazine_size,
+				  sizeof(*model->magazine), GFP_KERNEL);
+	if (!model->magazine)
+		goto done;
+
+	for (lp = 0; lp < model->magazine_size; ++lp) {
+		model->magazine[lp] = kmem_cache_zalloc(point_cachep,
+							GFP_KERNEL);
+		if (!model->magazine[lp])
+			goto done;
+	}
+
+	model->ws = kcalloc(model->magazine_size, sizeof(*model->ws),
+			    GFP_KERNEL);
+	if (model->ws)
+		retn = 0;
+
+ done:
+	if (retn)
+		tsem_model_magazine_free(model);
+
+	return retn;
+}
+
+static int generate_pseudonym(struct tsem_file *ep, u8 *pseudonym)
+{
+	int retn = 0;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, (u8 *) &ep->name_length,
+				   sizeof(ep->name_length));
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_finup(shash, ep->name, tsem_digestsize(),
+				  pseudonym);
+ done:
+	return retn;
+}
+
+static struct tsem_event_point *have_point(u8 *point)
+{
+	struct tsem_event_point *entry, *retn = NULL;
+	struct tsem_context *ctx = tsem_context(current);
+	struct tsem_model *model = ctx->model;
+
+	spin_lock(&model->point_lock);
+	list_for_each_entry(entry, &model->point_list, list) {
+		if (memcmp(entry->point, point, tsem_digestsize()) == 0) {
+			retn = entry;
+			goto done;
+		}
+	}
+
+ done:
+	spin_unlock(&model->point_lock);
+	return retn;
+}
+
+static struct tsem_event_point *add_event_point(u8 *point, bool valid,
+						bool locked)
+{
+	struct tsem_event_point *entry;
+	struct tsem_model *model = tsem_model(current);
+
+	entry = alloc_event_point(model, locked);
+	if (!entry)
+		return ERR_PTR(-ENOMEM);
+
+	entry->valid = valid;
+	memcpy(entry->point, point, tsem_digestsize());
+
+	spin_lock(&model->point_lock);
+	++model->point_count;
+	list_add_tail(&entry->list, &model->point_list);
+	spin_unlock(&model->point_lock);
+
+	return entry;
+}
+
+static int add_trajectory_point(struct tsem_event *ep)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	ep->pid = 0;
+	tsem_event_get(ep);
+
+	spin_lock(&model->trajectory_lock);
+	list_add_tail(&ep->list, &model->trajectory_list);
+	spin_unlock(&model->trajectory_lock);
+
+	return 0;
+}
+
+static int add_forensic_point(struct tsem_event *ep)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	ep->pid = 0;
+	tsem_event_get(ep);
+
+	spin_lock(&model->forensics_lock);
+	list_add_tail(&ep->list, &model->forensics_list);
+	spin_unlock(&model->forensics_lock);
+
+	return 0;
+}
+
+static int get_host_measurement(u8 *id, u8 *digest)
+{
+	int retn;
+	struct tsem_model *model = tsem_model(current);
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, model->base, tsem_digestsize());
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_finup(shash, id, tsem_digestsize(), digest);
+
+ done:
+	return retn;
+}
+
+static int update_events_measurement(struct tsem_event *ep)
+{
+	int retn;
+	u8 digest[HASH_MAX_DIGESTSIZE];
+	struct tsem_context *ctx = tsem_context(current);
+	struct tsem_model *model = ctx->model;
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	retn = get_host_measurement(ep->mapping, digest);
+	if (retn)
+		goto done;
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_update(shash, model->measurement,
+				   tsem_digestsize());
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_finup(shash, digest, tsem_digestsize(),
+				  model->measurement);
+	if (retn)
+		goto done;
+
+	if (!tsem_context(current)->id)
+		retn = tsem_trust_add_event(ep);
+
+ done:
+	return retn;
+}
+
+static int state_sort(const void *a, const void *b)
+{
+	unsigned int lp, retn = 0;
+	struct tsem_event_point *ap, *bp;
+
+	ap = *((struct tsem_event_point **) a);
+	bp = *((struct tsem_event_point **) b);
+
+	for (lp = 0; lp < tsem_digestsize(); ++lp) {
+		if (ap->point[lp] == bp->point[lp])
+			continue;
+
+		if (ap->point[lp] < bp->point[lp])
+			retn = -1;
+		else
+			retn = 1;
+		goto done;
+	}
+
+ done:
+	return retn;
+}
+
+/**
+ * tesm_model_compute_state() - Calculate a security model state value.
+ *
+ * The function generates the state value of the current modeling domain.
+ */
+void tsem_model_compute_state(void)
+{
+	u8 state[HASH_MAX_DIGESTSIZE];
+	int retn;
+	unsigned int lp, count, pt_count = 0;
+	struct list_head *end;
+	struct tsem_event_point *end_point, *entry, **points = NULL;
+	struct tsem_model *model = tsem_model(current);
+	SHASH_DESC_ON_STACK(shash, tfm);
+
+	shash->tfm = tsem_digest();
+	retn = crypto_shash_init(shash);
+	if (retn)
+		goto done;
+
+	memset(state, '\0', sizeof(state));
+	retn = crypto_shash_update(shash, state, tsem_digestsize());
+	if (retn)
+		goto done;
+
+	retn = get_host_measurement(tsem_trust_aggregate(), state);
+	if (retn)
+		goto done;
+
+	retn = crypto_shash_finup(shash, state, tsem_digestsize(), state);
+	if (retn)
+		goto done;
+
+	spin_lock(&model->point_lock);
+	end = model->point_list.prev;
+	count = model->point_count;
+	spin_unlock(&model->point_lock);
+
+	points = vmalloc(sizeof(*points) * count);
+	if (!points) {
+		retn = -ENOMEM;
+		goto done;
+	}
+
+	end_point = container_of(end, struct tsem_event_point, list);
+	list_for_each_entry(entry, &model->point_list, list) {
+		points[pt_count++] = entry;
+		if (end_point == entry)
+			break;
+	}
+	sort(points, count, sizeof(*points), state_sort, NULL);
+
+	memcpy(model->state, state, tsem_digestsize());
+	for (lp = 0; lp < pt_count; ++lp) {
+		entry = points[lp];
+
+		if (get_host_measurement(entry->point, state))
+			goto done;
+
+		if (crypto_shash_init(shash))
+			goto done;
+		if (crypto_shash_update(shash, model->state,
+					tsem_digestsize()))
+			goto done;
+		if (crypto_shash_finup(shash, state, tsem_digestsize(),
+				       model->state))
+			goto done;
+	}
+
+ done:
+	if (retn)
+		memset(model->state, '\0', tsem_digestsize());
+
+	vfree(points);
+}
+
+/**
+ * tsem_model_has_pseudonym() - Test for a model pseudonym.
+ * @tsip: A pointer to the TSEM inode security structure.
+ * @ep: A pointer to the TSEM event description structure.
+ *
+ * This function is used to test whether a pseudonym has been
+ * declared for a modeling domain.  It is up to the caller to
+ * populate the event description structure with a suitable
+ * value for the pseudonym digest.
+ *
+ * Return: If an error occurs during the pseudonym probe a negative
+ *	   return value is returned.  A zero return value indicates that
+ *	   a pseudonym was not present.  A value of one indicates that a
+ *	   pseudonym has been defined.
+ */
+int tsem_model_has_pseudonym(struct tsem_inode *tsip, struct tsem_file *ep)
+{
+	int retn = 0;
+	u8 pseudo_mapping[HASH_MAX_DIGESTSIZE];
+	struct tsem_model *model = tsem_model(current);
+	struct pseudonym *entry;
+
+	retn = generate_pseudonym(ep, pseudo_mapping);
+	if (retn)
+		goto done;
+
+	mutex_lock(&model->pseudonym_mutex);
+	list_for_each_entry(entry, &model->pseudonym_list, list) {
+		if (!memcmp(entry->mapping, pseudo_mapping,
+			    tsem_digestsize())) {
+			retn = 1;
+			goto done;
+		}
+	}
+	retn = 0;
+
+ done:
+	mutex_unlock(&model->pseudonym_mutex);
+	return retn;
+}
+
+/**
+ * tesm_model_event() - Inject a security event into a modeling domain.
+ * @ep: A pointer to the event description structure.
+ *
+ * This function is the entry point for the in kernel Trusted Modeling
+ * Agent (TMA).  It takes a description of an event encoded in a
+ * tsem_event structure and generates and updates the security model
+ * description.
+ *
+ * Return: If an error occurs during the injection of an event into a
+ *	   model a negative error value is returned.  A value of zero
+ *	   is returned if the event was successfully modeled.  The
+ *	   security status of the event is returned by encoding the value
+ *	   in the bad_COE member of the tsem_task structure.
+ */
+int tsem_model_event(struct tsem_event *ep)
+{
+	int retn;
+	struct tsem_event_point *point;
+	struct tsem_task *task = tsem_task(current);
+	struct tsem_context *ctx = task->context;
+
+	point = have_point(ep->mapping);
+	if (point) {
+		++point->count;
+		if (!point->valid)
+			task->trust_status = TSEM_TASK_UNTRUSTED;
+		return 0;
+	}
+
+	retn = update_events_measurement(ep);
+	if (retn)
+		goto done;
+
+	retn = -ENOMEM;
+	if (ctx->sealed) {
+		point = add_event_point(ep->mapping, false, ep->locked);
+		if (point) {
+			retn = add_forensic_point(ep);
+			task->trust_status = TSEM_TASK_UNTRUSTED;
+		}
+	} else {
+		point = add_event_point(ep->mapping, true, ep->locked);
+		if (point)
+			retn = add_trajectory_point(ep);
+	}
+
+	if (!retn)
+		++point->count;
+
+ done:
+	return retn;
+}
+
+/**
+ * tesm_model_load_point() - Load a security state event into a model.
+ * @point: A pointer to the array containing the security state
+ *	   point to be added to the model.
+ *
+ * This function takes the binary representation of a security state
+ * point and loads it into the current model domain.
+ *
+ * Return: If an error occurs during the processing of the security state
+ *	   point a negative return value is returned.  A return value of
+ *	   zero indicates the point was successfully loaded into the domain.
+ */
+int tsem_model_load_point(u8 *point)
+{
+	int retn = -ENOMEM;
+	struct tsem_event *ep;
+	struct tsem_context *ctx = tsem_context(current);
+
+	if (have_point(point))
+		return 0;
+
+	if (!add_event_point(point, true, false))
+		return retn;
+
+	if (!ctx->model->have_aggregate) {
+		retn = tsem_model_add_aggregate();
+		if (retn)
+			return retn;
+
+		ctx->model->have_aggregate = true;
+	}
+
+	ep = tsem_event_allocate(false);
+	if (!ep)
+		return retn;
+
+	kref_init(&ep->kref);
+	memcpy(ep->mapping, point, tsem_digestsize());
+	retn = update_events_measurement(ep);
+
+	tsem_event_put(ep);
+	return retn;
+}
+
+/**
+ * tesm_model_load_pseudonym() - Load a pseudonym state point to a model.
+ * @mapping: A pointer to the array containing the pseudonym state
+ *	     point that is to be added to the model.
+ *
+ * This function takes the binary representation of a file pseudonym
+ * and declares the presence of the pseudonym in the modeling domain.
+ *
+ * Return: If an error occurs during the processing of the pseudonym
+ *	   state point a negative return value is returned.  A return
+ *	   value of zero indicates the point was successfully loaded
+ *	   into the model.
+ */
+int tsem_model_load_pseudonym(u8 *mapping)
+{
+	struct pseudonym *psp = NULL;
+	struct tsem_model *model = tsem_model(current);
+
+	psp = kzalloc(sizeof(*psp), GFP_KERNEL);
+	if (!psp)
+		return -ENOMEM;
+	memcpy(psp->mapping, mapping, tsem_digestsize());
+
+	mutex_lock(&model->pseudonym_mutex);
+	list_add_tail(&psp->list, &model->pseudonym_list);
+	mutex_unlock(&model->pseudonym_mutex);
+	return 0;
+}
+
+/**
+ * tesm_model_load_base() - Load a model base point.
+ * @mapping: A pointer to the array containing the base point to be
+ *	     set for the model.
+ *
+ * This function takes the binary representation of a base point and
+ * sets this point as the base point for the model.
+ */
+void tsem_model_load_base(u8 *mapping)
+{
+	struct tsem_model *model = tsem_model(current);
+
+	memcpy(model->base, mapping, tsem_digestsize());
+}
+
+/**
+ * tesm_model_add_aggregate() - Add the hardware aggregate to a model.
+ *
+ * This function adds the hardware aggregate value to an internally
+ * modeled security domain.
+ *
+ * Return: If an error occurs during the injection of the aggregate
+ *	   value into the model a negative error value is returned.
+ *	   A return value of zero indicates the aggregate was
+ *	   successfully added.
+ */
+int tsem_model_add_aggregate(void)
+{
+	int retn = -ENOMEM;
+	struct tsem_event *ep;
+
+	ep = tsem_event_allocate(false);
+	if (!ep)
+		return retn;
+
+	kref_init(&ep->kref);
+	ep->digestsize = tsem_digestsize();
+	memcpy(ep->mapping, tsem_trust_aggregate(), ep->digestsize);
+
+	retn = update_events_measurement(ep);
+	tsem_event_put(ep);
+
+	return retn;
+}
+
+/**
+ * tsem_model_allocate() - Allocates a kernel TMA modeling structure.
+ * @size: The number of slots in the event point magazine for the model.
+ *
+ * This function allocates and initializes a tsem_model structure
+ * that is used to hold modeling information for an in kernel
+ * modeling domain.
+ *
+ * Return: On success a pointer to the model description structure is
+ *	   returned.  If an error occurs an error return value is
+ *	   encoded in the returned pointer.
+ */
+struct tsem_model *tsem_model_allocate(size_t size)
+{
+	struct tsem_model *model = NULL;
+
+	model = kzalloc(sizeof(*model), GFP_KERNEL);
+	if (!model)
+		return NULL;
+
+	spin_lock_init(&model->point_lock);
+	INIT_LIST_HEAD(&model->point_list);
+	mutex_init(&model->point_end_mutex);
+
+	spin_lock_init(&model->trajectory_lock);
+	INIT_LIST_HEAD(&model->trajectory_list);
+	mutex_init(&model->trajectory_end_mutex);
+
+	spin_lock_init(&model->forensics_lock);
+	INIT_LIST_HEAD(&model->forensics_list);
+	mutex_init(&model->forensics_end_mutex);
+
+	mutex_init(&model->pseudonym_mutex);
+	INIT_LIST_HEAD(&model->pseudonym_list);
+
+	if (magazine_allocate(model, size)) {
+		kfree(model);
+		model = NULL;
+	}
+
+	return model;
+}
+
+/**
+ * tsem_model_free() - Frees an a kernel TMA description structure.
+ * @ctx: A pointer to the TMA modeling description structure whose
+ *	 model definition is to be deleted.
+ *
+ * This function is called when the last reference to a kernel
+ * based TMA model description structure is released.
+ */
+void tsem_model_free(struct tsem_context *ctx)
+{
+	struct tsem_event_point *ep, *tmp_ep;
+	struct tsem_event *tentry, *tmp_tentry;
+	struct pseudonym *sentry, *tmp_sentry;
+	struct tsem_model *model = ctx->model;
+
+	list_for_each_entry_safe(ep, tmp_ep, &model->point_list, list) {
+		list_del(&ep->list);
+		kmem_cache_free(point_cachep, ep);
+	}
+
+	list_for_each_entry_safe(sentry, tmp_sentry, &model->pseudonym_list,
+				 list) {
+		list_del(&sentry->list);
+		kfree(sentry);
+	}
+
+	list_for_each_entry_safe(tentry, tmp_tentry, &model->trajectory_list,
+				 list) {
+		list_del(&tentry->list);
+		tsem_event_put(tentry);
+	}
+
+	if (ctx->sealed) {
+		list_for_each_entry_safe(tentry, tmp_tentry,
+					 &model->forensics_list, list) {
+			list_del(&tentry->list);
+			tsem_event_put(tentry);
+		}
+	}
+
+	tsem_model_magazine_free(model);
+	kfree(model);
+}
+
+/**
+ * tsem_model_magazine_free: Free the event point magazine for a model domain.
+ * @model: A pointer to the model whose magazine is to be freed.
+ *
+ * This function releases all of the components of an event point
+ * magazine that has been allocated for a modeling domain.
+ */
+void tsem_model_magazine_free(struct tsem_model *model)
+{
+	unsigned int lp;
+
+	for (lp = 0; lp < model->magazine_size; ++lp)
+		kmem_cache_free(point_cachep, model->magazine[lp]);
+
+	bitmap_free(model->magazine_index);
+	kfree(model->ws);
+	kfree(model->magazine);
+}
+
+/**
+ * tsem model_init() - Initialize the TSEM event point cache.
+ * @model: A pointer to the model that is being initialized.
+ * @size: The number of slots in the event point magazine for the root
+ *	  model.
+ *
+ * This function is called by the primary TSEM initialization function
+ * and sets up the cache that will be used to dispense tsem_event_point
+ * structures for security events that are called in atomic context.
+ *
+ * Return: This function returns a value of zero on success and a negative
+ *	   error code on failure.
+ */
+int __init tsem_model_cache_init(struct tsem_model *model, size_t size)
+{
+	point_cachep = kmem_cache_create("tsem_event_point_cache",
+					 sizeof(struct tsem_event_point), 0,
+					 SLAB_PANIC, 0);
+	if (!point_cachep)
+		return -ENOMEM;
+
+	if (magazine_allocate(model, size)) {
+		kmem_cache_destroy(point_cachep);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
-- 
2.39.1

