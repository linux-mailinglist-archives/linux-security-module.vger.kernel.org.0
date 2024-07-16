Return-Path: <linux-security-module+bounces-4314-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4B8932A66
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jul 2024 17:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87C11C22E39
	for <lists+linux-security-module@lfdr.de>; Tue, 16 Jul 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A085119DFAC;
	Tue, 16 Jul 2024 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Q1GTJCH8"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7010B19DF94
	for <linux-security-module@vger.kernel.org>; Tue, 16 Jul 2024 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143649; cv=none; b=MJjPT0nOWc/BEF42nvVnNaZxEs+PBiWlY1HAhEpXZ1Pq/ZBkdctxAbTHlnU+RzS6tMpz9+eZ3u6HANCJTCvC/4SSVOqOh7wWAHcF++9Bw4lbPc3b99vYlLaTu7Xzd6jdfSTl6Qnq0g//rsmomdyo4U7uNhVwo3hokPUAPgnjp+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143649; c=relaxed/simple;
	bh=MciHCjykVzCLsloWvBMq3Mk60cvmYK7lNa4zFsMZ4BY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z/4XjH3ZorvDkw9MTSwCyEes2gKMmodlxakoYOKtFHIXsHeMdc93f/rbVQSDXSpGK2KvjBp9zUGQpBk8bubH3GeTA1bxLdzeufBYGzFPt9DZGqjaY91DGL27iDhS9xE+SVOW2+Bs5dbcGOA/EIVmDC5D6cCOWJvqmTSjNhE4kyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Q1GTJCH8; arc=none smtp.client-ip=185.125.25.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WNjcC4BvDz15p9;
	Tue, 16 Jul 2024 17:27:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721143643;
	bh=MTy+WuAklkoimjPRPFnnMvrYWfaXAqiv/BdqRfJnrsw=;
	h=Date:From:To:Cc:Subject:From;
	b=Q1GTJCH8QB/YCj11kSHucclDrPj3puZbHG69qz7jCic+aRu3dzhY+24qKQC0QpxQM
	 s1LEkk8PGD62QPr9uLa6daSGUEJL/j52KQDEmbp7wWZFNC/m38YJ4KUPJ/no26s8Ps
	 MjBJEkHXimVgx7kBPX+YjsqD8jT08dUu0/bG4y3o=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WNjcB2WjgzHPq;
	Tue, 16 Jul 2024 17:27:22 +0200 (CEST)
Date: Tue, 16 Jul 2024 17:27:21 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: landlock@lists.linux.dev
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Tahera Fahimi <fahimitahera@gmail.com>, lwn@lwn.net, linux-security-module@vger.kernel.org, 
	oss-security@lists.openwall.com
Subject: Landlock news #4
Message-ID: <20240716.yui4Iezai8ae@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Here is the fourth Landlock newsletter!

Official website: https://landlock.io
Previews newsletter:
https://lore.kernel.org/landlock/d4ed5733-d07b-5548-2534-a63e22906778@digikod.net

Articles and conferences
------------------------

We wrote a detailed article about Landlock explaining the underlying
concepts, the implementation, and the community:
https://landlock.io/talks/2024-06-06_landlock-article.pdf
This was written for the SSTIC conference:
https://www.sstic.org/2024/presentation/landlock-design/

I did a workshop at the Pass the Salt conference to explain how to
mitigate security vulnerabilities with Landlock (demonstrated with
ImageMagick): https://cfp.pass-the-salt.org/pts2024/talk/8FVYDF/
Related materials are freely available to do it at home:
https://github.com/landlock-lsm/workshop-imagemagick

Arto Niemi published a "Survey of Real-World Process Sandboxing" at the
Conference of Open Innovations Association (FRUCT):
https://fruct.org/publications/volume-35/fruct35/files/Niem.pdf
Their conclusion:  "[...] we found Landlock and minijail [which uses
Landlock] to be relatively convenient from a developer perspective. In
general, process self-containment and process-wrapping seems to be an
order of magnitude easier to configure than MAC policies."

