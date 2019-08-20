import { Component, Input, OnInit } from '@angular/core';
import { ProductSearchResponse } from '@app/models/brsm/product-search-response';

@Component ( {
  selector: 'app-three-column-atc-button',
  templateUrl: './three-column-atc-button.component.html',
  styleUrls: [ './three-column-atc-button.component.scss' ]
} )
export class ThreeColumnAtcButtonComponent implements OnInit {

  @Input () categoryMap: any;
  @Input () facetCounts: any;
  @Input () pageSize: number;
  @Input () response: ProductSearchResponse;

  constructor () {
  }

  ngOnInit () {
  }

}
