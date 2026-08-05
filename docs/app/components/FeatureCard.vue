<script setup lang="ts">
defineProps<{
  icon: string
  title: string
  description: string
}>()
</script>

<template>
  <article class="feature-card tactile-card">
    <span class="feature-card__icon">
      <Icon :name="icon" />
    </span>
    <h3>{{ title }}</h3>
    <p>{{ description }}</p>
  </article>
</template>

<style scoped lang="scss">
.feature-card {
  width: 100%;
  padding: 1.75rem;
  transition: border-color 180ms ease, transform 180ms ease, box-shadow 180ms ease;

  &:hover {
    border-color: rgb(36 84 59 / 30%);
    box-shadow: var(--sc-shadow);
    transform: translateY(-4px);
  }

  &__icon {
    display: grid;
    width: 3rem;
    height: 3rem;
    margin-bottom: 1.35rem;
    place-items: center;
    border-radius: 0.9rem;
    background: var(--sc-secondary);
    box-shadow: 0 3px 0 var(--sc-secondary-deep);
    color: var(--sc-primary-deep);

    :deep(.iconify) {
      width: 1.45rem;
      height: 1.45rem;
    }
  }

  p {
    margin: 0;
    color: var(--sc-muted-foreground);
  }
}
</style>
