<template>
  <div class="site-shell">
    <a
      class="skip-link"
      href="#main-content"
    >
      {{ $t('accessibility.skipToContent') }}
    </a>
    <SiteHeader />
    <slot />
    <SiteFooter />
  </div>
</template>

<style scoped lang="scss">
.site-shell {
  min-height: 100vh;
}

.skip-link {
  position: fixed;
  z-index: 1100;
  top: 0.75rem;
  left: 0.75rem;
  padding: 0.75rem 1rem;
  border-radius: 0.75rem;
  background: var(--sc-primary);
  color: var(--sc-white);
  font-weight: 700;
  opacity: 0;
  transform: translateY(-150%);
  transition: opacity 150ms ease, transform 150ms ease;

  &:focus {
    color: var(--sc-white);
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
