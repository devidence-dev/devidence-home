import { mount } from 'svelte'
import '@fontsource-variable/geist'
import '@fontsource-variable/geist-mono'
import './app.css'
import './assets/styles/stars.css'
import './assets/styles/animations.css'
import App from './App.svelte'

const app = mount(App, {
  target: document.getElementById('app'),
})

export default app
