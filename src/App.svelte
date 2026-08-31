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

  // Correct asset paths
  const githubSvg = './svg/github.svg';
  const mediumSvg = './svg/medium.svg';

  onMount(() => {
    setupButtonTracking();
  });
</script>

<main>
  <!-- Star-animated background -->
  <Background />

  <div class="container">
    <div class="row">
      <div class="column" style="margin-top: 5vh">
        <!-- Profile with avatar and description -->
        <Profile 
          avatarSrc={currentLogo} 
          name="devidence" 
          description="🐢 Espol - 🐧 Linux - 📱 Geek - 🛡️ DevSecOps" 
          verified={true} 
          on:avatarError={handleLogoError}
        />
        
        <!-- Social buttons -->
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
  /* Add component-specific local styles here if needed */
  :global(.badge) {
    height: 0.6em;
    margin: 5px;
    display: inline-block;
    vertical-align: middle;
  }
  
  :global(span.copy-icon) {
    cursor: pointer;
  }
  
  /* Adjustments to improve vertical centering */
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
