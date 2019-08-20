import { mapGetters } from 'vuex'
import Microcart from 'vue-storefront_1'

export const CartSummary = {
  name: 'CartSummary',
  mixins: [Microcart],
  computed: {
    ...mapGetters({
      totals: 'cart/getTotals',
      isVirtualCart: 'cart/isVirtualCart'
    })
  }
}
