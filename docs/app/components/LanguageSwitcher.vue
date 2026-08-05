<script setup lang="ts">
const {
  availableLocales,
  locale,
  switchLocale,
} = useSiteLocale()
</script>

<template>
  <div
    class="language-switcher"
    role="group"
    :aria-label="$t('language.label')"
  >
    <button
      v-for="availableLocale in availableLocales"
      :key="availableLocale.code"
      type="button"
      class="language-switcher__button"
      :class="{ 'is-active': availableLocale.code === locale }"
      :aria-pressed="availableLocale.code === locale"
      :lang="availableLocale.code"
      :title="availableLocale.label"
      @click="switchLocale(availableLocale.code)"
    >
      {{ availableLocale.shortLabel }}
    </button>
  </div>
</template>

<style scoped lang="scss">
.language-switcher {
  display: flex;
  padding: 0.2rem;
  border: 1px solid var(--sc-border);
  border-radius: 0.72rem;
  background: var(--sc-muted);

  &__button {
    min-width: 2.2rem;
    padding: 0.34rem 0.45rem;
    border: 0;
    border-radius: 0.5rem;
    background: transparent;
    color: var(--sc-muted-foreground);
    font-size: 0.72rem;
    font-weight: 700;

    &.is-active {
      background: var(--sc-card);
      box-shadow: 0 2px 7px rgb(36 84 59 / 9%);
      color: var(--sc-primary);
    }
  }
}
</style>
