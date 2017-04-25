import path from 'path';
const webpack = require('webpack');

export default {
    entry: {
        chat: path.join(__dirname, 'assets', 'javascripts', 'chat.ts'),
        application: path.join(__dirname, 'assets', 'javascripts', 'application.ts'),
    },
    output: {
        path: path.join(__dirname, 'assets', 'dist', 'javascripts'),
        filename: '[name].js',
    },
    resolve: {
        extensions: ['', '.webpack.js', '.web.js', '.ts', '.js', '.vue'],
        alias: {
            vue: 'vue/dist/vue.js',
        },
    },
    plugins: [
        new webpack.ProvidePlugin({
            jQuery: "jquery",
            $: "jquery"
        })
    ],
    module: {
        loaders: [
            { test: /\.ts$/,  loaders: ['babel', 'ts'], exclude: /node_modules/ },
            { test: /\.vue$/, loaders: ['vue'],         exclude: /node_modules/ },
        ],
    },
    devtool: '#source-map',
};
