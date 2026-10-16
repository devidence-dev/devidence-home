<script>
  import { onMount, createEventDispatcher } from 'svelte';

  export let title = '';
  export let isOpen = false;
  
  const dispatch = createEventDispatcher();
  
  function closeModal() {
    dispatch('close');
  }
  
  function handleKeydown(event) {
    if (event.key === 'Escape') {
      closeModal();
    }
  }

  onMount(() => {
    document.addEventListener('keydown', handleKeydown);
    return () => {
      document.removeEventListener('keydown', handleKeydown);
    };
  });
</script>

{#if isOpen}
  <div class="fixed inset-0 z-[999] bg-black/50" on:click={closeModal} role="presentation"></div>
  <div class="fixed top-1/2 left-1/2 z-[1000] w-[95%] max-w-lg -translate-x-1/2 -translate-y-1/2" role="dialog" aria-modal="true" aria-label={title}>
    <div class="glass overflow-hidden rounded-3xl text-ink shadow-xl">
      <div class="flex items-center justify-between border-b border-line px-4 py-3 sm:px-6 sm:py-4">
        <h2 class="m-0 text-xl font-semibold">{title}</h2>
        <button type="button" class="cursor-pointer rounded-full px-2 text-2xl leading-none text-muted hover:text-ink focus-visible:outline-2 focus-visible:outline-accent" aria-label="Close" on:click={closeModal}>&times;</button>
      </div>
      <div class="prose-legal max-h-[70vh] overflow-y-auto p-4 sm:p-6">
        <slot></slot>
      </div>
    </div>
  </div>
{/if}

