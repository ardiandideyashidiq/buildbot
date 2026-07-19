ROM_NAME=voltage
MANIFEST_URL="https://github.com/VoltageOS/manifest.git"
MANIFEST_BRANCH="16.2"
LUNCH_CMD="brunch ${DEVICE} user"
BUILD_CMD="brunch ${DEVICE} user"
HAS_GAPPS=0
NEEDS_TREE_EDIT=1
MK_FLAGS=()
PROP_FLAGS=()
build_voltage() { build_generic voltage; }
