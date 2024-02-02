/** @type {import('next').NextConfig} */
const nextConfig = {}

module.exports = nextConfig


module.exports = {
    webpack: (config, { isServer }) => {
      // Add html-loader for handling HTML files
      config.module.rules.push({
        test: /\.html$/,
        use: 'html-loader',
      });
  
      return config;
    },
  };