import Product from 'vue-storefront_1'
import compareMountedMixin from 'vue-storefront_1'

export const AddToCompare = {
  name: 'AddToCompare',
  mixins: [compareMountedMixin],
  methods: {
    addToCompare (product: Product) {
      return this.$store.state['compare']
        ? this.$store.dispatch('compare/addItem', product)
        : false
    }
  }
}
