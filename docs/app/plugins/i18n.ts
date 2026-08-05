import { createI18n } from 'vue-i18n'

import {
  DEFAULT_LOCALE,
  FALLBACK_LOCALE,
  localeFromPath,
} from '~/constants/site'
import en from '~/locales/en.json'
import fr from '~/locales/fr.json'

export default defineNuxtPlugin(({ vueApp }) => {
  const initialLocale = localeFromPath(useRequestURL().pathname) ?? DEFAULT_LOCALE
  const i18n = createI18n({
    legacy: false,
    globalInjection: true,
    locale: initialLocale,
    fallbackLocale: FALLBACK_LOCALE,
    ssr: true,
    messages: { en, fr },
  })

  vueApp.use(i18n)
})
