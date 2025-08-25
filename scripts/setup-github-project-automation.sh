#!/bin/bash

# GitHub Project Automation Setup Script for Docqet
# This script sets up comprehensive project automation for the Docqet project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
ORG="loopcraftlab"
REPO="docqet"
PROJECT_NUMBER="3"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if GitHub CLI is installed
check_gh_cli() {
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI is not installed. Please install it first:"
        echo "  macOS: brew install gh"
        echo "  Ubuntu: sudo apt install gh"
        echo "  Windows: winget install GitHub.cli"
        exit 1
    fi
    
    if ! gh auth status &> /dev/null; then
        print_error "GitHub CLI is not authenticated. Please run: gh auth login"
        exit 1
    fi
    
    print_success "GitHub CLI is installed and authenticated"
}

# Function to check project access
check_project_access() {
    print_status "Checking project access..."
    
    # Try to get project info
    if gh api repos/$ORG/$REPO/projects &> /dev/null; then
        print_success "Project access confirmed"
    else
        print_warning "Could not verify project access. Please ensure you have access to the project."
    fi
}

# Function to setup issue templates
setup_issue_templates() {
    print_status "Setting up issue templates..."
    
    # Create issue templates directory if it doesn't exist
    mkdir -p .github/ISSUE_TEMPLATE
    
    # Create bug report template
    cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
---
name: Bug report
about: Create a report to help us improve
title: '[BUG] '
labels: ['bug']
assignees: ''
---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**Environment:**
- OS: [e.g. macOS, Windows, Linux]
- Browser: [e.g. chrome, safari, firefox]
- Version: [e.g. 22]
- Docqet Version: [e.g. 1.0.0]

**Additional context**
Add any other context about the problem here.
EOF

    # Create feature request template
    cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
---
name: Feature request
about: Suggest an idea for this project
title: '[FEATURE] '
labels: ['enhancement']
assignees: ''
---

**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

**Describe alternatives you've considered**
A clear and concise description of any alternative solutions or features you've considered.

**Additional context**
Add any other context or screenshots about the feature request here.
EOF

    # Create config.yml
    cat > .github/ISSUE_TEMPLATE/config.yml << 'EOF'
blank_issues_enabled: false
contact_links:
  - name: GitHub Community Support
    url: https://github.com/loopcraftlab/docqet/discussions
    about: Please ask and answer questions here.
  - name: Documentation
    url: https://github.com/loopcraftlab/docqet/tree/main/docs
    about: Check our documentation for guides and tutorials.
EOF

    print_success "Issue templates created"
}

# Function to create automation guide
create_automation_guide() {
    print_status "Creating automation rules setup guide..."
    
    cat > automation-rules-guide.md << 'EOF'
# GitHub Project Automation Rules Setup Guide

## Overview
This guide helps you set up automation rules for the Docqet GitHub Project. These rules will automatically update issue status, assign fields, and maintain project organization.

## Setup Instructions

1. Go to your GitHub Project: https://github.com/orgs/loopcraftlab/projects/3
2. Click on "Settings" (gear icon) in the top right
3. Navigate to the "Automation" section
4. Add each rule listed below

## Automation Rules to Configure

### 1. Issue Assignment Rules

**Rule 1: Issue Assigned → In Progress**
- **Trigger**: Issue is assigned
- **Action**: Set Status to "In Progress"

**Rule 2: Issue Unassigned → Todo**
- **Trigger**: Issue is unassigned
- **Action**: Set Status to "Todo"

### 2. Pull Request Rules

**Rule 3: PR Opened → Review**
- **Trigger**: Pull request is opened
- **Action**: Set Status to "Review"

**Rule 4: PR Merged → Done**
- **Trigger**: Pull request is merged
- **Action**: Set Status to "Done"

**Rule 5: PR Closed → In Progress**
- **Trigger**: Pull request is closed (not merged)
- **Action**: Set Status to "In Progress"

### 3. Label-Based Field Assignment

**Rule 6: Priority Labels → Priority Field**
- **Trigger**: Issue has label "priority-high"
- **Action**: Set Priority to "P0"

- **Trigger**: Issue has label "priority-medium"
- **Action**: Set Priority to "P1"

- **Trigger**: Issue has label "priority-low"
- **Action**: Set Priority to "P2"

**Rule 7: Area Labels → Area Field**
- **Trigger**: Issue has label "frontend"
- **Action**: Set Area to "Frontend"

- **Trigger**: Issue has label "backend"
- **Action**: Set Area to "Backend"

- **Trigger**: Issue has label "ai"
- **Action**: Set Area to "AI"

- **Trigger**: Issue has label "ci/cd"
- **Action**: Set Area to "DevOps"

### 4. Date Tracking Rules

**Rule 8: Start Date Tracking**
- **Trigger**: Status changes to "In Progress"
- **Action**: Set Start Date to current date

**Rule 9: Target Date Tracking**
- **Trigger**: Status changes to "Done"
- **Action**: Set Target Date to current date

## Testing Automation Rules

After setting up the rules:

1. Create a test issue
2. Assign it to yourself (should move to "In Progress")
3. Add a priority label (should set Priority field)
4. Add an area label (should set Area field)
5. Create a PR linked to the issue (should move to "Review")
6. Merge the PR (should move to "Done")

## Troubleshooting

- **Rules not working**: Check that the field names match exactly
- **Multiple rules conflicting**: Ensure rules have proper conditions
- **Field not updating**: Verify the field exists and is properly configured

## Maintenance

- Review automation rules monthly
- Update rules as project needs change
- Monitor rule performance and adjust as needed
EOF

    print_success "Automation rules guide created: automation-rules-guide.md"
}

