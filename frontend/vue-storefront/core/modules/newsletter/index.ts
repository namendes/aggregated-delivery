import { module } from './store'
import { VueStorefrontModule, VueStorefrontModuleConfig } from 'vue-storefront_1'
import { initCacheStorage } from 'vue-storefront_1'

export const KEY = 'newsletter'
export const cacheStorage = initCacheStorage(KEY)
const moduleConfig: VueStorefrontModuleConfig = {
  key: KEY,
  store: { modules: [{ key: KEY, module }] }
}
export const Newsletter = new VueStorefrontModule(moduleConfig)
