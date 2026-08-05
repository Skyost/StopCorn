<script setup lang="ts">
import { SITE } from '~/constants/site'

const { locale, localePath } = useSiteLocale()
</script>

<template>
  <NuxtLink
    :to="localePath(locale)"
    class="brand-logo"
    :aria-label="$t('brand.homeLabel')"
  >
    <span class="brand-logo__mark">
      <img
        :src="SITE.logoPath"
        alt=""
        width="28"
        height="35"
        aria-hidden="true"
      >
    </span>
    <span>{{ SITE.name }}</span>
  </NuxtLink>
</template>

<style scoped lang="scss">
.brand-logo {
  display: inline-flex;
  gap: 0.68rem;
  align-items: center;
  color: var(--sc-foreground);
  font-size: 1.28rem;
  font-weight: 700;
  letter-spacing: -0.025em;
  text-decoration: none;

  &:hover {
    color: var(--sc-primary);
  }

  &__mark {
    display: grid;
    width: 2.3rem;
    height: 2.6rem;
    place-items: center;
    border-radius: 0.75rem;
    background: var(--sc-secondary);
    box-shadow: 0 3px 0 var(--sc-secondary-deep);

    img {
      width: auto;
      height: 1.85rem;
    }
  }
}
</style>
