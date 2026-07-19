ROM_NAME=mist
MANIFEST_URL="https://github.com/Project-Mist-OS/manifest"
MANIFEST_BRANCH="16.2"
LUNCH_CMD="mistify ${DEVICE} user"
BUILD_CMD="mist b"
HAS_GAPPS=0
NEEDS_TREE_EDIT=1
MK_FLAGS=("MISTOS_MAINTAINER := \"R\"")
PROP_FLAGS=(
  "ro.mist.display=1200 x 1920, 60 hz"
  "ro.mist.battery=10000mah"
  "ro.mist.soc=Mediatek Helio G99"
  "ro.mist.camera=13MP"
  "ro.mist.front=8MP"
  "ro.mist.platform=MT6789"
  "ro.mist.screen=13' IPS LCD"
  "ro.mist.device.name=itel VistaTab 30 Pro"
)
build_mist() { build_generic mist; }
