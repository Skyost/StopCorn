<script setup lang="ts">
import { useI18n } from 'vue-i18n'

import {
  EXTERNAL_PRIVACY_LINKS,
  FAQ_ITEMS,
  FEATURE_ITEMS,
  FUTURE_LINKS,
  HERO_TRUST_ITEMS,
  PRIVACY_PROMISE_ITEMS,
  PRIVACY_SECTIONS,
  REASON_ITEMS,
  SECTION_IDS,
  SITE,
  STEP_ITEMS,
  TERMS_SECTIONS,
  SUPPORTED_LOCALES,
  isSupportedLocale,
  type SiteLocale,
} from '~/constants/site'

definePageMeta({
  validate: route => isSupportedLocale(route.params.locale),
})

const route = useRoute()
const { t } = useI18n({ useScope: 'global' })
const { localePath, setLocale } = useSiteLocale()
const currentLocale = computed(() => route.params.locale as SiteLocale)
const localeMetadata = computed(() => (
  SUPPORTED_LOCALES.find(({ code }) => code === currentLocale.value)
  ?? SUPPORTED_LOCALES[0]
))
const legalUpdatedAt = computed(() => new Intl.DateTimeFormat(
  localeMetadata.value.languageTag,
  { dateStyle: 'long', timeZone: 'UTC' },
).format(new Date(`${SITE.legalUpdatedAt}T00:00:00Z`)))

setLocale(currentLocale.value, false)
watch(currentLocale, value => setLocale(value, false))
usePageHead({ locale: currentLocale })
</script>

