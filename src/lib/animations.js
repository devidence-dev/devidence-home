// Registra los clics en los botones para fines de seguimiento.
// El fondo de estrellas se dibuja con box-shadow estático en
// skeleton-auto.css (#object1/#object2/#object3) - no requiere JS.
export function setupButtonTracking() {
  console.log("Setting up button tracking...");
  
  function handleClickOrTouch(event) {
    if (event.target.classList.contains('button-click')) {
      var id = event.target.id;
      if (!sessionStorage.getItem('clicked-' + id)) {
        // Como es una migración, omitimos la llamada fetch al endpoint original
        // y solo guardamos en sessionStorage
        sessionStorage.setItem('clicked-' + id, 'true');
      }
    }
  }

  document.addEventListener('mousedown', function (event) {
    if (event.button === 0 || event.button === 1) {
      handleClickOrTouch(event);
    }
  });

  document.addEventListener('touchstart', handleClickOrTouch);
}
