ROM_NAME=lumine
MANIFEST_URL="https://github.com/LumineDroid/platform_manifest"
MANIFEST_BRANCH="bellflower"
LUNCH_CMD="lunch lumine_${DEVICE}-bp4a-user"
BUILD_CMD="m bacon"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=()
PROP_FLAGS=()
build_lumine() { build_generic lumine; }
