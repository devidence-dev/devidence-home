<script>
  import { onMount } from 'svelte';
  import { initializeBackground, setupButtonTracking } from './lib/animations.js';
  import Footer from './lib/Footer.svelte';
  import SocialButton from './lib/SocialButton.svelte';
  import Background from './lib/Background.svelte';
  import Profile from './lib/Profile.svelte';

  // Las rutas correctas para los recursos
  const devidenceLogo = './images/devidence-logo.png';
  const githubSvg = './svg/github.svg';
  const mediumSvg = './svg/medium.svg';

  onMount(() => {
    // Inicializar el fondo de estrellas y el seguimiento de botones
    initializeBackground();
    setupButtonTracking();
  });
</script>

<main>
  <!-- Fondo con animación de estrellas -->
  <Background />

  <div class="container">
    <div class="row">
      <div class="column" style="margin-top: 5%">
        <!-- Perfil con avatar y descripción -->
        <Profile 
          avatarSrc={devidenceLogo} 
          name="devidence" 
          description="🐢 Espol - 🐧 Linux - ♥ Dogs - 📱 Geek - 🛡️ DevSecOps" 
          verified={true} 
        />
        
        <!-- Botones sociales -->
        <SocialButton id="1" url="https://medium.com/@devidence" iconSrc={mediumSvg} text="Medium" className="button-medium" delay={1} />
        <SocialButton id="2" url="https://github.com/devidence-dev" iconSrc={githubSvg} text="Github" className="button-github" delay={2} />
        
        <div class="container">
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
</style>
