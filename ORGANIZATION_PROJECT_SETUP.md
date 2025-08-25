# GitHub Organization Project Setup Guide

## Overview

This guide will help you set up a GitHub Organization Project for managing Docqet development and collaboration at the organization level.

## Prerequisites

1. **Organization Admin Access**: You need admin access to the `loopcraftlab` organization
2. **GitHub CLI with Proper Scopes**: Your GitHub token needs `read:project` and `write:project` scopes

## Step 1: Update GitHub Token Scopes

### Option A: Update Existing Token
1. Go to [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens)
2. Find your existing token or create a new one
3. Add the following scopes:
   - `read:project`
   - `write:project`
   - `read:org`
   - `repo`
   - `workflow`

### Option B: Create New Token
```bash
# Login with new token
gh auth logout
gh auth login --with-token < your-new-token-with-project-scopes >
```

## Step 2: Create Organization Project

### Using GitHub Web Interface (Recommended)

1. **Navigate to Organization Projects**:
   - Go to https://github.com/orgs/loopcraftlab/projects
   - Click "New project"

2. **Create Project**:
   - **Name**: `Docqet Development`
   - **Description**: `Project board for managing Docqet development and collaboration`
   - **Template**: Choose "Board" or "Table" (you can add more views later)
   - **Visibility**: Choose based on your needs (Public/Private)

3. **Configure Project**:
   - Click "Create project"
   - You'll be redirected to the project board

### Using GitHub CLI (Alternative)

If you have the proper scopes, you can run:
```bash
./scripts/setup-organization-project.sh
```

## Step 3: Configure Project Views

### Board View (Kanban)
1. In your project, click "Add view" → "Board"
2. Name it "Board"
3. Configure columns:
   - Backlog
   - To Do
   - In Progress
   - Review
   - Done

### Table View (Spreadsheet)
1. Click "Add view" → "Table"
2. Name it "Table"
3. Add columns for:
   - Title
   - Status
   - Priority
   - Story
   - Assignees
   - Due Date

### Roadmap View (Timeline)
1. Click "Add view" → "Roadmap"
2. Name it "Roadmap"
3. Configure for timeline-based planning

## Step 4: Create Custom Fields

### Status Field
1. Click "Add field" → "Single select"
2. Name: `Status`
3. Options:
   - Backlog (Gray)
   - To Do (Blue)
   - In Progress (Yellow)
   - Review (Orange)
   - Done (Green)

### Priority Field
1. Click "Add field" → "Single select"
2. Name: `Priority`
3. Options:
   - Low (Green)
   - Medium (Yellow)
   - High (Red)
   - Critical (Purple)

### Story Field
1. Click "Add field" → "Single select"
2. Name: `Story`
3. Options:
   - 1.1 - Project Setup (Blue)
   - 1.2 - Authentication (Green)
   - 1.3 - Document Upload (Yellow)
   - 1.4 - AI Integration (Purple)

## Step 5: Add Repository to Project

1. In your project, click "Add item"
2. Search for "loopcraftlab/docqet"
3. Select the repository
4. This will add all issues and pull requests from the repository

## Step 6: Configure Automation

### Auto-add Issues
1. Go to project settings
2. Under "Workflows", enable "Auto-add issues"
3. This will automatically add new issues to the project

### Status Sync
1. Enable "Status sync with labels"
2. This will sync project status with issue labels

## Step 7: Add Team Members

1. Go to project settings
2. Under "Access", add team members
3. Set appropriate permissions:
   - **Admin**: Full access
   - **Write**: Can edit items
   - **Read**: Can view only

## Step 8: Link Existing Issues

### Manual Addition
1. In your project, click "Add item"
2. Search for existing issues
3. Add them to the project

### Bulk Addition
You can use the GitHub CLI to add all existing issues:
```bash
# Get all issues
gh api repos/loopcraftlab/docqet/issues --jq '.[].id' > issues.txt

# Add each issue to project (requires proper scopes)
while read issue_id; do
  echo "Adding issue $issue_id to project..."
  # Add to project using GraphQL API
done < issues.txt
```

## Step 9: Set Up Workflows

### Daily Standup Workflow
1. Use the Board view for daily standups
2. Move items between columns as they progress
3. Update status and priority as needed

### Sprint Planning Workflow
1. Use the Table view for detailed planning
2. Assign stories and priorities
3. Set due dates and assignees

### Release Planning Workflow
1. Use the Roadmap view for release planning
2. Organize items by sprints or releases
3. Track progress over time

## Project URL Structure

Once set up, your project will be available at:
- **Organization Projects**: https://github.com/orgs/loopcraftlab/projects
- **Specific Project**: https://github.com/orgs/loopcraftlab/projects/[project-number]

## Integration with Repository

The project will integrate with:
- **Issues**: Automatically added to project
- **Pull Requests**: Can be linked to issues
- **Labels**: Sync with project fields
- **Milestones**: Can be used for grouping

## Best Practices

1. **Regular Updates**: Update project status during development
2. **Consistent Naming**: Use consistent naming for fields and views
3. **Team Training**: Train team members on project usage
4. **Automation**: Set up automation rules for efficiency
5. **Documentation**: Keep project documentation updated

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure you have admin access to the organization
2. **Token Scopes**: Make sure your token has `read:project` and `write:project` scopes
3. **Project Not Found**: Check if the project was created in the correct organization
4. **Items Not Syncing**: Verify automation rules are properly configured

### Getting Help

1. Check [GitHub Projects documentation](https://docs.github.com/en/issues/planning-and-tracking-with-projects)
2. Review organization settings and permissions
3. Contact GitHub support if needed

## Next Steps

After setting up the project:

1. **Add Team Members**: Invite team members to the project
2. **Configure Automation**: Set up automation rules
3. **Create Templates**: Create issue and PR templates
4. **Set Up Notifications**: Configure project notifications
5. **Train Team**: Conduct team training on project usage

---

**Note**: This setup requires organization admin access. If you don't have admin access, contact your organization administrator to set up the project. 