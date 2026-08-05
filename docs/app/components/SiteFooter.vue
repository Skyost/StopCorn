<script setup lang="ts">
import {
  SECTION_IDS,
  SITE,
} from '~/constants/site'

const { locale, localePath } = useSiteLocale()
const currentYear = new Date().getFullYear()
</script>

<template>
  <footer class="site-footer">
    <BContainer>
      <div class="site-footer__top">
        <div>
          <BrandLogo />
          <p>{{ $t('footer.tagline') }}</p>
        </div>
        <nav :aria-label="$t('footer.legalNavigation')">
          <ul class="site-footer__links">
            <li>
              <NuxtLink :to="localePath(locale, SECTION_IDS.privacy)">
                {{ $t('navigation.privacy') }}
              </NuxtLink>
            </li>
            <li>
              <NuxtLink :to="localePath(locale, SECTION_IDS.terms)">
                {{ $t('navigation.terms') }}
              </NuxtLink>
            </li>
            <li>
              <a
                :href="SITE.repositoryUrl"
                target="_blank"
                rel="noopener noreferrer"
              >
                {{ $t('navigation.source') }}
              </a>
            </li>
            <li>
              <a
                :href="SITE.issuesUrl"
                target="_blank"
                rel="noopener noreferrer"
              >
                {{ $t('navigation.contact') }}
              </a>
            </li>
          </ul>
        </nav>
      </div>
      <div class="site-footer__bottom">
        <p>
          {{ $t('footer.copyright', { year: currentYear }) }}
        </p>
        <p>{{ $t('footer.disclaimer') }}</p>
      </div>
    </BContainer>
  </footer>
</template>

<style scoped lang="scss">
.site-footer {
  padding: 4rem 0 2rem;
  background: var(--sc-foreground);
  color: rgb(255 255 255 / 66%);

  :deep(.brand-logo) {
    color: var(--sc-white);
  }

  &__top {
    display: flex;
    gap: 2rem;
    align-items: flex-start;
    justify-content: space-between;

    p {
      max-width: 25rem;
      margin: 1rem 0 0;
    }
  }

  &__links {
    display: grid;
    grid-template-columns: repeat(2, minmax(8rem, 1fr));
    gap: 0.55rem 2rem;
    margin: 0;
    padding: 0;
    list-style: none;

    a {
      color: rgb(255 255 255 / 78%);
      font-size: 0.9rem;
      font-weight: 600;
      text-decoration: none;

      &:hover {
        color: var(--sc-secondary);
      }
    }
  }

  &__bottom {
    display: flex;
    gap: 1.5rem;
    justify-content: space-between;
    margin-top: 3rem;
    padding-top: 1.5rem;
    border-top: 1px solid rgb(255 255 255 / 12%);
    font-size: 0.78rem;

    p {
      margin: 0;
    }
  }
}

@media (max-width: 767.98px) {
  .site-footer {
    &__top,
    &__bottom {
      display: grid;
    }

    &__links {
      margin-top: 1rem;
    }
  }
}

@media (max-width: 575.98px) {
  .site-footer__links {
    grid-template-columns: 1fr;
  }
}
</style>
