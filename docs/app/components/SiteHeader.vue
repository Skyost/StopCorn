<script setup lang="ts">
import {
  NAV_ITEMS,
  SECTION_IDS,
  SITE,
} from '~/constants/site'

const isMenuOpen = ref(false)
const { locale, localePath } = useSiteLocale()

function closeMenu() {
  isMenuOpen.value = false
}
</script>

<template>
  <header class="site-header">
    <BContainer class="site-header__inner">
      <BrandLogo class="site-header__brand" />

      <button
        class="site-header__toggle"
        type="button"
        :aria-expanded="isMenuOpen"
        aria-controls="primary-navigation"
        :aria-label="$t(isMenuOpen ? 'navigation.close' : 'navigation.open')"
        @click="isMenuOpen = !isMenuOpen"
      >
        <Icon :name="isMenuOpen ? 'lucide:x' : 'lucide:menu'" />
      </button>

      <div
        id="primary-navigation"
        class="site-header__panel"
        :class="{ 'is-open': isMenuOpen }"
      >
        <nav
          class="site-header__navigation"
          :aria-label="$t('navigation.label')"
        >
          <ul class="site-header__nav">
            <li
              v-for="item in NAV_ITEMS"
              :key="item.id"
            >
              <NuxtLink
                :to="localePath(locale, item.id)"
                @click="closeMenu"
              >
                {{ $t(item.translationKey) }}
              </NuxtLink>
            </li>
          </ul>
        </nav>

        <div class="site-header__actions">
          <LanguageSwitcher />
          <BButton
            :to="localePath(locale, SECTION_IDS.download)"
            variant="primary"
            class="button-soft button-soft--small"
            @click="closeMenu"
          >
            {{ $t('navigation.download') }}
          </BButton>
          <a
            class="site-header__source"
            :href="SITE.repositoryUrl"
            target="_blank"
            rel="noopener noreferrer"
            :aria-label="$t('navigation.sourceLabel')"
          >
            <Icon name="lucide:github" />
          </a>
        </div>
      </div>
    </BContainer>
  </header>
</template>

<style scoped lang="scss">
.site-header {
  --sc-header-control-height: 2.55rem;

  position: sticky;
  z-index: 1000;
  top: 0;
  height: var(--sc-header-height);
  border-bottom: 1px solid rgb(227 218 200 / 75%);
  background: rgb(255 252 242 / 89%);
  backdrop-filter: blur(16px);

  &__inner {
    display: grid;
    grid-template-columns: minmax(0, 1fr) auto minmax(0, 1fr);
    min-height: 100%;
    align-items: center;
  }

  &__actions,
  &__nav {
    display: flex;
    align-items: center;
  }

  &__panel {
    display: contents;
  }

  &__brand {
    justify-self: start;
  }

  &__navigation {
    justify-self: center;
  }

  &__nav {
    gap: clamp(0.85rem, 2vw, 1.5rem);
    margin: 0;
    padding: 0;
    list-style: none;

    a {
      color: var(--sc-foreground);
      font-size: 0.91rem;
      font-weight: 600;
      text-decoration: none;

      &:hover {
        color: var(--sc-primary);
      }
    }
  }

  &__actions {
    gap: 0.75rem;
    justify-self: end;
  }

  &__source,
  &__toggle {
    display: grid;
    width: var(--sc-header-control-height);
    height: var(--sc-header-control-height);
    place-items: center;
    border: 1px solid var(--sc-border);
    border-radius: 0.75rem;
    background: var(--sc-card);
    color: var(--sc-foreground);
    text-decoration: none;

    :deep(.iconify) {
      width: 1.25rem;
      height: 1.25rem;
    }
  }

  &__toggle {
    display: none;
    cursor: pointer;
  }

  :deep(.button-soft--small.btn) {
    height: var(--sc-header-control-height);
    padding: 0 0.92rem;
    border-radius: 0.75rem;
    box-shadow: none;
    font-size: 0.9rem;
    transform: none;
  }
}

@media (max-width: 991.98px) {
  .site-header {
    &__inner {
      display: flex;
      justify-content: space-between;
    }

    &__toggle {
      display: grid;
    }

    &__panel {
      position: absolute;
      top: calc(100% + 0.5rem);
      right: 0.75rem;
      left: 0.75rem;
      display: none;
      align-items: stretch;
      padding: 1rem;
      border: 1px solid var(--sc-border);
      border-radius: 1.25rem;
      background: var(--sc-card);
      box-shadow: var(--sc-shadow);

      &.is-open {
        display: grid;
      }
    }

    &__nav {
      display: grid;
      gap: 0;

      a {
        display: block;
        padding: 0.75rem;
        border-radius: 0.7rem;

        &:hover {
          background: var(--sc-muted);
        }
      }
    }

    &__navigation {
      justify-self: stretch;
    }

    &__actions {
      flex-wrap: wrap;
      justify-content: space-between;
      justify-self: auto;
      padding-top: 0.8rem;
      border-top: 1px solid var(--sc-border);
    }
  }
}
</style>
