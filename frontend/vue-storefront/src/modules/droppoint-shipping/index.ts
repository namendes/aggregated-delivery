import { createModule } from 'vue-storefront_1'
import { module } from './store'

export const KEY = 'droppoint-shipping'
export const DroppointShipping = createModule({
  key: KEY,
  store: { modules: [{ key: KEY, module }] }
})
