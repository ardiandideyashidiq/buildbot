ROM_NAME=infinity
MANIFEST_URL="https://github.com/ProjectInfinity-X/manifest"
MANIFEST_BRANCH="16"
MANIFEST_GROUPS="default,-mips,-darwin,-notdefault"
LUNCH_CMD="lunch infinity_${DEVICE}-user"
BUILD_CMD="m bacon"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=()
PROP_FLAGS=()
build_infinity() { build_generic infinity; }
