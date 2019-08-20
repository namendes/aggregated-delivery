import { module } from './store'
import { createModule } from 'vue-storefront_1'

export const KEY = 'review'
export const Review = createModule({
  key: KEY,
  store: { modules: [{ key: KEY, module }] }
})
