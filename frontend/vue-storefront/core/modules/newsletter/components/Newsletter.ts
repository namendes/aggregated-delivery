import SubscriptionStatus from 'vue-storefront_1'
import Subscribe from 'vue-storefront_1'
import Unsubscribe from 'vue-storefront_1'

export const Newsletter = {
  name: 'Newsletter',
  mixins: [SubscriptionStatus, Subscribe, Unsubscribe]
}
