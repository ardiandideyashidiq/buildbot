ROM_NAME=derpfest
MANIFEST_URL="https://github.com/DerpFest-AOSP/android_manifest.git"
MANIFEST_BRANCH="16.2"
LUNCH_CMD="lunch lineage_${DEVICE}-bp4a-user"
BUILD_CMD="m derp"
HAS_GAPPS=1
NEEDS_TREE_EDIT=0
MK_FLAGS=()
PROP_FLAGS=()
build_derpfest() { build_generic derpfest; }
