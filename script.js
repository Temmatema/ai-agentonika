/* ==========================================================================
   АгентникАи — скрипты
   ========================================================================== */
(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function () {
    var toggle = document.getElementById('navToggle');
    var nav = document.getElementById('nav');
    var header = document.querySelector('.site-header');

    /* --- Мобильное меню --- */
    if (toggle && nav) {
      var closeMenu = function () {
        nav.classList.remove('is-open');
        toggle.classList.remove('is-open');
        toggle.setAttribute('aria-expanded', 'false');
        toggle.setAttribute('aria-label', 'Открыть меню');
      };

      toggle.addEventListener('click', function () {
        var isOpen = nav.classList.toggle('is-open');
        toggle.classList.toggle('is-open', isOpen);
        toggle.setAttribute('aria-expanded', String(isOpen));
        toggle.setAttribute('aria-label', isOpen ? 'Закрыть меню' : 'Открыть меню');
      });

      /* закрываем меню после клика по ссылке */
      nav.querySelectorAll('a').forEach(function (link) {
        link.addEventListener('click', closeMenu);
      });

      /* закрываем меню по Esc */
      document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') closeMenu();
      });
    }

    /* --- Тень хедера при скролле --- */
    if (header) {
      var onScroll = function () {
        header.classList.toggle('is-scrolled', window.scrollY > 8);
      };
      onScroll();
      window.addEventListener('scroll', onScroll, { passive: true });
    }

    /* --- Плавающая панель секций (появляется после первого экрана) --- */
    var floatNav = document.getElementById('floatNav');
    if (floatNav) {
      var hero = document.querySelector('.hero');
      var trigger = 0;
      var enabled = true;

      var computeTrigger = function () {
        /* на мобильных панель скрыта (там закреплённый хедер с бургер-меню) */
        enabled = window.getComputedStyle(floatNav).display !== 'none';
        trigger = hero ? (hero.offsetTop + hero.offsetHeight - 40) : window.innerHeight;
      };

      var updateFloatNav = function () {
        floatNav.classList.toggle('is-visible', enabled && window.scrollY > trigger);
      };

      computeTrigger();
      updateFloatNav();
      window.addEventListener('scroll', updateFloatNav, { passive: true });
      window.addEventListener('resize', function () {
        computeTrigger();
        updateFloatNav();
      });
    }
  });
})();
