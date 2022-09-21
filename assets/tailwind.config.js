// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

let plugin = require('tailwindcss/plugin');

module.exports = {
  content: ['./js/**/*.js', '../lib/*_web.ex', '../lib/*_web/**/*.*ex'],
  theme: {
    extend: {
      backgroundImage: {
        'header-dark-background': "url('/images/bg-desktop-dark.jpg')",
        'header-light-background': "url('/images/bg-desktop-light.jpg')",
      },
      colors: {
        'light-mode-background': '#F2F2F2',
        'light-mode-background-card': '#FFFFFF',
        'light-mode-hover-active': '#3A7CFD',
        'light-mode-task-text': '#494C6B',
        'light-mode-text': '#9495A5',
        'light-mode-checkec-task-text': '#D1D2DA',
        'pink-check-background': '#C058F3',
        'blue-check-background': '#55DDFF',
      },
      borderRadius: {
        'task-card': '5px',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    plugin(({ addVariant }) =>
      addVariant('phx-no-feedback', ['&.phx-no-feedback', '.phx-no-feedback &'])
    ),
    plugin(({ addVariant }) =>
      addVariant('phx-click-loading', [
        '&.phx-click-loading',
        '.phx-click-loading &',
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant('phx-submit-loading', [
        '&.phx-submit-loading',
        '.phx-submit-loading &',
      ])
    ),
    plugin(({ addVariant }) =>
      addVariant('phx-change-loading', [
        '&.phx-change-loading',
        '.phx-change-loading &',
      ])
    ),
  ],
};
