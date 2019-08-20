import { createModule } from 'vue-storefront_1'
import { afterRegistration } from './hooks/afterRegistration'

const store = {
  namespaced: true,
  state: {
    key: null
  }
};
const KEY = 'hotjar';
export const Hotjar = createModule({
  key: KEY,
  store: { modules: [{ key: KEY, module: store }] },
  afterRegistration
});
