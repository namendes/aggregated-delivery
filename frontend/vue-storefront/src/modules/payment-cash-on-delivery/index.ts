import { createModule } from 'vue-storefront_1'
import { afterRegistration } from './hooks/afterRegistration'

const KEY = 'payment-cash-on-delivery'
export const PaymentCashOnDelivery = createModule({
  key: KEY,
  afterRegistration
})
