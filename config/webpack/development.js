process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const { merge } = require('webpack-merge');
const fs = require('fs');

module.exports = merge(environment.toWebpackConfig(), {
    mode: 'development',
    devServer: {
        public: process.env.WEBPACK_DEV_SERVER_PUBLIC + ":3035",
        // refs. https://memo.willnet.in/entry/2017/07/30/234412
        https: {
            cert: fs.readFileSync('./config/certs/localhost.cert'),
            key: fs.readFileSync('./config/certs/localhost.key'),
        }
    },
    resolve: {
        alias: {
            'vue$': 'vue/dist/vue.js'
        }
    }
})