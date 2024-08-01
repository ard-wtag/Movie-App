document.addEventListener('DOMContentLoaded', () => {
    // Select all buttons with a data-confirm attribute
    console.log("Hello from confirmation js file ")
    const deleteButtons = document.querySelectorAll('[data-confirm]');
  
    deleteButtons.forEach(button => {
      button.addEventListener('click', function(event) {
        // Show confirmation dialog
        const message = this.getAttribute('data-confirm');
        if (!confirm(message)) {
          // If not confirmed, prevent default action (form submission)
          event.preventDefault();
        }
      });
    });
  });
  