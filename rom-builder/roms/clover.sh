ROM_NAME=clover
MANIFEST_URL="https://github.com/The-Clover-Project/manifest.git"
MANIFEST_BRANCH="16-qpr2"
LUNCH_CMD="lunch clover_${DEVICE}-bp4a-user"
BUILD_CMD="m clover"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=(
  "CLOVER_BUILDTYPE := OFFICIAL"
  "CLOVER_MAINTAINER := R"
)
PROP_FLAGS=()
build_clover() { build_generic clover; }
