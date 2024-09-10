const path = require('path');

module.exports = {
  mode: 'production',
  entry: './app/javascript/packs/application.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'public/packs')
  },
  node: {
    __dirname: false,
    __filename: false
  }
};

