#!/bin/bash

# HelioCentric Mood Build Script
# Usage: ./scripts/build.sh [test|build|clean]

set -e

PROJECT_NAME="HelioCentricMood"
WORKSPACE="$PROJECT_NAME.xcworkspace"
SCHEME="HelioCentricMood"
DESTINATION="platform=iOS Simulator,name=iPhone 17 Pro Max"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Xcode is available
check_xcode() {
    if ! command -v xcodebuild &> /dev/null; then
        print_error "xcodebuild not found. Please install Xcode."
        exit 1
    fi
}

# Clean build artifacts
clean() {
    print_status "Cleaning build artifacts..."
    xcodebuild clean -workspace "$WORKSPACE" -scheme "$SCHEME"
    print_status "Clean completed."
}

# Build the project
build() {
    print_status "Building $PROJECT_NAME..."
    xcodebuild build -workspace "$WORKSPACE" -scheme "$SCHEME" -destination "$DESTINATION"
    print_status "Build completed successfully."
}

# Run tests
test() {
    print_status "Running tests..."
    xcodebuild test -workspace "$WORKSPACE" -scheme "$SCHEME" -destination "$DESTINATION"
    print_status "Tests completed."
}

# Run SwiftLint
lint() {
    print_status "Running SwiftLint..."
    if command -v swiftlint &> /dev/null; then
        swiftlint lint
        print_status "SwiftLint completed."
    else
        print_warning "SwiftLint not installed. Install with: brew install swiftlint"
    fi
}

# Main script logic
main() {
    check_xcode
    
    case "${1:-build}" in
        "clean")
            clean
            ;;
        "build")
            build
            ;;
        "test")
            test
            ;;
        "lint")
            lint
            ;;
        "all")
            clean
            lint
            build
            test
            ;;
        *)
            echo "Usage: $0 [clean|build|test|lint|all]"
            echo "  clean  - Clean build artifacts"
            echo "  build  - Build the project"
            echo "  test   - Run unit and UI tests"
            echo "  lint   - Run SwiftLint"
            echo "  all    - Run clean, lint, build, and test"
            exit 1
            ;;
    esac
}

main "$@"
