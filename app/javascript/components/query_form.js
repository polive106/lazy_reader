const manageButton = () => {
  const form = document.getElementById('query-form');
  if (form) {
    const inputField = document.querySelector('.query-input');
    const button = document.querySelector('.query-btn');
    inputField.addEventListener('keyup', (event) => {
      if (inputField.value.length === 0) {
        button.disabled = true;
      } else {
        button.disabled = false;
      }
    });
  }
}

export { manageButton };
