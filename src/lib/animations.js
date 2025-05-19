// Este script maneja la animación de estrellas en el fondo y 
// registra los clics en los botones para fines de seguimiento
export function initializeBackground() {
  console.log("Initializing background animation...");
  const object1 = [];
  const object2 = [];
  const object3 = [];

  const numberOfObject1 = 1000;
  const numberOfObject2 = 600;
  const numberOfObject3 = 100;

  for (let i = 0; i < numberOfObject1; i++) {
    const pos1 = (Math.floor(Math.random() * 5200));
    const pos2 = (Math.floor(Math.random() * 5200));
    object1.push(`${pos1}px ${pos2}px #fff`);
  }

  for (let i = 0; i < numberOfObject2; i++) {
    const pos1 = (Math.floor(Math.random() * 5200));
    const pos2 = (Math.floor(Math.random() * 5200));
    object2.push(`${pos1}px ${pos2}px #fff`);
  }

  for (let i = 0; i < numberOfObject3; i++) {
    const pos1 = (Math.floor(Math.random() * 5200));
    const pos2 = (Math.floor(Math.random() * 5200));
    object3.push(`${pos1}px ${pos2}px #fff`);
  }

  // Aplicar las estrellas al fondo
  setTimeout(() => {
    const obj1Elem = document.getElementById('object1');
    const obj2Elem = document.getElementById('object2');
    const obj3Elem = document.getElementById('object3');
    
    if (obj1Elem) obj1Elem.style.boxShadow = object1.join(',');
    if (obj2Elem) obj2Elem.style.boxShadow = object2.join(',');
    if (obj3Elem) obj3Elem.style.boxShadow = object3.join(',');
  }, 100);
}

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
