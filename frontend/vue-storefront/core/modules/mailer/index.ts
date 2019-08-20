import { module } from './store'
import { createModule } from 'vue-storefront_1'

export const KEY = 'mailer'
export const Mailer = createModule({
  key: KEY,
  store: { modules: [{ key: KEY, module }] }
})
