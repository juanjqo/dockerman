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
build_from_github() {
    if [[ -z "$1" ]]; then
        echo "❌ Usage: build_from_github <GitHub_HTTPS_Link>"
        return 1
    fi

    local url="$1"
    local repo_name
    repo_name=$(basename "$url" .git)

    echo "→ Preparing to clone or rebuild $repo_name..."
    mkdir -p ~/utils || return 1
    cd ~/utils || return 1

    if [[ -d "$repo_name" ]]; then
        echo "⚠️ Directory '$repo_name' already exists. Performing clean rebuild..."
        cd "$repo_name" || { echo "❌ Failed to enter $repo_name directory"; return 1; }
        cleanbuild || { echo "⚠️ cleanbuild failed, continuing anyway..."; }
    else
        echo "→ Cloning repository..."
        git clone "$url" || return 1
        cd "$repo_name" || { echo "❌ Failed to enter $repo_name directory"; return 1; }
    fi

    echo "→ Building with buildme()..."
    buildme
}
EOF