Researchers from University of Bergamo gave a talk at ASIA CCS
conference about Cage4Deno: A Fine-Grained Sandbox for Deno Subprocesses
(leveraging Landlock)
https://cs.unibg.it/seclab-papers/2023/ASIACCS/paper/cage4deno.pdf
They also gave a talk at the RAID conference about NatiSand: Native Code
Sandboxing for JavaScript Runtimes (leveraging Landlock)
https://cs.unibg.it/seclab-papers/2023/RAID/natisand.pdf

Eric Leblond gave a talk (in French) at the SSTIC conference about
sandboxing with Landlock to mitigate real world security issues:
https://www.sstic.org/2023/presentation/attaque_supply_chain_suricata/

Günther Noack will give a talk at LSS Europe about Landlock and the new
IOCTL support: https://sched.co/1ebVW

I'll give a talk at OSS Europe to better explain sandboxing with
Landlock: https://sched.co/1ej3a

The XZ backdoor
---------------

XZ Utils is a widely used compression tool and library.  The main
maintainer implemented sandboxing with Landlock, and released a new
version 5.6.0 with this feature.  In March 2024, a backdoor was found
and reported.  It was introduced in February by a new maintainer who
earned this trust after more than two years of effort.

Among the malicious changes, the attacker disabled Landlock's support
for XZ Utils and released a new version 5.6.1:
https://research.swtch.com/xz-timeline
The sabotaged configuration check has since been fixed with version
5.6.2, but this effort to stealthily disable sandboxing is a clear sign
that Landlock disturbs attackers:
https://github.com/tukaani-project/xz/commit/f9cf4c05edd1

Merged kernel features
----------------------

Linux 6.7 (Landlock ABI 4) supports initial network access control with
the LANDLOCK_ACCESS_NET_BIND_TCP and LANDLOCK_ACCESS_NET_CONNECT_TCP
rights thanks to Konstantin Meskhidze.  We can now control inbound and
outbound TCP connections according to the source or the destination
port.  This led to kernel code refactoring which opens the way to more
network protocol support.  See user space documentation:
https://docs.kernel.org/userspace-api/landlock.html#network-flags

Linux 6.10 (Landlock ABI 5) supports IOCTL control with the new
LANDLOCK_ACCESS_FS_IOCTL_DEV right thanks to Günther Noack.  This
restriction only applies to IOCTL commands implemented by device drivers
(i.e. block or character devices).  As other file system access rights,
this can be used to only allow such IOCTL commands on a specified set of
file hierarchies per sandbox.  See user space documentation:
https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags

We also added a slight change in all supported kernels to inform system
administrators (with kernel logs) how they can configure the system to
support Landlock, if a process tried to sandbox itself on a kernel where
Landlock is disabled.  New documentation will help enable Landlock on
systems when it is not already the case:
https://docs.kernel.org/userspace-api/landlock.html#kernel-support

Since Linux 6.3, we improved documentation and kselftests (user space
testing), and added support for KUnit (kernel testing).  Part of this
work lead us to support the UML architecture to easily run application
tests in a CI against different kernel versions.  With this support we
can make sure that backward compatibility works fine for the tested
applications.  I encourage to take a look at landlock-test-tools and the
GitHub CI configuration for the Rust library:
https://github.com/landlock-lsm/landlock-test-tools
https://github.com/landlock-lsm/rust-landlock/blob/main/.github/workflows/rust.yml#L166-L179

Roadmap and ongoing development
-------------------------------

We created GitHub issues to track ongoing and future work:
https://github.com/landlock-lsm/linux/issues
https://github.com/orgs/landlock-lsm/projects/1

Feel free to reach out if you want to contribute!
https://github.com/landlock-lsm/linux/contribute