<template>
  <main :id="SECTION_IDS.main">
    <section class="hero-section">
      <div class="hero-section__shape hero-section__shape--one" />
      <div class="hero-section__shape hero-section__shape--two" />
      <BContainer class="position-relative">
        <BRow class="align-items-center gy-5">
          <BCol
            lg="7"
            xl="6"
          >
            <div class="hero-section__copy">
              <div class="hero-section__badge">
                <Icon name="lucide:sprout" />
                {{ t('hero.badge') }}
              </div>
              <h1>
                {{ t('hero.title') }}
                <span>{{ t('hero.titleHighlight') }}</span>
              </h1>
              <p class="hero-section__lead">
                {{ t('hero.description') }}
              </p>
              <div class="hero-section__actions">
                <BButton
                  :to="localePath(currentLocale, SECTION_IDS.download)"
                  variant="primary"
                  size="lg"
                  class="button-soft"
                >
                  {{ t('hero.primaryAction') }}
                  <Icon name="lucide:arrow-down" />
                </BButton>
                <BButton
                  :href="SITE.repositoryUrl"
                  target="_blank"
                  rel="noopener noreferrer"
                  variant="outline-primary"
                  size="lg"
                  class="button-soft button-soft--outline"
                >
                  <Icon name="lucide:github" />
                  {{ t('hero.secondaryAction') }}
                </BButton>
              </div>
              <ul class="hero-section__trust">
                <li
                  v-for="item in HERO_TRUST_ITEMS"
                  :key="item.id"
                >
                  <Icon :name="item.icon" />
                  {{ t(`hero.trust.${item.id}`) }}
                </li>
              </ul>
            </div>
          </BCol>
          <BCol
            lg="5"
            xl="6"
          >
            <PhonePreview :locale="currentLocale" />
          </BCol>
        </BRow>
      </BContainer>
    </section>

    <section
      :id="SECTION_IDS.mission"
      class="content-section mission-section"
    >
      <BContainer>
        <BRow class="gy-5 align-items-end">
          <BCol lg="6">
            <SectionHeading
              :eyebrow="t('mission.eyebrow')"
              :title="t('mission.title')"
              :description="t('mission.description')"
            />
          </BCol>
          <BCol lg="6">
            <blockquote class="mission-section__quote">
              <Icon name="lucide:quote" />
              <p>{{ t('mission.quote') }}</p>
            </blockquote>
          </BCol>
        </BRow>

        <BRow class="g-4 mission-section__reasons">
          <BCol
            v-for="reason in REASON_ITEMS"
            :key="reason.id"
            md="4"
          >
            <article class="reason-card tactile-card">
              <Icon :name="reason.icon" />
              <h3>{{ t(`mission.reasons.${reason.id}.title`) }}</h3>
              <p>{{ t(`mission.reasons.${reason.id}.description`) }}</p>
            </article>
          </BCol>
        </BRow>
      </BContainer>
    </section>

    <section
      :id="SECTION_IDS.features"
      class="content-section content-section--tinted"
    >
      <BContainer>
        <SectionHeading
          centered
          :eyebrow="t('features.eyebrow')"
          :title="t('features.title')"
          :description="t('features.description')"
        />
        <BRow class="g-4 feature-grid">
          <BCol
            v-for="feature in FEATURE_ITEMS"
            :key="feature.id"
            md="6"
            xl="4"
          >
            <FeatureCard
              :icon="feature.icon"
              :title="t(`features.items.${feature.id}.title`)"
              :description="t(`features.items.${feature.id}.description`)"
            />
          </BCol>
        </BRow>
      </BContainer>
    </section>

    <section
      :id="SECTION_IDS.howItWorks"
      class="content-section steps-section"
    >
      <BContainer>
        <SectionHeading
          :eyebrow="t('howItWorks.eyebrow')"
          :title="t('howItWorks.title')"
          :description="t('howItWorks.description')"
        />
        <ol class="steps-list">
          <li
            v-for="(step, index) in STEP_ITEMS"
            :key="step.id"
          >
            <div class="steps-list__number">
              {{ index + 1 }}
            </div>
            <span class="steps-list__icon">
              <Icon :name="step.icon" />
            </span>
            <div>
              <h3>{{ t(`howItWorks.steps.${step.id}.title`) }}</h3>
              <p>{{ t(`howItWorks.steps.${step.id}.description`) }}</p>
            </div>
          </li>
        </ol>
        <p class="steps-section__note">
          <Icon name="lucide:info" />
          {{ t('howItWorks.note') }}
        </p>
      </BContainer>
    </section>

    <section
      :id="SECTION_IDS.privacy"
      class="content-section privacy-section"
    >
      <BContainer>
        <div class="privacy-section__intro">
          <SectionHeading
            :eyebrow="t('privacy.eyebrow')"
            :title="t('privacy.title')"
            :description="t('privacy.description')"
          />
          <span class="privacy-section__seal">
            <Icon name="lucide:shield-check" />
          </span>
        </div>

        <BRow class="g-4 privacy-section__promises">
          <BCol
            v-for="promise in PRIVACY_PROMISE_ITEMS"
            :key="promise.id"
            md="4"
          >
            <article>
              <Icon :name="promise.icon" />
              <h3>{{ t(`privacy.promises.${promise.id}.title`) }}</h3>
              <p>{{ t(`privacy.promises.${promise.id}.description`) }}</p>
            </article>
          </BCol>
        </BRow>

        <details class="legal-document">
          <summary class="legal-document__summary">
            <span>
              {{ t('privacy.policyEyebrow') }}
              <strong>{{ t('privacy.policyTitle') }}</strong>
            </span>
            <span>
              {{ t('legal.lastUpdated', { date: legalUpdatedAt }) }}
              <Icon name="lucide:plus" />
            </span>
          </summary>
          <div class="legal-document__content">
            <p class="legal-document__lead">
              {{ t('privacy.policyLead') }}
            </p>
            <div class="legal-document__grid">
              <article
                v-for="policySection in PRIVACY_SECTIONS"
                :key="policySection"
              >
                <h3>{{ t(`privacy.sections.${policySection}.title`) }}</h3>
                <p>{{ t(`privacy.sections.${policySection}.body`) }}</p>
              </article>
            </div>
            <div class="legal-document__external">
              <p>{{ t('privacy.externalPolicies') }}</p>
              <ul>
                <li
                  v-for="externalLink in EXTERNAL_PRIVACY_LINKS"
                  :key="externalLink.id"
                >
                  <a
                    :href="externalLink.url"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    {{ t(`privacy.externalLinks.${externalLink.id}`) }}
                    <Icon name="lucide:external-link" />
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </details>
      </BContainer>
    </section>

    <section
      :id="SECTION_IDS.support"
      class="content-section support-section"
    >
      <BContainer>
        <div class="support-card">
          <div
            class="support-card__art"
            aria-hidden="true"
          >
            <Icon name="lucide:heart" />
            <img
              :src="SITE.logoPath"
              alt=""
              width="92"
              height="114"
            >
          </div>
          <div class="support-card__copy">
            <p class="eyebrow">
              {{ t('support.eyebrow') }}
            </p>
            <h2>{{ t('support.title') }}</h2>
            <p>{{ t('support.description') }}</p>
            <div class="support-card__actions">
              <BButton
                :href="SITE.repositoryUrl"
                target="_blank"
                rel="noopener noreferrer"
                variant="primary"
                class="button-soft"
              >
                <Icon name="lucide:github" />
                {{ t('support.sourceAction') }}
              </BButton>
              <span class="support-card__paywall">
                <Icon name="lucide:heart-handshake" />
                {{ t('support.paywallAction') }}
              </span>
            </div>
          </div>
        </div>
      </BContainer>
    </section>

    <section
      :id="SECTION_IDS.download"
      class="content-section download-section"
    >
      <BContainer>
        <BRow class="gy-5 align-items-center">
          <BCol lg="7">
            <SectionHeading
              :eyebrow="t('download.eyebrow')"
              :title="t('download.title')"
              :description="t('download.description')"
            />
            <StoreButtons />
          </BCol>
          <BCol lg="5">
            <div class="merch-card tactile-card">
              <span class="merch-card__icon">
                <Icon name="lucide:shirt" />
              </span>
              <div>
                <span class="coming-soon-pill">{{ t('download.merch.badge') }}</span>
                <h3>{{ t('download.merch.title') }}</h3>
                <p>{{ t('download.merch.description') }}</p>
                <a
                  v-if="FUTURE_LINKS.merchUrl"
                  :href="FUTURE_LINKS.merchUrl"
                >
                  {{ t('download.merch.action') }}
                </a>
                <span
                  v-else
                  class="merch-card__disabled"
                >
                  {{ t('download.merch.unavailable') }}
                </span>
              </div>
            </div>
          </BCol>
        </BRow>
      </BContainer>
    </section>

    <section
      :id="SECTION_IDS.faq"
      class="content-section content-section--tinted faq-section"
    >
      <BContainer>
        <SectionHeading
          centered
          :eyebrow="t('faq.eyebrow')"
          :title="t('faq.title')"
          :description="t('faq.description')"
        />
        <div class="faq-list">
          <details
            v-for="faqItem in FAQ_ITEMS"
            :key="faqItem"
          >
            <summary>
              {{ t(`faq.items.${faqItem}.question`) }}
              <Icon name="lucide:plus" />
            </summary>
            <p>{{ t(`faq.items.${faqItem}.answer`) }}</p>
          </details>
        </div>
      </BContainer>
    </section>

    <section
      :id="SECTION_IDS.terms"
      class="content-section terms-section"
    >
      <BContainer>
        <div class="legal-document legal-document--plain">
          <div class="legal-document__heading">
            <div>
              <p class="eyebrow">
                {{ t('terms.eyebrow') }}
              </p>
              <h2>{{ t('terms.title') }}</h2>
            </div>
            <p>{{ t('legal.lastUpdated', { date: legalUpdatedAt }) }}</p>
          </div>
          <p class="legal-document__lead">
            {{ t('terms.lead') }}
          </p>
          <div class="legal-document__grid">
            <article
              v-for="termsSection in TERMS_SECTIONS"
              :key="termsSection"
            >
              <h3>{{ t(`terms.sections.${termsSection}.title`) }}</h3>
              <p>{{ t(`terms.sections.${termsSection}.body`) }}</p>
            </article>
          </div>
          <p class="legal-document__contact">
            {{ t('terms.contact') }}
            <a
              :href="SITE.issuesUrl"
              target="_blank"
              rel="noopener noreferrer"
            >
              {{ t('terms.contactAction') }}
              <Icon name="lucide:external-link" />
            </a>
          </p>
        </div>
      </BContainer>
    </section>
  </main>
