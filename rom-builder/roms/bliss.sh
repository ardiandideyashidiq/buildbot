ROM_NAME=bliss
MANIFEST_URL="https://github.com/BlissRoms/stable_releases.git"
MANIFEST_BRANCH="waterlily"
LUNCH_CMD="blissify -g ${DEVICE} user"
BUILD_CMD=":"
HAS_GAPPS=1
NEEDS_TREE_EDIT=1
MK_FLAGS=("BLISS_BUILD_VARIANT := GAPPS")
PROP_FLAGS=()
build_bliss() { build_generic bliss; }
