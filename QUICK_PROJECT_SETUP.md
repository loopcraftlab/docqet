# Quick GitHub Organization Project Setup

## Prerequisites

You need a GitHub token with the following scopes:
- `read:project`
- `write:project`
- `read:org`
- `repo`

## Step 1: Update GitHub Token Scopes

1. Go to [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens)
2. Find your existing token or create a new one
3. Add the required scopes listed above
4. Copy the new token

## Step 2: Authenticate with GitHub CLI

```bash
# Logout and login with new token
gh auth logout
gh auth login --with-token <your-new-token-with-project-scopes>
```

## Step 3: Run the Setup Script

```bash
# Make the script executable (if not already)
chmod +x scripts/setup-org-project.sh

# Run the complete setup
./scripts/setup-org-project.sh
```

## Step 4: Manual Commands (Alternative)

If you prefer to run commands manually:

### 1. Create the project
```bash
gh project create --owner loopcraftlab --title "Docqet – Product Dev"
```

### 2. Get the project number
```bash
gh project list --owner loopcraftlab
```

### 3. Create fields (replace PROJECT_NUMBER with actual number)
```bash
gh project field-create --owner loopcraftlab --project-number PROJECT_NUMBER --name "Status" --data-type SINGLE_SELECT --single-select-options "Todo,In progress,Blocked,In review,Done"

gh project field-create --owner loopcraftlab --project-number PROJECT_NUMBER --name "Priority" --data-type SINGLE_SELECT --single-select-options "P0,P1,P2"

gh project field-create --owner loopcraftlab --project-number PROJECT_NUMBER --name "Area" --data-type SINGLE_SELECT --single-select-options "Backend,Frontend,AI,DevOps,Docs"

gh project field-create --owner loopcraftlab --project-number PROJECT_NUMBER --name "Start date" --data-type DATE

gh project field-create --owner loopcraftlab --project-number PROJECT_NUMBER --name "Target date" --data-type DATE
```

### 4. Add repository
```bash
gh project item-add --owner loopcraftlab --project-number PROJECT_NUMBER --repo loopcraftlab/docqet
```

### 5. Add existing issues
```bash
gh project item-add --owner loopcraftlab --project-number PROJECT_NUMBER --issue-number 1 --repo loopcraftlab/docqet
gh project item-add --owner loopcraftlab --project-number PROJECT_NUMBER --issue-number 2 --repo loopcraftlab/docqet
gh project item-add --owner loopcraftlab --project-number PROJECT_NUMBER --issue-number 3 --repo loopcraftlab/docqet
```

### 6. Create views
```bash
gh project view-create --owner loopcraftlab --project-number PROJECT_NUMBER --name "Board" --layout BOARD
gh project view-create --owner loopcraftlab --project-number PROJECT_NUMBER --name "Table" --layout TABLE
gh project view-create --owner loopcraftlab --project-number PROJECT_NUMBER --name "Roadmap" --layout ROADMAP
```

## What the Setup Creates

### Project Fields
- **Status**: Todo, In progress, Blocked, In review, Done
- **Priority**: P0, P1, P2
- **Area**: Backend, Frontend, AI, DevOps, Docs
- **Start date**: Date field for tracking when work starts
- **Target date**: Date field for tracking deadlines

### Project Views
- **Board**: Kanban-style board for visual task management
- **Table**: Spreadsheet-style view for detailed tracking
- **Roadmap**: Timeline view for project planning

### Integration
- Repository automatically added to project
- All existing issues added to project
- New issues will be automatically added (if automation is enabled)

## Access Your Project

Once setup is complete, your project will be available at:
- **Organization Projects**: https://github.com/orgs/loopcraftlab/projects
- **Specific Project**: https://github.com/orgs/loopcraftlab/projects/[PROJECT_NUMBER]

## Troubleshooting

### "Token missing required scopes"
- Make sure your token has `read:project` and `write:project` scopes
- Re-authenticate with the updated token

### "Permission denied"
- Ensure you have admin access to the loopcraftlab organization
- Check that your token has the correct scopes

### "Project not found"
- Verify the project was created in the correct organization
- Check the project number is correct

## Next Steps

After setup:
1. Visit your project board
2. Customize views and fields as needed
3. Add team members
4. Set up automation rules
5. Start managing your development workflow!

---

**Note**: The script will save the project number to `.github/project-number.txt` for future reference. 