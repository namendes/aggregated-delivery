import { module } from './store'
import { createModule } from 'vue-storefront_1'

import { VueStorefrontModule, VueStorefrontModuleConfig } from 'vue-storefront_1'
import { initCacheStorage } from 'vue-storefront_1'
import { beforeEach } from './router/beforeEach'

export const KEY = 'url'
export const cacheStorage = initCacheStorage(KEY)

export const Url = createModule({
  key: KEY,
  store: { modules: [{ key: KEY, module }] },
  router: { beforeEach }
})
