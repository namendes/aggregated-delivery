import compareMountedMixin from 'vue-storefront_1'

export const CompareButton = {
  name: 'CompareButton',
  mixins: [compareMountedMixin],
  computed: {
    isEmpty (): boolean {
      return this.$store.getters['compare/isEmpty']
    }
  }
}
