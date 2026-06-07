const THEME_KEY = "club-theme";
const root = document.documentElement;
const toggleButton = document.getElementById("themeToggleBtn");

if (toggleButton) {
  const getPreferredTheme = () => {
    const storedTheme = localStorage.getItem(THEME_KEY);
    if (storedTheme === "light" || storedTheme === "dark") {
      return storedTheme;
    }
    return window.matchMedia("(prefers-color-scheme: light)").matches
      ? "light"
      : "dark";
  };

  const applyTheme = (theme) => {
    root.setAttribute("data-theme", theme);
    const isLight = theme === "light";
    // Icons swap via CSS (icon-sun / icon-moon); only update ARIA attrs here
    toggleButton.setAttribute(
      "aria-label",
      isLight ? "Switch to dark theme" : "Switch to light theme"
    );
    toggleButton.setAttribute("aria-pressed", String(isLight));
  };

  const initialTheme = getPreferredTheme();
  applyTheme(initialTheme);

  toggleButton.addEventListener("click", () => {
    const currentTheme = root.getAttribute("data-theme") || "dark";
    const nextTheme = currentTheme === "light" ? "dark" : "light";
    localStorage.setItem(THEME_KEY, nextTheme);
    applyTheme(nextTheme);
  });
}

// ── Mobile hamburger drawer ──────────────────────────────────────────────────
(function () {
  const hamburger = document.getElementById("hamburgerBtn");
  const drawer    = document.getElementById("navDrawer");
  const overlay   = document.getElementById("navOverlay");

  if (!hamburger || !drawer || !overlay) return;

  function openDrawer() {
    drawer.classList.add("open");
    drawer.setAttribute("aria-hidden", "false");
    overlay.classList.add("active");
    overlay.setAttribute("aria-hidden", "false");
    hamburger.setAttribute("aria-expanded", "true");
    hamburger.setAttribute("aria-label", "Close navigation menu");
    document.body.style.overflow = "hidden";
  }

  function closeDrawer() {
    drawer.classList.remove("open");
    drawer.setAttribute("aria-hidden", "true");
    overlay.classList.remove("active");
    overlay.setAttribute("aria-hidden", "true");
    hamburger.setAttribute("aria-expanded", "false");
    hamburger.setAttribute("aria-label", "Open navigation menu");
    document.body.style.overflow = "";
  }

  hamburger.addEventListener("click", () => {
    const isOpen = hamburger.getAttribute("aria-expanded") === "true";
    isOpen ? closeDrawer() : openDrawer();
  });

  overlay.addEventListener("click", closeDrawer);

  drawer.querySelectorAll("a").forEach(link => {
    link.addEventListener("click", closeDrawer);
  });

  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape" && hamburger.getAttribute("aria-expanded") === "true") {
      closeDrawer();
      hamburger.focus();
    }
  });
})();

// ── Transparent header on top ──────────────────────────────────────────────
(function () {
  const header = document.querySelector(".site-header");
  if (!header) return;

  function handleScroll() {
    if (window.scrollY > 10) {
      header.classList.add("scrolled");
    } else {
      header.classList.remove("scrolled");
    }
  }

  window.addEventListener("scroll", handleScroll, { passive: true });
  // Initial check in case the page is loaded already scrolled
  handleScroll();
})();
