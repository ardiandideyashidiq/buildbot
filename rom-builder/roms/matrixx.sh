ROM_NAME=matrixx
MANIFEST_URL="https://github.com/ProjectMatrixx/android"
MANIFEST_BRANCH="16.2"
LUNCH_CMD="lunch matrixx_${DEVICE}-bp4a-user"
BUILD_CMD="m matrixx"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=(
  "MATRIXX_MAINTAINER := R"
  "TARGET_CUSTOM_UDFPS := true"
  "WITH_BCR := true"
  "TARGET_INCLUDE_MATLOG := true"
  "TARGET_INCLUDE_PIXEL_LAUNCHER := true"
  "BYPASS_CHARGE_SUPPORTED := true"
  "TARGET_OPTIMIZED_DEXOPT := true"
  "TARGET_DISABLE_EPPE := true"
  "TARGET_BOOT_ANIMATION_RES := 1080"
  "WITH_EXTRA_GAPPS := true"
  "WITH_GMS_COMMS_SUITE := true"
  "WITH_GMS_AICORE := true"
)
PROP_FLAGS=()
build_matrixx() { build_generic matrixx; }
