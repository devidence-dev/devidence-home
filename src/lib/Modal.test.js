import { describe, it, expect, vi } from 'vitest'
import { render, screen, fireEvent } from '@testing-library/svelte'
import Modal from './Modal.svelte'

describe('Modal', () => {
  it('renders the dialog with the given title when open', () => {
    render(Modal, { props: { isOpen: true, title: 'Terms' } })

    expect(screen.getByRole('dialog', { name: 'Terms' })).toBeInTheDocument()
  })

  it('dispatches close when Escape is pressed', () => {
    const onClose = vi.fn()
    render(Modal, { props: { isOpen: true, title: 'Terms' }, events: { close: onClose } })

    fireEvent.keyDown(document, { key: 'Escape' })

    expect(onClose).toHaveBeenCalledTimes(1)
  })

  it('dispatches close when the close button is clicked', async () => {
    const onClose = vi.fn()
    render(Modal, { props: { isOpen: true, title: 'Terms' }, events: { close: onClose } })

    await fireEvent.click(screen.getByRole('button', { name: 'Close' }))

    expect(onClose).toHaveBeenCalledTimes(1)
  })
})
