# Docqet Project Management Quick Reference

## 🚀 Quick Start

### Project URLs
- **GitHub Project**: https://github.com/orgs/loopcraftlab/projects/3
- **Repository**: https://github.com/loopcraftlab/docqet
- **Issues**: https://github.com/loopcraftlab/docqet/issues

### Development Commands
```bash
make dev              # Start all services
make test             # Run all tests
make ci               # Run all CI checks
make health           # Check service health
```

## 📊 Daily Workflow

### Morning Standup
1. **Check Project Board**: Review current sprint progress
2. **Update Status**: Move your issues to correct columns
3. **Report Progress**: What you did yesterday, today's plan, any blockers
4. **Team Sync**: Coordinate with team members

### During Development
1. **Pick Up Issue**: Move issue from "Todo" to "In Progress"
2. **Create Branch**: `git checkout -b feature/story-1.2-user-authentication`
3. **Develop**: Implement with tests and documentation
4. **Create PR**: Link to issue with `Closes #issue-number`
5. **Update Issue**: Add progress comments and move to "Review"

### End of Day
1. **Commit Changes**: Use conventional commit messages
2. **Update Issues**: Add progress comments
3. **Plan Tomorrow**: Review next day's tasks
4. **Team Updates**: Share any blockers or achievements

## 🏷️ Issue Management

### Issue States
- **Todo**: Ready for development
- **In Progress**: Currently being worked on
- **Review**: Ready for code review
- **Testing**: Being tested by QA
- **Done**: Completed and deployed

### Issue Labels
- **Epic**: `epic-1` through `epic-7`
- **Priority**: `priority-p0`, `priority-p1`, `priority-p2`
- **Area**: `backend`, `frontend`, `ai`, `devops`
- **Type**: `story`, `bug`, `enhancement`, `documentation`

### Issue Fields
- **Status**: Current state (Todo, In Progress, etc.)
- **Priority**: P0 (Critical), P1 (High), P2 (Medium)
- **Area**: Backend, Frontend, AI, DevOps
- **Start Date**: When work began
- **Target Date**: When work should be completed

## 🔄 Pull Request Workflow

### PR Creation
```bash
# Create feature branch
git checkout -b feature/story-1.2-user-authentication

# Make changes and commit
git add .
git commit -m "feat(auth): add JWT token authentication"

# Push and create PR
git push origin feature/story-1.2-user-authentication
```

### PR Description Template
```markdown
## Description
Implements user authentication with JWT tokens.

## Changes
- Added JWT token authentication
- Implemented user registration and login
- Added password reset functionality
- Added role-based access control

## Testing
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Related Issues
Closes #11
```

### PR Review Checklist
- [ ] Code follows project standards
- [ ] Tests are included and pass
- [ ] Documentation is updated
- [ ] No security vulnerabilities
- [ ] Performance impact considered

## 📅 Sprint Management

### Sprint Planning (Every 2 weeks)
1. **Review Backlog**: Prioritize stories
2. **Estimate Stories**: Use story points (1, 2, 3, 5, 8, 13)
3. **Assign Stories**: Based on team capacity
4. **Set Goals**: Define sprint objectives

### Sprint Review (End of sprint)
1. **Demo Features**: Show completed work
2. **Review Metrics**: Velocity, quality, team health
3. **Gather Feedback**: From stakeholders
4. **Plan Next Sprint**: Based on learnings

### Sprint Retrospective
1. **What Went Well**: Celebrate successes
2. **What Could Improve**: Identify areas for improvement
3. **Action Items**: Create improvement tasks
4. **Team Health**: Check team satisfaction

## 🎯 Epic Progress Tracking

### Epic 1: Foundation (P0) - In Progress
- ✅ Story 1.1: Project Setup
- 🔄 Story 1.2: User Authentication
- 📋 Story 1.3: Document Upload
- 📋 Story 1.4: AI Integration

### Epic 2: Document Management (P1) - Planned
- 📋 Story 2.1: Advanced Sharing
- 📋 Story 2.2: Organization
- 📋 Story 2.3: Analytics
- 📋 Story 2.4: Data Rooms

### Epic 3: AI Analysis (P1) - Planned
- 📋 Story 3.1: Content Analysis
- 📋 Story 3.2: Visual Optimization
- 📋 Story 3.3: SEO Recommendations

## 📈 Metrics to Track

### Sprint Metrics
- **Velocity**: Story points completed per sprint
- **Burndown**: Progress throughout sprint
- **Quality**: Bugs and technical debt
- **Team Health**: Satisfaction and collaboration

### Project Metrics
- **Epic Progress**: Completion percentage
- **Release Timeline**: On track for MVP
- **Code Quality**: Test coverage, linting
- **Team Performance**: Productivity and satisfaction

## 🚨 Common Issues & Solutions

### Issue: Issue stuck in "Review"
**Solution**: Follow up with reviewers, provide additional context

### Issue: Tests failing in CI
**Solution**: Run tests locally first, fix issues before pushing

### Issue: Merge conflicts
**Solution**: Rebase on develop branch, resolve conflicts carefully

### Issue: Scope creep
**Solution**: Stick to acceptance criteria, create separate issues for new features

## 📞 Team Communication

### Daily Standup Format
```
Yesterday: [What you accomplished]
Today: [What you'll work on]
Blockers: [Any issues preventing progress]
```

### Issue Updates
- **Progress**: Regular status updates
- **Blockers**: Clear communication of issues
- **Questions**: Ask early, don't get stuck
- **Achievements**: Celebrate wins

### Team Channels
- **GitHub Issues**: Technical discussions
- **GitHub Discussions**: General project chat
- **Pull Requests**: Code review feedback
- **Project Board**: Visual progress tracking

## 🔧 Useful Commands

### Development
```bash
make dev              # Start development environment
make test             # Run all tests
make ci               # Run CI checks
make health           # Check service health
make logs             # View service logs
make stop             # Stop all services
```

### Git Workflow
```bash
git status            # Check current status
git pull origin develop # Update with latest changes
git checkout -b feature/story-name # Create feature branch
git add .             # Stage changes
git commit -m "type(scope): description" # Commit changes
git push origin feature/story-name # Push to remote
```

### GitHub CLI
```bash
gh issue list         # List all issues
gh issue view 11      # View specific issue
gh issue edit 11 --add-label "in-progress" # Add label
gh pr create          # Create pull request
gh pr list            # List pull requests
```

## 📚 Quick Links

- **Full PM Guide**: [PROJECT_MANAGEMENT_GUIDE.md](./PROJECT_MANAGEMENT_GUIDE.md)
- **Contributing Guide**: [CONTRIBUTING.md](./CONTRIBUTING.md)
- **Development Guide**: [docs/development.md](./docs/development.md)
- **Epic Documentation**: [docs/epics/](./docs/epics/)

---

**Remember**: Keep issues updated, communicate regularly, and focus on delivering value! 