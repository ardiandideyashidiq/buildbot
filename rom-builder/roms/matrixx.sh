ROM_NAME=matrixx
MANIFEST_URL="https://github.com/ProjectMatrixx/android"
MANIFEST_BRANCH="16.2"
LUNCH_CMD="lunch matrixx_${DEVICE}-bp4a-user"
BUILD_CMD="make matrixx"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=(
  "MATRIXX_MAINTAINER := R"
  "WITH_EXTRA_GAPPS := true"
  "TARGET_INCLUDE_PIXEL_LAUNCHER := true"
  "WITH_GMS_COMMS_SUITE := true"
  "WITH_GMS_AICORE := true"
)
PROP_FLAGS=()
build_matrixx() { build_generic matrixx; }
