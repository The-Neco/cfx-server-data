const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const webpack = require('webpack')

module.exports = {
  mode: 'production',
  entry: './ui/src/index.tsx',
  output: {
    path: "./html",
    filename: '[name].js',
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
				],
			},
    ]
  },

  plugins: [
    new webpack.EnvironmentPlugin({
			NODE_ENV: 'production'
		}),
    new HtmlWebpackPlugin({
      template: "ui/public/index.html",
			minify: {
				removeComments: true,
				collapseWhitespace: true,
				removeRedundantAttributes: true,
				useShortDoctype: true,
				removeEmptyAttributes: true,
				removeStyleLinkTypeAttributes: true,
				keepClosingSlash: true,
				minifyJS: true,
				minifyCSS: true,
				minifyURLs: true,
			},
      inject: true
    })
  ],


  resolve: {
		modules: ['src', 'node_modules'],
		extensions: ['.js', '.jsx', '.ts', '.tsx', '.react.js']
	}
}
