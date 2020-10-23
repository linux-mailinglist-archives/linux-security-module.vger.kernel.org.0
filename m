Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Original-To: lists+linux-security-module@lfdr.de
Delivered-To: lists+linux-security-module@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1936B296C0C
	for <lists+linux-security-module@lfdr.de>; Fri, 23 Oct 2020 11:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461300AbgJWJ0W (ORCPT
        <rfc822;lists+linux-security-module@lfdr.de>);
        Fri, 23 Oct 2020 05:26:22 -0400
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:33810 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S461149AbgJWJ0V (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 23 Oct 2020 05:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603445180; bh=sTPe8ZyzoohU+dH6WLO8xT9jxZB2XadCqVZVCpoFGIY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=jqpdij8m1/PhwWwnlrQs7Mss4WxQd1YwDCzDUTO+C9R9adr3DamW5WVXHt0yl83SkyKLAGt6Thjknb3g6CcOp03n8XLPpRxpyljblciEtKYFn4BuC1L0VL7HdfE2uihNfMTGMWY4/InrYWEYD7IltWEwXvfFWh2sEDtgMcM9gNqike9bZeCuyRv+7hbaGYQUVjxbfCMZIVUMejCZJH2j6JjHdhqgTEXrgpq0S0ezKhQfr3RuN0ylABwqmPxnsiyP/yCQbR2HVABOWKTgzqt9Uv/R3Tisoyli00GYU1xIFdFtYUm6TLAA734Qf9njScvnAIYBdZDxCL/SJ3atXjwz2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603445180; bh=GfSt558ujYtadXY/+kCzZGp9ClZuRaM9hAsvj1w3Spm=; h=Date:From:Subject; b=ouIuYISdhipPVdF2qi36aou3tuWJDs3MtZnq/evNxNRGoyAZuab5cUY4LHYQpGwS1jehnqMioQ8h9GFh7XxkoBo3q1Lc93vrG23o9jEbJPCtv4z28uwoGuLtrD8AxnNXDC+Le+dk6B6cVpz0R7LZe0RJQeNEq+FOp2vbVniamzpLnJvjwT45eItFm5yXt0VtdS8Ls27nX7fTSwe/qQ82k6y2t1t/rSW82gvFKGjR8sWT8seGtvsmZQJ46afwUeb4k6lOAKOvlaUbJIwTXo0/P8IHNE2pUvK3VmiG54SV2IARqiMeJ/6rvfFeoiMVD0L60JLh/SRcrWj3KZWJynpGVg==
X-YMail-OSG: ZKKYZ2UVM1lYj.XXqZbyr4Unz6jrWsvi2YMV2SKUPobROidJVVXMPxROzgmlnMK
 Zh2LcZQPD3Uiqz1fcjpyVvWD9PrbRWUc6HN5Ze5gf5FQJ2pBZwg3OWK.YivTSYy9y0mT4cBjQJ1B
 N3PBU1GTJkzZOCs2aNX0sL_7rkb6AURPO0af_scpoUwftQzyqSHfaFjLNe3.kH4Id9wF40AFQXOx
 Jd3ghPi0OxM1IArFVgLE6BDVV0.wWTlprAvcii28O7BGlrbmJC0QtSTXDH8.hBc0X5cUrJsF.3qU
 pq6l9fRqEJ.aNMUn25RYIkjhA1jcN24rRKrwWa7cA_j9N46ecNfa_yqjZ7i8WKmip4.SfexNvZ4X
 TKZppsF8kudUC3XNKK_ZM17HI4zB8Oo.u0dqnH8kgIoGxlmYvzJzb1lYuSFeyhbkwpsRRlEN666_
 GfIOY_GKw7O0VFK5VuXk7w.mvEgiQYyzbc7EzrYjXXyOJZXKbL6.Dc6Wnx7dowG9SXXHVetNrQ8C
 PK8MEt8DQw.oAJ5LEnQdMgvOtjMKWlVxAFRKzytTk1zXuI0Sh28jEtRLQzriP2vv1FaNvMG4hplf
 u9yx14qaFEtKpAhS1nh7fIhmfvZ7msScKXYf3HFTals5od2b8NTFES899ZTltFsR6GRUMRGPPWS5
 cd3B7dqmX_cU..sBEp6LMebLACVFeEAuzVFE1OBVc52UDL8yX2jEhfy.cWcWYyxlM6HcLyykovRY
 ulX9akyw1lxzK0SI28a9dLTmhr52kvzUMwfFL_ROtzi5x2lI5rXy3p6qKzdEq08frPXcjm09NwjK
 1s_RwFGHkn.Hei3zXSOwVHEXUjW7G8uq_MggkYRgDTlH8SUF.HIh0.u6PbiWVvN5C5wHB0LnBbLN
 TlxxVIcxM0j2t8XlCz4miBHiHD2u8oeIRb2nXTV8OX9Td6JZyLGKqTl6t3QgLGwQZJTAlGypb.oE
 rBap_p0vfypmOUouTBOwf2j4SowaXXoL0g.i0JI5GKATyWSL.3RYzAFA2y0Gyf78lZqa62KD3NGq
 9xtZg1sMBPTx7LjZl83VHl5dr1FI2pydsZ_8c0P.juco1plYTFE8WY_peLHaBeBrIKV26RCRNj5g
 4hot219nxoN9KHRIuo6zFAcS6LfOSt42qWW7liJp5mJ9_ZuynAzl9c0h9t.uRlWrxLhnklCnhecU
 ApdaltiIxCvyf04ZORWF1JxSnGZHvpiD17GqakOSs0YXt0XIiEMJFlv5G3INxoClFzAdqH_mIkoT
 kR_nFpMPOJTK09W_.O___tb81KyjSUhQn2vrO6Bdl7eVlzTmicGq0WrUPKeKIpXtt82EZ14mSDgV
 usE6.qIbE64dd5lkTjPKLOSZT0hvlxwcZg3d1jEbC3d7Fol5HP5LhonQEZPqzHYZuFVsnontgYK2
 wNAe7WgDNHU2148gVVYK0OyUCZiJeNWASpXFGLmIBD.erotDmkJDt30HwLUlsJrQoj3GgqmdXRbj
 HwHoL9G5wOv6ChjTjUVSxgWeJpGUtVnh.8XLR3W8d4zk5KZ8D70_1yIRYWDd__Bv5ts1EADlcaM4
 sCW1FP77YbGywZR32pW5s8n1jN0B8r577jP822w417PIoqVVAoQjoBQLYTHJMvZJCPbUWodoYcKW
 NqGxt8k8M3aHYdcTVkljsGn6F33cv3Rguud19J028iskNKLyByCLe8LxSRWxqg2whb4WjL2DKCce
 sKEc3fnLpQGbwpaBnt7ReYZ2eEt9kv5FyUFxjlwTGU22fevRA0Jh_iSq0ufwW5zEi481JDAi4RUt
 OJelr9r7y64kiDRn6Hl6kz0S2RWJ5yKI.henSlrSKCUfscOraBNehigM67DGfDW74SyiPojwfgf8
 8vGmSaNkjk7uoYaj2ch28z6bJjSjdAm3ZBTLdvDcq3xkKLjFeQahwVrjreh4_4KBTdayy8gvnGtW
 nUGCHQyp.RhXr0fd55MDtuQklhGDU1yuIAxlt8wwUywlAVcRNQOSnev51WHtdqg0qgIN9_1QH3AJ
 TiD0Pey5FKRPqMyAKZKiUe7zR8GVriafFsbjTqUJQBijXeHRsZFGwerV1ZpMepYr5i.9ld7lqfGF
 0kugWbzs3HcOEiRdxOszVgHSW8AnImDH.X5BT_a_bDNmvOjOXCDfLba6mYCY2ym.XOwOFqeteNEV
 zb3pUthUjhvokwvcyi6BLblcAoDHGpNtJTr.Qkqx788wDbQUfcj1MKKDafOO0eCrXb3GRR8YG4td
 CPexXFLVEyPrH_ujJsYbVDompEK7jkh5jLwTq3B5DLahyX5c7rvOMzKHuoJMpOYITMtB6MDaifQ.
 UU6oXHRLCaYq.cqNPHD59uHHO0ZD2hbIwPcHFnkCpaaCHdqQHfrlRvnctnGWsMTE15zYd93OVR4r
 0ZB7pvJ09X0BBHoUhRewhs3.czkVwtDuAFov00UMNO8N8xhVXbNByPvy.p1SghVW9jDW9vBiSNYo
 bGsNHHUJjTvvap3HeLmcmY55CW9q.8aYIqmiaYMTixAaVpxoHIyHweukrbyP8XjI_vca7jgoWEFD
 VzIro6rKaGffEpq7jjo8Wa2TrrAeZEfhUUFojEwP._KfYc__o.5OOrM9UE8r4_4Y4OWubmfs4jU6
 gEsFiGVA75_4FtV_5MrkC8jmPJpnzSO527eaw6PR22pFM3fi55pBOqc3EFm5DaUxtdpKY8NSIPzj
 ds_T7MmZaHXlvwEK2SyEbpmO4WsvXt1hlLmSYcCLsoHHUXR0pghI3_nKmVJ9Z75UD2m7ig93YOqu
 N8Ze7S0mLgk.5mdnZwmUjltBxT3H14..Tgl0oD0A_PDtMdCXOh5iVyQBA0Lc0t4BK2MMRmd2CoHj
 oBuKvYByQ6N06LMzXjEO6mMkJ8_beFM5fGWK1b86t7iGLRgwNwGTjk6doKBdGYvKnnp3u5svJA4G
 gDLOtvHMdg8Qv1He0Bwd.TNkY6nEx7tsB4kH5hl9RxYgTyEyPiCVZvwOlX3eACeKNBqldssXNluE
 6feu6nLrh.ueusqnkz0h8uoPLmGgO1ocRHsCsuM5nDJ1yc8zw8._2AoXNrFFTd37w2XOPdGy0lCP
 ZFRm.yoxTMKi26ZTJE7FXWIr0L5VE6SF1cXcIpb_b0MCFgYKCyv4tAPacj3mEhNYEHnNoEYLUWGw
 zc4nIwukQ2JfGWxmClw5yEXI2tshSzWhS_df.hIy4CIcG7ifYqOprP3yGRALt71s34KaELXOMq5J
 5UGmcM63r5KhA.eZ6heqpxIqk37w3VoVGjR2KlQ88JXnmkBAx3M8FMeMlPzir2OfhHLQGGzo8b_z
 od3oowN4exKvepGucPe1p0bUYtnzh7.9R5RUcJCtNNuaqcx6YkI8_h7OSBfI50LVbcmkidh0yQHj
 Q4eI.HUwHFCt2qZ6.ZRS105MzXv62JgG6g5njK4S1HWD9Cye6VHPBZshVeH6Tw84xSneys4922jZ
 LItK7n6MxnrYRV_v9h4Y1KpigELSFqPBJrh1QXu0f46gGtTuAltpW5eiG8fwfyqM_NH10rW3FTQx
 Ol7ecKEYq9CBuXHazZbK_ugUjLv7R.INeVc.27YRsEF6DNgYAR2EU228spo3ApQSkUWtZSEjkM2e
 T4y_L05rRHwT8yhMWg05TTVReDVHLmscwDR8i37NhbJye43Qx4NxKrd_sSsLHp3rAyczYID516os
 cySXySW7UVben.dQNCn_ZdUPOaX.Kt7uq7qaEEC4Lc4kMTJPuwQbFpd.eJ2yYjH_S0XEmr_ugkCo
 C91GUUotykEJSzXF.jY.1XxskbNMdpQzOBsxAtRJhHmrYSLyjsUWkgoiUIR.kSnjp1E2Rm80P33T
 H85dnqhL2sS8qEuQ2jV4vnh7p38xrnUmtR5fZrFlpKjbLF.aY.CjuLsh0PWAobBmihnSMy4Lth65
 ASyZJECdyyxdDZJ3CNATb7FGk3uPZCcVDSnZ4RuyB4Y9zIZfa2ZiVYxGVdAbI5oOD7itnvuiB4Vt
 4lcwBZXaIzAgS1TrqPt6DCHhtPOQS5tdBwyFWvHwaV5iWp2zuwZ6SY56WPXnYobVR7YK7vkpiJNH
 GqsuCwZG71fA1YCvpTxusomYH6_ugtR9aaqodEUd0LG6wOFLTOoPZEgTK7eSIaa8fbKMAkyzNydR
 C6B22TMQfpHT6_EdHVkwOGehfA8y_YqtpwuyCP0YthYu6oG4lG_lSuLKmo9TRl3H_kERM2VmayNu
 C71dRniYOdjVr1L5WwkmyFYzMRrYasWaZ8QGNNy5oZlZQas1hfO..zPLr8QrcrqIsGPMDHzI1GAE
 wF514G3CpAIiz9calyThhErUmaTYo2aGPKCLuuyt9mODXyC72keOWW2KxsFLlWcORCFX408FzuBb
 SeOxe4ZZnWX1xrgzlxpifL8qQ640wPTeGF0DItAmBd.ypB.MduJw3AyF0QlQ7g6oSx_bcQMuJZMD
 Y_iy9bhMQsl8gpcz9PIAZfta9n3ptR3LZEOKotRprRfjCVJA2yEdEAP_8hK8aZXX7PgPZPzjnp6I
 Q20j35yJhG7zgmrpM_7dX817vuJ703XMTaxDYX9Md.HUWbMaOCAIncxYBYtHFxmWRTk6GJ4yhF2l
 TRA8IQvquV0SAE7mbBvt7hcJ7AvCmWR_G0a0ki9RngZxBs0oSUNhLkkJiPoQTCR0IcqrZ79xH.n5
 YaBjZGN41GOOa4.vLQGKJuQnC7N6qfyZcuuZgGPOfCS7TF9r2n6B4x82RcnEaS4ok0Gatwb3vXO_
 1KsO7UIgpy3CXw7XR1pw.hfcb1gJuVRtgNb8dORiLo.dzS6K._NsThmOQpC.MhK.HSQSvAs2BeRz
 gcBMXjE9_gjSMJq1wdJ3gwuZoXFV.ggN3wp54CINnlN7yVbozmxTx0J.p3LV6N0wS1GX1XiMNwyA
 EiNIJsDiV2GFDif5FkRBHsSqccX21sgCBPz0hEx0ImVMeMFVShBzGaHMK4D1WLySq9uxytS7fddh
 DKNsRsLfBWZ2yA9gzdl6zEQmbjsnFiaj9gcLc4B7TWsnXe_IWcaALBriUocszguHWJfib_acWQtq
 84_2AzvmXXn9yq.adq1cL.zM9m7feqdYBXAEExG2XtmGsIQub.TfSwF9_t_maQoiAGcaJhkWQxaG
 Kgfo0woaowhx7.3ZxcnYlXYCWcnnbuePY_7FSBshl5bQo6XXDGVI4xIgFbAwOP4wQCOxGWFAiOvQ
 q6r1yA0VkZaPc5yBnIHYS6d4kBGHGers3Hg4t3HRftg3NZvA96Iof_5uHmBeX1yPV41FgsouJPem
 1mGBc2pkbxGyCEv5TZXdlOqZDqvGiaGQC87IYPYmZEESBtlYWS6x_sc5KBTXcTjviYoq6tk.9M1_
 8IRUZGDT89Ly1hQB4FrbJyhpbq.0wlmqpl4QNKyt.OykZA9UWzLHDFRXz0KLq45mh8hCwV8oeIED
 Io60nGDfUuLRyzN601fnGwjoPE8SjEggx4YSBWuTa.VwCixi2xvcPkcXarMqoopdNjkCbcaP_cRI
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Fri, 23 Oct 2020 09:26:20 +0000
Date:   Fri, 23 Oct 2020 09:26:16 +0000 (UTC)
From:   Kuban Manfi <nolanbraten4@gmail.com>
Reply-To: fadiansi55@gmail.com
Message-ID: <1596003857.1958418.1603445176751@mail.yahoo.com>
Subject: VERY CONFIDENTIAL.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1596003857.1958418.1603445176751.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>



Compliment of the season,

My names are Mr. Kuban Manfi, i work as a department manager in one of the reputable banks here in Africa.

I have a lucrative and profitable business which i would like to introduce to you. Please this is very confidential and if you are interested kindly get back to me for more details.

Thanks
Mr.Kuban Manfi
