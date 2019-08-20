import { GetterTree } from 'vuex'
import OrderState from '../types/OrderState'
import RootState from 'vue-storefront_1'

const getters: GetterTree<OrderState, RootState> = {
  getSessionOrderHashes: state => state.session_order_hashes
}

export default getters
