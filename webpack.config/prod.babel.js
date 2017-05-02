import webpack from 'webpack';
import conf from './base.babel.js';

conf.plugins = [
    new webpack.optimize.UglifyJsPlugin({
        comments: false,
        sourceMap: false,
    }),
    new webpack.DefinePlugin({
        'process.env': {
            NODE_ENV: '"production"'
        }
    })
];
export default conf;
