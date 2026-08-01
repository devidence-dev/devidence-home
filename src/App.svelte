<script>
  import { onMount } from 'svelte';
  import { setupButtonTracking } from './lib/animations.js';
  import Footer from './lib/Footer.svelte';
  import SocialButton from './lib/SocialButton.svelte';
  import Background from './lib/Background.svelte';
  import Profile from './lib/Profile.svelte';

  let devidenceLogo = './images/devidence-logo.webp';
  let fallbackLogo = './images/devidence-logo.png';
  let currentLogo = devidenceLogo;

  function handleLogoError() {
    if (currentLogo !== fallbackLogo) {
      currentLogo = fallbackLogo;
    }
  }

  // Las rutas correctas para los recursos
  const githubSvg = './svg/github.svg';
  const mediumSvg = './svg/medium.svg';

  onMount(() => {
    setupButtonTracking();
  });
</script>

<main>
  <!-- Fondo con animación de estrellas -->
  <Background />

  <div class="container">
    <div class="row">
      <div class="column" style="margin-top: 5vh">
        <!-- Perfil con avatar y descripción -->
        <Profile 
          avatarSrc={currentLogo} 
          name="devidence" 
          description="🐢 Espol - 🐧 Linux - 📱 Geek - 🛡️ DevSecOps" 
          verified={true} 
          on:avatarError={handleLogoError}
        />
        
        <!-- Botones sociales -->
        <SocialButton id="1" url="https://medium.com/@devidence" iconSrc={mediumSvg} text="Medium" className="button-medium" delay={1} />
        <SocialButton id="2" url="https://github.com/devidence-dev" iconSrc={githubSvg} text="Github" className="button-github" delay={2} />
        
        <div class="container footer-container">
          <Footer />
        </div>
      </div>
    </div>
  </div>
</main>

<style>
  /* Incluimos estilos locales específicos del componente aquí si los necesitamos */
  :global(.badge) {
    height: 0.6em;
    margin: 5px;
    display: inline-block;
    vertical-align: middle;
  }
  
  :global(span.copy-icon) {
    cursor: pointer;
  }
  
  /* Ajustes para mejorar el centrado vertical */
  :global(body), :global(html) {
    height: 100%;
  }
  
  main {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  
  .footer-container {
    margin-top: auto;
    padding-top: 2rem;
  }
</style>
