import { createModule } from 'vue-storefront_1'
import { store } from './store'
import { afterRegistration } from './hooks/afterRegistration'

const KEY = 'cms'
export const Magento2CMS = createModule({
  key: KEY,
  store: { modules: [{ key: KEY, module: store }] },
  afterRegistration
})
