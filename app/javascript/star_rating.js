document.addEventListener('DOMContentLoaded', () => {
    const stars = document.querySelectorAll('.star');
    
    stars.forEach(star => {
      star.addEventListener('mouseover', () => {
        const rating = parseInt(star.getAttribute('for').split('_')[1]);
        updateStars(rating);
      });
  
      star.addEventListener('mouseout', () => {
        const checkedRating = document.querySelector('input[name="review[rating]"]:checked');
        const rating = checkedRating ? parseInt(checkedRating.value) : 0;
        updateStars(rating);
      });
  
      star.addEventListener('click', () => {
        const rating = parseInt(star.getAttribute('for').split('_')[1]);
        document.querySelector(`input[name="review[rating][value]"][value="${rating}"]`).checked = true;
        updateStars(rating);
      });
    });
  
    function updateStars(rating) {
      stars.forEach(star => {
        const starRating = parseInt(star.getAttribute('for').split('_')[1]);
        star.classList.toggle('text-yellow-400', starRating <= rating);
        star.classList.toggle('text-gray-300', starRating > rating);
      });
    }
  });
  