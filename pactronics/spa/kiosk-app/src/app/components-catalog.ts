import {
  BannerComponent,
  LogoComponent,
  MenuComponent,
  ProductsGridComponent,
  SimpleContentComponent
} from '@app/catalog-components';

export class ComponentsCatalog {
  static componentMappings = {
    'Banner': BannerComponent,
    'Logo': LogoComponent,
    'Menu': MenuComponent,
    'Products Grid': ProductsGridComponent,
    'Simple Content': SimpleContentComponent
  };

}
