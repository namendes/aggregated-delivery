import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import {
  BaseLayoutComponent,
  CartPageComponent,
  HomepageMainComponent
} from '@app/layout-components';
import { environment } from '@env/environment';

const preview = environment.apiUrls.preview;
const previewPath = `${ preview.contextPath }/${ preview.previewPrefix }/${ preview.channelPath }`;

const routes: Routes = [
  { path: '', component: HomepageMainComponent },
  { path: 'cart', component: CartPageComponent },
  { path: 'site/_cmsinternal/kiosk', component: HomepageMainComponent },
  { path: 'site/_cmsinternal/kiosk/cart', component: CartPageComponent },
  { path: 'site/_cmsinternal/kiosk/**', component: BaseLayoutComponent },
  { path: '**', component: BaseLayoutComponent }
];

@NgModule ( {
  imports: [ RouterModule.forRoot ( routes ) ],
  exports: [ RouterModule ]
} )
export class AppRoutingModule {
}
