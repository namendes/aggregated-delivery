import { createModule } from 'vue-storefront_1'
import { afterRegistration } from './hooks/afterRegistration'

const KEY = 'sample-custom-entity-gql'
export const SampleCustomEntityGql = createModule({
  key: KEY,
  afterRegistration
})
