import { Component, Input, OnInit } from '@angular/core';
import { ProductSearchResponse } from '@app/models/brsm/product-search-response';

@Component ( {
  selector: 'app-one-column-atc-button',
  templateUrl: './one-column-atc-button.component.html',
  styleUrls: [ './one-column-atc-button.component.scss' ]
} )
export class OneColumnAtcButtonComponent implements OnInit {

  @Input () categoryMap: any;
  @Input () facetCounts: any;
  @Input () pageSize: number;
  @Input () response: ProductSearchResponse;

  constructor () {
  }

  ngOnInit () {
  }

}
