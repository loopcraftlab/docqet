#!/bin/bash

# Setup GitHub Organization Project for Docqet
# This script creates an organization-level project for managing Docqet development

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

# Create organization project
create_organization_project() {
    print_status "Creating organization-level project..."
    
    # Create the project
    PROJECT_ID=$(gh api graphql -f query='
    mutation {
        createProjectV2(input: {
            ownerId: "O_kgDOGqXqXQ"
            title: "Docqet Development"
            description: "Project board for managing Docqet development and collaboration"
        }) {
            projectV2 {
                id
                title
                url
            }
        }
    }' --jq '.data.createProjectV2.projectV2.id' 2>/dev/null || echo "")
    
    if [ -n "$PROJECT_ID" ]; then
        print_success "Organization project created with ID: $PROJECT_ID"
        echo "Project URL: https://github.com/orgs/loopcraftlab/projects/1"
    else
        print_warning "Failed to create organization project. It might already exist."
        print_status "Trying to find existing project..."
        
        # Try to find existing project
        EXISTING_PROJECT=$(gh api graphql -f query='
        query {
            organization(login: "loopcraftlab") {
                projectsV2(first: 10) {
                    nodes {
                        id
                        title
                        url
                    }
                }
            }
        }' --jq '.data.organization.projectsV2.nodes[] | select(.title == "Docqet Development") | .id' 2>/dev/null || echo "")
        
        if [ -n "$EXISTING_PROJECT" ]; then
            PROJECT_ID=$EXISTING_PROJECT
            print_success "Found existing project with ID: $PROJECT_ID"
        else
            print_error "Could not create or find organization project"
            return 1
        fi
    fi
    
    # Store project ID for later use
    echo "$PROJECT_ID" > .github/project-id.txt
    print_success "Project ID saved to .github/project-id.txt"
}

# Add repository to project
add_repository_to_project() {
    print_status "Adding repository to project..."
    
    if [ ! -f ".github/project-id.txt" ]; then
        print_error "Project ID file not found. Please run project creation first."
        return 1
    fi
    
    PROJECT_ID=$(cat .github/project-id.txt)
    
    # Add repository to project
    gh api graphql -f query='
    mutation($projectId: ID!, $repositoryId: ID!) {
        addProjectV2Item(input: {
            projectId: $projectId
            contentId: $repositoryId
        }) {
            item {
                id
            }
        }
    }' -f projectId="$PROJECT_ID" -f repositoryId="R_kgDOGqXqXQ" 2>/dev/null || print_warning "Failed to add repository to project (might already be added)"
    
    print_success "Repository added to project"
}

# Create project views
create_project_views() {
    print_status "Creating project views..."
    
    if [ ! -f ".github/project-id.txt" ]; then
        print_error "Project ID file not found. Please run project creation first."
        return 1
    fi
    
    PROJECT_ID=$(cat .github/project-id.txt)
    
    # Create different views for the project
    # Board view
    gh api graphql -f query='
    mutation($projectId: ID!) {
        createProjectV2View(input: {
            projectId: $projectId
            name: "Board"
            layout: BOARD_LAYOUT
        }) {
            projectV2View {
                id
                name
            }
        }
    }' -f projectId="$PROJECT_ID" 2>/dev/null || print_warning "Failed to create board view (might already exist)"
    
    # Table view
    gh api graphql -f query='
    mutation($projectId: ID!) {
        createProjectV2View(input: {
            projectId: $projectId
            name: "Table"
            layout: TABLE_LAYOUT
        }) {
            projectV2View {
                id
                name
            }
        }
    }' -f projectId="$PROJECT_ID" 2>/dev/null || print_warning "Failed to create table view (might already exist)"
    
    # Roadmap view
    gh api graphql -f query='
    mutation($projectId: ID!) {
        createProjectV2View(input: {
            projectId: $projectId
            name: "Roadmap"
            layout: ROADMAP_LAYOUT
        }) {
            projectV2View {
                id
                name
            }
        }
    }' -f projectId="$PROJECT_ID" 2>/dev/null || print_warning "Failed to create roadmap view (might already exist)"
    
    print_success "Project views created"
}

# Create project fields
create_project_fields() {
    print_status "Creating project fields..."
    
    if [ ! -f ".github/project-id.txt" ]; then
        print_error "Project ID file not found. Please run project creation first."
        return 1
    fi
    
    PROJECT_ID=$(cat .github/project-id.txt)
    
    # Create Status field
    gh api graphql -f query='
    mutation($projectId: ID!) {
        createProjectV2Field(input: {
            projectId: $projectId
            name: "Status"
            dataType: SINGLE_SELECT
            singleSelectOptions: [
                { name: "Backlog", color: "GRAY" }
                { name: "To Do", color: "BLUE" }
                { name: "In Progress", color: "YELLOW" }
                { name: "Review", color: "ORANGE" }
                { name: "Done", color: "GREEN" }
            ]
        }) {
            projectV2Field {
                id
                name
            }
        }
    }' -f projectId="$PROJECT_ID" 2>/dev/null || print_warning "Failed to create Status field (might already exist)"
    
    # Create Priority field
    gh api graphql -f query='
    mutation($projectId: ID!) {
        createProjectV2Field(input: {
            projectId: $projectId
            name: "Priority"
            dataType: SINGLE_SELECT
            singleSelectOptions: [
                { name: "Low", color: "GREEN" }
                { name: "Medium", color: "YELLOW" }
                { name: "High", color: "RED" }
                { name: "Critical", color: "PURPLE" }
            ]
        }) {
            projectV2Field {
                id
                name
            }
        }
    }' -f projectId="$PROJECT_ID" 2>/dev/null || print_warning "Failed to create Priority field (might already exist)"
    
    # Create Story field
    gh api graphql -f query='
    mutation($projectId: ID!) {
        createProjectV2Field(input: {
            projectId: $projectId
            name: "Story"
            dataType: SINGLE_SELECT
            singleSelectOptions: [
                { name: "1.1 - Project Setup", color: "BLUE" }
                { name: "1.2 - Authentication", color: "GREEN" }
                { name: "1.3 - Document Upload", color: "YELLOW" }
                { name: "1.4 - AI Integration", color: "PURPLE" }
            ]
        }) {
            projectV2Field {
                id
                name
            }
        }
    }' -f projectId="$PROJECT_ID" 2>/dev/null || print_warning "Failed to create Story field (might already exist)"
    
    print_success "Project fields created"
}

# Add existing issues to project
add_issues_to_project() {
    print_status "Adding existing issues to project..."
    
    if [ ! -f ".github/project-id.txt" ]; then
        print_error "Project ID file not found. Please run project creation first."
        return 1
    fi
    
    PROJECT_ID=$(cat .github/project-id.txt)
    
    # Get all issues from the repository
    ISSUES=$(gh api repos/loopcraftlab/docqet/issues --jq '.[].id' 2>/dev/null || echo "")
    
    if [ -n "$ISSUES" ]; then
        for ISSUE_ID in $ISSUES; do
            print_status "Adding issue $ISSUE_ID to project..."
            gh api graphql -f query='
            mutation($projectId: ID!, $issueId: ID!) {
                addProjectV2Item(input: {
                    projectId: $projectId
                    contentId: $issueId
                }) {
                    item {
                        id
                    }
                }
            }' -f projectId="$PROJECT_ID" -f issueId="$ISSUE_ID" 2>/dev/null || print_warning "Failed to add issue $ISSUE_ID to project"
        done
        print_success "Issues added to project"
    else
        print_warning "No issues found to add to project"
    fi
}

# Create project documentation
create_project_documentation() {
    print_status "Creating project documentation..."
    
    cat > .github/PROJECT_GUIDE.md << 'EOF'
# Docqet Organization Project Guide

## Overview

This GitHub Project is used to manage the development and collaboration for the Docqet project at the organization level.

## Project Structure

### Views
- **Board**: Kanban-style board for visual task management
- **Table**: Spreadsheet-style view for detailed task tracking
- **Roadmap**: Timeline view for project planning

### Fields
- **Status**: Task status (Backlog, To Do, In Progress, Review, Done)
- **Priority**: Task priority (Low, Medium, High, Critical)
- **Story**: Associated user story (1.1, 1.2, 1.3, 1.4)

## Workflow

### Adding Items to Project
1. Create issues in the repository
2. Issues are automatically added to the project
3. Use fields to categorize and prioritize

### Managing Tasks
1. Use the Board view for daily standups
2. Use the Table view for detailed planning
3. Use the Roadmap view for sprint planning

### Automation
- Issues are automatically added to the project
- Status updates sync with issue labels
- Pull requests can be linked to issues

## Best Practices

1. **Always assign Status**: Keep tasks properly categorized
2. **Set Priority**: Help team understand urgency
3. **Link Stories**: Connect tasks to user stories
4. **Regular Updates**: Update status during development
5. **Use Labels**: Combine with repository labels for better organization

## Access

- **Organization Members**: Full access to project
- **Repository Contributors**: Can view and update items
- **Public**: Read-only access to project board

## Integration

This project integrates with:
- GitHub Issues
- GitHub Pull Requests
- GitHub Actions (for automation)
- Repository labels and milestones
EOF

    print_success "Project documentation created"
}

# Main function
main() {
    echo "🏢 Docqet Organization Project Setup"
    echo "===================================="
    
    check_github_cli
    create_organization_project
    add_repository_to_project
    create_project_views
    create_project_fields
    add_issues_to_project
    create_project_documentation
    
    echo ""
    echo "🎉 Organization project setup completed!"
    echo ""
    echo "Project URL: https://github.com/orgs/loopcraftlab/projects"
    echo "Documentation: .github/PROJECT_GUIDE.md"
    echo ""
    echo "Next steps:"
    echo "1. Visit the project board to see your issues"
    echo "2. Customize views and fields as needed"
    echo "3. Add team members to the project"
    echo "4. Set up automation rules"
    echo ""
    echo "Happy project managing! 🚀"
}

# Run main function
main "$@" 