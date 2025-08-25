#!/bin/bash

# Docqet Project Management Setup Script
# This script helps set up comprehensive project management features

set -e

echo "📊 Setting up Docqet Project Management..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
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

# Display project management setup instructions
display_setup_instructions() {
    echo ""
    echo "🎯 Docqet Project Management Setup Instructions"
    echo "=============================================="
    echo ""
    echo "📋 Current Project Status:"
    echo "  - Project Number: 3"
    echo "  - URL: https://github.com/orgs/loopcraftlab/projects/3"
    echo "  - Custom Fields: ✅ Created"
    echo "  - Epic Issues: ✅ Created"
    echo "  - Story Issues: ✅ Created"
    echo ""
    echo "📊 Next Steps - Manual Setup Required:"
    echo ""
    echo "1. 🌐 Open GitHub Project:"
    echo "   https://github.com/orgs/loopcraftlab/projects/3"
    echo ""
    echo "2. 📋 Create Project Views (Manual):"
    echo "   a) Board View:"
    echo "      - Click 'Add view' → 'Board'"
    echo "      - Name: 'Development Board'"
    echo "      - Group by: 'Status'"
    echo "      - Columns: Todo, In Progress, Review, Testing, Done"
    echo ""
    echo "   b) Table View:"
    echo "      - Click 'Add view' → 'Table'"
    echo "      - Name: 'Project Table'"
    echo "      - Include fields: Title, Status, Priority, Area, Assignees, Labels"
    echo ""
    echo "   c) Roadmap View:"
    echo "      - Click 'Add view' → 'Roadmap'"
    echo "      - Name: 'Release Roadmap'"
    echo "      - Group by: 'Epic'"
    echo "      - Timeline: Based on Target Date"
    echo ""
    echo "3. 🔗 Add Issues to Project:"
    echo "   - Go to each epic issue (4-10)"
    echo "   - Click 'Add to project' → Select project #3"
    echo "   - Go to each story issue (11-13)"
    echo "   - Click 'Add to project' → Select project #3"
    echo ""
    echo "4. 🏷️  Set Issue Fields:"
    echo "   - Status: Set to 'Todo' for all new issues"
    echo "   - Priority: Set based on labels (P0, P1, P2)"
    echo "   - Area: Set based on labels (Backend, Frontend, AI, DevOps)"
    echo "   - Start Date: Leave empty for now"
    echo "   - Target Date: Set based on sprint planning"
    echo ""
    echo "5. ⚙️  Set up Automation (Optional):"
    echo "   - Go to Project Settings → Automation"
    echo "   - Add rules for:"
    echo "     * Move issues to 'In Progress' when assigned"
    echo "     * Move issues to 'Review' when PR is created"
    echo "     * Move issues to 'Done' when PR is merged"
    echo ""
    echo "6. 👥 Team Setup:"
    echo "   - Add team members to the project"
    echo "   - Set up notifications"
    echo "   - Configure access permissions"
    echo ""
    echo "📈 Project Management Best Practices:"
    echo ""
    echo "• Daily Standups: Use the Board view to track progress"
    echo "• Sprint Planning: Use the Table view for detailed planning"
    echo "• Release Planning: Use the Roadmap view for timeline management"
    echo "• Issue Updates: Update status and add comments regularly"
    echo "• Documentation: Link PRs to issues using 'Closes #issue-number'"
    echo ""
    echo "🎯 Epic Structure Overview:"
    echo ""
    echo "Epic 1 (P0): Foundation & Core Infrastructure"
    echo "  ├── Story 1.2: User Authentication (P0)"
    echo "  ├── Story 1.3: Document Upload (P0)"
    echo "  └── Story 1.4: AI Integration (P0)"
    echo ""
    echo "Epic 2 (P1): Document Management & Sharing"
    echo "Epic 3 (P1): AI-Powered Content Analysis"
    echo "Epic 4 (P2): Real-Time Synchronization"
    echo "Epic 5 (P2): Integration & Deployment"
    echo "Epic 6 (P2): Compliance & Enterprise Features"
    echo "Epic 7 (P2): Admin & Billing"
    echo ""
    echo "🚀 Ready to Start Development!"
    echo ""
    echo "Next Actions:"
    echo "1. Complete the manual setup above"
    echo "2. Start working on Story 1.2 (User Authentication)"
    echo "3. Use 'make dev' to start the development environment"
    echo "4. Follow the development workflow in CONTRIBUTING.md"
    echo ""
    print_success "Project management setup instructions completed!"
}

# Display current project information
display_project_info() {
    if [ -f ".github/project-number.txt" ]; then
        PROJECT_NUMBER=$(cat .github/project-number.txt)
        echo ""
        echo "📊 Current Project Information:"
        echo "  Project Number: $PROJECT_NUMBER"
        echo "  URL: https://github.com/orgs/loopcraftlab/projects/$PROJECT_NUMBER"
        echo ""
        echo "📋 Created Issues:"
        echo "  Epics: #4-#10 (7 epics)"
        echo "  Stories: #11-#13 (3 stories from Epic 1)"
        echo ""
        echo "🏷️  Available Labels:"
        echo "  Epic: epic, epic-1 through epic-7"
        echo "  Priority: priority-p0, priority-p1, priority-p2"
        echo "  Area: backend, frontend, ai, devops"
        echo "  Type: story, bug, enhancement, documentation"
        echo ""
    else
        print_warning "Project number file not found. Using default project #3"
    fi
}

# Main function
main() {
    echo "📊 Docqet Project Management Setup"
    echo "=================================="
    
    check_github_cli
    display_project_info
    display_setup_instructions
}

# Run main function
main "$@" 