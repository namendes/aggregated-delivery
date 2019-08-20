import { Component, Input, OnInit } from '@angular/core';
import { ProductSearchResponse } from '@app/models/brsm/product-search-response';

@Component ( {
  selector: 'app-three-column-buy-button',
  templateUrl: './three-column-buy-button.component.html',
  styleUrls: [ './three-column-buy-button.component.scss' ]
} )
export class ThreeColumnBuyButtonComponent implements OnInit {

  @Input () categoryMap: any;
  @Input () facetCounts: any;
  @Input () pageSize: number;
  @Input () response: ProductSearchResponse;

  constructor () {
  }

  ngOnInit () {
  }

  openModal ( pid: string ): void {
    console.log ( 'open modal request for product: ' + pid );
  }
}
