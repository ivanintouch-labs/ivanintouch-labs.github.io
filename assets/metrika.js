/* Яндекс.Метрика — единая точка подключения для всего сайта.
   ЧТОБЫ ВКЛЮЧИТЬ: вставь номер счётчика в COUNTER_ID (получишь в metrika.yandex.ru).
   Пока COUNTER_ID = 0 — скрипт ничего не грузит и не шлёт (безопасный no-op). */
(function () {
  var COUNTER_ID = 0; // <-- ВСТАВИТЬ номер счётчика Яндекс.Метрики, напр. 99999999

  // Заглушка цели, чтобы вызовы window.ymGoal(...) не падали до подключения счётчика.
  window.ymGoal = function () {};
  if (!COUNTER_ID) return;

  // Стандартный инициализатор Метрики
  (function (m, e, t, r, i, k, a) {
    m[i] = m[i] || function () { (m[i].a = m[i].a || []).push(arguments); };
    m[i].l = 1 * new Date();
    for (var j = 0; j < e.scripts.length; j++) { if (e.scripts[j].src === r) return; }
    k = e.createElement(t); a = e.getElementsByTagName(t)[0];
    k.async = 1; k.src = r; a.parentNode.insertBefore(k, a);
  })(window, document, 'script', 'https://mc.yandex.ru/metrika/tag.js', 'ym');

  ym(COUNTER_ID, 'init', {
    clickmap: true,
    trackLinks: true,
    accurateTrackBounce: true,
    webvisor: true
  });

  window.ymGoal = function (goal) { try { ym(COUNTER_ID, 'reachGoal', goal); } catch (e) {} };

  // --- Автоцели по селекторам (не нужно размечать каждую кнопку вручную) ---
  // quiz_cta — клик по любой кнопке подбора/квиза или по верхнему CTA
  document.addEventListener('click', function (e) {
    var a = e.target.closest && e.target.closest('a');
    if (!a) return;
    if (a.closest('.quiz-embed') || a.classList.contains('cta') ||
        (a.getAttribute('href') || '').indexOf('#quiz') !== -1) {
      window.ymGoal('quiz_cta');
    }
  });

  // calc_used — первое взаимодействие с калькулятором (страница маткапитала)
  var calc = document.querySelector('.calc');
  if (calc) {
    var fired = false;
    calc.addEventListener('input', function () {
      if (!fired) { fired = true; window.ymGoal('calc_used'); }
    });
  }
})();
