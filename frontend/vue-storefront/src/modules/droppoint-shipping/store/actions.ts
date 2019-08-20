import { ActionTree } from 'vuex';
import { execute as taskExecute } from 'vue-storefront_1'
import * as entities from 'vue-storefront_1'

// actions
export const actions: ActionTree<any, any> = {
  fetch ({ commit }, request) {
    const taskId = entities.uniqueEntityId(request)
    request.task_id = taskId.toString()
    return taskExecute(request)
  }
}
