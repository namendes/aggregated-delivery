import * as localForage from 'localforage'
import store from 'vue-storefront_1'

import UniversalStorage from 'vue-storefront_1'
import { Logger } from 'vue-storefront_1'
import config from 'config'

export const CancelOrders = {
  methods: {
    cancelOrders () {
      const ordersCollection = new UniversalStorage(localForage.createInstance({
        name: 'shop',
        storeName: 'orders',
        driver: localForage[config.localForage.defaultDrivers['orders']]
      }))

      ordersCollection.iterate((order, id, iterationNumber) => {
        if (!order.transmited) {
          ordersCollection.removeItem(id)
        }
      }).catch(err => {
        Logger.error(err, 'offline-order')()
        Logger.log('Not transmitted orders have been deleted', 'offline-order')()
      })
    }
  }
}
