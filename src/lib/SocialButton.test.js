import { describe, it, expect } from 'vitest'
import { render, screen } from '@testing-library/svelte'
import SocialButton from './SocialButton.svelte'

describe('SocialButton', () => {
  it('renders a link with the given text, url and id', () => {
    render(SocialButton, {
      props: {
        id: 'github',
        url: 'https://github.com/devidence-dev',
        iconSrc: '/svg/github.svg',
        text: 'Github',
      },
    })

    const link = screen.getByRole('link', { name: /github/i })
    expect(link).toHaveAttribute('href', 'https://github.com/devidence-dev')
    expect(link).toHaveAttribute('id', 'github')
    expect(link).toHaveAttribute('target', '_blank')
  })

  it('applies the default and custom class names', () => {
    render(SocialButton, {
      props: {
        id: 'medium',
        url: 'https://medium.com/@devidence',
        iconSrc: '/svg/medium.svg',
        text: 'Medium',
        className: 'button-medium',
      },
    })

    const link = screen.getByRole('link', { name: /medium/i })
    expect(link.className).toContain('button-medium')
  })
})
