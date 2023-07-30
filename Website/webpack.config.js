const path = require("path");

module.exports = {
  mode: 'production',
  entry: {
    account: './src/js/account.js',
    checkout: './src/js/checkout.js',
    checkoutWelcome: './src/js/checkoutWelcome.js',
    contact: './src/js/contact.js',
    default: './src/js/default.js',
    download: './src/js/download.js',
    generator: './src/js/generator.js',
    helpArticle: './src/js/helpArticle.js',
    login: './src/js/login.js',
    photoswipe: './src/js/photoswipe.js',
    spawncodes: './src/js/spawncodes.js',
    viewpurchase: './src/js/viewpurchase.js',
    whatsnew: './src/js/whatsnew.js',
  },
  output: {
    path: path.join(__dirname, 'www/assets/scripts'),
    clean: true,
  },
  module: {
    rules: [
      {
        test: /(\.jsx|\.js)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [
              ['@babel/preset-env', {
                targets: {browsers: ["> 4%", "safari 10"]},
                modules: false,
              }],
            ]
          },
        },
      },
    ],
  },
  optimization: {
    minimize: true,
  },
};
