#!/bin/bash

# 📊 Mobile Escalation Dashboard - Update Script
# Usage: ./update-dashboard.sh

echo "🚀 Starting Dashboard Update..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Set colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
DASHBOARD_DIR="/Users/asrilwardhani/escalation-dashboard"
SOURCE_FILE="/Users/asrilwardhani/Library/CloudStorage/OneDrive-PTTelekomunikasiSelular/Reporting 2026 Mobile Escalation/Mobile_Escalation_Dashboard.html"

# Check if dashboard directory exists
if [ ! -d "$DASHBOARD_DIR" ]; then
    echo -e "${RED}❌ Dashboard directory not found at $DASHBOARD_DIR${NC}"
    echo "Please create the GitHub repository first."
    exit 1
fi

# Check if source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo -e "${RED}❌ Source dashboard file not found${NC}"
    echo "Expected location: $SOURCE_FILE"
    exit 1
fi

# Copy the dashboard file
echo -e "${BLUE}📋 Copying dashboard file...${NC}"
cp "$SOURCE_FILE" "$DASHBOARD_DIR/index.html"

if [ $? -ne 0 ]; then
    echo -e "${RED}❌ Failed to copy dashboard file${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Dashboard file copied${NC}"

# Change to dashboard directory
cd "$DASHBOARD_DIR"

# Check git status
echo -e "${BLUE}📊 Git status:${NC}"
git status

# Add files
echo -e "${BLUE}➕ Adding files to staging...${NC}"
git add index.html

# Get current date for commit message
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Commit
echo -e "${BLUE}💾 Creating commit...${NC}"
git commit -m "Update dashboard - $TIMESTAMP"

if [ $? -ne 0 ]; then
    echo -e "${RED}⚠️  No changes to commit (dashboard already up to date)${NC}"
else
    echo -e "${GREEN}✅ Commit created${NC}"
fi

# Push to GitHub
echo -e "${BLUE}🚀 Pushing to GitHub...${NC}"
git push origin main

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Successfully pushed to GitHub${NC}"
    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✨ Dashboard Updated!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${BLUE}Your dashboard is now live at:${NC}"
    echo "📊 GitHub Pages: https://asriel992001.github.io/escalation-dashboard/"
    echo "📊 Netlify: https://escalation-dashboard.netlify.app/ (password protected)"
    echo ""
    echo "📝 Deployment will be live in 1-2 minutes..."
else
    echo -e "${RED}❌ Failed to push to GitHub${NC}"
    echo "Please check your internet connection and try again."
    exit 1
fi

echo -e "${GREEN}✅ Update complete!${NC}"
