ROM_NAME=superior
MANIFEST_URL="https://github.com/SuperiorOS/manifest.git"
MANIFEST_BRANCH="16.2"
LUNCH_CMD=":"
BUILD_CMD="./build-superior.sh ${DEVICE} -t user"
HAS_GAPPS=0
NEEDS_TREE_EDIT=0
MK_FLAGS=()
PROP_FLAGS=()
build_superior() { build_generic superior; }
