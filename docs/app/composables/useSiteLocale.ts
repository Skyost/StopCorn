import { useI18n } from 'vue-i18n'

import {
  DEFAULT_LOCALE,
  LOCALE_COOKIE,
  SUPPORTED_LOCALES,
  isSupportedLocale,
  localizedPath,
  type SiteLocale,
} from '~/constants/site'

export function useSiteLocale() {
  const route = useRoute()
  const { locale: i18nLocale } = useI18n({ useScope: 'global' })
  const localeCookie = useCookie<SiteLocale | null>(LOCALE_COOKIE.name, {
    maxAge: LOCALE_COOKIE.maxAge,
    sameSite: LOCALE_COOKIE.sameSite,
  })

  const locale = computed<SiteLocale>(() => (
    isSupportedLocale(i18nLocale.value) ? i18nLocale.value : DEFAULT_LOCALE
  ))

  function setLocale(nextLocale: SiteLocale, persist = true) {
    i18nLocale.value = nextLocale
    if (persist) {
      localeCookie.value = nextLocale
    }
  }

  function detectPreferredLocale(): SiteLocale {
    if (isSupportedLocale(localeCookie.value)) {
      return localeCookie.value
    }

    if (import.meta.client) {
      const browserLocale = navigator.languages
        .map(value => value.split('-')[0]?.toLowerCase())
        .find(isSupportedLocale)
      if (browserLocale) {
        return browserLocale
      }
    }

    return DEFAULT_LOCALE
  }

  async function switchLocale(nextLocale: SiteLocale) {
    setLocale(nextLocale)
    await navigateTo({
      path: localizedPath(nextLocale),
      hash: route.hash,
    })
  }

  return {
    availableLocales: SUPPORTED_LOCALES,
    detectPreferredLocale,
    locale,
    localePath: localizedPath,
    setLocale,
    switchLocale,
  }
}
