# Contributing to Docqet

Thank you for your interest in contributing to Docqet! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### 1. Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/docqet.git
   cd docqet
   ```

### 2. Set Up Development Environment

```bash
# Install dependencies and start development environment
make dev
```

### 3. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
# or for bug fixes
git checkout -b fix/your-bug-description
```

### 4. Make Your Changes

- Write clean, well-documented code
- Add tests for new functionality
- Update documentation as needed
- Follow the coding standards below

### 5. Test Your Changes

```bash
# Run all tests
make test

# Run specific test suites
make test-backend
make test-frontend
make test-integration
```

### 6. Commit Your Changes

Use conventional commit messages:

```bash
git commit -m "feat: add user authentication system"
git commit -m "fix: resolve database connection timeout"
git commit -m "docs: update API documentation"
```

### 7. Push and Create Pull Request

```bash
git push origin feature/your-feature-name
```

Then create a pull request on GitHub with a clear description of your changes.

## 📋 Development Guidelines

### Code Style

#### Python (Backend)
- Follow [PEP 8](https://www.python.org/dev/peps/pep-0008/) style guide
- Use type hints for all function parameters and return values
- Maximum line length: 88 characters (Black formatter)
- Use docstrings for all public functions and classes

```python
from typing import List, Optional

def process_document(
    document_id: int, 
    user_id: Optional[int] = None
) -> List[dict]:
    """
    Process a document and return analysis results.
    
    Args:
        document_id: The ID of the document to process
        user_id: Optional user ID for access control
        
    Returns:
        List of analysis results
    """
    pass
```

#### TypeScript (Frontend)
- Use strict TypeScript configuration
- Follow ESLint and Prettier configurations
- Use functional components with hooks
- Implement proper error handling

```typescript
interface User {
  id: number;
  email: string;
  name: string;
}

const UserProfile: React.FC<{ user: User }> = ({ user }) => {
  const [isLoading, setIsLoading] = useState(false);
  
  // Component implementation
};
```

### Testing

#### Backend Tests
- Use pytest for testing
- Aim for 90%+ code coverage
- Test both unit and integration scenarios
- Mock external dependencies

```python
import pytest
from unittest.mock import Mock

def test_user_creation():
    user_data = {"email": "test@example.com", "name": "Test User"}
    user = create_user(user_data)
    assert user.email == user_data["email"]
```

#### Frontend Tests
- Use Jest and React Testing Library
- Test component behavior, not implementation
- Mock API calls and external services

```typescript
import { render, screen } from '@testing-library/react';
import { UserProfile } from './UserProfile';

test('displays user information', () => {
  const user = { id: 1, name: 'John Doe', email: 'john@example.com' };
  render(<UserProfile user={user} />);
  expect(screen.getByText('John Doe')).toBeInTheDocument();
});
```

### Database Changes

When making database changes:

1. Create a new migration:
   ```bash
   cd backend
   alembic revision --autogenerate -m "Description of changes"
   ```

2. Test the migration:
   ```bash
   alembic upgrade head
   ```

3. Include the migration file in your pull request

### API Changes

When modifying APIs:

1. Update API documentation in the endpoint functions
2. Add or update tests for the endpoints
3. Consider backward compatibility
4. Update the OpenAPI schema if needed

## 🏗️ Project Structure

### Backend Structure
```
backend/
├── app/
│   ├── api/              # API endpoints
│   │   └── v1/          # API version 1
│   ├── core/            # Core configuration
│   ├── models/          # Database models
│   ├── schemas/         # Pydantic schemas
│   └── services/        # Business logic
├── alembic/             # Database migrations
└── tests/               # Test files
```

### Frontend Structure
```
frontend/
├── app/                 # Next.js app directory
├── components/          # Reusable components
├── hooks/              # Custom React hooks
├── lib/                # Utility functions
└── __tests__/          # Test files
```

## 🔍 Code Review Process

### Pull Request Guidelines

1. **Title**: Clear, descriptive title
2. **Description**: Detailed description of changes
3. **Tests**: Include tests for new functionality
4. **Documentation**: Update docs if needed
5. **Screenshots**: For UI changes

### Review Checklist

- [ ] Code follows style guidelines
- [ ] Tests pass and coverage is adequate
- [ ] Documentation is updated
- [ ] No security vulnerabilities
- [ ] Performance impact is considered
- [ ] Backward compatibility is maintained

## 🐛 Bug Reports

When reporting bugs, please include:

1. **Environment**: OS, Python/Node.js versions
2. **Steps to reproduce**: Clear, step-by-step instructions
3. **Expected behavior**: What should happen
4. **Actual behavior**: What actually happens
5. **Screenshots**: If applicable
6. **Logs**: Error messages and stack traces

## 💡 Feature Requests

When requesting features:

1. **Problem**: Describe the problem you're solving
2. **Solution**: Propose a solution
3. **Alternatives**: Consider other approaches
4. **Use cases**: Provide real-world examples

## 📚 Documentation

### Writing Documentation

- Use clear, concise language
- Include code examples
- Keep documentation up to date
- Use proper markdown formatting

### Documentation Structure

```
docs/
├── getting-started.md
├── api-reference.md
├── deployment.md
├── development.md
└── contributing.md
```

## 🚀 Release Process

### Versioning

We use [Semantic Versioning](https://semver.org/):

- **Major**: Breaking changes
- **Minor**: New features, backward compatible
- **Patch**: Bug fixes, backward compatible

### Release Checklist

- [ ] All tests pass
- [ ] Documentation is updated
- [ ] Changelog is updated
- [ ] Version is bumped
- [ ] Release notes are written

## 🛡️ Security

### Security Guidelines

- Never commit sensitive information (API keys, passwords)
- Use environment variables for configuration
- Validate all user inputs
- Implement proper authentication and authorization
- Follow OWASP security guidelines

### Reporting Security Issues

For security issues, please email security@loopcraftlab.com instead of creating a public issue.

## 🎯 Getting Help

### Communication Channels

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and general discussion
- **Documentation**: Check the docs/ directory

### Mentorship

New contributors can:
- Look for issues labeled "good first issue"
- Ask questions in GitHub Discussions
- Request help from maintainers

## 📄 License

By contributing to Docqet, you agree that your contributions will be licensed under the MIT License.

## 🙏 Recognition

Contributors will be recognized in:
- GitHub contributors list
- Release notes
- Project documentation

Thank you for contributing to Docqet! 🚀 