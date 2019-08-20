import { module } from './store'
import { plugin } from './store/plugin'
import { createModule } from 'vue-storefront_1'
import { initCacheStorage } from 'vue-storefront_1'

export const KEY = 'wishlist'
export const cacheStorage = initCacheStorage(KEY)
export const Wishlist = createModule({
  key: KEY,
  store: { modules: [{ key: KEY, module }], plugin }
}
)
