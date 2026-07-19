ROM_NAME=evolution
MANIFEST_URL="https://github.com/Evolution-X/manifest"
MANIFEST_BRANCH="bka"
LUNCH_CMD="lunch lineage_${DEVICE}-bp4a-user"
BUILD_CMD="m evolution"
HAS_GAPPS=1
NEEDS_TREE_EDIT=0
MK_FLAGS=()
PROP_FLAGS=()
build_evolution() { build_generic evolution; }
