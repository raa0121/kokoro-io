import webpack from 'webpack';
import path from 'path';

export default {
    entry: {
        chat: path.join(__dirname, '..', 'assets', 'javascripts', 'chat.ts'),
        application: path.join(__dirname, '..' ,'assets', 'javascripts', 'application.ts'),
    },
    output: {
        path: path.join(__dirname, '..', 'assets', 'dist', 'javascripts'),
        filename: '[name].js',
    },
    resolve: {
        extensions: ['*', '.webpack.js', '.web.js', '.ts', '.js', '.vue'],
        alias: {
            'vue$': 'vue/dist/vue.esm.js',
        },
    },
    plugins: [],
    module: {
        rules: [
            {
                use: ['babel-loader', 'vue-ts-loader'],
                test: /\.ts$/,
                exclude: /node_modules/
            },
            {
                use: ['babel-loader', {
                    loader: 'vue-loader',
                    options: {
                        loaders: {
                            js: 'vue-ts-loader',
                        },
                        esModule: true,
                    },
                }],
                test: /\.vue$/,
                exclude: /node_modules/
            },
        ],
    },
};