</template>

<style scoped lang="scss">
.content-section {
  position: relative;
  padding: var(--sc-section-space) 0;

  &--tinted {
    border-block: 1px solid rgb(227 218 200 / 68%);
    background:
      radial-gradient(circle at 8% 4%, rgb(244 217 120 / 23%), transparent 25rem),
      var(--sc-muted);
  }
}

.hero-section {
  position: relative;
  display: flex;
  min-height: min(52rem, calc(100vh - var(--sc-header-height)));
  align-items: center;
  overflow: hidden;
  padding: clamp(4rem, 9vw, 7rem) 0;
  isolation: isolate;

  &::before {
    position: absolute;
    z-index: -2;
    inset: 0;
    background-image: radial-gradient(rgb(36 84 59 / 8%) 1px, transparent 1px);
    background-size: 22px 22px;
    content: '';
    mask-image: linear-gradient(to right, black, transparent 72%);
  }

  &__shape {
    position: absolute;
    z-index: -1;
    border-radius: 46% 54% 61% 39% / 48% 39% 61% 52%;
    filter: blur(1px);

    &--one {
      top: 8%;
      right: -6rem;
      width: clamp(22rem, 44vw, 43rem);
      aspect-ratio: 1;
      background: rgb(244 217 120 / 45%);
      transform: rotate(12deg);
    }

    &--two {
      bottom: -16rem;
      left: -13rem;
      width: 30rem;
      aspect-ratio: 1;
      background: rgb(52 115 81 / 10%);
    }
  }

  &__badge {
    display: inline-flex;
    gap: 0.5rem;
    align-items: center;
    margin-bottom: 1.5rem;
    padding: 0.48rem 0.78rem;
    border: 1px solid rgb(36 84 59 / 16%);
    border-radius: 999px;
    background: var(--sc-primary-soft);
    color: var(--sc-primary);
    font-size: 0.86rem;
    font-weight: 700;

    :deep(.iconify) {
      width: 1rem;
      height: 1rem;
    }
  }

  h1 {
    max-width: 48rem;
    margin: 0;
    font-size: clamp(3.25rem, 7vw, 5.8rem);
    line-height: 0.97;

    span {
      display: block;
      color: var(--sc-primary);
    }
  }

  &__lead {
    max-width: 43rem;
    margin: 1.65rem 0 0;
    color: var(--sc-muted-foreground);
    font-size: clamp(1.08rem, 2vw, 1.24rem);
  }

  &__actions {
    display: flex;
    flex-wrap: wrap;
    gap: 0.9rem;
    margin-top: 2rem;

    :deep(.button-soft--outline.btn) {
      background: rgb(255 254 250 / 76%);
      box-shadow: 0 4px 0 var(--sc-border);

      &:hover {
        color: var(--sc-primary);
        background: var(--sc-white);
        box-shadow: 0 6px 0 var(--sc-border);
      }
    }
  }

  &__trust {
    display: flex;
    flex-wrap: wrap;
    gap: 0.7rem 1.35rem;
    margin: 2rem 0 0;
    padding: 0;
    color: var(--sc-muted-foreground);
    font-size: 0.88rem;
    font-weight: 600;
    list-style: none;

    li {
      display: inline-flex;
      gap: 0.4rem;
      align-items: center;
    }

    :deep(.iconify) {
      width: 1rem;
      height: 1rem;
      color: var(--sc-primary);
    }
  }
}