We also plan to improve the website with extended documentation and
examples.

Kernel development highlights
-----------------------------

Günther Noack is now an official reviewer of Landlock!
https://git.kernel.org/torvalds/c/5bf9e57e634b
After the IOCTL feature, he is now working on improving the
documentation, including man pages.

Mikhail Ivanov is working on socket type control.  This is an important
feature that will make it possible to create sandboxes without any
network access, except for an explicit list of allowed protocols.  This
will nicely complement the TCP port control (and future ones for other
protocols): https://github.com/landlock-lsm/linux/issues/6
He is also working on controlling TCP listen calls:
https://github.com/landlock-lsm/linux/issues/15

Tahera Fahimi was selected as an Outreachy intern to work on IPC
restrictions (e.g. abstract unix socket, signals) to better isolate a
Landlock domain:
https://github.com/landlock-lsm/linux/issues/7
https://github.com/landlock-lsm/linux/issues/8

I'm working on bringing audit support to Landlock:
https://github.com/landlock-lsm/linux/issues/3

Landlock libraries
------------------

As explained by Günther Noack, the Go library now supports TCP and IOCTL
restrictions: https://blog.gnoack.org/post/landlock-v4/
https://blog.gnoack.org/post/landlock-ioctl/

A new version of the Rust crate was released, with support for TCP
control and some miscellaneous improvements:
https://github.com/landlock-lsm/rust-landlock/releases/tag/v0.4.0

Please update your dependencies and use the latest Landlock ABI version
for improved sandboxing.

We are also working on a new minimal C library:
https://github.com/landlock-lsm/linux/issues/38

New Landlock user space supports
--------------------------------

Firejail 0.9.74 (sandboxer) will be able to use landlock:
https://github.com/netblue30/firejail/pull/6078

setpriv 2.40 (sandboxer):
https://github.com/util-linux/util-linux/pull/2628

extrasafe 0.4.0 (sandbox library):
https://github.com/boustrophedon/extrasafe/pull/28

bevy_mod_lockdown (sandbox library):
https://github.com/FrTerstappen/bevy_mod_lockdown

Cloud Hypervisor (VM monitor) will be sandboxed with Landlock:
https://github.com/cloud-hypervisor/cloud-hypervisor/pull/6214

Ukuleleweb (wiki server):
https://github.com/gnoack/ukuleleweb/commit/0ecdd54b36fa

websrv 3.2.0 (web server):
https://github.com/ngergs/websrv/commit/40fa2d7d2bbb

egress-eddie 0.5.0 (network filtering):
https://github.com/capnspacehook/egress-eddie/releases/tag/v0.5.0

Suricata 7.0.0 (network security monitoring engine):
https://docs.suricata.io/en/latest/configuration/landlock.html

sslh 2.1.0 (protocol multiplexer):
https://lore.kernel.org/landlock/Zfq6f30spnYCx_9Y@rutschle.net/
https://github.com/yrutschle/sslh/releases/tag/v2.1.0

wireproxy 1.0.8 (Wireguard client):
https://github.com/pufferffish/wireproxy/pull/108

Emilua 0.5.0 (Lua runtime):
https://lore.kernel.org/landlock/CAK9RveLxro4zUG4jfFB=UNgcv5gdc8JuzNhMt=YbNhH=35ADzg@mail.gmail.com/
https://docs.emilua.org/api/0.5/changelog.html

Polkadot (blockchain SDK):
https://github.com/paritytech/polkadot/pull/7303

XZ Utils 5.6.2 (archive manager):
https://github.com/tukaani-project/xz/commit/374868d81d47

Zathura (document viewer) will be sandboxed with Landlock:
https://github.com/pwmt/zathura/pull/575

Pacman 7.0.0 (Arch Linux's package manager):
https://gitlab.archlinux.org/pacman/pacman/-/merge_requests/167


Thanks to all contributors!

Regards,
 Mickaël

