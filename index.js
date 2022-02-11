const nav = document.querySelector('.primary-navigation');
const navToggle = document.querySelector('.mobile-nav-toggle');

navToggle.addEventListener('click', () => {
  onOff = nav.dataset.visible === 'false' ? 'true' : 'false'

  nav.dataset.visible = onOff;
  navToggle.setAttribute('aria-expanded', onOff);
});