.mission-section {
  &__quote {
    position: relative;
    margin: 0 0 1rem;
    padding: 1.75rem 1.75rem 1.75rem 4.3rem;
    border-left: 0;
    border-radius: var(--sc-radius);
    background: var(--sc-primary-soft);
    color: var(--sc-primary);

    :deep(.iconify) {
      position: absolute;
      top: 1.8rem;
      left: 1.55rem;
      width: 1.7rem;
      height: 1.7rem;
    }

    p {
      margin: 0;
      font-size: 1.13rem;
      font-weight: 600;
    }
  }

  &__reasons {
    margin-top: 1.5rem;
  }
}

.reason-card {
  height: 100%;
  padding: 1.8rem;

  > :deep(.iconify) {
    width: 1.7rem;
    height: 1.7rem;
    margin-bottom: 1.4rem;
    color: var(--sc-primary);
  }

  h3 {
    margin-bottom: 0.65rem;
  }

  p {
    margin: 0;
    color: var(--sc-muted-foreground);
  }
}

.feature-grid > div {
  display: flex;
}

.steps-list {
  position: relative;
  display: grid;
  margin: 0;
  padding: 0;
  list-style: none;

  &::before {
    position: absolute;
    top: 2.2rem;
    bottom: 2.2rem;
    left: 1.35rem;
    width: 2px;
    background: var(--sc-border);
    content: '';
  }

  li {
    position: relative;
    display: grid;
    grid-template-columns: 2.8rem 3.3rem 1fr;
    gap: 1.1rem;
    align-items: start;
    padding: 1.1rem 0;
  }

  &__number {
    z-index: 1;
    display: grid;
    width: 2.8rem;
    height: 2.8rem;
    place-items: center;
    border: 2px solid var(--sc-primary);
    border-radius: 50%;
    background: var(--sc-background);
    color: var(--sc-primary);
    font-weight: 700;
  }

  &__icon {
    display: grid;
    width: 3.3rem;
    height: 3.3rem;
    place-items: center;
    border-radius: 1rem;
    background: var(--sc-muted);
    color: var(--sc-primary);

    :deep(.iconify) {
      width: 1.4rem;
      height: 1.4rem;
    }
  }

  h3 {
    margin: 0.15rem 0 0.4rem;
  }

  p {
    max-width: 48rem;
    margin: 0;
    color: var(--sc-muted-foreground);
  }
}

