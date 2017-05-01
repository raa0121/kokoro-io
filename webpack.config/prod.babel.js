import webpack from 'webpack';
import conf from './base.babel.js';

conf.plugins = [
  new webpack.optimize.UglifyJsPlugin({
    comments: false,
    sourceMap: false,
  }),
];
export default conf;
