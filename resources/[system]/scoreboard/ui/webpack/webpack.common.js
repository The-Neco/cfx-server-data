
const path = require('path');
const webpack = require('webpack')

module.exports = (options) => ({
	mode: options.mode,
	entry: options.entry,
	output: {
		path: path.resolve(process.cwd(), "../html"),
		filename: '[name].js'
	},

	module: {
		rules: [
			{
				test: /\.tsx?$/,
				use: [
					{
						loader:'ts-loader',
						options: {
							transpileOnly: true
						},
					},
				],
				exclude: /node_modules/,
			},
			{
				test: /\.css$/,
				exclude: /node_modules/,
				use: ['style-loader', 'css-loader']
			},
			{
				test: /\.css$/,
				include: /node_modules/,
				use: ['style-loader', 'css-loader']
			},
			{
				test: /\.(jpg|png|gif)$/,
				use: [
					{
						loader: 'url-loader',
						options: {
							// Inline files smaller than 10 kB
							limit: 10 * 1024,
						},
					},
					{
						loader: 'image-webpack-loader',
						options: {
							mozjpeg: {
								enabled: false,
								// NOTE: mozjpeg is disabled as it causes errors in some Linux environments
								// Try enabling it in your environment by switching the config to:
								// enabled: true,
								// progressive: true,
							},
							gifsicle: {
								interlaced: false,
							},
							optipng: {
								optimizationLevel: 7,
							},
							pngquant: {
								quality: [0.60, 0.90],
								speed: 4,
							},
						},
					},
				],
			},
		],
	},

	plugins: options.plugins.concat([

		new webpack.EnvironmentPlugin({
			NODE_ENV: options.mode
		}),
	]),

	resolve: {
		modules: ['src', 'node_modules'],
		extensions: ['.js', '.jsx', '.ts', '.tsx', '.react.js']
	}

})