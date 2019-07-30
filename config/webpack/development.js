process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')
const merge = require('webpack-merge')

module.exports = Object.assign({}, environment.toWebpackConfig(), {
    resolve: {
        alias: {
            'vue$': 'vue/dist/vue.esm.js'
        }
    }
})
module.exports = merge(environment.toWebpackConfig(), {
    devServer: {
        public: process.env.WEBPACK_DEV_SERVER_PUBLIC
    }
})