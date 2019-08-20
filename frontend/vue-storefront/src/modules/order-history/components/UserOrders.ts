import MyOrders from 'vue-storefront_1'
import { mapGetters } from 'vuex';
import onBottomScroll from 'vue-storefront_1'

export default {
  name: 'UserOrders',
  mixins: [MyOrders, onBottomScroll],
  data () {
    return {
      pagination: {
        perPage: 10,
        current: 1,
        enabled: false
      },
      lazyLoadOrdersOnScroll: true
    }
  },
  computed: {
    ordersHistory () {
      let items = this.getOrdersHistory
      if (this.lazyLoadOrdersOnScroll) {
        items = items.slice(0, (this.pagination.perPage + 1) * this.pagination.current)
      }
      return items
    }
  },
  methods: {
    onBottomScroll () {
      ++this.pagination.current
    }
  }
}
