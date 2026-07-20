ROM_NAME=superior
MANIFEST_URL="https://github.com/SuperiorOS/manifest.git"
MANIFEST_BRANCH="16.2"
LUNCH_CMD="lunch superior_${DEVICE}-user"
BUILD_CMD="m bacon"
HAS_GAPPS=0
NEEDS_TREE_EDIT=1
MK_FLAGS=(
  "SUPERIOR_OFFICIAL := true"
  "SUPERIOR_GAPPS := minimal"
  "TARGET_BOOT_ANIMATION_RES := 1080"
)
PROP_FLAGS=()
build_superior() { build_generic superior; }
