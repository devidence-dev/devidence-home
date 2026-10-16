<script>
  import { onMount } from 'svelte';
  import { setupButtonTracking } from './lib/animations.js';
  import Footer from './lib/Footer.svelte';
  import SocialButton from './lib/SocialButton.svelte';
  import Background from './lib/Background.svelte';
  import Profile from './lib/Profile.svelte';

  const githubSvg = './svg/github.svg';
  const mediumSvg = './svg/medium.svg';

  onMount(() => {
    setupButtonTracking();
  });
</script>

<Background />

<div class="flex min-h-dvh flex-col">
<main class="mx-auto flex w-full max-w-md flex-1 flex-col justify-center px-4 py-6">
  <Profile
    name="devidence"
    description="🐢 Espol - 🐧 Linux - 📱 Geek - 🛡️ DevSecOps"
    verified={true}
  />

  <SocialButton id="1" url="https://medium.com/@devidence" iconSrc={mediumSvg} text="Medium" className="button-medium" delay={1} />
  <SocialButton id="2" url="https://github.com/devidence-dev" iconSrc={githubSvg} text="Github" className="button-github" delay={2} />

</main>

<Footer />
</div>
