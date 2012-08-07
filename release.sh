#!/bin/sh

# release.sh
# Creates a release build 
# Example: release.sh production

# Validate args
if (( $# != 1 ))
then
  echo "Creates a release build "
  echo "Usage: release.sh CONFIG_NAME"
  echo "Example: release.sh production"
  exit 1
fi

CONFIG=$1
CONFIG_FILE="config/${CONFIG}.xml"
APP_NAME="$(grep "app_name" res/values/strings.xml | sed -E 's/.*app_name\">(.*)<.*/\1/')"
VERSION_NAME="$(grep "versionName" AndroidManifest.xml | sed -E 's/.*versionName=\"(.*)\".*/\1/')"

# Update constant in MyActivity.java
IN_PRODUCTION="false"
if [ "$CONFIG" = "production" ] ; then
  IN_PRODUCTION="true"
fi
# Need '.bak' for OS X
sed -i.bak "s/\(.*private static final boolean PRODUCTION\).*/\1 = ${IN_PRODUCTION};/" src/com/jeremyhaberman/cab/MyActivity.java
rm src/com/jeremyhaberman/cab/MyActivity.java.bak

# Update config.xml
echo "Using ${CONFIG_FILE}"
cp ${CONFIG_FILE} res/values/config.xml

# Set APK filename
if [ "$CONFIG" = "production" ] ; then
  OUTPUT_FILENAME="packages/${APP_NAME}-${VERSION_NAME}.apk"
else
  OUTPUT_FILENAME="packages/${APP_NAME}-${VERSION_NAME}-${CONFIG}.apk"
fi

# build package
echo "Building ${OUTPUT_FILENAME}"
ant -q release

# copy to packages dir
cp bin/${APP_NAME}-release.apk ${OUTPUT_FILENAME}
echo "Build complete: ${OUTPUT_FILENAME}"
