import { createModule } from 'vue-storefront_1'
import { module } from './store'
import { beforeRegistration } from './hooks/beforeRegistration'

export const KEY = 'order'
export const Order = createModule({
  key: KEY,
  store: { modules: [{ key: KEY, module }] },
  beforeRegistration
})
