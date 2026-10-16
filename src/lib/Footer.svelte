<script>
  import Modal from './Modal.svelte';
  import TermsContent from './TermsContent.svelte';
  import PrivacyContent from './PrivacyContent.svelte';
  
  let termsModalOpen = false;
  let privacyModalOpen = false;
</script>

<footer class="fadein flex flex-col items-center gap-9 px-4 pt-6 pb-4 text-sm text-muted">
  <nav aria-label="Legal" class="flex gap-6">
    <button type="button" class="rounded px-1 py-1 text-muted underline-offset-4 transition-colors hover:text-ink hover:underline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-accent" on:click={() => termsModalOpen = true}>Terms</button>
    <button type="button" class="rounded px-1 py-1 text-muted underline-offset-4 transition-colors hover:text-ink hover:underline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-accent" on:click={() => privacyModalOpen = true}>Privacy</button>
  </nav>
  <p class="m-0 text-xs">© {new Date().getFullYear()} devidence</p>
</footer>

<Modal title="Terms of Service" isOpen={termsModalOpen} on:close={() => termsModalOpen = false}>
  <TermsContent />
</Modal>

<Modal title="Privacy Policy" isOpen={privacyModalOpen} on:close={() => privacyModalOpen = false}>
  <PrivacyContent />
</Modal>
