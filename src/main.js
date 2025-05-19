import { mount } from 'svelte'
import './app.css'
import './assets/styles/skeleton-auto.css'
import './assets/styles/animations.css'
import './assets/styles/brands.css'
import App from './App.svelte'

const app = mount(App, {
  target: document.getElementById('app'),
})

export default app
