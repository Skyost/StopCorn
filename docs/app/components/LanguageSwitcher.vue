<script setup lang="ts">
const {
  availableLocales,
  locale,
  switchLocale,
} = useSiteLocale()

const currentLocaleShortLabel = computed(() => (
  availableLocales.find(availableLocale => availableLocale.code === locale.value)?.shortLabel
  ?? locale.value.toUpperCase()
))

async function onLocaleChange(event: Event) {
  const selectedCode = (event.target as HTMLSelectElement).value
  const selectedLocale = availableLocales.find(({ code }) => code === selectedCode)

  if (selectedLocale && selectedLocale.code !== locale.value) {
    await switchLocale(selectedLocale.code)
  }
}
</script>

<template>
  <div class="language-switcher">
    <div class="language-switcher__compact">
      <select
        class="language-switcher__select"
        :value="locale"
        :aria-label="$t('language.label')"
        @change="onLocaleChange"
      >
        <option
          v-for="availableLocale in availableLocales"
          :key="availableLocale.code"
          :value="availableLocale.code"
          :lang="availableLocale.code"
        >
          {{ availableLocale.label }}
        </option>
      </select>

      <span
        class="language-switcher__compact-content"
        aria-hidden="true"
      >
        <Icon name="lucide:languages" />
        <span>{{ currentLocaleShortLabel }}</span>
        <Icon
          class="language-switcher__chevron"
          name="lucide:chevron-down"
        />
      </span>
    </div>

    <div
      class="language-switcher__buttons"
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
  </div>
</template>

<style scoped lang="scss">
.language-switcher {
  &__compact {
    position: relative;
  }

  &__compact-content {
    display: flex;
    height: var(--sc-header-control-height, 2.55rem);
    gap: 0.32rem;
    align-items: center;
    padding: 0.38rem 0.52rem;
    border: 1px solid var(--sc-border);
    border-radius: 0.75rem;
    background: var(--sc-muted);
    color: var(--sc-muted-foreground);
    font-size: 0.72rem;
    font-weight: 700;
    line-height: 1;

    :deep(.iconify) {
      width: 1rem;
      height: 1rem;
    }

    :deep(.language-switcher__chevron) {
      width: 0.78rem;
      height: 0.78rem;
    }
  }

  &__select {
    position: absolute;
    z-index: 1;
    inset: 0;
    width: 100%;
    height: 100%;
    cursor: pointer;
    opacity: 0;

    &:hover + .language-switcher__compact-content {
      border-color: var(--sc-primary);
    }

    &:focus-visible + .language-switcher__compact-content {
      outline: 3px solid rgb(36 84 59 / 35%);
      outline-offset: 3px;
    }
  }

  &__buttons {
    display: none;
    flex-wrap: wrap;
    justify-content: center;
    padding: 0.2rem;
    border: 1px solid var(--sc-border);
    border-radius: 0.72rem;
    background: var(--sc-muted);
  }

  &__button {
    min-width: 2.05rem;
    padding: 0.34rem 0.38rem;
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

@media (max-width: 991.98px) {
  .language-switcher {
    &__compact {
      display: none;
    }

    &__buttons {
      display: flex;
    }
  }
}
</style>
