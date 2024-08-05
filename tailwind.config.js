module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        customBlue: 'rgb(56, 189, 248)',
      },
    },
  },
  plugins: [require("daisyui")],
}
