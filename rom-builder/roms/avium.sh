ROM_NAME=avium
MANIFEST_URL="https://github.com/AviumUI/android_manifests"
MANIFEST_BRANCH="avium-16.2"
LUNCH_CMD="lunch lineage_${DEVICE}-bp4a-user"
BUILD_CMD="m bacon"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=(
  "AVIUM_VERSION_APPEND_TIME_OF_DAY := true"
  "AVIUM_MAINTAINER := \"R\""
  "AVIUM_SETTINGS_SOC_MODEL_NAME := Mediatek Helio G99"
  "AVIUM_SETTINGS_DEVICE_CODENAME := P13001L"
  "TARGET_INCLUDE_GOOGLEIME := true"
  "TARGET_GOOGLEIME_OVERRIDE_IME := true"
  "AVIUM_FORCE_SET_FAKE_PROP := true"
)
PROP_FLAGS=()
build_avium() { build_generic avium; }
