import { render, screen } from '@testing-library/react'
import HomePage from '../app/page'

describe('HomePage', () => {
  it('renders welcome message', () => {
    render(<HomePage />)
    
    expect(screen.getByText(/Welcome to/i)).toBeInTheDocument()
    expect(screen.getByText(/Docqet/i)).toBeInTheDocument()
    expect(screen.getByText(/Secure Document Sharing with AI/i)).toBeInTheDocument()
  })

  it('renders development environment status', () => {
    render(<HomePage />)
    
    expect(screen.getByText(/Development Environment Ready/i)).toBeInTheDocument()
    expect(screen.getByText(/Next.js 14 with TypeScript/i)).toBeInTheDocument()
    expect(screen.getByText(/FastAPI Backend/i)).toBeInTheDocument()
  })

  it('renders feature cards', () => {
    render(<HomePage />)
    
    expect(screen.getByText(/Secure Sharing/i)).toBeInTheDocument()
    expect(screen.getByText(/AI-Powered Insights/i)).toBeInTheDocument()
    expect(screen.getByText(/Lightning Fast/i)).toBeInTheDocument()
  })
}) 