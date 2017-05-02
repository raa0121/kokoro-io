import webpack from 'webpack';
import path from 'path';

export default {
    entry: {
        chat: path.join(__dirname, '..', 'assets', 'javascripts', 'chat.ts'),
        application: path.join(__dirname, '..' ,'assets', 'javascripts', 'application.ts'),
    },
    output: {
        path: path.join(__dirname, '../assets', 'dist', 'javascripts'),
        filename: '[name].js',
    },
    resolve: {
        extensions: ['*', '.webpack.js', '.web.js', '.ts', '.js', '.vue'],
        alias: {
            vue: 'vue/dist/vue.js',
        },
    },
    plugins: [],
    module: {
        loaders: [
            { test: /\.ts$/,  loaders: ['babel-loader', 'ts-loader'], exclude: /node_modules/ },
            { test: /\.vue$/, loaders: ['vue-loader'],                exclude: /node_modules/ },
        ],
    },
};
