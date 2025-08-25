#!/bin/bash

# GitHub Project Views and Automation Setup Script
# This script provides step-by-step instructions for setting up GitHub project views and automation

set -e

echo "🎯 Setting up GitHub Project Views and Automation..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

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

print_step() {
    echo -e "${PURPLE}[STEP]${NC} $1"
}

print_note() {
    echo -e "${CYAN}[NOTE]${NC} $1"
}

# Check if GitHub CLI is available and authenticated
check_github_cli() {
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI is not installed. Please install it first."
        exit 1
    fi
    
    if ! gh auth status &> /dev/null; then
        print_error "GitHub CLI is not authenticated. Please run 'gh auth login' first."
        exit 1
    fi
    
    print_success "GitHub CLI is available and authenticated"
}

# Display current project status
display_project_status() {
    echo ""
    echo "📊 Current Project Status"
    echo "========================"
    echo ""
    echo "🏗️  Project Information:"
    echo "  - Project Number: 3"
    echo "  - URL: https://github.com/orgs/loopcraftlab/projects/3"
    echo "  - Custom Fields: ✅ Created"
    echo ""
    echo "📋 Created Issues:"
    echo "  Epics: #4-#10 (7 epics)"
    echo "  Stories: #11-#18 (8 stories)"
    echo ""
    echo "🏷️  Available Labels:"
    echo "  Epic: epic, epic-1 through epic-7"
    echo "  Priority: priority-p0, priority-p1, priority-p2"
    echo "  Area: backend, frontend, ai, devops"
    echo "  Type: story, bug, enhancement, documentation"
    echo ""
}