.steps-section__note {
  display: flex;
  max-width: 54rem;
  gap: 0.75rem;
  align-items: flex-start;
  margin: 2rem 0 0 7.2rem;
  padding: 1rem 1.2rem;
  border: 1px solid var(--sc-border);
  border-radius: 1rem;
  background: var(--sc-card);
  color: var(--sc-muted-foreground);
  font-size: 0.94rem;

  :deep(.iconify) {
    flex: 0 0 auto;
    width: 1.15rem;
    margin-top: 0.2rem;
    color: var(--sc-primary);
  }
}

.privacy-section {
  overflow: hidden;
  background: var(--sc-primary-deep);
  color: rgb(255 255 255 / 77%);

  &::after {
    position: absolute;
    top: -15rem;
    right: -12rem;
    width: 34rem;
    height: 34rem;
    border-radius: 50%;
    background: rgb(244 217 120 / 9%);
    content: '';
  }

  :deep(.section-heading),
  .privacy-section__promises,
  .legal-document {
    position: relative;
    z-index: 1;
  }

  :deep(.eyebrow) {
    color: var(--sc-secondary);
  }

  :deep(.section-heading) {
    margin: 0;

    h2 {
      color: var(--sc-white);
    }

    .section-heading__description {
      color: rgb(255 255 255 / 70%);
    }
  }

  &__intro {
    display: flex;
    gap: 2rem;
    align-items: center;
    justify-content: space-between;
  }

  &__seal {
    display: grid;
    flex: 0 0 auto;
    width: clamp(5rem, 9vw, 7.5rem);
    aspect-ratio: 1;
    place-items: center;
    border: 1px solid rgb(244 217 120 / 25%);
    border-radius: 50%;
    background: rgb(244 217 120 / 10%);
    color: var(--sc-secondary);

    :deep(.iconify) {
      width: 44%;
      height: 44%;
    }
  }

  &__promises {
    margin-top: 3rem;
    margin-bottom: 3.5rem;

    article {
      height: 100%;
      padding: 1.4rem;
      border: 1px solid rgb(255 255 255 / 12%);
      border-radius: 1.1rem;
      background: rgb(255 255 255 / 5%);
    }

    :deep(.iconify) {
      width: 1.5rem;
      height: 1.5rem;
      margin-bottom: 1rem;
      color: var(--sc-secondary);
    }

    h3 {
      color: var(--sc-white);
    }

    p {
      margin: 0;
      color: rgb(255 255 255 / 65%);
      font-size: 0.94rem;
    }
  }
}

