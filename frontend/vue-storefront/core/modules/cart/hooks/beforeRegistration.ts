import * as localForage from 'localforage'
import UniversalStorage from 'vue-storefront_1'
import { currentStoreView } from 'vue-storefront_1'

export function beforeRegistration ({ Vue, config, store, isServer }) {
  const storeView = currentStoreView()
  const dbNamePrefix = storeView.storeCode ? storeView.storeCode + '-' : ''

  Vue.prototype.$db.cartsCollection = new UniversalStorage(localForage.createInstance({
    name: (config.storeViews.commonCache ? '' : dbNamePrefix) + 'shop',
    storeName: 'carts',
    driver: localForage[config.localForage.defaultDrivers['carts']]
  }))
}