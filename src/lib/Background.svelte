<script>
  // This simple component does not need props
</script>

<div class="background-container">
  <section class="parallax-background">
    <div id="object1" class="object1"></div>
    <div id="object2" class="object2"></div>
    <div id="object3" class="object3"></div>
    <div id="object4" class="object4"></div>
    <div id="object5" class="object5"></div>
    <div id="object6" class="object6"></div>
    <div id="object7" class="object7"></div>
    <div id="object8" class="object8"></div>
    <div id="object9" class="object9"></div>
    <div id="object10" class="object10"></div>
    <div id="object11" class="object11"></div>
    <div id="object12" class="object12"></div>
  </section>

  <div class="shooting-stars" aria-hidden="true">
    <span class="shooting-star star-a"></span>
    <span class="shooting-star star-b"></span>
    <span class="shooting-star star-c"></span>
    <span class="shooting-star star-d"></span>
  </div>
</div>

<style>
  .shooting-stars {
    position: absolute;
    inset: 0;
    overflow: hidden;
    pointer-events: none;
  }

  .shooting-star {
    --angle: 320deg;
    position: absolute;
    top: 0;
    left: 0;
    width: 160px;
    height: 2px;
    border-radius: 999px;
    background: linear-gradient(-45deg, rgba(255, 255, 255, 0), #fff, rgba(255, 255, 255, 0));
    filter: drop-shadow(0 0 6px #fff);
    opacity: 0;
    transform: rotate(var(--angle));
    animation-name: shoot;
    animation-timing-function: ease-in;
    animation-iteration-count: infinite;
  }

  .star-a { --angle: 320deg; top: 8%;  left: 15%; animation-duration: 9s;  animation-delay: 1s; }
  .star-b { --angle: 300deg; top: 15%; left: 70%; animation-duration: 14s; animation-delay: 5s; }
  .star-c { --angle: 335deg; top: 40%; left: 85%; animation-duration: 17s; animation-delay: 9s; }
  .star-d { --angle: 310deg; top: 4%;  left: 45%; animation-duration: 12s; animation-delay: 13s; }

  @keyframes shoot {
    0%   { opacity: 0; }
    1%   { opacity: 1; }
    4%   { transform: translateX(-420px) rotate(var(--angle)); opacity: 0; }
    100% { transform: translateX(-420px) rotate(var(--angle)); opacity: 0; }
  }

  @media (prefers-reduced-motion: reduce) {
    .shooting-star {
      animation: none;
      opacity: 0;
    }
  }
</style>
