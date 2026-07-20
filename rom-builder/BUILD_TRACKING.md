# Build tracking

| # | ROM | Status | ZIP | URL | Duration | Notes |
|---|-----|--------|-----|-----|----------|-------|
| 2026-07-19 | lineage | FAILED | - | - | 0s |  |
| 2026-07-19 | lineage | FAILED | - | - | 50s | 369:FAILED: out/soong/build.lineage_P13001L.ninja
371:error: vendor/itel/P13001L/Android.bp:20051:1: "camerahalserver" depends on undefined module "libbinder-v32". |
| 2026-07-19 | lineage | BUILT | lineage-23.2-20260719_204721-UNOFFICIAL-P13001L.zip | https://gofile.io/d/UFcZyAs | |
| 1433 |  |  |  | s | |
| 2026-07-19 | axion | FAILED | - | - | 47s | 549:FAILED: 
553:build/make/core/base_rules.mk:320: error: device/itel/P13001L/vndk: MODULE.TARGET.SHARED_LIBRARIES.libbinder-v32 already defined by hardware/lineage/compat.
817:FAILED: out/soong/build.lineage_P13001L.ninja
819:error: device/google/cuttlefish/build/Android.bp:526:1: dependency "" of "cvd-host_package" missing variant:
824:error: device/google/cuttlefish/build/Android.bp:526:1: dependency "" of "cvd-host_package" missing variant: |
| 2026-07-19 | axion | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-19 | axion | BUILT | axion-2.8-ONEIRA_FINAL-20260719230111-INCREMENTAL-UNOFFICIAL-GMS-P13001L.zip | https://gofile.io/d/6qwjYKs | |
| 522 |  |  |  | s | |
| 2026-07-19 | evolution | BUILT | EvolutionX-16.0-20260719-P13001L-11.9-Unofficial.zip | https://gofile.io/d/kkQMDgs | |
| 1483 |  |  |  | s | |
| 2026-07-20 | derpfest | BUILT | DerpFest-v16.2-20260720-P13001L-Community-Stable.zip | https://gofile.io/d/7d3Rwss | |
| 1607 |  |  |  | s | |
| 2026-07-20 | lumine | FAILED | - | - | 17s | 11:Error: No beans found for the device (P13001L).
19:device/mediatek/sepolicy_vndr/SEPolicy.mk:4: error: device/lineage/sepolicy/libperfmgr/sepolicy.mk: No such file or directory
46:build/make/core/release_config.mk:151: error: No release config set for target; please set TARGET_RELEASE, or if building on the command line use 'lunch <target>-<release>-<build_type>', where release is one of: . |
| 2026-07-20 | lumine | FAILED | - | - | 2s | 11:Error: No beans found for the device (P13001L).
19:device/mediatek/sepolicy_vndr/SEPolicy.mk:4: error: device/lineage/sepolicy/libperfmgr/sepolicy.mk: No such file or directory
46:build/make/core/release_config.mk:151: error: No release config set for target; please set TARGET_RELEASE, or if building on the command line use 'lunch <target>-<release>-<build_type>', where release is one of: .
82:Error: No beans found for the device (P13001L).
86:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "lumine_P13001L". |
| 2026-07-20 | lumine | FAILED | - | - | 29s | 11:Error: No beans found for the device (P13001L).
19:device/mediatek/sepolicy_vndr/SEPolicy.mk:4: error: device/lineage/sepolicy/libperfmgr/sepolicy.mk: No such file or directory
46:build/make/core/release_config.mk:151: error: No release config set for target; please set TARGET_RELEASE, or if building on the command line use 'lunch <target>-<release>-<build_type>', where release is one of: .
82:Error: No beans found for the device (P13001L).
86:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "lumine_P13001L". |
| 2026-07-20 | lumine | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-20 | voltage | FAILED | - | - | 73s | 342:FAILED: out/soong/build.voltage_P13001L.ninja
344:error: system/timezone/apex/Android.bp:62:1: "com.android.tzdata" depends on undefined module "com.android.tzdata.certificate.override".
346:error: packages/modules/Virtualization/build/compos/Android.bp:29:1: "com.android.compos" depends on undefined module "com.android.compos.certificate.override".
348:error: packages/modules/adb/apex/Android.bp:35:1: "com.android.adbd" depends on undefined module "com.android.adbd.certificate.override".
350:error: packages/modules/DnsResolver/apex/Android.bp:33:1: "com.android.resolv" depends on undefined module "com.android.resolv.certificate.override". |
| 2026-07-20 | voltage | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-20 | alphadroid | FAILED | - | - | 45s | 14:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
40:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
67:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
93:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
422:FAILED: out/soong/build.aosp_arm64.ninja |
| 2026-07-20 | alphadroid | FAILED | - | - | 19s | 14:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
40:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
67:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
93:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
422:FAILED: out/soong/build.aosp_arm64.ninja |
| 2026-07-20 | alphadroid | FAILED | - | - | 15s | 14:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
40:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
67:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
93:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
422:FAILED: out/soong/build.aosp_arm64.ninja |
| 2026-07-20 | alphadroid | FAILED | - | - | 15s | 14:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
40:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
67:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
93:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "alpha_P13001L".
422:FAILED: out/soong/build.aosp_arm64.ninja |
| 2026-07-20 | alphadroid | BUILT | AlphaDroid-16-20260720-vanilla-P13001L-v4.6.zip | https://gofile.io/d/Y1qERts | |
| 1497 |  |  |  | s | |
| 2026-07-20 | matrixx | FAILED | - | - | 49s | 353:FAILED: out/soong/build.matrixx_P13001L.ninja
355:error: hardware/lineage/compat/Android.bp:679:1: module "prebuilt_libprotobuf-cpp-full-3.9.1-vendorcompat" already defined
357:error: hardware/lineage/compat/Android.bp:702:1: module "prebuilt_libprotobuf-cpp-lite-3.9.1-vendorcompat" already defined
359:error: hardware/lineage/compat/Android.bp:769:1: module "prebuilt_libprotobuf-cpp-full-21.12-vendorcompat" already defined
361:error: hardware/lineage/compat/Android.bp:794:1: module "prebuilt_libprotobuf-cpp-lite-21.12-vendorcompat" already defined |
| 2026-07-20 | matrixx | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-20 | lunaris | FAILED | - | - | 45s | 355:FAILED: out/soong/build.lineage_P13001L.ninja
357:error: vendor/gapps/common/Android.bp:120:1: module "com.google.android.dialer.support" variant "android_common": found in multiple namespaces(vendor/pixel/gms/common and vendor/gapps/common) when including in product partition
358:error: vendor/gapps/arm64/Android.bp:20:1: module "MarkupGoogle_v2" variant "android_common": found in multiple namespaces(vendor/pixel/gms/common and vendor/gapps/arm64) when including in product partition
359:error: vendor/pixel/gms/common/Android.bp:731:1: module "Velvet" variant "android_common": found in multiple namespaces(vendor/gapps/arm64 and vendor/pixel/gms/common) when including in product partition
360:error: vendor/gapps/arm64/Android.bp:98:1: module "talkback" variant "android_common": found in multiple namespaces(vendor/pixel/gms/common and vendor/gapps/arm64) when including in product partition |
| 2026-07-20 | lunaris | FAILED | - | - | 16s | 355:FAILED: out/soong/build.lineage_P13001L.ninja
357:error: vendor/gapps/common/Android.bp:120:1: module "com.google.android.dialer.support" variant "android_common": found in multiple namespaces(vendor/pixel/gms/common and vendor/gapps/common) when including in product partition
358:error: vendor/gapps/arm64/Android.bp:20:1: module "MarkupGoogle_v2" variant "android_common": found in multiple namespaces(vendor/pixel/gms/common and vendor/gapps/arm64) when including in product partition
359:error: vendor/pixel/gms/common/Android.bp:731:1: module "Velvet" variant "android_common": found in multiple namespaces(vendor/gapps/arm64 and vendor/pixel/gms/common) when including in product partition
360:error: vendor/gapps/arm64/Android.bp:98:1: module "talkback" variant "android_common": found in multiple namespaces(vendor/pixel/gms/common and vendor/gapps/arm64) when including in product partition |
| 2026-07-20 | lunaris | BUILT | Lunaris-AOSP-P13001L-Community-3.12-GMS-2026072002.zip | https://gofile.io/d/rlkP01s | |
| 1497 |  |  |  | s | |
| 2026-07-20 | bliss | FAILED | - | - | 0s |  |
| 2026-07-20 | bliss | FAILED | - | - | 0s |  |
| 2026-07-20 | bliss | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-20 | avium | FAILED | - | - | 19s | 14:vendor/avium/config/gms.mk:41: error: Aborting due to missing required repositories.
43:vendor/avium/config/gms.mk:41: error: Aborting due to missing required repositories.
72:vendor/avium/config/gms.mk:41: error: Aborting due to missing required repositories.
74:03:45:21 runtime error: invalid memory address or nil pointer dereference
75:panic: runtime error: invalid memory address or nil pointer dereference [recovered] |
| 2026-07-20 | avium | FAILED | - | - | 8s | 14:vendor/avium/config/gms.mk:41: error: Aborting due to missing required repositories.
43:vendor/avium/config/gms.mk:41: error: Aborting due to missing required repositories.
72:vendor/avium/config/gms.mk:41: error: Aborting due to missing required repositories.
74:03:45:21 runtime error: invalid memory address or nil pointer dereference
75:panic: runtime error: invalid memory address or nil pointer dereference [recovered] |
| 2026-07-20 | avium | FAILED | - | - | 1165s | 14:vendor/avium/config/gms.mk:41: error: Aborting due to missing required repositories.
43:vendor/avium/config/gms.mk:41: error: Aborting due to missing required repositories.
72:vendor/avium/config/gms.mk:41: error: Aborting due to missing required repositories.
74:03:45:21 runtime error: invalid memory address or nil pointer dereference
75:panic: runtime error: invalid memory address or nil pointer dereference [recovered] |
| 2026-07-20 | avium | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-20 | mist | FAILED | - | - | 12s | 13:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "lineage_P13001L".
41:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "lineage_P13001L".
67:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "lineage_P13001L".
94:Error: No device target set. Please use 'mistify' or 'lunch' to set the target device. |
| 2026-07-20 | mist | FAILED | - | - | 7s | 13:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "lineage_P13001L".
41:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "lineage_P13001L".
67:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "lineage_P13001L".
94:Error: No device target set. Please use 'mistify' or 'lunch' to set the target device.
107:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "lineage_P13001L". |
| 2026-07-20 | mist | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-20 | pixelos | FAILED | - | - | 13s | 7:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "custom_P13001L".
9:04:48:20 runtime error: invalid memory address or nil pointer dereference
36:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "custom_P13001L".
62:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "custom_P13001L".
93:build/make/core/release_config.mk:151: error: No release config set for target; please set TARGET_RELEASE, or if building on the command line use 'lunch <target>-<release>-<build_type>', where release is one of: . |
| 2026-07-20 | pixelos | FAILED | - | - | 0s | 7:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "custom_P13001L".
9:04:48:20 runtime error: invalid memory address or nil pointer dereference
36:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "custom_P13001L".
62:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "custom_P13001L".
93:build/make/core/release_config.mk:151: error: No release config set for target; please set TARGET_RELEASE, or if building on the command line use 'lunch <target>-<release>-<build_type>', where release is one of: . |
| 2026-07-20 | pixelos | FAILED | - | - | 149s | 7:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "custom_P13001L".
9:04:48:20 runtime error: invalid memory address or nil pointer dereference
36:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "custom_P13001L".
62:build/make/core/product_config.mk:226: error: Cannot locate config makefile for product "custom_P13001L".
93:build/make/core/release_config.mk:151: error: No release config set for target; please set TARGET_RELEASE, or if building on the command line use 'lunch <target>-<release>-<build_type>', where release is one of: . |
| 2026-07-20 | pixelos | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-20 | genesis | FAILED | - | - | 103s | 338:FAILED: out/soong/build.genesis_P13001L.ninja
340:error: hardware/lineage/compat/Android.bp:679:1: module "prebuilt_libprotobuf-cpp-full-3.9.1-vendorcompat" already defined
342:error: hardware/lineage/compat/Android.bp:702:1: module "prebuilt_libprotobuf-cpp-lite-3.9.1-vendorcompat" already defined
344:error: hardware/lineage/compat/Android.bp:769:1: module "prebuilt_libprotobuf-cpp-full-21.12-vendorcompat" already defined
346:error: hardware/lineage/compat/Android.bp:794:1: module "prebuilt_libprotobuf-cpp-lite-21.12-vendorcompat" already defined |
| 2026-07-20 | genesis | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-20 | clover | FAILED | - | - | 12s | 7:vendor/clover/config/common.mk:143: error: vendor/clover-priv/keys/keys.mk: No such file or directory
33:vendor/clover/config/common.mk:143: error: vendor/clover-priv/keys/keys.mk: No such file or directory
59:build/make/core/release_config.mk:151: error: No release config set for target; please set TARGET_RELEASE, or if building on the command line use 'lunch <target>-<release>-<build_type>', where release is one of: . |
| 2026-07-20 | clover | SKIPPED | - | - | - | unbuildable - ROM source edit required |
| 2026-07-20 | yaap | FAILED | - | - | 0s |  |
| 2026-07-20 | yaap | SKIPPED | - | - | - | unbuildable - ROM source edit required |
