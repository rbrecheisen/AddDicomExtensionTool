#!/bin/bash

rm -rf distribution

~/.venv/AddDicomExtensionTool/bin/python -m nuitka --include-package=pydicom --enable-plugin=pyside6 --standalone src/main.py

mv main.dist/main.bin main.dist/AddDicomExtensionTool
mv main.dist distribution
rm -rf main.build

# mkdir AddDicomFileExtensionTool.app
# mkdir AddDicomFileExtensionTool.app/Contents
# mkdir AddDicomFileExtensionTool.app/Contents/MacOS
# mkdir AddDicomFileExtensionTool.app/Contents/Resources
# cp -R distribution/* AddDicomFileExtensionTool.app/Contents/MacOS
# chmod +x AddDicomFileExtensionTool.app/Contents/MacOS/AddDicomFileExtensionTool
# echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > AddDicomFileExtensionTool.app/Contents/Info.plist
# echo "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">" >> AddDicomFileExtensionTool.app/Contents/Info.plist
# echo "<plist version=\"1.0\">" >> AddDicomFileExtensionTool.app/Contents/Info.plist
# echo "<dict>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
# echo "    <key>CFBundleExecutable</key>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
# echo "    <string>AddDicomFileExtensionTool</string>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
# echo "    <key>LSMinimumSystemVersion</key>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
# echo "    <string>10.9</string>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
# echo "</dict>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
# echo "</plist>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
# hdiutil create -volname "AddDicomFileExtensionTool" -srcfolder ./AddDicomFileExtensionTool.app -ov -format UDZO AddDicomFileExtensionTool.dmg
# rm -rf ./AddDicomFileExtensionTool.app