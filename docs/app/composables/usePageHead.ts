import { useI18n } from 'vue-i18n'

import {
  DEFAULT_LOCALE,
  FAQ_ITEMS,
  SITE,
  SUPPORTED_LOCALES,
  absoluteUrl,
  localizedPath,
  type SiteLocale,
} from '~/constants/site'

interface PageHeadOptions {
  locale: MaybeRefOrGetter<SiteLocale>
  noIndex?: boolean
}

export function usePageHead(options: PageHeadOptions) {
  const { t } = useI18n({ useScope: 'global' })
  const locale = computed(() => toValue(options.locale))
  const title = computed(() => t('seo.title'))
  const description = computed(() => t('seo.description'))
  const socialImageAlt = computed(() => t('seo.socialImageAlt'))
  const pageUrl = computed(() => absoluteUrl(localizedPath(locale.value)))
  const defaultUrl = absoluteUrl(localizedPath(DEFAULT_LOCALE))

  useSeoMeta({
    title,
    description,
    robots: options.noIndex
      ? 'noindex, follow'
      : 'index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1',
    ogType: 'website',
    ogSiteName: SITE.name,
    ogTitle: title,
    ogDescription: description,
    ogImage: absoluteUrl(SITE.socialImages.openGraph.path),
    ogImageAlt: socialImageAlt,
    ogImageWidth: SITE.socialImages.openGraph.width,
    ogImageHeight: SITE.socialImages.openGraph.height,
    ogImageType: 'image/png',
    ogUrl: pageUrl,
    ogLocale: computed(() => locale.value === 'fr' ? 'fr_FR' : 'en_US'),
    twitterCard: 'summary',
    twitterTitle: title,
    twitterDescription: description,
    twitterImage: absoluteUrl(SITE.socialImages.twitter.path),
    twitterImageAlt: socialImageAlt,
  })

  useHead(() => ({
    htmlAttrs: {
      lang: locale.value,
    },
    link: [
      { rel: 'canonical', href: pageUrl.value },
      ...SUPPORTED_LOCALES.map(({ code, languageTag }) => ({
        rel: 'alternate' as const,
        hreflang: languageTag,
        href: absoluteUrl(localizedPath(code)),
      })),
      { rel: 'alternate', hreflang: 'x-default', href: defaultUrl },
    ],
    script: [
      {
        key: 'stopcorn-structured-data',
        type: 'application/ld+json',
        innerHTML: JSON.stringify({
          '@context': 'https://schema.org',
          '@graph': [
            {
              '@type': 'SoftwareApplication',
              '@id': `${SITE.url}/#application`,
              'name': SITE.name,
              'applicationCategory': 'LifestyleApplication',
              'operatingSystem': 'Android, iOS',
              'description': description.value,
              'image': absoluteUrl(SITE.socialImages.openGraph.path),
              'url': pageUrl.value,
              'isAccessibleForFree': true,
              'offers': {
                '@type': 'Offer',
                'price': '0',
                'priceCurrency': 'EUR',
              },
              'codeRepository': SITE.repositoryUrl,
              'inLanguage': locale.value,
            },
            {
              '@type': 'FAQPage',
              '@id': `${pageUrl.value}#faq`,
              'mainEntity': FAQ_ITEMS.map(id => ({
                '@type': 'Question',
                'name': t(`faq.items.${id}.question`),
                'acceptedAnswer': {
                  '@type': 'Answer',
                  'text': t(`faq.items.${id}.answer`),
                },
              })),
            },
          ],
        }),
      },
    ],
  }))
}
