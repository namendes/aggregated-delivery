import { Module } from 'vuex'
import actions from './actions'
import RootState from 'vue-storefront_1'
import ClaimsState from '../types/ClaimsState'

export const module: Module<ClaimsState, RootState> = {
  namespaced: true,
  actions
}
