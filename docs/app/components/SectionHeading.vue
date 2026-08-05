<script setup lang="ts">
withDefaults(defineProps<{
  eyebrow: string
  title: string
  description?: string
  centered?: boolean
}>(), {
  description: undefined,
  centered: false,
})
</script>

<template>
  <div
    class="section-heading"
    :class="{ 'section-heading--centered': centered }"
  >
    <p class="eyebrow">
      {{ eyebrow }}
    </p>
    <h2>{{ title }}</h2>
    <p
      v-if="description"
      class="section-heading__description"
    >
      {{ description }}
    </p>
  </div>
</template>

<style scoped lang="scss">
.section-heading {
  max-width: 47rem;
  margin-bottom: clamp(2.5rem, 5vw, 4rem);

  h2 {
    margin: 0;
  }

  &__description {
    max-width: 43rem;
    margin: 1.25rem 0 0;
    color: var(--sc-muted-foreground);
    font-size: 1.1rem;
  }

  &--centered {
    margin-inline: auto;
    text-align: center;

    .section-heading__description {
      margin-inline: auto;
    }
  }
}
</style>
