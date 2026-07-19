ROM_NAME=genesis
MANIFEST_URL="https://github.com/GenesisOS/manifest.git"
MANIFEST_BRANCH="yume"
LUNCH_CMD="lunch genesis_${DEVICE}-bp4a-user"
BUILD_CMD="mka genesis"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=()
PROP_FLAGS=()
build_genesis() { build_generic genesis; }
