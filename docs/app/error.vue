<script setup lang="ts">
import type { NuxtError } from '#app'
import { useI18n } from 'vue-i18n'

import {
  DEFAULT_LOCALE,
  localeFromPath,
} from '~/constants/site'

const props = defineProps<{
  error: NuxtError
}>()

const route = useRoute()
const { localePath, setLocale } = useSiteLocale()
const { t } = useI18n({ useScope: 'global' })
const currentLocale = localeFromPath(route.path) ?? DEFAULT_LOCALE
const isNotFound = computed(() => props.error.statusCode === 404)

setLocale(currentLocale, false)
useSeoMeta({
  title: computed(() => t(isNotFound.value ? 'error.notFoundTitle' : 'error.genericTitle')),
  robots: 'noindex, nofollow',
})

async function returnHome() {
  await clearError({ redirect: localePath(currentLocale) })
}
</script>

<template>
  <BApp>
    <div class="error-page">
      <BContainer>
        <BrandLogo />
        <div class="error-page__card tactile-card">
          <span class="error-page__code">{{ error.statusCode }}</span>
          <p class="eyebrow">
            {{ $t('error.eyebrow') }}
          </p>
          <h1>
            {{ $t(isNotFound ? 'error.notFoundTitle' : 'error.genericTitle') }}
          </h1>
          <p>
            {{ $t(isNotFound ? 'error.notFoundDescription' : 'error.genericDescription') }}
          </p>
          <BButton
            variant="primary"
            class="button-soft"
            @click="returnHome"
          >
            <Icon name="lucide:arrow-left" />
            {{ $t('error.backHome') }}
          </BButton>
        </div>
      </BContainer>
    </div>
  </BApp>
</template>

<style scoped lang="scss">
.error-page {
  display: grid;
  min-height: 100vh;
  place-items: center;
  padding: 2rem 0;
  background:
    radial-gradient(circle at 80% 15%, rgb(244 217 120 / 40%), transparent 25rem),
    var(--sc-background);

  :deep(.brand-logo) {
    margin-bottom: 2rem;
  }

  &__card {
    position: relative;
    max-width: 43rem;
    overflow: hidden;
    padding: clamp(2rem, 6vw, 4rem);

    h1 {
      margin-bottom: 1rem;
      font-size: clamp(2.5rem, 7vw, 4.5rem);
      line-height: 1;
    }

    > p:not(.eyebrow) {
      max-width: 34rem;
      margin-bottom: 1.75rem;
      color: var(--sc-muted-foreground);
      font-size: 1.08rem;
    }
  }

  &__code {
    position: absolute;
    top: -2.5rem;
    right: -0.5rem;
    color: rgb(36 84 59 / 6%);
    font-family: 'DM Serif Display', Georgia, serif;
    font-size: 11rem;
    line-height: 1;
    pointer-events: none;
  }
}
</style>
