import { HttpClientJsonpModule, HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppRoutingModule } from '@app/app-routing.module';
import { AppComponent } from '@app/app.component';
import {
  BannerComponent,
  LogoComponent,
  MenuComponent,
  MenuDefaultComponent,
  MenuItemComponent,
  MenuNavbarComponent,
  OneColumnAtcButtonComponent,
  OneColumnBuyButtonComponent,
  ProductsGridComponent,
  SimpleContentComponent,
  StarterstoreCategoriesMenuComponent,
  StarterstoreMenuComponent,
  ThreeColumnAtcButtonComponent,
  ThreeColumnBuyButtonComponent,
  VerticalComponent
} from '@app/catalog-components';
import { BaseCatalogComponent } from '@app/common';
import {
  BaseFooterComponent,
  BaseLayoutComponent,
  BaseTopComponent,
  BreadcrumbComponent,
  CartPageComponent,
  HomepageMainComponent,
  StarterstoreHeaderComponent
} from '@app/layout-components';
import { BrsmService, Logger } from '@app/services';
import { BloomreachExperienceNgSdkModule } from 'bloomreach-experience-ng-sdk';

@NgModule ( {
  declarations: [
    AppComponent,
    BannerComponent,
    BaseCatalogComponent,
    BaseFooterComponent,
    BaseLayoutComponent,
    BaseTopComponent,
    BreadcrumbComponent,
    CartPageComponent,
    HomepageMainComponent,
    LogoComponent,
    MenuComponent,
    MenuDefaultComponent,
    MenuItemComponent,
    MenuNavbarComponent,
    OneColumnAtcButtonComponent,
    OneColumnBuyButtonComponent,
    ProductsGridComponent,
    SimpleContentComponent,
    StarterstoreHeaderComponent,
    StarterstoreCategoriesMenuComponent,
    StarterstoreMenuComponent,
    ThreeColumnBuyButtonComponent,
    ThreeColumnAtcButtonComponent,
    VerticalComponent,
  ],
  entryComponents: [
    BannerComponent,
    BreadcrumbComponent,
    LogoComponent,
    MenuComponent,
    MenuDefaultComponent,
    MenuItemComponent,
    MenuNavbarComponent,
    OneColumnAtcButtonComponent,
    OneColumnBuyButtonComponent,
    ProductsGridComponent,
    SimpleContentComponent,
    StarterstoreHeaderComponent,
    ThreeColumnBuyButtonComponent,
    ThreeColumnAtcButtonComponent,
  ],
  exports: [],
  imports: [
    AppRoutingModule,
    BrowserAnimationsModule,
    BrowserModule,
    BloomreachExperienceNgSdkModule,
    HttpClientModule,
    HttpClientJsonpModule,
    ReactiveFormsModule
  ],
  providers: [
    BrsmService,
    Logger
  ],
  bootstrap: [ AppComponent ]
} )
export class AppModule {
}
