#!/bin/bash
cat << 'EOF' >> /etc/bash_env
buildme() {
    echo "→ Creating build directory...";
    mkdir -p build && cd build || { echo "❌ Failed to enter build/"; return 1; };
    echo "→ Running CMake...";
    cmake .. || { echo "❌ CMake failed!"; return 1; };
    echo "→ Compiling with $(nproc) cores...";
    make -j$(nproc) || { echo "❌ Make failed!"; return 1; };
    echo "→ Installing...";
    make install || { echo "❌ Installation failed!"; return 1; };
    echo "✅ Build complete!";
}
cleanbuild() {
    echo "→ Navigating to build directory...";
    cd build || { echo "❌ No build directory found"; return 1; };
    echo "→ Removing installed files from manifest...";
    if [ -f install_manifest.txt ]; then
        xargs rm -f < install_manifest.txt || { echo "⚠️ Some files couldn't be removed (may not exist)"; };
    else
        echo "⚠️ No install_manifest.txt found - skipping installed files removal";
    fi;
    echo "→ Cleaning up build directory...";
    cd .. && rm -rf build || { echo "❌ Failed to remove build directory"; return 1; };
    echo "✅ Build cleanup complete!";
}
EOF
