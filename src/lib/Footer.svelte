<script>
  import Modal from './Modal.svelte';
  import TermsContent from './TermsContent.svelte';
  import PrivacyContent from './PrivacyContent.svelte';
  
  let termsModalOpen = false;
  let privacyModalOpen = false;
</script>

<div class="footer fadein">
  <a class="footer-hover spacing" href="/">Home</a>
  <a class="footer-hover spacing" href="#" on:click|preventDefault={() => termsModalOpen = true}>Terms</a>
  <a class="footer-hover spacing" href="#" on:click|preventDefault={() => privacyModalOpen = true}>Privacy</a>
</div>

<Modal title="Terms of Service" isOpen={termsModalOpen} on:close={() => termsModalOpen = false}>
  <TermsContent />
</Modal>

<Modal title="Privacy Policy" isOpen={privacyModalOpen} on:close={() => privacyModalOpen = false}>
  <PrivacyContent />
</Modal>

<style>
  .footer {
    margin: 2rem 0px 2rem 0px;
    text-align: center;
    display: flex;
    justify-content: center;
    gap: 1.5rem;
  }
  
  .footer-hover {
    transition: all 0.2s ease-in-out;
    color: #4a89dc; /* Azul más claro como se ve en la imagen */
    text-decoration: none;
  }
  
  .footer-hover:hover {
    opacity: 0.8;
    text-decoration: underline;
  }
  
  .spacing {
    font-size: 0.9rem;
  }
</style>
