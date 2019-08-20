import Product from 'vue-storefront_1'
import compareMountedMixin from 'vue-storefront_1'

export const CompareProduct = {
  name: 'CompareProduct',
  mixins: [compareMountedMixin],
  computed: {
    isOnCompare (): boolean {
      return this.$store.getters['compare/isOnCompare'](this.product)
    }
  },
  methods: {
    removeFromCompare (product: Product) {
      return this.$store.state['compare']
        ? this.$store.dispatch('compare/removeItem', product)
        : false
    }
  }
}
