const path= require('path');

module.exports= {
    entry: {
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
    module: {
        loaders: [
            { test: /\.ts$/,  loaders: ['babel', 'ts'], exclude: /node_modules/ },
            { test: /\.vue$/, loaders: ['vue'],         exclude: /node_modules/ },
        ],
    },
    devtool: '#source-map',
};
