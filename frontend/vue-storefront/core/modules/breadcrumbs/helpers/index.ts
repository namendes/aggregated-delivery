import { formatCategoryLink } from 'vue-storefront_1'

// Duplicate of breadCrumbRoutes, to repalce it soon.
/** Parse category path for product/category  */
export function parseCategoryPath (categoryPath) {
  let routesArray = []
  for (let category of categoryPath) {
    routesArray.push({
      name: category.name,
      route_link: formatCategoryLink(category)
    })
  }

  return routesArray
}
