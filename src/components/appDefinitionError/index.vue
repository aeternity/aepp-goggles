<template>
  <div
    class="app-definition-error"
    :class="{
      [type]: Boolean(type)
    }"
  >
    <div
      v-if="title"
      class="app-definition-error-title"
    >
      {{ title }}
    </div>
    <div class="app-definition-error-content">
      <slot />
    </div>
  </div>
</template>

<script>
export default {
  name: 'AppDefinitionError',
  props: {
    /**
     * Fill property changes the color state of the button
     * select something between: `primary, secondary, neutral, alternative`
     */
    type: {
      type: String,
      validator: value => [
        'block',
        'list'
      ].includes(value),
      default: 'block'
    },
    title: {
      type: String,
      default: ''
    }
  }
}
</script>

<style scoped lang="scss">
  @import "~@aeternity/aepp-components-3/src/styles/variables/colors";
  @import "~@aeternity/aepp-components-3/src/styles/placeholders/typography";
  .app-definition-error {
    display: flex;
    margin: 0;
    flex-direction: column;
    align-items: baseline;
    width: 100%;
    height: 100%;
  }
  .app-definition-error-title {
    font-weight: 500;
    @extend %face-uppercase-xs;
  }
  .app-definition-error-content {
    color: #76818C;
    display: flex;
    @extend %face-mono-xs;
  }
  .app-definition-error.block {
    padding: .6rem;
  }
  .app-definition-error.list {
    background-color: #FFBFD7;
    padding: .6rem;
    @media (min-width: 450px) {
      flex-direction: row;
      padding: 0;
    }
    & .app-definition-error-title {
      @media (min-width: 450px) {
        text-align: right;
        width: 25%;
        padding: .6rem;
      }
    }
    & .app-definition-error-content {
      word-break: break-all;
      @media (min-width: 450px) {
        padding: .8rem;
        background-color: #FFFFFF;
        width: 75%;
      }
    }
  }

</style>
