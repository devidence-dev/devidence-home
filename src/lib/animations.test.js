import { describe, it, expect, beforeAll, beforeEach } from 'vitest'
import { setupButtonTracking } from './animations.js'

function createButton(id) {
  const btn = document.createElement('a')
  btn.id = id
  btn.classList.add('button-click')
  document.body.appendChild(btn)
  return btn
}

describe('setupButtonTracking', () => {
  beforeAll(() => {
    setupButtonTracking()
  })

  beforeEach(() => {
    sessionStorage.clear()
    document.body.innerHTML = ''
  })

  it('marks a button as clicked on left mousedown', () => {
    const btn = createButton('social-1')
    btn.dispatchEvent(new MouseEvent('mousedown', { button: 0, bubbles: true }))
    expect(sessionStorage.getItem('clicked-social-1')).toBe('true')
  })

  it('marks a button as clicked on middle mousedown', () => {
    const btn = createButton('social-2')
    btn.dispatchEvent(new MouseEvent('mousedown', { button: 1, bubbles: true }))
    expect(sessionStorage.getItem('clicked-social-2')).toBe('true')
  })

  it('ignores right-click mousedown', () => {
    const btn = createButton('social-3')
    btn.dispatchEvent(new MouseEvent('mousedown', { button: 2, bubbles: true }))
    expect(sessionStorage.getItem('clicked-social-3')).toBeNull()
  })

  it('ignores elements without the button-click class', () => {
    const btn = document.createElement('a')
    btn.id = 'not-tracked'
    document.body.appendChild(btn)
    btn.dispatchEvent(new MouseEvent('mousedown', { button: 0, bubbles: true }))
    expect(sessionStorage.getItem('clicked-not-tracked')).toBeNull()
  })

  it('marks a button as clicked on touchstart', () => {
    const btn = createButton('social-4')
    btn.dispatchEvent(new Event('touchstart', { bubbles: true }))
    expect(sessionStorage.getItem('clicked-social-4')).toBe('true')
  })
})
