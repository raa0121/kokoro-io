const path= require('path');

module.exports= {
    entry: {
        application: path.join(__dirname, 'assets', 'javascripts', 'application.ts'),
    },
    output: {
        path: path.join(__dirname, 'assets', 'dist', 'javascripts'),
        filename: '[name].js',
    },
    module: {
        loaders: [
            { test: /\.ts$/, loader: 'ts-loader', exclude: /node_modules/ },
        ],
    },
};
