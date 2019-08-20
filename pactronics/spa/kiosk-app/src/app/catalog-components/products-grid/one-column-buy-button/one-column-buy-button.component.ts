import { Component, Input, OnInit } from '@angular/core';
import { ProductSearchResponse } from '@app/models/brsm/product-search-response';

@Component ( {
  selector: 'app-one-column-buy-button',
  templateUrl: './one-column-buy-button.component.html',
  styleUrls: [ './one-column-buy-button.component.scss' ]
} )
export class OneColumnBuyButtonComponent implements OnInit {

  @Input () categoryMap: any;
  @Input () facetCounts: any;
  @Input () pageSize: number;
  @Input () response: ProductSearchResponse;

  constructor () {
  }

  ngOnInit () {
  }

}
