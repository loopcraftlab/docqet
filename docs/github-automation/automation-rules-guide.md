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
