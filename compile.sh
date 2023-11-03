#!/bin/bash

rm -rf distribution

~/.venv/AddDicomFileExtensionTool/bin/python -m nuitka --include-package=pydicom --enable-plugin=pyside6 --standalone src/main.py

mv main.dist/main.bin main.dist/AddDicomFileExtensionTool
mv main.dist distribution
rm -rf main.build

mkdir AddDicomFileExtensionTool.app
mkdir AddDicomFileExtensionTool.app/Contents
mkdir AddDicomFileExtensionTool.app/Contents/MacOS
mkdir AddDicomFileExtensionTool.app/Contents/Resources

cp -R distribution/* AddDicomFileExtensionTool.app/Contents/MacOS
chmod +x AddDicomFileExtensionTool.app/Contents/MacOS/AddDicomFileExtensionTool

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > AddDicomFileExtensionTool.app/Contents/Info.plist
echo "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">" >> AddDicomFileExtensionTool.app/Contents/Info.plist
echo "<plist version=\"1.0\">" >> AddDicomFileExtensionTool.app/Contents/Info.plist
echo "<dict>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
echo "    <key>CFBundleExecutable</key>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
echo "    <string>AddDicomFileExtensionTool</string>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
echo "    <key>LSMinimumSystemVersion</key>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
echo "    <string>10.9</string>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
echo "</dict>" >> AddDicomFileExtensionTool.app/Contents/Info.plist
echo "</plist>" >> AddDicomFileExtensionTool.app/Contents/Info.plist

hdiutil create -volname "AddDicomFileExtensionTool" -srcfolder ./AddDicomFileExtensionTool.app -ov -format UDZO AddDicomFileExtensionTool.dmg

rm -rf ./AddDicomFileExtensionTool.app

# Output ChatGPT
# ==============

# The error you're encountering suggests that Nuitka has not successfully included the `pydicom.encoders.gdcm` module in the standalone executable. This can happen for various reasons, such as dynamic imports that Nuitka does not detect, or issues with how the package is structured.

# To resolve this issue, you might have to give Nuitka hints about the import using the `--include-package` or `--include-module` options. Here's how you could modify your build command to explicitly include the `pydicom` package:

# ```bash
# python -m nuitka --standalone --include-package=pydicom --output-dir=build your_script.py
# ```

# If including the whole package doesn't solve the problem, or you want to be more specific, you could try to include the problematic module directly:

# ```bash
# python -m nuitka --standalone --include-module=pydicom.encoders.gdcm --output-dir=build your_script.py
# ```

# Another common solution is to create a `.nuitka` file that explicitly tells Nuitka what to include. Nuitka can sometimes miss modules that are not imported in a standard way (e.g., modules loaded using `__import__`, `importlib`, or missed due to conditional imports). In such cases, creating hints for Nuitka can help ensure all necessary modules are included.

# Additionally, since `pydicom.encoders.gdcm` seems to be related to the GDCM (Grassroots DICOM) library, which is a C++ library with Python bindings, you may need to ensure that the GDCM shared libraries are also copied to your distribution. Nuitka won't automatically include shared libraries (.dylib files on macOS) that are loaded at runtime.

# If GDCM was installed as a separate package outside of Python, you might have to manually copy the required `.dylib` files into your app bundle, typically within the `YourApp.app/Contents/Resources/` directory or somewhere your application expects them to be. After copying them, you would also need to adjust the search path for dynamic libraries in your code or set up an appropriate `rpath`.

# Finally, make sure all dependencies are correctly installed in your environment when you run the Nuitka build command, and consider using a virtual environment that closely matches the target environment where your standalone app will run. This helps to ensure that all the dependencies are properly resolved and packaged with your application.