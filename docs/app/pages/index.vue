<script setup lang="ts">
import { DEFAULT_LOCALE } from '~/constants/site'

definePageMeta({
  layout: false,
})

const route = useRoute()
const {
  detectPreferredLocale,
  localePath,
  setLocale,
} = useSiteLocale()

setLocale(DEFAULT_LOCALE, false)
usePageHead({ locale: DEFAULT_LOCALE, noIndex: true })

onMounted(async () => {
  const preferredLocale = detectPreferredLocale()
  setLocale(preferredLocale)
  await navigateTo({
    path: localePath(preferredLocale),
    hash: route.hash,
  }, { replace: true })
})
</script>

<template>
  <div aria-hidden="true" />
</template>
