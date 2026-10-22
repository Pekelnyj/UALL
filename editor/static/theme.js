// Перемикач тем: dark (стандарт) / light / oled / medoid. Зберігається в localStorage.
// Анти-FOUC рядок у <head> кожної сторінки виставляє data-theme ще до рендера.
(function () {
  "use strict";
  var KEY = "wowua-theme", THEMES = ["dark", "light", "oled", "medoid"];

  function cur() {
    try { return localStorage.getItem(KEY) || "dark"; } catch (e) { return "dark"; }
  }

  window.setTheme = function (t) {
    if (THEMES.indexOf(t) < 0) t = "dark";
    document.documentElement.dataset.theme = t;
    try { localStorage.setItem(KEY, t); } catch (e) {}
    var s = document.getElementById("themeSel");
    if (s) s.value = t;
  };

  function init() {
    document.documentElement.dataset.theme = cur();
    var s = document.getElementById("themeSel");
    if (s) {
      s.value = cur();
      s.addEventListener("change", function () { window.setTheme(s.value); });
    }
  }

  if (document.readyState !== "loading") init();
  else document.addEventListener("DOMContentLoaded", init);
})();