.legal-document {
  padding: clamp(1.5rem, 4vw, 3rem);
  border: 1px solid rgb(255 255 255 / 12%);
  border-radius: var(--sc-radius-large);
  background: rgb(255 255 255 / 7%);

  &__heading {
    display: flex;
    gap: 2rem;
    align-items: end;
    justify-content: space-between;
    padding-bottom: 1.5rem;
    border-bottom: 1px solid rgb(255 255 255 / 12%);

    h2 {
      margin: 0;
      color: var(--sc-white);
      font-size: clamp(2rem, 4vw, 3rem);
    }

    > p {
      flex: 0 0 auto;
      margin: 0 0 0.35rem;
      color: rgb(255 255 255 / 60%);
      font-size: 0.86rem;
    }
  }

  &[open] {
    .legal-document__summary :deep(.iconify) {
      transform: rotate(45deg);
    }
  }

  &__summary {
    display: flex;
    gap: 2rem;
    align-items: center;
    justify-content: space-between;
    cursor: pointer;
    list-style: none;

    &::-webkit-details-marker {
      display: none;
    }

    > span:first-child {
      display: grid;
      gap: 0.25rem;
      color: var(--sc-secondary);
      font-size: 0.78rem;
      font-weight: 700;
      letter-spacing: 0.08em;
      text-transform: uppercase;

      strong {
        color: var(--sc-white);
        font-size: clamp(1.6rem, 3vw, 2.25rem);
        letter-spacing: normal;
        text-transform: none;
      }
    }

    > span:last-child {
      display: inline-flex;
      flex: 0 0 auto;
      gap: 0.7rem;
      align-items: center;
      color: var(--sc-white);
      font-size: 0.86rem;

      :deep(.iconify) {
        width: 1.1rem;
        color: var(--sc-secondary);
        transition: transform 180ms ease;
      }
    }
  }

  &__content {
    margin-top: 1.5rem;
    padding-top: 0.1rem;
    border-top: 1px solid rgb(255 255 255 / 12%);
  }

  &__lead {
    max-width: 55rem;
    margin: 1.5rem 0 2.25rem;
    font-size: 1.04rem;
  }

  &__grid {
    display: grid;
    grid-template-columns: repeat(2, minmax(0, 1fr));
    gap: 2rem 2.5rem;

    h3 {
      margin-bottom: 0.55rem;
      color: var(--sc-white);
      font-size: 1.02rem;
    }

    p {
      margin: 0;
      color: rgb(255 255 255 / 66%);
      font-size: 0.92rem;
    }
  }

  &__external {
    margin-top: 2.25rem;
    padding-top: 1.5rem;
    border-top: 1px solid rgb(255 255 255 / 12%);

    > p {
      margin-bottom: 0.65rem;
      font-size: 0.88rem;
    }

    ul {
      display: flex;
      flex-wrap: wrap;
      gap: 0.5rem 1.2rem;
      margin: 0;
      padding: 0;
      list-style: none;
    }

    a {
      display: inline-flex;
      gap: 0.35rem;
      align-items: center;
      color: var(--sc-secondary);
      font-size: 0.86rem;
      font-weight: 600;

      :deep(.iconify) {
        width: 0.85rem;
      }
    }
  }

  &--plain {
    border-color: var(--sc-border);
    background: var(--sc-card);
    box-shadow: var(--sc-shadow-small);
    color: var(--sc-foreground);

    .eyebrow {
      color: var(--sc-primary);
    }

    .legal-document__heading {
      border-bottom-color: var(--sc-border);

      h2 {
        color: var(--sc-foreground);
      }

      > p {
        color: var(--sc-muted-foreground);
      }
    }

    .legal-document__grid {
      h3 {
        color: var(--sc-foreground);
      }

      p {
        color: var(--sc-muted-foreground);
      }
    }
  }

  &__contact {
    margin: 2.25rem 0 0;
    padding-top: 1.5rem;
    border-top: 1px solid var(--sc-border);

    a {
      display: inline-flex;
      gap: 0.35rem;
      align-items: center;
      margin-left: 0.25rem;
      font-weight: 700;

      :deep(.iconify) {
        width: 0.9rem;
      }
    }
  }
}

