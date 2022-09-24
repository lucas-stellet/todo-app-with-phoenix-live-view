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
        'light-mode-task-button-border': '#E3E4F1',
        'light-mode-x-mark': '#E3E4F1',

        'pink-check-background': '#C058F3',
        'blue-check-background': '#55DDFF',

        'dark-mode-task-text': '#C8CBE7',
        'dark-mode-task-button-border': '#393A4B',
        'dark-mode-background-card': '#25273D',
        'dark-mode-input': '#25273D',
        'dark-mode-task-button-border': '#393A4B',
        'dark-mode-bottom-text': '#8f91ae',
        'dark-mode-x-mark': '#E3E4F1',
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
