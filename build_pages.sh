#!/bin/bash

echo "Building GitHub Pages site..."

# Create github_page directory if it doesn't exist
mkdir -p github_page

# Remove old assets in github_page if they exist
if [ -d "github_page/assets" ]; then
    echo "Removing old github_page/assets folder..."
    rm -rf github_page/assets
fi

# Copy assets folder to github_page
echo "Copying assets folder to github_page..."
cp -r assets github_page/

# Create a local version of index.html without the base href
echo "Creating local version of index.html..."
if [ -f "github_page/index.html" ]; then
    # Create a temporary file with the base href line commented out
    sed 's|<base href="/wow-classic-pvpwarn-vpumc/">|<!-- <base href="/wow-classic-pvpwarn-vpumc/"> -->|g' github_page/index.html > github_page/index_local.html
    echo "Created github_page/index_local.html for local testing"
fi

echo "Build complete!"
echo ""
echo "To test locally:"
echo "1. Navigate to the github_page folder: cd github_page"
echo "2. Start a local server:"
echo "   - Python 3: python -m http.server 8000"
echo "   - Python 2: python -m SimpleHTTPServer 8000"
echo "   - Node.js: npx http-server -p 8000"
echo "3. Open http://localhost:8000/index_local.html in your browser"
echo ""
echo "Note: Use index_local.html for local testing, index.html is for GitHub Pages"
