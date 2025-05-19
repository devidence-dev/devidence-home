<script>
  export let id;
  export let url;
  export let iconSrc;
  export let text;
  export let className = "button-medium"; // Clase predeterminada
  export let delay = 1; // Retraso predeterminado
</script>

<div style="--delay: {delay}s" class="button-entrance button-wrapper">
  <a 
    {id} 
    class="button {className} button-click button-hover icon-hover" 
    rel="noopener noreferrer nofollow noindex" 
    href={url} 
    target="_blank"
  >
    <img alt={text.toLowerCase()} class="icon hvr-icon" src={iconSrc}>{text}
  </a>
</div>

<style>
  .button-wrapper {
    margin: 0.5rem auto;
    max-width: 400px;
  }
  
  /* Make buttons look more like the image */
  :global(.button) {
    border-radius: 2rem !important;
    padding: 0.8rem 1rem !important;
  }
</style>
