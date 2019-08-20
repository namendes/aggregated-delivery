import { GetterTree } from 'vuex'
import RootState from 'vue-storefront_1'
import CmsPageState from '../../types/CmsPageState'

const getters: GetterTree<CmsPageState, RootState> = {
  cmsPages: (state) => state.items
}

export default getters
