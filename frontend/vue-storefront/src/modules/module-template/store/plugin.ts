import * as types from './mutation-types'
import { Logger } from 'vue-storefront_1'

export function plugin (mutation, state) {
  if (types[mutation.type]) {
    Logger.info('performed mutation from this store with type' + mutation.type)()
  } else {
    Logger.info('performed mutation from other store with type' + mutation.type)()
  }
}
