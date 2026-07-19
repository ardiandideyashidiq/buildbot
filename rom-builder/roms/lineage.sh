ROM_NAME=lineage
MANIFEST_URL="https://github.com/LineageOS/android.git"
MANIFEST_BRANCH="lineage-23.2"
LUNCH_CMD="breakfast ${DEVICE} user"
BUILD_CMD="brunch ${DEVICE} user"
HAS_GAPPS=0
NEEDS_TREE_EDIT=0
MK_FLAGS=()
PROP_FLAGS=()
build_lineage() { build_generic lineage; }
