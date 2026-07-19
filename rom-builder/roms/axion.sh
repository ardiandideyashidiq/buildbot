ROM_NAME=axion
MANIFEST_URL="https://github.com/AxionAOSP/android.git"
MANIFEST_BRANCH="lineage-23.2"
LUNCH_CMD="axion ${DEVICE} user gms"
BUILD_CMD="ax -br"
HAS_GAPPS=1
NEEDS_TREE_EDIT=0
MK_FLAGS=()
PROP_FLAGS=()
build_axion() { build_generic axion; }
