if ! xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools are required but not installed."
    echo "Starting installation now - please complete it in the popup dialog."

    if xcode-select --install 2>&1; then
        echo ""
        echo "⚠️  Please complete the Xcode installation, then re-run this script."
        echo "   This typically takes 5-10 minutes."
        exit 0
    else
        echo ""
        echo "⚠️  Failed to start Xcode Command Line Tools installation."
        echo "   Please install manually with: xcode-select --install"
        echo "   Then re-run this script."
        exit 1
    fi
else
    echo "✓ Xcode Command Line Tools already installed"
fi
