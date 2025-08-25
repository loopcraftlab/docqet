#!/bin/bash

# Setup GitHub Labels for Docqet Project
# This script creates labels for the GitHub repository

echo "Setting up GitHub labels for Docqet project..."

# Read labels from JSON file and create them
while IFS= read -r line; do
    if [[ $line =~ \"name\":[[:space:]]*\"([^\"]+)\" ]]; then
        name="${BASH_REMATCH[1]}"
        echo "Creating label: $name"
        
        # Extract color and description from the same object
        color=$(grep -A 10 "\"name\": \"$name\"" .github/labels.json | grep "\"color\":" | sed 's/.*"color": "\([^"]*\)".*/\1/')
        description=$(grep -A 10 "\"name\": \"$name\"" .github/labels.json | grep "\"description\":" | sed 's/.*"description": "\([^"]*\)".*/\1/')
        
        # Create the label
        gh api repos/loopcraftlab/docqet/labels \
            --method POST \
            --field name="$name" \
            --field color="$color" \
            --field description="$description" \
            --silent
    fi
done < <(grep "\"name\":" .github/labels.json)

echo "GitHub labels setup complete!" 