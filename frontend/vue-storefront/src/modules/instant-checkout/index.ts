import { VueStorefrontModule, VueStorefrontModuleConfig } from 'vue-storefront_1'

const KEY = 'instant-checkout'

const moduleConfig: VueStorefrontModuleConfig = {
  key: KEY
}

export const InstantCheckout = new VueStorefrontModule(moduleConfig)
