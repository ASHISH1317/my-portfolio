#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define color codes for rich console aesthetics
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Helper for headers
print_header() {
  echo -e "\n${BOLD}${CYAN}======================================================================${NC}"
  echo -e "${BOLD}${CYAN}  $1${NC}"
  echo -e "${BOLD}${CYAN}======================================================================${NC}\n"
}

# Helper for success messages
print_success() {
  echo -e "${GREEN}✓ $1${NC}\n"
}

# Helper for error messages
print_error() {
  echo -e "${RED}✗ Error: $1${NC}\n"
}

# Helper for info messages
print_info() {
  echo -e "${BLUE}i $1${NC}"
}

# Trace timings
START_TIME=$(date +%s)

# Clear screen for dynamic build view
clear

echo -e "${BOLD}${YELLOW}"
echo "    ____             __              ____             __               "
echo "   / __ \____  _____/ /_____  ____  / __/___  _______/ /_  ____        "
echo "  / /_/ / __ \/ ___/ __/ __ \/ __ \/ /_/ __ \/ ___/ / __ \/ __ \       "
echo " / ____/ /_/ / /  / /_/ /_/ / /_/ / __/ /_/ / /  / / /_/ / /_/ /       "
echo "/_/    \____/_/   \__/\____/\____/_/  \____/_/  /_/_.___/\____/        "
echo -e "                                                     Deployment System${NC}"

# Check dependencies
print_header "Checking Prerequisites"

if ! command -v flutter &> /dev/null; then
    print_error "Flutter is not installed or not in your PATH."
    exit 1
fi
print_success "Flutter is installed ($(flutter --version | head -n 1))"

if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js."
    exit 1
fi
print_success "Node.js is installed ($(node -v))"

if ! command -v npx &> /dev/null; then
    print_error "npx is not installed. Please install npm/npx."
    exit 1
fi
print_success "npx is installed ($(npx -v))"

# Check if logged in to firebase
print_info "Verifying Firebase authentication status..."
if ! npx -y firebase-tools@latest login:list &> /dev/null; then
    print_info "Not logged in to Firebase. Starting interactive login..."
    npx -y firebase-tools@latest login
fi
print_success "Authenticated with Firebase Hosting."

# ----------------- Step 1: Clean -----------------
print_header "[1/3] Cleaning Flutter Build Environment"
CLEAN_START=$(date +%s)

flutter clean

CLEAN_END=$(date +%s)
CLEAN_DURATION=$((CLEAN_END - CLEAN_START))
print_success "Flutter clean completed in ${CLEAN_DURATION}s."

# ----------------- Step 2: Build -----------------
print_header "[2/3] Building Flutter Web Application (Release)"
BUILD_START=$(date +%s)

flutter build web --release

BUILD_END=$(date +%s)
BUILD_DURATION=$((BUILD_END - BUILD_START))
print_success "Flutter Web built successfully in ${BUILD_DURATION}s."

# ----------------- Step 3: Deploy -----------------
print_header "[3/3] Deploying to Firebase Hosting"
DEPLOY_START=$(date +%s)

npx -y firebase-tools@latest deploy --only hosting

DEPLOY_END=$(date +%s)
DEPLOY_DURATION=$((DEPLOY_END - DEPLOY_START))
print_success "Deployed to Firebase Hosting in ${DEPLOY_DURATION}s."

# ----------------- Summary -----------------
TOTAL_END=$(date +%s)
TOTAL_DURATION=$((TOTAL_END - START_TIME))

echo -e "${BOLD}${GREEN}======================================================================${NC}"
echo -e "${BOLD}${GREEN}  🎉 DEPLOYMENT SUCCESSFUL!${NC}"
echo -e "${BOLD}${GREEN}======================================================================${NC}"
echo -e "${BOLD}Summary of steps:${NC}"
echo -e "  - Clean environment:       ${CYAN}${CLEAN_DURATION}s${NC}"
echo -e "  - Build Web app (release):   ${CYAN}${BUILD_DURATION}s${NC}"
echo -e "  - Deploy to Firebase:       ${CYAN}${DEPLOY_DURATION}s${NC}"
echo -e "  - Total Elapsed Time:       ${BOLD}${YELLOW}${TOTAL_DURATION}s${NC}"
echo -e "${BOLD}${GREEN}======================================================================${NC}\n"
