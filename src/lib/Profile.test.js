import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/svelte'
import Profile from './Profile.svelte'

describe('Profile', () => {
  it('shows the logo with the name as its accessible name', () => {
    render(Profile, { props: { name: 'devidence', description: 'desc', verified: true } })

    const logo = screen.getByRole('img', { name: 'devidence' })
    expect(logo).toHaveAttribute('src', '/images/devidence-logo-light.svg')
  })

  it('renders the moon avatar with the logo inside', () => {
    const { container } = render(Profile, { props: { name: 'devidence', description: 'desc', verified: true } })

    const moon = container.querySelector('.moon')
    expect(moon).toBeInTheDocument()
    expect(moon).toHaveClass('size-62')
    expect(moon.querySelector('img[src="/images/devidence-logo-light.svg"]')).toBeInTheDocument()
  })

  it('keeps name, badge and description', () => {
    render(Profile, { props: { name: 'devidence', description: 'my description', verified: true } })

    expect(screen.getByRole('heading', { name: /devidence/ })).toBeInTheDocument()
    expect(screen.getByTitle('Verified user')).toBeInTheDocument()
    expect(screen.getByText('my description')).toBeInTheDocument()
  })
})
