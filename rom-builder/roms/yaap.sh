ROM_NAME=yaap
MANIFEST_URL="https://github.com/yaap/manifest.git"
MANIFEST_BRANCH="sixteen"
LUNCH_CMD="lunch yaap_${DEVICE}-user"
BUILD_CMD="m yaap"
HAS_GAPPS=0
NEEDS_TREE_EDIT=1
MK_FLAGS=()
PROP_FLAGS=()
build_yaap() { build_generic yaap; }
