Return-Path: <linux-security-module+bounces-12185-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633F4B9FF66
	for <lists+linux-security-module@lfdr.de>; Thu, 25 Sep 2025 16:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA1A4C8156
	for <lists+linux-security-module@lfdr.de>; Thu, 25 Sep 2025 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D061629994B;
	Thu, 25 Sep 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPzGc9bA"
X-Original-To: linux-security-module@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4428D8F4
	for <linux-security-module@vger.kernel.org>; Thu, 25 Sep 2025 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809824; cv=none; b=gLwWQLV2zt/loE0kvwxafiSXwJka0q5cF2hOsFGRlpBGoAB9MuNttFFS0ebjSK6dpVB2gQoFzi0wRUhzq80NFn2SNCPvIPa27/drt2wHezGfY/pp9bel5lN5uMoowbPTfR5e0Qf28ekFtxqaiTuGiKox0gA9dIS6oTmPU/ihkfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809824; c=relaxed/simple;
	bh=mqqPbcRc1y90cS3KVveWh9IwNrxKa0lpS3/3p6HfGes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ri4VKZFNg13ukWtpqIxBPqnnaStrboi6IZtWUTklBH88yVW+j3/Ul+GiEa9YwgdGsZCsP2Cdogla0AbtmZxmslUoU8f9Wdh9QLWdWjxIzVzYH/OXP+YJiTN31M5LMBS73RmTXO/uPFb0cWMQIqcbHU/xcRwo7wQNO9iDH7HaCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PPzGc9bA; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befbbaso1213617a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 25 Sep 2025 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758809822; x=1759414622; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q01z2q70uBCSgJYAVR+vis46yH2U6fCb9IpR1jV5kvA=;
        b=PPzGc9bAp6e0r47fL36avRKQmImoYCZcN8jluProQ0yummOXlnjqCIdnDkzPHLnc5k
         xUE0wIixBf2H6O5QJ8VEt7TNBGKTUy4m+79sjMAx1iRfilyVs9cYNJ5y10jPPKJ/D2of
         IYHPVw3AYz7I8gD+0Cor1rItbXuVr5kT2fD9S6+0dwWKcBhSVPuRWyjnC7Tp/EAkCrxW
         2/HDRm2zaq6OJ1JcJvM2kxkZWOY+QJX2s3m1QduPVFH0Gv9soFe8YegZRXpWquEGByeS
         nmo2x8dRm9F74/xWMYKNYDt8CW/TLYLr/a1LhxpmBJHAwxHhGRusuQLKDqPzkqsoHTI2
         tsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809822; x=1759414622;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q01z2q70uBCSgJYAVR+vis46yH2U6fCb9IpR1jV5kvA=;
        b=gxDkY1rRvDmnbm1IT2Qso+UqJXJ29ldWqIjegx4I44CspvFfjX8bAFQc0anabqdS+T
         VV6617kOpquHocIoFoKfHm1CqL8X9Xwz6FxNd+L5ojowYZMe+FOJaTAKm694ITW/QE79
         3MZHS3v+8bKRRzhW/9iQb3hvk2gbQYCSlORZhssWnUCbk37J0x1IRRkoDrgp98xRiBBY
         VW77wioBpG866fY8KQ2KrnQ9W/sYk63GcDdvkkj2PwlcbZJACp0y3rqgagkp1T6qIchz
         sf3UkBzPXLCqifApw9SpO/7smLy5soHlWhCqAplu9I8dOiZsCg4UbzjI97AbBpYVC9MR
         4BQA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ73OE3pYzvp0zfEGRBep30WYmJft9vllkC+NFaVs8Z9dsNY0Xw6fchszwlk+t7uV7lvpEBrOQbr+gim8NnRoePvR2C5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXNoUnM+GQl4KH1NiqqkHzn6hPTV9bwzdkDHLo/0qEGDLMBh2
	otvT4q3DSd7p6gliPCimL2nopK6xofvNNnzF4XAUZj5GKQSojVhtRuBypIjecVfmW7ghyxn90Uo
	S0BjGAw==
X-Google-Smtp-Source: AGHT+IGC7UvA+zy0Lzxdig1u574Z6HM9V6jNvtPYVpQ99Zo3hDJZ7LLoK6uH5QRKE/XipBEFnMeanJ3T9fg=
X-Received: from pjbon17.prod.google.com ([2002:a17:90b:1d11:b0:32e:e06a:4668])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3143:b0:32e:1ff5:5af4
 with SMTP id 98e67ed59e1d1-3342a2fe9ddmr3876418a91.35.1758809822200; Thu, 25
 Sep 2025 07:17:02 -0700 (PDT)
