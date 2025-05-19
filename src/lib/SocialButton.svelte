<script>
  export let id;
  export let url;
  export let iconSrc;
  export let text;
  export let className = "button-medium"; // Clase predeterminada
  export let delay = 1; // Retraso predeterminado
</script>

<div style="--delay: {delay}s" class="button-entrance">
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
