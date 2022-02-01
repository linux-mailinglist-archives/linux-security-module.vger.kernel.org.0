Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0444A66EB
	for <lists+linux-security-module@lfdr.de>; Tue,  1 Feb 2022 22:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiBAVVZ (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Tue, 1 Feb 2022 16:21:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:4038 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbiBAVVY (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 1 Feb 2022 16:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643750484; x=1675286484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ubsoS7BsMkbM/h2ImghwXfdPiiiv2Ar113GmICMr2Nc=;
  b=XEPPWSPx3Lc3BncfBXfkvl4Hz2uaKV14KJ9tRJ2X06a3CPcDsQnqat0R
   UaaHHIB7/lF4mm8Ycm6wds44gEEpl0bW2+WGsVGGlOpSJHtorpnnfmoYV
   UIGvf5So7CGN7oDzj4U24ji5NNS76DDnK766/NV35PNu+8i1fmnlctwIj
   xEwDwTX4jcNBeU3UfP0IZzDQqmK7u60XcuYWGIQ8IfIN4xILgKOL+OTGV
   M60PX9K1tsLBv+xM3wVGYBCLFDgjWI8yMu/sRW8zzFoA3sWFnGFAjd0id
   VuBHjUqr/Lu4n5uQR83xfc4v08vMmERhJ3IjOZTZoyPA2IAoRwmr6924f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="248016950"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="248016950"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:21:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="583184395"
Received: from mdroper-desk1.fm.intel.com (HELO mdroper-desk1.amr.corp.intel.com) ([10.1.27.134])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:21:24 -0800
Date:   Tue, 1 Feb 2022 13:21:22 -0800
From:   Matt Roper <matthew.d.roper@intel.com>
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-security-module@vger.kernel.org,
        nouveau@lists.freedesktop.org, netdev@vger.kernel.org,
        Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Vishal Kulkarni <vishal@chelsio.com>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Leo Li <sunpeng.li@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        Petr Mladek <pmladek@suse.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-gfx] [PATCH v2 05/11] drm/i915: Use str_enabled_disabled()
Message-ID: <YfmkUmUHtbjLnMAr@mdroper-desk1.amr.corp.intel.com>
References: <20220126093951.1470898-1-lucas.demarchi@intel.com>
 <20220126093951.1470898-6-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126093951.1470898-6-lucas.demarchi@intel.com>
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On Wed, Jan 26, 2022 at 01:39:45AM -0800, Lucas De Marchi wrote:
> Remove the local enableddisabled() implementation and adopt the
> str_enabled_disabled() from linux/string_helpers.h.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Acked-by: Jani Nikula <jani.nikula@intel.com>

There's two open-coded versions of this in intel_dp_hdcp.c
(intel_dp_mst_hdcp_stream_encryption() and
intel_dp_mst_hdcp2_stream_encryption()) that you might want to convert
as well.  Up to you whether you squash them into this patch or convert
them as a separate patch.  Either way,

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>


> ---
>  drivers/gpu/drm/i915/display/intel_backlight.c   |  3 ++-
>  drivers/gpu/drm/i915/display/intel_display.c     | 16 ++++++++--------
>  .../gpu/drm/i915/display/intel_display_debugfs.c |  8 ++++----
>  drivers/gpu/drm/i915/display/intel_dsi_vbt.c     |  7 ++++---
>  drivers/gpu/drm/i915/gt/intel_breadcrumbs.c      |  3 ++-
>  drivers/gpu/drm/i915/gt/intel_engine_cs.c        |  2 +-
>  drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c        |  2 +-
>  drivers/gpu/drm/i915/gt/uc/intel_guc_log.c       |  2 +-
>  drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c        |  2 +-
>  drivers/gpu/drm/i915/gt/uc/intel_uc.c            |  4 ++--
>  drivers/gpu/drm/i915/i915_debugfs.c              |  2 +-
>  drivers/gpu/drm/i915/i915_driver.c               |  4 +++-
>  drivers/gpu/drm/i915/i915_utils.h                |  6 +-----
>  drivers/gpu/drm/i915/intel_pm.c                  |  4 ++--
>  14 files changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
> index 98f7ea44042f..c8e1fc53a881 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/pwm.h>
> +#include <linux/string_helpers.h>
>  
>  #include "intel_backlight.h"
>  #include "intel_connector.h"
> @@ -1633,7 +1634,7 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
>  	drm_dbg_kms(&dev_priv->drm,
>  		    "Connector %s backlight initialized, %s, brightness %u/%u\n",
>  		    connector->base.name,
> -		    enableddisabled(panel->backlight.enabled),
> +		    str_enabled_disabled(panel->backlight.enabled),
>  		    panel->backlight.level, panel->backlight.max);
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index bd453861088e..8920bdb53b7b 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -3110,8 +3110,8 @@ static void intel_panel_sanitize_ssc(struct drm_i915_private *dev_priv)
>  		if (dev_priv->vbt.lvds_use_ssc != bios_lvds_use_ssc) {
>  			drm_dbg_kms(&dev_priv->drm,
>  				    "SSC %s by BIOS, overriding VBT which says %s\n",
> -				    enableddisabled(bios_lvds_use_ssc),
> -				    enableddisabled(dev_priv->vbt.lvds_use_ssc));
> +				    str_enabled_disabled(bios_lvds_use_ssc),
> +				    str_enabled_disabled(dev_priv->vbt.lvds_use_ssc));
>  			dev_priv->vbt.lvds_use_ssc = bios_lvds_use_ssc;
>  		}
>  	}
> @@ -5648,7 +5648,7 @@ static void intel_dump_pipe_config(const struct intel_crtc_state *pipe_config,
>  		    pipe_config->bigjoiner ? "master" : "no");
>  
>  	drm_dbg_kms(&dev_priv->drm, "splitter: %s, link count %d, overlap %d\n",
> -		    enableddisabled(pipe_config->splitter.enable),
> +		    str_enabled_disabled(pipe_config->splitter.enable),
>  		    pipe_config->splitter.link_count,
>  		    pipe_config->splitter.pixel_overlap);
>  
> @@ -5736,7 +5736,7 @@ static void intel_dump_pipe_config(const struct intel_crtc_state *pipe_config,
>  		drm_dbg_kms(&dev_priv->drm,
>  			    "pch pfit: " DRM_RECT_FMT ", %s, force thru: %s\n",
>  			    DRM_RECT_ARG(&pipe_config->pch_pfit.dst),
> -			    enableddisabled(pipe_config->pch_pfit.enabled),
> +			    str_enabled_disabled(pipe_config->pch_pfit.enabled),
>  			    str_yes_no(pipe_config->pch_pfit.force_thru));
>  
>  	drm_dbg_kms(&dev_priv->drm, "ips: %i, double wide: %i\n",
> @@ -10300,7 +10300,7 @@ static void readout_plane_state(struct drm_i915_private *dev_priv)
>  		drm_dbg_kms(&dev_priv->drm,
>  			    "[PLANE:%d:%s] hw state readout: %s, pipe %c\n",
>  			    plane->base.base.id, plane->base.name,
> -			    enableddisabled(visible), pipe_name(pipe));
> +			    str_enabled_disabled(visible), pipe_name(pipe));
>  	}
>  
>  	for_each_intel_crtc(&dev_priv->drm, crtc) {
> @@ -10346,7 +10346,7 @@ static void intel_modeset_readout_hw_state(struct drm_device *dev)
>  		drm_dbg_kms(&dev_priv->drm,
>  			    "[CRTC:%d:%s] hw state readout: %s\n",
>  			    crtc->base.base.id, crtc->base.name,
> -			    enableddisabled(crtc_state->hw.active));
> +			    str_enabled_disabled(crtc_state->hw.active));
>  	}
>  
>  	cdclk_state->active_pipes = dbuf_state->active_pipes = active_pipes;
> @@ -10384,7 +10384,7 @@ static void intel_modeset_readout_hw_state(struct drm_device *dev)
>  		drm_dbg_kms(&dev_priv->drm,
>  			    "[ENCODER:%d:%s] hw state readout: %s, pipe %c\n",
>  			    encoder->base.base.id, encoder->base.name,
> -			    enableddisabled(encoder->base.crtc),
> +			    str_enabled_disabled(encoder->base.crtc),
>  			    pipe_name(pipe));
>  	}
>  
> @@ -10422,7 +10422,7 @@ static void intel_modeset_readout_hw_state(struct drm_device *dev)
>  		drm_dbg_kms(&dev_priv->drm,
>  			    "[CONNECTOR:%d:%s] hw state readout: %s\n",
>  			    connector->base.base.id, connector->base.name,
> -			    enableddisabled(connector->base.encoder));
> +			    str_enabled_disabled(connector->base.encoder));
>  	}
>  	drm_connector_list_iter_end(&conn_iter);
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> index a9ba998e0659..6bc820c3f00e 100644
> --- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> @@ -93,7 +93,7 @@ static int i915_sr_status(struct seq_file *m, void *unused)
>  
>  	intel_display_power_put(dev_priv, POWER_DOMAIN_INIT, wakeref);
>  
> -	seq_printf(m, "self-refresh: %s\n", enableddisabled(sr_enabled));
> +	seq_printf(m, "self-refresh: %s\n", str_enabled_disabled(sr_enabled));
>  
>  	return 0;
>  }
> @@ -296,7 +296,7 @@ static int intel_psr_status(struct seq_file *m, struct intel_dp *intel_dp)
>  		enabled = val & EDP_PSR_ENABLE;
>  	}
>  	seq_printf(m, "Source PSR ctl: %s [0x%08x]\n",
> -		   enableddisabled(enabled), val);
> +		   str_enabled_disabled(enabled), val);
>  	psr_source_status(intel_dp, m);
>  	seq_printf(m, "Busy frontbuffer bits: 0x%08x\n",
>  		   psr->busy_frontbuffer_bits);
> @@ -343,7 +343,7 @@ static int intel_psr_status(struct seq_file *m, struct intel_dp *intel_dp)
>  		}
>  
>  		seq_printf(m, "PSR2 selective fetch: %s\n",
> -			   enableddisabled(psr->psr2_sel_fetch_enabled));
> +			   str_enabled_disabled(psr->psr2_sel_fetch_enabled));
>  	}
>  
>  unlock:
> @@ -1268,7 +1268,7 @@ static int i915_lpsp_status(struct seq_file *m, void *unused)
>  		return 0;
>  	}
>  
> -	seq_printf(m, "LPSP: %s\n", enableddisabled(lpsp_enabled));
> +	seq_printf(m, "LPSP: %s\n", str_enabled_disabled(lpsp_enabled));
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> index da0bd056f3d3..5e1e2e7fe382 100644
> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> @@ -30,6 +30,7 @@
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/pinctrl/machine.h>
>  #include <linux/slab.h>
> +#include <linux/string_helpers.h>
>  
>  #include <asm/unaligned.h>
>  
> @@ -684,9 +685,9 @@ void intel_dsi_log_params(struct intel_dsi *intel_dsi)
>  		    intel_dsi->burst_mode_ratio);
>  	drm_dbg_kms(&i915->drm, "Reset timer %d\n", intel_dsi->rst_timer_val);
>  	drm_dbg_kms(&i915->drm, "Eot %s\n",
> -		    enableddisabled(intel_dsi->eotp_pkt));
> +		    str_enabled_disabled(intel_dsi->eotp_pkt));
>  	drm_dbg_kms(&i915->drm, "Clockstop %s\n",
> -		    enableddisabled(!intel_dsi->clock_stop));
> +		    str_enabled_disabled(!intel_dsi->clock_stop));
>  	drm_dbg_kms(&i915->drm, "Mode %s\n",
>  		    intel_dsi->operation_mode ? "command" : "video");
>  	if (intel_dsi->dual_link == DSI_DUAL_LINK_FRONT_BACK)
> @@ -713,7 +714,7 @@ void intel_dsi_log_params(struct intel_dsi *intel_dsi)
>  	drm_dbg_kms(&i915->drm, "HS to LP Clock Count 0x%x\n",
>  		    intel_dsi->clk_hs_to_lp_count);
>  	drm_dbg_kms(&i915->drm, "BTA %s\n",
> -		    enableddisabled(!(intel_dsi->video_frmt_cfg_bits & DISABLE_VIDEO_BTA)));
> +		    str_enabled_disabled(!(intel_dsi->video_frmt_cfg_bits & DISABLE_VIDEO_BTA)));
>  }
>  
>  bool intel_dsi_vbt_init(struct intel_dsi *intel_dsi, u16 panel_id)
> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> index 209cf265bf74..9dc9dccf7b09 100644
> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/kthread.h>
> +#include <linux/string_helpers.h>
>  #include <trace/events/dma_fence.h>
>  #include <uapi/linux/sched/types.h>
>  
> @@ -512,7 +513,7 @@ void intel_engine_print_breadcrumbs(struct intel_engine_cs *engine,
>  	if (!b)
>  		return;
>  
> -	drm_printf(p, "IRQ: %s\n", enableddisabled(b->irq_armed));
> +	drm_printf(p, "IRQ: %s\n", str_enabled_disabled(b->irq_armed));
>  	if (!list_empty(&b->signalers))
>  		print_signals(b, p);
>  }
> diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
> index 07de0fb56f51..6f4a39a3b44f 100644
> --- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
> @@ -1642,7 +1642,7 @@ static void intel_engine_print_registers(struct intel_engine_cs *engine,
>  
>  		drm_printf(m, "\tExeclist tasklet queued? %s (%s), preempt? %s, timeslice? %s\n",
>  			   str_yes_no(test_bit(TASKLET_STATE_SCHED, &engine->sched_engine->tasklet.state)),
> -			   enableddisabled(!atomic_read(&engine->sched_engine->tasklet.count)),
> +			   str_enabled_disabled(!atomic_read(&engine->sched_engine->tasklet.count)),
>  			   repr_timer(&engine->execlists.preempt),
>  			   repr_timer(&engine->execlists.timer));
>  
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
> index 31c3c3bceb95..0cfb29440c47 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_ct.c
> @@ -1203,7 +1203,7 @@ void intel_guc_ct_event_handler(struct intel_guc_ct *ct)
>  void intel_guc_ct_print_info(struct intel_guc_ct *ct,
>  			     struct drm_printer *p)
>  {
> -	drm_printf(p, "CT %s\n", enableddisabled(ct->enabled));
> +	drm_printf(p, "CT %s\n", str_enabled_disabled(ct->enabled));
>  
>  	if (!ct->enabled)
>  		return;
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
> index 8a99c2e624c2..a24dc6441872 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
> @@ -477,7 +477,7 @@ int intel_guc_log_create(struct intel_guc_log *log)
>  
>  	log->level = __get_default_log_level(log);
>  	DRM_DEBUG_DRIVER("guc_log_level=%d (%s, verbose:%s, verbosity:%d)\n",
> -			 log->level, enableddisabled(log->level),
> +			 log->level, str_enabled_disabled(log->level),
>  			 str_yes_no(GUC_LOG_LEVEL_IS_VERBOSE(log->level)),
>  			 GUC_LOG_LEVEL_TO_VERBOSITY(log->level));
>  
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c
> index f8fc90ea71e7..e00661fb0853 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_rc.c
> @@ -66,7 +66,7 @@ static int __guc_rc_control(struct intel_guc *guc, bool enable)
>  	}
>  
>  	drm_info(&gt->i915->drm, "GuC RC: %s\n",
> -		 enableddisabled(enable));
> +		 str_enabled_disabled(enable));
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_uc.c b/drivers/gpu/drm/i915/gt/uc/intel_uc.c
> index 8e756d4c2c16..8c9ef690ac9d 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_uc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_uc.c
> @@ -524,9 +524,9 @@ static int __uc_init_hw(struct intel_uc *uc)
>  	}
>  
>  	drm_info(&i915->drm, "GuC submission %s\n",
> -		 enableddisabled(intel_uc_uses_guc_submission(uc)));
> +		 str_enabled_disabled(intel_uc_uses_guc_submission(uc)));
>  	drm_info(&i915->drm, "GuC SLPC %s\n",
> -		 enableddisabled(intel_uc_uses_guc_slpc(uc)));
> +		 str_enabled_disabled(intel_uc_uses_guc_slpc(uc)));
>  
>  	return 0;
>  
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index 8e70c404bcc5..b98ea01af075 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -478,7 +478,7 @@ static int i915_runtime_pm_status(struct seq_file *m, void *unused)
>  		seq_puts(m, "Runtime power management not supported\n");
>  
>  	seq_printf(m, "Runtime power status: %s\n",
> -		   enableddisabled(!dev_priv->power_domains.init_wakeref));
> +		   str_enabled_disabled(!dev_priv->power_domains.init_wakeref));
>  
>  	seq_printf(m, "GPU idle: %s\n", str_yes_no(!to_gt(dev_priv)->awake));
>  	seq_printf(m, "IRQs disabled: %s\n",
> diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
> index 3d41f532a5d6..e89afce4c576 100644
> --- a/drivers/gpu/drm/i915/i915_driver.c
> +++ b/drivers/gpu/drm/i915/i915_driver.c
> @@ -36,6 +36,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pnp.h>
>  #include <linux/slab.h>
> +#include <linux/string_helpers.h>
>  #include <linux/vga_switcheroo.h>
>  #include <linux/vt.h>
>  
> @@ -749,7 +750,8 @@ static void i915_driver_unregister(struct drm_i915_private *dev_priv)
>  void
>  i915_print_iommu_status(struct drm_i915_private *i915, struct drm_printer *p)
>  {
> -	drm_printf(p, "iommu: %s\n", enableddisabled(intel_vtd_active(i915)));
> +	drm_printf(p, "iommu: %s\n",
> +		   str_enabled_disabled(intel_vtd_active(i915)));
>  }
>  
>  static void i915_welcome_messages(struct drm_i915_private *dev_priv)
> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> index 06aac2be49ee..6d26920d0632 100644
> --- a/drivers/gpu/drm/i915/i915_utils.h
> +++ b/drivers/gpu/drm/i915/i915_utils.h
> @@ -28,6 +28,7 @@
>  #include <linux/list.h>
>  #include <linux/overflow.h>
>  #include <linux/sched.h>
> +#include <linux/string_helpers.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
>  #include <linux/sched/clock.h>
> @@ -404,11 +405,6 @@ static inline const char *onoff(bool v)
>  	return v ? "on" : "off";
>  }
>  
> -static inline const char *enableddisabled(bool v)
> -{
> -	return v ? "enabled" : "disabled";
> -}
> -
>  void add_taint_for_CI(struct drm_i915_private *i915, unsigned int taint);
>  static inline void __add_taint_for_CI(unsigned int taint)
>  {
> diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> index c538a66687bd..69f442200784 100644
> --- a/drivers/gpu/drm/i915/intel_pm.c
> +++ b/drivers/gpu/drm/i915/intel_pm.c
> @@ -413,8 +413,8 @@ static bool _intel_set_memory_cxsr(struct drm_i915_private *dev_priv, bool enabl
>  	trace_intel_memory_cxsr(dev_priv, was_enabled, enable);
>  
>  	drm_dbg_kms(&dev_priv->drm, "memory self-refresh is %s (was %s)\n",
> -		    enableddisabled(enable),
> -		    enableddisabled(was_enabled));
> +		    str_enabled_disabled(enable),
> +		    str_enabled_disabled(was_enabled));
>  
>  	return was_enabled;
>  }
> -- 
> 2.34.1
> 

-- 
Matt Roper
Graphics Software Engineer
VTT-OSGC Platform Enablement
Intel Corporation
(916) 356-2795
