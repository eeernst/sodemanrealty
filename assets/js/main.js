(function () {
  const reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  // reveal animations
  if (!reduce) {
    const els = document.querySelectorAll(".reveal");
    const io = new IntersectionObserver((entries) => {
      entries.forEach(e => { if (e.isIntersecting) e.target.classList.add("is-visible"); });
    }, { threshold: 0.12 });
    els.forEach(el => io.observe(el));
  }

  // mobile nav toggle (animated)
  const btn = document.querySelector(".nav-toggle");
  const menu = document.getElementById("mobileMenu");
  if (!btn || !menu) return;

  function setOpen(nextOpen){
    btn.setAttribute("aria-expanded", String(nextOpen));
    btn.classList.toggle("is-open", nextOpen);

    menu.hidden = false; // keep in DOM so animation can run
    menu.classList.toggle("is-open", nextOpen);

    if (!nextOpen) {
      if (reduce) { menu.hidden = true; return; }
      const onEnd = () => {
        menu.hidden = true;
        menu.removeEventListener("transitionend", onEnd);
      };
      menu.addEventListener("transitionend", onEnd);
    }
  }

  btn.addEventListener("click", () => {
    const open = btn.getAttribute("aria-expanded") === "true";
    setOpen(!open);
  });

  menu.addEventListener("click", (e) => {
    if (e.target.tagName.toLowerCase() === "a") setOpen(false);
  });
})();
