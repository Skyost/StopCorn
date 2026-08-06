import { dirname, resolve } from 'node:path'
import { fileURLToPath } from 'node:url'

import {
  BUNDLED_ICON_NAMES,
  DEFAULT_LOCALE,
  SITE,
  SUPPORTED_LOCALES,
  absoluteUrl,
  localizedPath,
} from './app/constants/site'

const rootDirectory = dirname(fileURLToPath(import.meta.url))

export default defineNuxtConfig({
  modules: [
    '@bootstrap-vue-next/nuxt',
    '@nuxt/eslint',
    '@nuxt/icon',
    '@nuxtjs/google-fonts',
    '@nuxtjs/robots',
    '@nuxtjs/sitemap',
    'nuxt-cname-generator',
    'nuxt-link-checker',
  ],
  devtools: { enabled: true },
  app: {
    head: {
      htmlAttrs: { lang: DEFAULT_LOCALE },
      meta: [
        { name: 'theme-color', content: '#24543b' },
        { name: 'color-scheme', content: 'light' },
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: SITE.faviconPath },
        { rel: 'icon', type: 'image/svg+xml', href: SITE.logoPath },
      ],
    },
  },
  css: ['~/assets/app.scss'],
  site: {
    url: SITE.url,
    name: SITE.name,
    trailingSlash: true,
  },
  runtimeConfig: {
    public: {
      siteUrl: SITE.url,
    },
  },
  build: {
    transpile: ['bootstrap-vue-next', 'vue-i18n'],
  },
  routeRules: {
    '/': { prerender: true },
    ...Object.fromEntries(SUPPORTED_LOCALES.map(({ code }) => [`/${code}/**`, { prerender: true }])),
  },
  experimental: {
    defaults: {
      nuxtLink: {
        trailingSlash: 'append',
      },
    },
  },
  compatibilityDate: '2026-08-04',
  nitro: {
    publicAssets: [
      {
        dir: resolve(rootDirectory, '../assets/branding'),
        baseURL: '/branding',
        maxAge: 60 * 60 * 24 * 30,
      },
    ],
    prerender: {
      crawlLinks: true,
      routes: ['/', ...SUPPORTED_LOCALES.map(({ code }) => localizedPath(code))],
    },
  },
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          silenceDeprecations: ['color-functions', 'global-builtin', 'if-function', 'import'],
        },
      },
    },
    define: {
      __INTLIFY_DROP_MESSAGE_COMPILER__: false,
      __INTLIFY_PROD_DEVTOOLS__: false,
      __VUE_I18N_FULL_INSTALL__: true,
      __VUE_I18N_LEGACY_API__: false,
      __VUE_PROD_DEVTOOLS__: false,
    },
    ssr: {
      noExternal: ['bootstrap-vue-next', 'vue-i18n'],
    },
  },
  bootstrapVueNext: {
    css: false,
  },
  cname: {
    host: SITE.host,
  },
  eslint: {
    config: {
      stylistic: true,
    },
  },
  googleFonts: {
    display: 'swap',
    download: true,
    families: {
      'DM Serif Display': [400],
      'Outfit': [400, 500, 600, 700],
    },
    preload: true,
  },
  icon: {
    provider: 'none',
    clientBundle: {
      icons: [...BUNDLED_ICON_NAMES],
      scan: true,
    },
  },
  linkChecker: {
    failOnError: false,
  },
  robots: {
    groups: [
      {
        userAgent: ['*'],
        allow: ['/'],
      },
    ],
  },
  sitemap: {
    excludeAppSources: true,
    zeroRuntime: true,
    urls: SUPPORTED_LOCALES.map(({ code }) => ({
      loc: localizedPath(code),
      alternatives: [
        ...SUPPORTED_LOCALES.map(locale => ({
          hreflang: locale.languageTag,
          href: absoluteUrl(localizedPath(locale.code)),
        })),
        {
          hreflang: 'x-default',
          href: absoluteUrl(localizedPath(DEFAULT_LOCALE)),
        },
      ],
      images: [{
        loc: absoluteUrl(SITE.socialImages.openGraph.path),
        title: SITE.name,
      }],
      _i18nTransform: false,
    })),
  },
})
