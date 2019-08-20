import * as localForage from 'localforage'
import UniversalStorage from 'vue-storefront_1'
import { currentStoreView } from 'vue-storefront_1'

export function beforeRegistration ({ Vue, config, store, isServer }) {
  const storeView = currentStoreView()
  const dbNamePrefix = storeView.storeCode ? storeView.storeCode + '-' : ''

  Vue.prototype.$db.compareCollection = new UniversalStorage(localForage.createInstance({
    name: dbNamePrefix + 'shop',
    storeName: 'compare',
    driver: localForage[config.localForage.defaultDrivers['compare']]
  }))
}
