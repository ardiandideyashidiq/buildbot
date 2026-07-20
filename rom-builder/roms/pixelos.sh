ROM_NAME=pixelos
ROM_PREFIX="custom"
MANIFEST_URL="https://github.com/PixelOS-AOSP/android_manifest.git"
MANIFEST_BRANCH="sixteen-qpr2"
LUNCH_CMD="lunch custom_${DEVICE}-bp4a-user"
BUILD_CMD="m pixelos"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=()
PROP_FLAGS=()
build_pixelos() { build_generic pixelos; }
