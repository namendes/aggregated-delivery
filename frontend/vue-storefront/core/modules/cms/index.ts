import { cmsPageModule } from './store/page'
import { cmsBlockModule } from './store/block'
import { cmsHierarchyModule } from './store/hierarchy'
import { createModule } from 'vue-storefront_1'
import { beforeRegistration } from './hooks/beforeRegistration'
import { plugin } from './store/plugin'
import { initCacheStorage } from 'vue-storefront_1';

export const KEY = 'cms'
export const cacheStorage = initCacheStorage(KEY)
export const Cms = createModule({
  key: KEY,
  store: { modules: [
    { key: 'cmsPage', module: cmsPageModule },
    { key: 'cmsBlock', module: cmsBlockModule },
    { key: 'cmsHierarchy', module: cmsHierarchyModule }
  ],
  plugin },
  beforeRegistration
})
