#!/bin/bash

# Setup GitHub Organization Project for Docqet
# This script creates and configures the organization project

set -e

echo "🏢 Setting up GitHub Organization Project for Docqet..."

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

# Create the organization project
create_project() {
    print_status "Creating organization project..."
    
    PROJECT_NUMBER=$(gh project create --owner loopcraftlab --title "Docqet – Product Dev" --format json | jq -r '.number')
    
    if [ -n "$PROJECT_NUMBER" ] && [ "$PROJECT_NUMBER" != "null" ]; then
        print_success "Project created with number: $PROJECT_NUMBER"
        echo "$PROJECT_NUMBER" > .github/project-number.txt
        return 0
    else
        print_error "Failed to create project"
        return 1
    fi
}

# Create project fields
create_fields() {
    print_status "Creating project fields..."
    
    if [ ! -f ".github/project-number.txt" ]; then
        print_error "Project number file not found. Please run project creation first."
        return 1
    fi
    
    PROJECT_NUMBER=$(cat .github/project-number.txt)
    
    # Status field
    print_status "Creating Status field..."
    gh project field-create "$PROJECT_NUMBER" --owner loopcraftlab \
        --name "Status" \
        --data-type SINGLE_SELECT \
        --single-select-options "Todo,In progress,Blocked,In review,Done"
    
    # Priority field
    print_status "Creating Priority field..."
    gh project field-create "$PROJECT_NUMBER" --owner loopcraftlab \
        --name "Priority" \
        --data-type SINGLE_SELECT \
        --single-select-options "P0,P1,P2"
    
    # Area field
    print_status "Creating Area field..."
    gh project field-create "$PROJECT_NUMBER" --owner loopcraftlab \
        --name "Area" \
        --data-type SINGLE_SELECT \
        --single-select-options "Backend,Frontend,AI,DevOps,Docs"
    
    # Start date field
    print_status "Creating Start date field..."
    gh project field-create "$PROJECT_NUMBER" --owner loopcraftlab \
        --name "Start date" \
        --data-type DATE
    
    # Target date field
    print_status "Creating Target date field..."
    gh project field-create "$PROJECT_NUMBER" --owner loopcraftlab \
        --name "Target date" \
        --data-type DATE
    
    print_success "All project fields created"
}

# Add repository to project
add_repository() {
    print_status "Adding repository to project..."
    
    if [ ! -f ".github/project-number.txt" ]; then
        print_error "Project number file not found. Please run project creation first."
        return 1
    fi
    
    PROJECT_NUMBER=$(cat .github/project-number.txt)
    
    # Add the repository
    gh project item-add "$PROJECT_NUMBER" --owner loopcraftlab \
        --repo loopcraftlab/docqet
    
    print_success "Repository added to project"
}

# Add existing issues to project
add_issues() {
    print_status "Adding existing issues to project..."
    
    if [ ! -f ".github/project-number.txt" ]; then
        print_error "Project number file not found. Please run project creation first."
        return 1
    fi
    
    PROJECT_NUMBER=$(cat .github/project-number.txt)
    
    # Get all issues from the repository
    ISSUES=$(gh issue list --repo loopcraftlab/docqet --json number --jq '.[].number' 2>/dev/null || echo "")
    
    if [ -n "$ISSUES" ]; then
        for ISSUE_NUMBER in $ISSUES; do
            print_status "Adding issue #$ISSUE_NUMBER to project..."
            gh project item-add "$PROJECT_NUMBER" --owner loopcraftlab \
                --issue-number "$ISSUE_NUMBER" \
                --repo loopcraftlab/docqet
        done
        print_success "All issues added to project"
    else
        print_warning "No issues found to add to project"
    fi
}

# Create project views
create_views() {
    print_status "Creating project views..."
    
    if [ ! -f ".github/project-number.txt" ]; then
        print_error "Project number file not found. Please run project creation first."
        return 1
    fi
    
    PROJECT_NUMBER=$(cat .github/project-number.txt)
    
    # Board view
    print_status "Creating Board view..."
    gh project view-create "$PROJECT_NUMBER" --owner loopcraftlab \
        --name "Board" \
        --layout BOARD
    
    # Table view
    print_status "Creating Table view..."
    gh project view-create "$PROJECT_NUMBER" --owner loopcraftlab \
        --name "Table" \
        --layout TABLE
    
    # Roadmap view
    print_status "Creating Roadmap view..."
    gh project view-create "$PROJECT_NUMBER" --owner loopcraftlab \
        --name "Roadmap" \
        --layout ROADMAP
    
    print_success "All project views created"
}

# Display project information
display_info() {
    if [ -f ".github/project-number.txt" ]; then
        PROJECT_NUMBER=$(cat .github/project-number.txt)
        echo ""
        echo "🎉 Organization project setup completed!"
        echo ""
        echo "Project Information:"
        echo "  Number: $PROJECT_NUMBER"
        echo "  URL: https://github.com/orgs/loopcraftlab/projects/$PROJECT_NUMBER"
        echo ""
        echo "Views:"
        echo "  - Board: https://github.com/orgs/loopcraftlab/projects/$PROJECT_NUMBER?view=board"
        echo "  - Table: https://github.com/orgs/loopcraftlab/projects/$PROJECT_NUMBER?view=table"
        echo "  - Roadmap: https://github.com/orgs/loopcraftlab/projects/$PROJECT_NUMBER?view=roadmap"
        echo ""
        echo "Fields Created:"
        echo "  - Status (Todo, In progress, Blocked, In review, Done)"
        echo "  - Priority (P0, P1, P2)"
        echo "  - Area (Backend, Frontend, AI, DevOps, Docs)"
        echo "  - Start date"
        echo "  - Target date"
        echo ""
        echo "Next steps:"
        echo "1. Visit the project board to see your issues"
        echo "2. Customize views and fields as needed"
        echo "3. Add team members to the project"
        echo "4. Set up automation rules"
        echo ""
        echo "Happy project managing! 🚀"
    else
        print_error "Project number not found. Setup may have failed."
    fi
}

# Main function
main() {
    echo "🏢 Docqet Organization Project Setup"
    echo "===================================="
    
    check_github_cli
    create_project
    create_fields
    add_repository
    add_issues
    create_views
    display_info
}

# Run main function
main "$@" 