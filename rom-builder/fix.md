# Build fixes log

## Framework fixes (device-tree only)

| Date | ROM | Error | Fix | File |
|------|-----|-------|-----|------|
| 2026-07-19 | lineage | `inject_gapps: command not found`, `setup_keys: command not found`, `MK_FLAGS: unbound variable` | Sourced gapps.sh, keys.sh, vndk_fix.sh, rom_adapt.sh inside build_generic(). Fixed empty array handling with `${MK_FLAGS[@]:-}` | `lib/common.sh` |
| 2026-07-19 | lineage | `vendor/itel/P13001L/Android.bp` depends on undefined module `libbinder-v32` after vndk/ removal | vndk_fix no longer removes vndk/ entirely. Instead patches Android.bp to suppress make-namespace export while keeping soong definition for vendor blobs. | `lib/vndk_fix.sh` |
| 2026-07-19 | lineage | `build/envsetup.sh: TOP: unbound variable` caused by `set -u` | Moved build into subshell with `set +u` via `run_build()` function | `lib/common.sh` |

| 2026-07-19 | axion | `device/google/cuttlefish/build/Android.bp` dependency missing variant — not in device tree | Skipped. Error is in ROM source (cuttlefish), cannot fix from device tree. | — |

## Notes
- GApps injection is non-mandatory. If a ROM fails to build due to GApps and the only fix requires editing ROM source (outside device tree), skip GApps for that ROM.
- If the only fix for a build error requires editing ROM source, the ROM is skipped.
- VNDK pre-clean removed — vndk_fix only applies reactively when `libbinder-v32 already defined` is detected in build log.
- Between ROM builds, previous source tree is cleaned to free disk space.
