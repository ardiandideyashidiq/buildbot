ROM_NAME=crdroid
MANIFEST_URL="https://github.com/crdroidandroid/android.git"
MANIFEST_BRANCH="16.0"
LUNCH_CMD="breakfast ${DEVICE} user"
BUILD_CMD="brunch ${DEVICE} user"
HAS_GAPPS=0
NEEDS_TREE_EDIT=0
MK_FLAGS=()
PROP_FLAGS=()
build_crdroid() { build_generic crdroid; }
