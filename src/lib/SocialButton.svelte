<script>
  export let id;
  export let url;
  export let iconSrc;
  export let text;
  export let className = "button-medium"; // Default class
  export let delay = 1; // Default delay
</script>

<div style="--delay: {delay}s" class="button-entrance mx-auto my-2 w-full max-w-sm">
  <a
    {id}
    class="button {className} button-click button-hover glass flex items-center justify-center gap-3 rounded-full px-6 py-3 font-medium text-ink shadow-sm transition-colors hover:bg-accent/15 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-accent active:bg-accent/25"
    rel="noopener noreferrer nofollow noindex"
    href={url}
    target="_blank"
  >
    <img alt="" aria-hidden="true" class="icon size-5" src={iconSrc}>{text}
  </a>
</div>
