<script setup lang="ts">
import { useI18n } from 'vue-i18n'

import {
  APP_SCREENSHOTS,
  SCREENSHOT_CAROUSEL,
  appScreenshotPath,
  type SiteLocale,
} from '~/constants/site'

interface CarouselController {
  pause: () => void
  resume: () => void
}

const props = defineProps<{
  locale: SiteLocale
}>()

const { t } = useI18n({ useScope: 'global' })
const carousel = ref<CarouselController | null>(null)
const activeSlide = ref(0)
const isPaused = ref(false)
let motionPreference: MediaQueryList | undefined

const screenshots = computed(() => APP_SCREENSHOTS.map(item => ({
  ...item,
  alt: t(`preview.slides.${item.id}`),
  src: appScreenshotPath(props.locale, item.fileName),
})))

function applyPlaybackState() {
  void nextTick(() => {
    if (isPaused.value) {
      carousel.value?.pause()
    }
    else {
      carousel.value?.resume()
    }
  })
}

function togglePlayback() {
  isPaused.value = !isPaused.value
  applyPlaybackState()
}

function updateMotionPreference(event: MediaQueryListEvent) {
  isPaused.value = event.matches
  applyPlaybackState()
}

watch(() => props.locale, () => {
  activeSlide.value = 0
})

onMounted(() => {
  motionPreference = window.matchMedia('(prefers-reduced-motion: reduce)')
  isPaused.value = motionPreference.matches
  motionPreference.addEventListener('change', updateMotionPreference)
  applyPlaybackState()
})

onBeforeUnmount(() => {
  motionPreference?.removeEventListener('change', updateMotionPreference)
})
</script>

<template>
  <section
    class="phone-preview"
    :aria-label="t('preview.accessibleLabel')"
  >
    <div class="phone-preview__frame">
      <BCarousel
        id="stopcorn-screenshot-carousel"
        ref="carousel"
        v-model="activeSlide"
        class="phone-preview__carousel"
        controls
        indicators
        ride="carousel"
        :controls-next-text="t('preview.next')"
        :controls-prev-text="t('preview.previous')"
        :img-height="`${SCREENSHOT_CAROUSEL.imageHeight}`"
        :img-width="`${SCREENSHOT_CAROUSEL.imageWidth}`"
        :indicators-button-label="t('preview.screenshotLabel')"
        :interval="SCREENSHOT_CAROUSEL.interval"
        :label-indicators="t('preview.selectScreenshot')"
      >
        <BCarouselSlide
          v-for="(screenshot, index) in screenshots"
          :key="screenshot.id"
        >
          <template #img>
            <img
              class="phone-preview__image"
              :src="screenshot.src"
              :alt="screenshot.alt"
              :width="SCREENSHOT_CAROUSEL.imageWidth"
              :height="SCREENSHOT_CAROUSEL.imageHeight"
              :fetchpriority="index === 0 ? 'high' : 'auto'"
              :loading="index === 0 ? 'eager' : 'lazy'"
              decoding="async"
              draggable="false"
            >
          </template>
        </BCarouselSlide>
      </BCarousel>
    </div>

    <button
      type="button"
      class="phone-preview__toggle"
      :aria-label="t(isPaused ? 'preview.resume' : 'preview.pause')"
      @click="togglePlayback"
    >
      <Icon :name="isPaused ? 'lucide:play' : 'lucide:pause'" />
      <span>{{ t(isPaused ? 'preview.resume' : 'preview.pause') }}</span>
    </button>
  </section>
</template>

<style scoped lang="scss">
.phone-preview {
  position: relative;
  width: min(100%, 21rem);
  margin-inline: auto;
  text-align: center;

  &::before,
  &::after {
    position: absolute;
    z-index: -1;
    border-radius: 50%;
    content: '';
  }

  &::before {
    top: 9%;
    right: -17%;
    width: 7rem;
    height: 7rem;
    background: var(--sc-primary);
  }

  &::after {
    bottom: 12%;
    left: -15%;
    width: 5rem;
    height: 5rem;
    background: var(--sc-secondary-deep);
  }

  &__frame {
    overflow: hidden;
    border: 2px solid #26322b;
    border-radius: 2.25rem;
    background: #172019;
    box-shadow: 0 2.2rem 4rem rgb(23 32 25 / 25%);
    transform: rotate(1.5deg);
  }

  &__carousel {
    background: var(--sc-background);

    :deep(.carousel-control-prev),
    :deep(.carousel-control-next) {
      top: 50%;
      bottom: auto;
      width: 2.75rem;
      height: 2.75rem;
      margin-inline: 0.65rem;
      border: 1px solid rgb(255 255 255 / 60%);
      border-radius: 50%;
      background: rgb(36 84 59 / 88%);
      opacity: 1;
      transform: translateY(-50%);

      &:focus-visible {
        outline: 3px solid var(--sc-secondary);
        outline-offset: 2px;
      }
    }

    :deep(.carousel-control-prev-icon),
    :deep(.carousel-control-next-icon) {
      width: 1.1rem;
      height: 1.1rem;
    }

    :deep(.carousel-indicators) {
      gap: 0.35rem;
      margin-bottom: 0.75rem;

      [data-bs-target] {
        width: 0.55rem;
        height: 0.55rem;
        margin: 0;
        border: 0;
        border-radius: 50%;
        background-color: var(--sc-primary);
        box-shadow: 0 0 0 1px rgb(255 255 255 / 65%);
        opacity: 0.48;
        transition:
          opacity 160ms ease,
          transform 160ms ease;
      }

      .active {
        opacity: 1;
        transform: scale(1.18);
      }
    }
  }

  &__image {
    display: block;
    width: 100%;
    height: auto;
    user-select: none;
  }

  &__toggle {
    margin-top: 2.5rem;
    display: inline-flex;
    gap: 0.4rem;
    align-items: center;
    font-size: 0.75rem;
    font-weight: 700;

    :deep(.iconify) {
      flex: 0 0 auto;
      width: 1rem;
      height: 1rem;
    }
  }

  &__label {
    color: var(--sc-muted-foreground);
  }

  &__toggle {
    padding: 0.42rem 0.65rem;
    border: 1px solid transparent;
    border-radius: 999px;
    background: var(--sc-primary-soft);
    color: var(--sc-primary);
    cursor: pointer;
    transition:
      background-color 160ms ease,
      border-color 160ms ease;

    &:hover {
      border-color: var(--sc-primary);
      background: var(--sc-card);
    }

    &:focus-visible {
      outline: 3px solid var(--sc-secondary);
      outline-offset: 2px;
    }
  }
}

@media (max-width: 575.98px) {
  .phone-preview {
    width: min(calc(100% - 1.5rem), 21rem);

    &__toggle {
      justify-content: center;
    }
  }
}

@media (prefers-reduced-motion: reduce) {
  .phone-preview__carousel :deep(.carousel-item) {
    transition: none;
  }
}
</style>
