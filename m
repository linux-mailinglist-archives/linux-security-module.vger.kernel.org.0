Return-Path: <linux-security-module+bounces-1825-lists+linux-security-module=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4C88710D8
	for <lists+linux-security-module@lfdr.de>; Tue,  5 Mar 2024 00:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16444287D7A
	for <lists+linux-security-module@lfdr.de>; Mon,  4 Mar 2024 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB637C0B5;
	Mon,  4 Mar 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb7zGDfS"
X-Original-To: linux-security-module@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C247B3FA;
	Mon,  4 Mar 2024 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593453; cv=none; b=cBaBqnC3WfZtXpXx3dqnkhezR+JinPjcFM3n7214sFEDSEft6q7uDjI1TzYUo+w6X3s9aVZ5eFpRLZpxxjtIZ/fq76zrCusnP7pEz+ozSI3c01ngviurB6TqvZglXsXfnlVQCIoXhCEj5U1N/+U19DLJmdmuEgikdEsElgHQPcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593453; c=relaxed/simple;
	bh=yuCHCk5pAXWk9zFTn51GPimxWJDaabkWYuCRAsFiCzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3M+x+yfLeBWdzw814ooGG1QnXIHqo2DlQ2ocMp4jWdqE/vhS2HVvwM/Zr+LNdmo9DQbTWdPV7XRVo/tFdYdp0VgdjHezk/cowSXVFMSF2khNr62RWhC6wHkOwYATcv4fQeG8aUm8b9Gv5TdPxTLmmfBUlD9IxX4AzfC2jfCGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb7zGDfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00501C433C7;
	Mon,  4 Mar 2024 23:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709593452;
	bh=yuCHCk5pAXWk9zFTn51GPimxWJDaabkWYuCRAsFiCzk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cb7zGDfSF8eJ+WnXgLNsm70sNwG68ToebQ03PvaEhRbasgRdsFD7lYGpDDFj16hky
	 gZAkDMVOhFbrkSdOjLbb5V5nxy4B0GyrLSY5HyNlg9h4p8xTB9T6Ld8Mzqhatf6TQj
	 pACJUr+eYqcpii8SMNdZp93BsvX3vvxDobVG8l1CrS2xlARYM2HSCnDtOqbHGhY/Tc
	 ntcCSKdMe44cQNbb9zmLvUhUzCE6PEUW4MYC+epAeJR2K3A8tzQfYQSn18SFbblLKo
	 dKxjx4bmeqwARqzyD/UaqvZDBtbYWnPUeQFQO8JEEQtyS/b9koDaOyRU+C4hr6yx9r
	 6Cf7E+zaRiIKg==
Date: Mon, 4 Mar 2024 15:04:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mark Brown <broonie@kernel.org>, keescook@chromium.org
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 mic@digikod.net, linux-security-module@vger.kernel.org,
 jakub@cloudflare.com
Subject: Re: [PATCH v4 00/12] selftests: kselftest_harness: support using
 xfail
Message-ID: <20240304150411.6a9bd50b@kernel.org>
In-Reply-To: <05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
References: <20240229005920.2407409-1-kuba@kernel.org>
	<05f7bf89-04a5-4b65-bf59-c19456aeb1f0@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 22:20:03 +0000 Mark Brown wrote:
