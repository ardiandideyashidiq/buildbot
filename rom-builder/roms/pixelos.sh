ROM_NAME=pixelos
MANIFEST_URL="https://github.com/PixelOS-AOSP/android_manifest.git"
MANIFEST_BRANCH="sixteen-qpr2"
LUNCH_CMD="breakfast ${DEVICE} user"
BUILD_CMD="m pixelos"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=()
PROP_FLAGS=()
build_pixelos() { build_generic pixelos; }
