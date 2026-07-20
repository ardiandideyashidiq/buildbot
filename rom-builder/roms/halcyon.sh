ROM_NAME=halcyon
MANIFEST_URL="https://github.com/halcyonproject/manifest"
MANIFEST_BRANCH="16.2"
LUNCH_CMD="lunch halcyon_${DEVICE}-bp4a-user"
BUILD_CMD="m carthage"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=()
PROP_FLAGS=()
build_halcyon() { build_generic halcyon; }
