// Records button clicks for tracking purposes.
// The star background is rendered with static box-shadow values in
// skeleton-auto.css (#object1/#object2/#object3) - no JavaScript required.
export function setupButtonTracking() {
  console.log("Setting up button tracking...");
  
  function handleClickOrTouch(event) {
    if (event.target.classList.contains('button-click')) {
      var id = event.target.id;
      if (!sessionStorage.getItem('clicked-' + id)) {
        // Since this is a migration, skip the fetch call to the original endpoint
        // and only store the result in sessionStorage
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
