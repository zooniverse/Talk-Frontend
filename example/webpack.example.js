module.exports = {
    watch: true,
    context: __dirname,
    entry: {
        bundle: './main.cjsx'
    },
    output: {
        path: __dirname + '/build',
        filename: 'bundle.js',
        chunkFilename: '[id].example.js'
    },
    resolve: {
        extensions: ['', '.js', '.cjsx', '.coffee']
    },
    module: {
        loaders: [
            { test: /\.cjsx$/, loaders: ['coffee-loader', 'cjsx-loader'] },
            { test: /\.coffee$/, loader: 'coffee-loader' }
        ],
        noParse: [
                /^react$/
        ]
    },
    node: {
        fs: 'empty'
    },
    watchDelay: 0,
    devtool: 'eval-source-map'
};