.support-card {
  position: relative;
  display: grid;
  grid-template-columns: minmax(14rem, 0.7fr) 1.5fr;
  overflow: hidden;
  border: 1px solid #d4ae3f;
  border-radius: var(--sc-radius-large);
  background: var(--sc-secondary);
  box-shadow: 0 10px 0 #d4ae3f, var(--sc-shadow);

  &__art {
    position: relative;
    display: grid;
    min-height: 22rem;
    place-items: center;
    overflow: hidden;
    background:
      radial-gradient(rgb(36 84 59 / 12%) 1.5px, transparent 1.5px),
      rgb(255 255 255 / 18%);
    background-size: 20px 20px;

    &::before {
      position: absolute;
      width: 15rem;
      height: 15rem;
      border-radius: 50%;
      background: var(--sc-primary-soft);
      content: '';
    }

    img {
      z-index: 1;
      height: 9.5rem;
      filter: drop-shadow(0 12px 12px rgb(36 84 59 / 18%));
      transform: rotate(-5deg);
    }

    :deep(.iconify) {
      position: absolute;
      z-index: 2;
      top: 3rem;
      right: 2.5rem;
      width: 3rem;
      height: 3rem;
      background: var(--sc-primary);
      transform: rotate(9deg);
    }
  }

  &__copy {
    align-self: center;
    padding: clamp(2rem, 5vw, 4.5rem);

    .eyebrow {
      color: var(--sc-primary-deep);
    }

    h2 {
      margin-bottom: 1.2rem;
    }

    > p:not(.eyebrow) {
      max-width: 45rem;
      margin: 0;
      color: #34423a;
      font-size: 1.05rem;
    }
  }

  &__actions {
    display: flex;
    flex-wrap: wrap;
    gap: 1rem 1.25rem;
    align-items: center;
    margin-top: 1.75rem;
  }

  &__paywall {
    display: inline-flex;
    gap: 0.5rem;
    align-items: center;
    color: var(--sc-primary-deep);
    font-size: 0.88rem;
    font-weight: 700;

    :deep(.iconify) {
      width: 1.1rem;
    }
  }
}

.download-section {
  background:
    radial-gradient(circle at 95% 10%, rgb(36 84 59 / 10%), transparent 25rem),
    var(--sc-background);
}

