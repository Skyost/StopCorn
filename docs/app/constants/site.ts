export const SITE = Object.freeze({
  name: 'StopCorn',
  url: 'https://stopcorn.skyost.eu',
  host: 'stopcorn.skyost.eu',
  repositoryUrl: 'https://github.com/Skyost/StopCorn',
  issuesUrl: 'https://github.com/Skyost/StopCorn/issues',
  logoPath: '/branding/logo.svg',
  faviconPath: '/favicon.ico',
  socialImages: Object.freeze({
    openGraph: Object.freeze({
      path: '/social/open-graph.png',
      width: 1200,
      height: 630,
    }),
    twitter: Object.freeze({
      path: '/social/twitter.png',
      width: 1024,
      height: 1024,
    }),
  }),
  foundedYear: 2026,
  legalUpdatedAt: '2026-08-04',
})

export const DEFAULT_LOCALE = 'en' as const
export const FALLBACK_LOCALE = 'en' as const
export const DEFAULT_LANGUAGE_TAG = 'en-US' as const

export const SUPPORTED_LOCALES = [
  { code: 'en', languageTag: DEFAULT_LANGUAGE_TAG, label: 'English', shortLabel: 'EN' },
  { code: 'fr', languageTag: 'fr-FR', label: 'Français', shortLabel: 'FR' },
  { code: 'es', languageTag: 'es-ES', label: 'Español', shortLabel: 'ES' },
  { code: 'pt', languageTag: 'pt-PT', label: 'Português', shortLabel: 'PT' },
  { code: 'de', languageTag: 'de-DE', label: 'Deutsch', shortLabel: 'DE' },
  { code: 'it', languageTag: 'it-IT', label: 'Italiano', shortLabel: 'IT' },
] as const

export type SiteLocale = (typeof SUPPORTED_LOCALES)[number]['code']

export const APP_SCREENSHOTS = [
  { id: 'home', fileName: '1_home.png' },
  { id: 'urgeSupport', fileName: '2_urge_support.png' },
  { id: 'progress', fileName: '3_progress.png' },
  { id: 'journal', fileName: '4_journal.png' },
  { id: 'learning', fileName: '5_learning.png' },
] as const

export const SCREENSHOT_CAROUSEL = Object.freeze({
  interval: 6000,
  imageWidth: 1320,
  imageHeight: 2868,
})

export const LOCALE_COOKIE = Object.freeze({
  name: 'stopcorn-locale',
  maxAge: 60 * 60 * 24 * 365,
  sameSite: 'lax' as const,
})

export const SECTION_IDS = Object.freeze({
  main: 'main-content',
  mission: 'mission',
  features: 'features',
  howItWorks: 'how-it-works',
  privacy: 'privacy',
  support: 'support',
  download: 'download',
  faq: 'faq',
  terms: 'terms',
})

export const NAV_ITEMS = [
  { id: SECTION_IDS.mission, translationKey: 'navigation.mission' },
  { id: SECTION_IDS.features, translationKey: 'navigation.features' },
  { id: SECTION_IDS.howItWorks, translationKey: 'navigation.howItWorks' },
  { id: SECTION_IDS.privacy, translationKey: 'navigation.privacy' },
] as const

export const FEATURE_ITEMS = [
  { id: 'urge', icon: 'lucide:timer-reset' },
  { id: 'journal', icon: 'lucide:notebook-pen' },
  { id: 'progress', icon: 'lucide:chart-no-axes-combined' },
  { id: 'checkIn', icon: 'lucide:calendar-check-2' },
  { id: 'plan', icon: 'lucide:list-checks' },
  { id: 'harvest', icon: 'lucide:sprout' },
] as const

export const STEP_ITEMS = [
  { id: 'baseline', icon: 'lucide:map-pin-check-inside' },
  { id: 'observe', icon: 'lucide:search' },
  { id: 'act', icon: 'lucide:footprints' },
  { id: 'learn', icon: 'lucide:line-chart' },
] as const

