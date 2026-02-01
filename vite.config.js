import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'

// https://vite.dev/config/
export default defineConfig({
  plugins: [svelte()],
  build: {
    // Optimizaciones de producción
    target: 'es2020',
    minify: 'terser',
    cssMinify: true,
    rollupOptions: {
      output: {
        manualChunks: {
          // Separar vendor chunks para mejor caching
          vendor: ['svelte']
        }
      }
    },
    // Comprimir más agresivamente
    terserOptions: {
      compress: {
        drop_console: true, // Eliminar console.logs en prod
        drop_debugger: true
      }
    }
  }
})