# Display step-by-step setup instructions
display_setup_instructions() {
    echo ""
    echo "🎯 GitHub Project Setup Instructions"
    echo "==================================="
    echo ""
    
    print_step "Step 1: Open GitHub Project"
    echo "🌐 Navigate to: https://github.com/orgs/loopcraftlab/projects/3"
    echo ""
    
    print_step "Step 2: Create Project Views"
    echo "📋 You need to create 3 views manually:"
    echo ""
    
    echo "   a) 📊 Development Board View:"
    echo "      - Click 'Add view' → 'Board'"
    echo "      - Name: 'Development Board'"
    echo "      - Group by: 'Status'"
    echo "      - Columns: Todo, In Progress, Review, Testing, Done"
    echo "      - Purpose: Daily standups and visual progress tracking"
    echo ""
    
    echo "   b) 📋 Project Table View:"
    echo "      - Click 'Add view' → 'Table'"
    echo "      - Name: 'Project Table'"
    echo "      - Include fields: Title, Status, Priority, Area, Assignees, Labels"
    echo "      - Purpose: Detailed planning and sprint management"
    echo ""
    
    echo "   c) 🗓️  Release Roadmap View:"
    echo "      - Click 'Add view' → 'Roadmap'"
    echo "      - Name: 'Release Roadmap'"
    echo "      - Group by: 'Epic'"
    echo "      - Timeline: Based on Target Date"
    echo "      - Purpose: Release planning and timeline management"
    echo ""
    
    print_step "Step 3: Add All Issues to Project"
    echo "🔗 Add the following issues to the project:"
    echo ""
    
    echo "   📚 Epic Issues:"
    echo "   - Issue #4: Epic 1 - Foundation & Core Infrastructure"
    echo "   - Issue #5: Epic 2 - Document Management & Sharing"
    echo "   - Issue #6: Epic 3 - AI-Powered Content Analysis"
    echo "   - Issue #7: Epic 4 - Real-Time Synchronization"
    echo "   - Issue #8: Epic 5 - Integration & Deployment"
    echo "   - Issue #9: Epic 6 - Compliance & Enterprise Features"
    echo "   - Issue #10: Epic 7 - Admin & Billing"
    echo ""
    
    echo "   📖 Story Issues:"
    echo "   - Issue #11: Story 1.2 - User Authentication and Authorization"
    echo "   - Issue #12: Story 1.3 - Basic Document Upload and Storage"
    echo "   - Issue #13: Story 1.4 - Core AI Integration Setup"
    echo "   - Issue #14: Story 1.5 - Document Viewer and Preview"
    echo "   - Issue #15: Story 1.6 - Localization and Internationalization"
    echo "   - Issue #16: Story 2.1 - Advanced Document Sharing and Access Controls"
    echo "   - Issue #17: Story 2.2 - Document Organization and Metadata Management"
    echo "   - Issue #18: Story 3.1 - Advanced Content Analysis and Summarization"
    echo ""
    
    echo "   📝 How to add issues:"
    echo "   1. Go to each issue (e.g., https://github.com/loopcraftlab/docqet/issues/4)"
    echo "   2. Click 'Add to project' button"
    echo "   3. Select 'Docqet – Product Dev' project"
    echo "   4. Set initial fields (Status: Todo, Priority: based on labels)"
    echo ""
    
    print_step "Step 4: Configure Issue Fields"
    echo "🏷️  Set the following fields for each issue:"
    echo ""
    
    echo "   📊 Status Field:"
    echo "   - All new issues: 'Todo'"
    echo "   - In Progress: 'In Progress'"
    echo "   - Ready for Review: 'Review'"
    echo "   - Being Tested: 'Testing'"
    echo "   - Completed: 'Done'"
    echo ""
    
    echo "   🎯 Priority Field:"
    echo "   - Epic 1 stories: 'P0' (Critical)"
    echo "   - Epic 2 & 3 stories: 'P1' (High)"
    echo "   - Epic 4-7: 'P2' (Medium)"
    echo ""
    
    echo "   🏢 Area Field:"
    echo "   - Backend stories: 'Backend'"
    echo "   - Frontend stories: 'Frontend'"
    echo "   - AI stories: 'AI'"
    echo "   - DevOps stories: 'DevOps'"
    echo ""
    
    print_step "Step 5: Set up Automation Rules"
    echo "⚙️  Configure automation for efficient workflow:"
    echo ""
    
    echo "   🔄 Issue Assignment Automation:"
    echo "   - Rule: When issue is assigned → Move to 'In Progress'"
    echo "   - Rule: When issue is unassigned → Move to 'Todo'"
    echo ""
    
    echo "   📝 Pull Request Automation:"
    echo "   - Rule: When PR is created → Move linked issue to 'Review'"
    echo "   - Rule: When PR is merged → Move linked issue to 'Done'"
    echo "   - Rule: When PR is closed without merge → Move linked issue to 'In Progress'"
    echo ""
    
    echo "   🏷️  Label-based Automation:"
    echo "   - Rule: When 'priority-p0' label is added → Set Priority to 'P0'"
    echo "   - Rule: When 'priority-p1' label is added → Set Priority to 'P1'"
    echo "   - Rule: When 'priority-p2' label is added → Set Priority to 'P2'"
    echo ""
    
    echo "   📅 Date Automation:"
    echo "   - Rule: When issue is moved to 'In Progress' → Set Start Date to today"
    echo "   - Rule: When issue is moved to 'Done' → Set Target Date to today"
    echo ""
    
    print_step "Step 6: Team Setup"
    echo "👥 Configure team access and notifications:"
    echo ""
    
    echo "   👤 Add Team Members:"
    echo "   - Go to Project Settings → Access"
    echo "   - Add team members with appropriate permissions"
    echo "   - Set up team roles (Admin, Write, Read)"
    echo ""
    
    echo "   🔔 Notification Setup:"
    echo "   - Configure email notifications for project updates"
    echo "   - Set up Slack/Teams integration if needed"
    echo "   - Configure issue assignment notifications"
    echo ""
    
    print_step "Step 7: Project Configuration"
    echo "⚙️  Final project configuration:"
    echo ""
    
    echo "   📊 Project Settings:"
    echo "   - Set project description and visibility"
    echo "   - Configure default view (Development Board)"
    echo "   - Set up project templates if needed"
    echo ""
    
    echo "   📈 Analytics Setup:"
    echo "   - Enable project insights and analytics"
    echo "   - Set up velocity tracking"
    echo "   - Configure burndown charts"
    echo ""
}