export const REASON_ITEMS = [
  { id: 'free', icon: 'lucide:badge-euro' },
  { id: 'private', icon: 'lucide:shield-check' },
  { id: 'kind', icon: 'lucide:heart-handshake' },
] as const

export const HERO_TRUST_ITEMS = [
  { id: 'free', icon: 'lucide:circle-dollar-sign' },
  { id: 'local', icon: 'lucide:smartphone' },
  { id: 'noAds', icon: 'lucide:badge-x' },
] as const

export const PRIVACY_PROMISE_ITEMS = [
  { id: 'noAccount', icon: 'lucide:user-round-x' },
  { id: 'noTracking', icon: 'lucide:scan-eye' },
  { id: 'noExplicitData', icon: 'lucide:file-x-2' },
] as const

export const FAQ_ITEMS = [
  'purpose',
  'privacy',
  'blocking',
  'medical',
  'price',
  'support',
] as const

export const PRIVACY_SECTIONS = [
  'overview',
  'mobileData',
  'crashReports',
  'websiteData',
  'supportPurchase',
  'externalServices',
  'choices',
] as const

export const TERMS_SECTIONS = [
  'eligibility',
  'purpose',
  'responsibilities',
  'availability',
  'externalServices',
  'changes',
] as const

interface StoreLink {
  id: 'appStore' | 'playStore'
  icon: string
  url: string | null
}

export const STORE_LINKS: readonly StoreLink[] = [
  { id: 'appStore', icon: 'lucide:apple', url: null },
  { id: 'playStore', icon: 'lucide:play', url: null },
] as const

export const FUTURE_LINKS: Readonly<{ merchUrl: string | null }> = Object.freeze({
  merchUrl: null,
})

export const EXTERNAL_PRIVACY_LINKS = [
  {
    id: 'revenueCat',
    url: 'https://www.revenuecat.com/privacy/',
  },
  {
    id: 'sentry',
    url: 'https://sentry.io/privacy/',
  },
  {
    id: 'apple',
    url: 'https://www.apple.com/legal/privacy/',
  },
  {
    id: 'google',
    url: 'https://policies.google.com/privacy',
  },
] as const

export const BUNDLED_ICON_NAMES = [
  ...FEATURE_ITEMS.map(({ icon }) => icon),
  ...STEP_ITEMS.map(({ icon }) => icon),
  ...REASON_ITEMS.map(({ icon }) => icon),
  ...HERO_TRUST_ITEMS.map(({ icon }) => icon),
  ...PRIVACY_PROMISE_ITEMS.map(({ icon }) => icon),
  ...STORE_LINKS.map(({ icon }) => icon),
  'lucide:images',
  'lucide:menu',
  'lucide:pause',
  'lucide:play',
  'lucide:x',
] as const

export function isSupportedLocale(value: unknown): value is SiteLocale {
  return SUPPORTED_LOCALES.some(({ code }) => code === value)
}

export function localeFromPath(path: string): SiteLocale | undefined {
  const candidate = path.split('/').filter(Boolean)[0]
  return isSupportedLocale(candidate) ? candidate : undefined
}

export function localizedPath(locale: SiteLocale, hash?: string): string {
  const suffix = hash ? `#${hash.replace(/^#/, '')}` : ''
  return `/${locale}/${suffix}`
}

export function absoluteUrl(path: string): string {
  return new URL(path, SITE.url).toString()
}

export function openGraphLocale(locale: SiteLocale): string {
  const supported = SUPPORTED_LOCALES.find(({ code }) => code === locale)
  return (supported?.languageTag ?? DEFAULT_LANGUAGE_TAG).replace('-', '_')
}

export function appScreenshotPath(locale: SiteLocale, fileName: string): string {
  return `/screenshots/${locale}/ios/iphone/${fileName}`
}
