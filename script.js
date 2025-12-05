document.addEventListener('DOMContentLoaded', () => {
    // Reveal on scroll using IntersectionObserver
    const revealOptions = {
        threshold: 0.15,
        rootMargin: "0px 0px -50px 0px"
    };

    const revealObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach((entry, index) => {
            if (entry.isIntersecting) {
                // Check if the element is part of a grid for staggered animation
                const parent = entry.target.parentElement;
                if (parent && (parent.classList.contains('product-grid') || 
                               parent.classList.contains('categories') || 
                               parent.classList.contains('benefits-strip') || 
                               parent.classList.contains('campaign-section') || 
                               parent.classList.contains('collections'))) {
                    
                    // Get index of child within parent to calculate delay
                    const children = Array.from(parent.children);
                    const childIndex = children.indexOf(entry.target);
                    entry.target.style.transitionDelay = `${childIndex * 0.1}s`;
                }

                entry.target.classList.add('active');
                observer.unobserve(entry.target);
            }
        });
    }, revealOptions);

    const revealElements = document.querySelectorAll('.product-card, .category-card, .collection-circle, .campaign-card, .section-title, .benefit-item, .offer-banner, .mid-promo');
    revealElements.forEach(el => {
        // Assign specific reveal types based on class or section
        if (el.classList.contains('section-title') || el.classList.contains('mid-promo')) {
            el.classList.add('reveal');
        } else if (el.classList.contains('category-card')) {
            el.classList.add('reveal-left');
        } else if (el.classList.contains('offer-banner')) {
            el.classList.add('reveal-scale');
        } else {
            el.classList.add('reveal');
        }
        revealObserver.observe(el);
    });

    // Smoother Parallax effect for hero callouts
    const hero = document.querySelector('.hero');
    const callouts = document.querySelectorAll('.ingredient-callout');
    let mouseX = 0, mouseY = 0;
    let targetX = 0, targetY = 0;

    hero.addEventListener('mousemove', (e) => {
        targetX = (window.innerWidth / 2 - e.pageX) / 30;
        targetY = (window.innerHeight / 2 - e.pageY) / 30;
    });

    function updateParallax() {
        mouseX += (targetX - mouseX) * 0.1;
        mouseY += (targetY - mouseY) * 0.1;

        callouts.forEach((callout, index) => {
            const speed = (index + 1) * 0.8;
            callout.style.transform = `translate(${mouseX * speed}px, ${mouseY * speed}px)`;
        });
        requestAnimationFrame(updateParallax);
    }
    updateParallax();

    // Magnetic Button Effect with smoother return
    const magneticBtns = document.querySelectorAll('.cta-button, .add-to-cart, .buy-now-btn');
    magneticBtns.forEach(btn => {
        btn.addEventListener('mousemove', (e) => {
            const rect = btn.getBoundingClientRect();
            const x = e.clientX - rect.left - rect.width / 2;
            const y = e.clientY - rect.top - rect.height / 2;

            btn.style.transform = `translate(${x * 0.3}px, ${y * 0.3}px)`;
        });

        btn.addEventListener('mouseleave', () => {
            btn.style.transition = 'transform 0.5s cubic-bezier(0.23, 1, 0.32, 1)';
            btn.style.transform = 'translate(0px, 0px)';
            setTimeout(() => {
                btn.style.transition = '';
            }, 500);
        });
    });

    // Add to cart interaction
    const cartButtons = document.querySelectorAll('.add-to-cart, .buy-now-btn');
    cartButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            const originalText = btn.innerHTML;
            btn.innerHTML = 'Added ✨';
            btn.style.transform = 'scale(0.9)';
            btn.style.background = '#9D84D1';
            setTimeout(() => {
                btn.innerHTML = originalText;
                btn.style.transform = '';
                btn.style.background = '';
            }, 1500);
        });
    });
});