# Display automation setup details
display_automation_details() {
    echo ""
    echo "🤖 Automation Configuration Details"
    echo "=================================="
    echo ""
    
    print_note "Automation Rules to Create:"
    echo ""
    
    echo "1. 📋 Issue Assignment Rules:"
    echo "   - Trigger: Issue assigned"
    echo "   - Action: Move to 'In Progress'"
    echo "   - Trigger: Issue unassigned"
    echo "   - Action: Move to 'Todo'"
    echo ""
    
    echo "2. 🔄 Pull Request Rules:"
    echo "   - Trigger: PR created"
    echo "   - Action: Move linked issue to 'Review'"
    echo "   - Trigger: PR merged"
    echo "   - Action: Move linked issue to 'Done'"
    echo "   - Trigger: PR closed without merge"
    echo "   - Action: Move linked issue to 'In Progress'"
    echo ""
    
    echo "3. 🏷️  Label Rules:"
    echo "   - Trigger: priority-p0 label added"
    echo "   - Action: Set Priority field to 'P0'"
    echo "   - Trigger: priority-p1 label added"
    echo "   - Action: Set Priority field to 'P1'"
    echo "   - Trigger: priority-p2 label added"
    echo "   - Action: Set Priority field to 'P2'"
    echo ""
    
    echo "4. 📅 Date Rules:"
    echo "   - Trigger: Issue moved to 'In Progress'"
    echo "   - Action: Set Start Date to current date"
    echo "   - Trigger: Issue moved to 'Done'"
    echo "   - Action: Set Target Date to current date"
    echo ""
    
    echo "5. 🔔 Notification Rules:"
    echo "   - Trigger: Issue assigned"
    echo "   - Action: Notify assignee"
    echo "   - Trigger: Issue moved to 'Review'"
    echo "   - Action: Notify reviewers"
    echo ""
}

# Display best practices
display_best_practices() {
    echo ""
    echo "📈 Project Management Best Practices"
    echo "==================================="
    echo ""
    
    echo "🎯 Daily Workflow:"
    echo "• Start each day by checking the Development Board"
    echo "• Update issue status as you work"
    echo "• Add progress comments to issues"
    echo "• Move issues to appropriate columns"
    echo ""
    
    echo "📋 Sprint Management:"
    echo "• Use the Table view for sprint planning"
    echo "• Use the Roadmap view for release planning"
    echo "• Track velocity and burndown charts"
    echo "• Conduct regular sprint reviews and retrospectives"
    echo ""
    
    echo "🔗 Issue Management:"
    echo "• Always link PRs to issues using 'Closes #issue-number'"
    echo "• Update issue status when creating PRs"
    echo "• Add detailed acceptance criteria to stories"
    echo "• Use labels consistently for organization"
    echo ""
    
    echo "👥 Team Collaboration:"
    echo "• Use the Board view for daily standups"
    echo "• Communicate blockers in issue comments"
    echo "• Share progress updates regularly"
    echo "• Celebrate team achievements"
    echo ""
}

# Display next steps
display_next_steps() {
    echo ""
    echo "🚀 Next Steps After Setup"
    echo "========================="
    echo ""
    
    print_step "Immediate Actions:"
    echo "1. Complete the manual setup steps above"
    echo "2. Start working on Story 1.2 (User Authentication)"
    echo "3. Set up your development environment with 'make dev'"
    echo "4. Create your first feature branch"
    echo ""
    
    print_step "Team Onboarding:"
    echo "1. Share this setup guide with your team"
    echo "2. Conduct a project management training session"
    echo "3. Set up team communication channels"
    echo "4. Establish sprint planning and review processes"
    echo ""
    
    print_step "Ongoing Management:"
    echo "1. Regular project board updates"
    echo "2. Weekly sprint planning sessions"
    echo "3. Daily standup meetings"
    echo "4. Monthly project reviews"
    echo ""
    
    print_success "GitHub project setup instructions completed!"
    echo ""
    echo "🎉 Your Docqet project is ready for development!"
    echo "📊 Project URL: https://github.com/orgs/loopcraftlab/projects/3"
    echo "📚 Documentation: PROJECT_MANAGEMENT_GUIDE.md"
    echo "⚡ Quick Reference: PROJECT_MANAGEMENT_QUICK_REFERENCE.md"
    echo ""
}

# Main function
main() {
    echo "🎯 GitHub Project Views and Automation Setup"
    echo "============================================"
    
    check_github_cli
    display_project_status
    display_setup_instructions
    display_automation_details
    display_best_practices
    display_next_steps
}

# Run main function
main "$@" 