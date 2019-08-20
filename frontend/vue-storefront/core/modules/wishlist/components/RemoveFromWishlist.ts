import Product from 'vue-storefront_1'
import { Wishlist as WishlistModule } from '../'
import wishlistMountedMixin from 'vue-storefront_1'

export const RemoveFromWishlist = {
  name: 'RemoveFromWishlist',
  mixins: [wishlistMountedMixin],
  props: {
    product: {
      required: true,
      type: Object
    }
  },
  methods: {
    removeFromWishlist (product: Product) {
      WishlistModule.register()
      this.$store.dispatch('wishlist/removeItem', product)
    }
  }
}