.merch-card {
  display: flex;
  gap: 1.25rem;
  align-items: flex-start;
  padding: 1.6rem;

  &__icon {
    display: grid;
    flex: 0 0 auto;
    width: 3.3rem;
    height: 3.3rem;
    place-items: center;
    border-radius: 1rem;
    background: var(--sc-secondary);
    color: var(--sc-primary);

    :deep(.iconify) {
      width: 1.5rem;
      height: 1.5rem;
    }
  }

  h3 {
    margin: 0.7rem 0 0.4rem;
  }

  p {
    margin: 0 0 0.6rem;
    color: var(--sc-muted-foreground);
  }

  &__disabled {
    color: var(--sc-muted-foreground);
    font-size: 0.84rem;
    font-weight: 600;
  }
}

.coming-soon-pill {
  display: inline-block;
  padding: 0.25rem 0.52rem;
  border-radius: 999px;
  background: var(--sc-primary-soft);
  color: var(--sc-primary);
  font-size: 0.68rem;
  font-weight: 700;
  letter-spacing: 0.06em;
  text-transform: uppercase;
}

.faq-list {
  max-width: 53rem;
  margin-inline: auto;

  details {
    border-bottom: 1px solid var(--sc-border);
    background: transparent;

    &:first-child {
      border-top: 1px solid var(--sc-border);
    }

    &[open] summary :deep(.iconify) {
      transform: rotate(45deg);
    }
  }

  summary {
    display: flex;
    gap: 1rem;
    align-items: center;
    justify-content: space-between;
    padding: 1.35rem 0;
    cursor: pointer;
    font-size: 1.05rem;
    font-weight: 700;
    list-style: none;

    &::-webkit-details-marker {
      display: none;
    }

    :deep(.iconify) {
      flex: 0 0 auto;
      width: 1.2rem;
      color: var(--sc-primary);
      transition: transform 180ms ease;
    }
  }

  p {
    max-width: 48rem;
    margin: -0.3rem 0 1.4rem;
    color: var(--sc-muted-foreground);
  }
}

@media (max-width: 991.98px) {
  .hero-section {
    text-align: center;

    &::before {
      mask-image: linear-gradient(to bottom, black, transparent 70%);
    }

    &__badge,
    &__actions,
    &__trust {
      justify-content: center;
    }

    &__lead,
    h1 {
      margin-inline: auto;
    }

    :deep(.phone-preview) {
      margin-top: 1rem;
    }
  }

  .support-card {
    grid-template-columns: 1fr;

    &__art {
      min-height: 15rem;
    }
  }
}

@media (max-width: 767.98px) {
  .content-section {
    overflow: hidden;
  }

  .privacy-section__intro {
    align-items: flex-start;
  }

  .privacy-section__seal {
    width: 4.2rem;
  }

  .legal-document {
    border-radius: var(--sc-radius);

    &__heading {
      display: grid;
      gap: 0.7rem;

      > p {
        margin: 0;
      }
    }

    &__grid {
      grid-template-columns: 1fr;
    }
  }

  .steps-list {
    &::before {
      left: 1.2rem;
    }

    li {
      grid-template-columns: 2.5rem 1fr;
      gap: 0.9rem;
    }

    &__number {
      width: 2.5rem;
      height: 2.5rem;
    }

    &__icon {
      display: none;
    }
  }

  .steps-section__note {
    margin-left: 3.4rem;
  }
}

@media (max-width: 575.98px) {
  .hero-section {
    padding-top: 3.2rem;

    h1 {
      font-size: clamp(2.85rem, 15vw, 4rem);
    }

    &__actions {
      display: grid;

      :deep(.btn) {
        width: 100%;
      }
    }
  }

  .mission-section__quote {
    padding: 1.4rem;

    :deep(.iconify) {
      position: static;
      margin-bottom: 0.8rem;
    }
  }

  .privacy-section__seal {
    display: none;
  }

  .support-card {
    &__art {
      min-height: 12rem;

      &::before {
        width: 10rem;
        height: 10rem;
      }

      img {
        height: 7rem;
      }
    }

    &__actions :deep(.btn) {
      width: 100%;
    }
  }

  .merch-card {
    display: grid;
  }
}
</style>
