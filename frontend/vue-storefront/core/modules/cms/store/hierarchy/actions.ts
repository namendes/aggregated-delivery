import { ActionTree } from 'vuex'
import { quickSearchByQuery } from 'vue-storefront_1'
import SearchQuery from 'vue-storefront_1'
import RootState from 'vue-storefront_1';
import CmsHierarchyState from '../../types/CmsHierarchyState'
import { Logger } from 'vue-storefront_1'

const actions: ActionTree<CmsHierarchyState, RootState> = {
  /**
   * Retrieve cms hierarchy
   *
   * @param context
   * @param {any} query
   * @param {any} entityType
   * @param {any} excludeFields
   * @param {any} includeFields
   * @returns {Promise<T> & Promise<any>}
   */
  list (context, {id, entityType = 'cms_hierarchy', excludeFields = null, includeFields = null}) {
    let query = new SearchQuery()

    if (id) {
      query = query.applyFilter({key: 'identifier', value: {'eq': id}})
    }

    return quickSearchByQuery({ query, entityType, excludeFields, includeFields }).catch(err => {
      Logger.error(err, 'cms')()
    })
  }
}

export default actions
