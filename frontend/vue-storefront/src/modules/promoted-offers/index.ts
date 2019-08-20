import { createModule } from 'vue-storefront_1'
import { module } from './store'

const KEY = 'promoted'
export const PromotedOffers = createModule({
  key: KEY,
  store: { modules: [{ key: KEY, module }] }
})
