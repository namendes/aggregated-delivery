import { Component, OnDestroy, OnInit } from '@angular/core';
import { BaseCatalogComponent } from '@app/common';
import { ProductSearchResponse } from '@app/models/brsm/product-search-response';
import { BrsmService } from '@app/services/brsm.service';
import {
  BaseComponent,
  getNestedObject,
  ImageUrlService,
  PageModelService,
  SingleContentComponent
} from 'bloomreach-experience-ng-sdk';
import { BehaviorSubject, Observable, Subscription } from 'rxjs';

@Component ( {
  selector: 'app-products-grid',
  templateUrl: './products-grid.component.html',
  styleUrls: [ './products-grid.component.scss' ]
} )
export class ProductsGridComponent extends BaseCatalogComponent implements BaseComponent, OnDestroy, OnInit {

  private _categoryMap: BehaviorSubject<any> = new BehaviorSubject ( {} );
  private _facetCounts: BehaviorSubject<any> = new BehaviorSubject ( {} );
  private _response: BehaviorSubject<ProductSearchResponse> = new BehaviorSubject ( new ProductSearchResponse () );

  categoryMap: Observable<any> = this._categoryMap.asObservable ();
  facetCounts: Observable<any> = this._facetCounts.asObservable ();
  response: Observable<ProductSearchResponse> = this._response.asObservable ();

  paramsInfo: any;
  serviceSubscription: Subscription;

  constructor ( imageUrlService: ImageUrlService,
                pageModelService: PageModelService,
                private brsmService: BrsmService ) {
    super ( imageUrlService, pageModelService );
  }

  ngOnInit () {
    super.ngOnInit ();
    this.getParamsInfo ();
    this.getProducts ();
  }

  ngOnDestroy (): void {
    this.serviceSubscription.unsubscribe ();
  }

  getParamsInfo () {
    this.paramsInfo = getNestedObject ( this.configuration, [ '_meta', 'paramsInfo' ] );
  }

  getProducts (): void {
    let searchType = 'keyword';
    if ( this.paramsInfo.query.startsWith ( 'cat' ) ) {
      searchType = 'category';
    }
    this.serviceSubscription = this.brsmService.executeSearch ( searchType, this.paramsInfo.query,
      this.paramsInfo.widgetId, this.paramsInfo.pageSize )
    .subscribe ( resp => {
      this._response.next ( resp.response );
      this._facetCounts.next ( resp[ 'facet_counts' ] );
      this._categoryMap.next ( resp[ 'category_map' ] );
    } );
  }

}
