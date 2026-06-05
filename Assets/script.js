const THEME_KEY = "club-theme";
const root = document.documentElement;
const toggleButton = document.querySelector(".theme-toggle");

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
    toggleButton.textContent = isLight ? "Dark mode" : "Light mode";
    toggleButton.setAttribute(
      "aria-label", /*ARIA - Accessible Rich Internet Applications */
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
