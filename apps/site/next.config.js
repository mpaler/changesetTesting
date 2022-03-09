const withTM = require("next-transpile-modules")([
  "@ets/ui",
  "@headlessui/react",
]);
const withNextra = require('nextra')({
  theme: 'nextra-theme-docs',
  themeConfig: './theme.config.js',
});

/**
 * @type {import('next').NextConfig}
 **/
 const nextConfig = {
  reactStrictMode: true,
  async redirects() {
    return [
      {
        source: '/explorer',
        destination: 'https://app-f0rqgtug1-ethereum-tag-service.vercel.app/',
        permanent: false,
        basePath: false
      },
    ]
  },
};

module.exports = withNextra(withTM(nextConfig));