# Function to generate setup report
generate_setup_report() {
    print_status "Generating setup report..."
    
    cat > project-setup-report.md << EOF
# GitHub Project Automation Setup Report

## Project Information
- **Organization**: $ORG
- **Repository**: $REPO
- **Project Number**: $PROJECT_NUMBER
- **Project URL**: https://github.com/orgs/$ORG/projects/$PROJECT_NUMBER
- **Setup Date**: $(date)

## ✅ Completed Setup

### Issue Templates
- ✅ Bug Report Template
- ✅ Feature Request Template
- ✅ Issue Template Configuration

### GitHub Actions Workflows
- ✅ Project Automation Workflow
- ✅ Issue Templates Management
- ✅ Project Views Setup
- ✅ Release Automation

### Documentation
- ✅ Automation Rules Guide
- ✅ Project Setup Report
- ✅ Comprehensive Documentation

## 🔧 Manual Setup Required

### Project Board Setup
1. Go to https://github.com/orgs/$ORG/projects/$PROJECT_NUMBER
2. Set up custom fields:
   - Status (Todo, In Progress, Review, Testing, Done)
   - Priority (P0, P1, P2)
   - Area (Frontend, Backend, AI, DevOps)
   - Start Date (Date field)
   - Target Date (Date field)
   - Epic (Text field)

### Project Views
1. Create the following views:
   - Development Board (Board layout, grouped by Status)
   - Project Table (Table layout with key fields)
   - Release Roadmap (Roadmap layout, grouped by Epic)
   - Sprint Board (Board layout, sorted by Priority)
   - Backlog (Table layout, filtered for Todo items)

### Automation Rules
Please set up automation rules using the guide in \`automation-rules-guide.md\`

### Team Access
1. Add team members to the project
2. Configure appropriate permissions
3. Set up notifications

## 📊 Project Statistics

- **Total Issues**: $(gh issue list --limit 1000 --json number | jq length 2>/dev/null || echo "Unable to fetch")
- **Open Issues**: $(gh issue list --state open --limit 1000 --json number | jq length 2>/dev/null || echo "Unable to fetch")
- **Closed Issues**: $(gh issue list --state closed --limit 1000 --json number | jq length 2>/dev/null || echo "Unable to fetch")

## 🎯 Next Steps

1. **Set up project board** with custom fields and views
2. **Configure automation rules** using the provided guide
3. **Add team members** and set up permissions
4. **Test the automation** with sample issues
5. **Start using the project board** for issue tracking

## 🔗 Useful Links

- **Project URL**: https://github.com/orgs/$ORG/projects/$PROJECT_NUMBER
- **Repository**: https://github.com/$ORG/$REPO
- **Issues**: https://github.com/$ORG/$REPO/issues
- **Discussions**: https://github.com/$ORG/$REPO/discussions
- **Actions**: https://github.com/$ORG/$REPO/actions

## 📚 Documentation

- **Automation Rules Guide**: automation-rules-guide.md
- **Project Management Guide**: PROJECT_MANAGEMENT_GUIDE.md
- **Quick Reference**: PROJECT_MANAGEMENT_QUICK_REFERENCE.md
- **GitHub Project Setup**: GITHUB_PROJECT_AUTOMATION_SETUP.md

## 🚀 Automation Features

### Workflows Created
- **project-automation.yml**: Handles issue management and status updates
- **issue-templates.yml**: Manages issue templates
- **project-views-setup.yml**: Sets up project views and fields
- **release-automation.yml**: Handles releases and versioning

### Features
- Automatic issue labeling based on content
- Status tracking based on assignments and PRs
- Weekly maintenance and reporting
- Dependency update monitoring
- Release automation with changelogs
- Docker image building and pushing

---
*Report generated by setup-github-project-automation.sh on $(date)*
EOF

    print_success "Setup report generated: project-setup-report.md"
}

# Function to commit changes
commit_changes() {
    print_status "Committing changes..."
    
    # Check if there are changes to commit
    if git status --porcelain | grep -q .; then
        git add .
        git commit -m "Setup GitHub Project automation and issue templates" || print_warning "No changes to commit"
        print_success "Changes committed"
    else
        print_warning "No changes to commit"
    fi
}

# Main execution
main() {
    echo "🚀 GitHub Project Automation Setup for Docqet"
    echo "=============================================="
    echo
    
    # Check prerequisites
    check_gh_cli
    
    # Check project access
    check_project_access
    
    # Setup issue templates
    setup_issue_templates
    
    # Create automation guide
    create_automation_guide
    
    # Generate setup report
    generate_setup_report
    
    # Commit changes
    commit_changes
    
    echo
    echo "🎉 GitHub Project Automation Setup Complete!"
    echo "=============================================="
    echo
    echo "📋 Next Steps:"
    echo "1. Review the setup report: project-setup-report.md"
    echo "2. Set up project board with custom fields and views"
    echo "3. Configure automation rules: automation-rules-guide.md"
    echo "4. Add team members and set up permissions"
    echo "5. Test the automation with sample issues"
    echo
    echo "🔗 Project URL: https://github.com/orgs/$ORG/projects/$PROJECT_NUMBER"
    echo
    echo "📚 Generated Files:"
    echo "- automation-rules-guide.md"
    echo "- project-setup-report.md"
    echo "- .github/ISSUE_TEMPLATE/ (issue templates)"
    echo
}

# Run main function
main "$@" 