> On Wed, Feb 28, 2024 at 04:59:07PM -0800, Jakub Kicinski wrote:
> 
> > When running selftests for our subsystem in our CI we'd like all
> > tests to pass. Currently some tests use SKIP for cases they
> > expect to fail, because the kselftest_harness limits the return
> > codes to pass/fail/skip. XFAIL which would be a great match
> > here cannot be used.
> > 
> > Remove the no_print handling and use vfork() to run the test in
> > a different process than the setup. This way we don't need to
> > pass "failing step" via the exit code. Further clean up the exit
> > codes so that we can use all KSFT_* values. Rewrite the result
> > printing to make handling XFAIL/XPASS easier. Support tests
> > declaring combinations of fixture + variant they expect to fail.  
> 
> This series landed in -next today and has caused breakage on all
> platforms in the ALSA pcmtest-driver test.  When run on systems that
> don't have the driver it needs loaded the test skip but since this
> series was merged skipped tests are logged but then reported back as
> failures:
> 
> # selftests: alsa: test-pcmtest-driver
> # TAP version 13
> # 1..5
> # # Starting 5 tests from 1 test cases.
> # #  RUN           pcmtest.playback ...
> # #      SKIP      Can't read patterns. Probably, module isn't loaded
> # # playback: Test failed
> # #          FAIL  pcmtest.playback
> # not ok 1 pcmtest.playback #  Can't read patterns. Probably, module isn't loaded
> # #  RUN           pcmtest.capture ...
> # #      SKIP      Can't read patterns. Probably, module isn't loaded
> # # capture: Test failed
> # #          FAIL  pcmtest.capture
> # not ok 2 pcmtest.capture #  Can't read patterns. Probably, module isn't loaded
> # #  RUN           pcmtest.ni_capture ...
> # #      SKIP      Can't read patterns. Probably, module isn't loaded
> # # ni_capture: Test failed
> # #          FAIL  pcmtest.ni_capture
> # not ok 3 pcmtest.ni_capture #  Can't read patterns. Probably, module isn't loaded
> # #  RUN           pcmtest.ni_playback ...
> # #      SKIP      Can't read patterns. Probably, module isn't loaded
> # # ni_playback: Test failed
> # #          FAIL  pcmtest.ni_playback
> # not ok 4 pcmtest.ni_playback #  Can't read patterns. Probably, module isn't loaded
> # #  RUN           pcmtest.reset_ioctl ...
> # #      SKIP      Can't read patterns. Probably, module isn't loaded
> # # reset_ioctl: Test failed
> # #          FAIL  pcmtest.reset_ioctl
> # not ok 5 pcmtest.reset_ioctl #  Can't read patterns. Probably, module isn't loaded
> # # FAILED: 0 / 5 tests passed.
> # # Totals: pass:0 fail:5 xfail:0 xpass:0 skip:0 error:0
> 
> I haven't completely isolated the issue due to some other breakage
> that's making it harder that it should be to test.  
> 
> A sample full log can be seen at:
> 
>    https://lava.sirena.org.uk/scheduler/job/659576#L1349

Thanks! the exit() inside the skip evaded my grep, I'm testing this:

diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
index a52ecd43dbe3..7ab81d6f9e05 100644
--- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
+++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
@@ -127,11 +127,11 @@ FIXTURE_SETUP(pcmtest) {
 	int err;
 
 	if (geteuid())
-		SKIP(exit(-1), "This test needs root to run!");
+		SKIP(exit(KSFT_SKIP), "This test needs root to run!");
 
 	err = read_patterns();
 	if (err)
-		SKIP(exit(-1), "Can't read patterns. Probably, module isn't loaded");
+		SKIP(exit(KSFT_SKIP), "Can't read patterns. Probably, module isn't loaded");
 
 	card_name = malloc(127);
 	ASSERT_NE(card_name, NULL);
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 20294553a5dd..356ba5f3b68c 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -138,7 +138,7 @@ FIXTURE_SETUP(hmm)
 
 	self->fd = hmm_open(variant->device_number);
 	if (self->fd < 0 && hmm_is_coherent_type(variant->device_number))
-		SKIP(exit(0), "DEVICE_COHERENT not available");
+		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
 	ASSERT_GE(self->fd, 0);
 }
 
@@ -149,7 +149,7 @@ FIXTURE_SETUP(hmm2)
 
 	self->fd0 = hmm_open(variant->device_number0);
 	if (self->fd0 < 0 && hmm_is_coherent_type(variant->device_number0))
-		SKIP(exit(0), "DEVICE_COHERENT not available");
+		SKIP(exit(KSFT_SKIP), "DEVICE_COHERENT not available");
 	ASSERT_GE(self->fd0, 0);
 	self->fd1 = hmm_open(variant->device_number1);
 	ASSERT_GE(self->fd1, 0);

> but there's no more context.  I'm also seeing some breakage in the
> seccomp selftests which also use kselftest-harness:
> 
> # #  RUN           TRAP.dfl ...
> # # dfl: Test exited normally instead of by signal (code: 0)
> # #          FAIL  TRAP.dfl
> # not ok 56 TRAP.dfl
> # #  RUN           TRAP.ign ...
> # # ign: Test exited normally instead of by signal (code: 0)
> # #          FAIL  TRAP.ign
> # not ok 57 TRAP.ign

Ugh, I'm guessing vfork() "eats" the signal, IOW grandchild signals,
child exits? vfork() and signals.. I'd rather leave to Kees || Mickael.

