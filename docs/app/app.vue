<script setup lang="ts">
const { locale } = useSiteLocale()

useHead(() => ({
  htmlAttrs: { lang: locale.value },
}))
</script>

<template>
  <BApp>
    <NuxtRouteAnnouncer />
    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </BApp>
</template>
