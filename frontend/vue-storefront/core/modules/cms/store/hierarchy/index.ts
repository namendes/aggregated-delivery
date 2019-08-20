import { Module } from 'vuex'
import actions from './actions'
import RootState from 'vue-storefront_1'
import CmsHierarchyState from '../../types/CmsHierarchyState'

export const cmsHierarchyModule: Module<CmsHierarchyState, RootState> = {
  namespaced: true,
  state: {
    items: []
  },
  actions
}
