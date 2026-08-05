<script setup lang="ts">
import { STORE_LINKS } from '~/constants/site'
</script>

<template>
  <div class="store-buttons">
    <template
      v-for="store in STORE_LINKS"
      :key="store.id"
    >
      <a
        v-if="store.url"
        class="store-button"
        :href="store.url"
        target="_blank"
        rel="noopener noreferrer"
      >
        <Icon :name="store.icon" />
        <span>
          <small>{{ $t(`stores.${store.id}.overline`) }}</small>
          <strong>{{ $t(`stores.${store.id}.name`) }}</strong>
        </span>
      </a>
      <span
        v-else
        class="store-button store-button--disabled"
        :aria-label="$t(`stores.${store.id}.comingSoonLabel`)"
      >
        <Icon :name="store.icon" />
        <span>
          <small>{{ $t('stores.comingSoon') }}</small>
          <strong>{{ $t(`stores.${store.id}.name`) }}</strong>
        </span>
      </span>
    </template>
  </div>
</template>

<style scoped lang="scss">
.store-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 0.85rem;
}

.store-button {
  display: inline-flex;
  min-width: 12.5rem;
  gap: 0.8rem;
  align-items: center;
  padding: 0.72rem 1rem;
  border: 1px solid var(--sc-foreground);
  border-radius: 0.9rem;
  background: var(--sc-foreground);
  color: var(--sc-white);
  text-decoration: none;

  > :deep(.iconify) {
    width: 1.75rem;
    height: 1.75rem;
  }

  span {
    display: grid;
    line-height: 1.2;
  }

  small {
    color: rgb(255 255 255 / 65%);
    font-size: 0.66rem;
    text-transform: uppercase;
  }

  strong {
    font-size: 1rem;
  }

  &--disabled {
    border-color: var(--sc-border);
    background: var(--sc-muted);
    color: var(--sc-muted-foreground);
    cursor: not-allowed;

    small {
      color: var(--sc-muted-foreground);
    }
  }
}

@media (max-width: 575.98px) {
  .store-buttons {
    display: grid;
  }

  .store-button {
    width: 100%;
  }
}
</style>
