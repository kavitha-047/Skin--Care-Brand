document.addEventListener('DOMContentLoaded', () => {
    // Reveal on scroll using IntersectionObserver
    const revealOptions = {
        threshold: 0.15,
        rootMargin: "0px 0px -100px 0px"
    };

    const revealObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('active');
                // Optional: Stop observing after reveal
                // observer.unobserve(entry.target);
            }
        });
    }, revealOptions);

    const revealElements = document.querySelectorAll('.product-card, .category-card, .collection-circle, .campaign-card, .section-title, .benefit-item');
    revealElements.forEach(el => {
        el.classList.add('reveal');
        revealObserver.observe(el);
    });

    // Parallax effect for hero callouts on mouse move
    const hero = document.querySelector('.hero');
    const callouts = document.querySelectorAll('.ingredient-callout');

    hero.addEventListener('mousemove', (e) => {
        const x = (window.innerWidth - e.pageX * 2) / 100;
        const y = (window.innerHeight - e.pageY * 2) / 100;

        callouts.forEach((callout, index) => {
            const speed = (index + 1) * 2;
            callout.style.transform = `translateX(${x * speed}px) translateY(${y * speed}px)`;
        });
    });

    // Magnetic Button Effect
    const magneticBtns = document.querySelectorAll('.cta-button, .add-to-cart, .buy-now-btn');
    magneticBtns.forEach(btn => {
        btn.addEventListener('mousemove', (e) => {
            const position = btn.getBoundingClientRect();
            const x = e.pageX - position.left - position.width / 2;
            const y = e.pageY - position.top - position.height / 2;

            btn.style.transform = `translate(${x * 0.3}px, ${y * 0.5}px)`;
        });

        btn.addEventListener('mouseleave', () => {
            btn.style.transform = 'translate(0px, 0px)';
        });
    });

    // Add to cart interaction
    const cartButtons = document.querySelectorAll('.add-to-cart, .buy-now-btn');
    cartButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            const originalText = btn.innerHTML;
            btn.innerHTML = 'Added ✨';
            btn.style.transform = 'scale(0.95)';
            setTimeout(() => {
                btn.innerHTML = originalText;
                btn.style.transform = 'scale(1)';
            }, 1500);
        });
    });
});
