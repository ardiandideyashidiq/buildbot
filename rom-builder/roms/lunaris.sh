ROM_NAME=lunaris
MANIFEST_URL="https://github.com/Lunaris-AOSP/android"
MANIFEST_BRANCH="16.2"
LUNCH_CMD="lunch lineage_${DEVICE}-bp4a-user"
BUILD_CMD="m bacon"
HAS_GAPPS=0
NEEDS_TREE_EDIT=0
MK_FLAGS=()
PROP_FLAGS=()
build_lunaris() { build_generic lunaris; }
