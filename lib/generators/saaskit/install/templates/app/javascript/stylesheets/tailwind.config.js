const { colors } = require('tailwindcss/defaultTheme')

module.exports = {
  theme: {
    extend: {
      colors: {
        brand: {
          lighter: '#bfe9ff',
          default: '#56b4fc',
          dark: '#1552f0',
          darker: '#194bcc',
        },
        info: colors.blue,
        danger: colors.red,
        warning: colors.yellow,
        success: colors.green,
        facebook: '#3b5998',
      },
      spacing: {
        '72': '18rem',
        '80': '20rem',
        '88': '22rem',
        '96': '24rem',
        '104': '26rem',
        '112': '28rem',
        '120': '30rem',
      },
      boxShadow: {
        focus: '0 0 0 1px rgba(86, 180, 252, 1)',
        light: '0 8px 16px rgba(0, 0, 0, 0.03)',
        lighter: '0 4px 8px 0 rgba(0, 0, 0, 0.03)',
      },
      fontFamily: {
        sans: [
          'Inter',
        ],
      },
      maxHeight: {
        '0': '0',
      },
      pseudo: {
        'before': 'before',
        'after': 'after',
        'not-first': 'not(:first-child)',
      },
      transitionProperty: {
        'none': 'none',
        'all': 'all',
        'color': 'color',
        'bg': 'background-color',
        'border': 'border-color',
        'colors': ['color', 'background-color', 'border-color'],
        'opacity': 'opacity',
        'transform': 'transform',
        'height': 'height',
      },
      linearGradients: theme => ({
        colors: {
          'semi-transparent-white': ['rgba(255, 255, 255, 0)', 'rgba(255, 255, 255, 0.4) 70%', 'rgba(255, 255, 255, 1)'],
        }
      }),
    }
  },
  variants: {
    backgroundColor: ['responsive', 'hover', 'focus', 'group-hover'],
    height: ['responsive', 'after'],
    objectPosition: ['responsive', 'after'],
    position: ['responsive', 'after'],
    textColor: ['responsive', 'hover', 'focus', 'group-hover'],
    width: ['responsive', 'after'],
    empty: ['before', 'after'],
    linearGradients: ['responsive', 'after'],
  },
  plugins: [
    require('tailwindcss-transitions')(),
    require('tailwindcss-gradients')(),
    require('tailwindcss-pseudo')({
      empty: true,
    }),
  ],
}