Date: Thu, 25 Sep 2025 07:17:00 -0700
In-Reply-To: <aNVMIRels8iCldOj@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-8-shivankg@amd.com>
 <aNVMIRels8iCldOj@google.com>
Message-ID: <aNVO3Lr-_U5Bmvem@google.com>
Subject: Re: [PATCH kvm-next V11 5/7] KVM: guest_memfd: Add slab-allocated
 inode cache
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, vbabka@suse.cz, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, dsterba@suse.com, xiang@kernel.org, chao@kernel.org, 
	jaegeuk@kernel.org, clm@fb.com, josef@toxicpanda.com, 
	kent.overstreet@linux.dev, zbestahu@gmail.com, jefflexu@linux.alibaba.com, 
	dhavale@google.com, lihongbo22@huawei.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, tabba@google.com, 
	ackerleytng@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com, 
	roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org, 
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com, 
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, 
	yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 25, 2025, Sean Christopherson wrote:
> On Wed, Aug 27, 2025, Shivank Garg wrote:
> > Add dedicated inode structure (kvm_gmem_inode_info) and slab-allocated
> > inode cache for guest memory backing, similar to how shmem handles inodes.
> > 
> > This adds the necessary allocation/destruction functions and prepares
> > for upcoming guest_memfd NUMA policy support changes.
> > 
> > Signed-off-by: Shivank Garg <shivankg@amd.com>
> > ---
> >  virt/kvm/guest_memfd.c | 70 ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 68 insertions(+), 2 deletions(-)
> > 
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 6c66a0974055..356947d36a47 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -17,6 +17,15 @@ struct kvm_gmem {
> >  	struct list_head entry;
> >  };
> >  
> > +struct kvm_gmem_inode_info {
> 
> What about naming this simply gmem_inode?

Heh, after looking through other filesystems, they're fairly even on appending
_info or not.  My vote is definitely for gmem_inode.

Before we accumulate more inode usage, e.g. for in-place conversion (which is
actually why I started looking at this code), I think we should also settle on
naming for gmem_file and gmem_inode variables.

As below, "struct kvm_gmem *gmem" gets quite confusing once inodes are in the
picture, especially since that structure isn't _the_ gmem instance, rather it's
a VM's view of that gmem instance.  And on the other side, "info" for the inode
is a bit imprecise, e.g. doesn't immediately make me think of inodes.

A few ideas:

 (a)
   struct gmem_inode *gmem;
   struct gmem_file *f;

 (b)
   struct gmem_inode *gi;
   struct gmem_file *f;

 (c)
   struct gmem_inode *gi;
   struct gmem_file *gf;

 (d)
   struct gmem_inode *gmem_i;
   struct gmem_file *gmem_f;


I think my would be for (a) or (b).  Option (c) seems like it would be hard to
visually differentiate between "gi" and "gf", and gmem_{i,f} are a bit verbose
IMO.

> > +	struct inode vfs_inode;
> > +};
> > +
> > +static inline struct kvm_gmem_inode_info *KVM_GMEM_I(struct inode *inode)
> 
> And then GMEM_I()?
> 
> And then (in a later follow-up if we target this for 6.18, or as a prep patch if
> we push this out to 6.19), rename kvm_gmem to gmem_file?
> 
> That would make guest_memfd look a bit more like other filesystems, and I don't
> see a need to preface the local structures and helpers with "kvm_", e.g. GMEM_I()
> is analogous to x86's to_vmx() and to_svm().
> 
> As for renaming kvm_gmem => gmem_file, I wandered back into this code via Ackerley's
> in-place conversion series, and it took me a good long while to remember the roles
> of files vs. inodes in gmem.  That's probably a sign that the code needs clarification
> given that I wrote the original code.  :-)
> 
> Leveraging an old discussion[*], my thought is to get to this:
> 
> /*
>  * A guest_memfd instance can be associated multiple VMs, each with its own
>  * "view" of the underlying physical memory.
>  *
>  * The gmem's inode is effectively the raw underlying physical storage, and is
>  * used to track properties of the physical memory, while each gmem file is
>  * effectively a single VM's view of that storage, and is used to track assets
>  * specific to its associated VM, e.g. memslots=>gmem bindings.
>  */
> struct gmem_file {
> 	struct kvm *kvm;
> 	struct xarray bindings;
> 	struct list_head entry;
> };
> 
> struct gmem_inode {
> 	struct shared_policy policy;
> 	struct inode vfs_inode;
> };
> 
> [*] https://lore.kernel.org/all/ZLGiEfJZTyl7M8mS@google.com

