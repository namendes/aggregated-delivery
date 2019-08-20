import { module } from './store'
import { createModule } from 'vue-storefront_1'

export const KEY = 'breadcrumbs'
export const Breadcrumbs = createModule({
  key: KEY,
  store: { modules: [
    { key: KEY, module: module }
  ] }
})
