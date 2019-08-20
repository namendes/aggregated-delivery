import { Component, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { Router } from '@angular/router';
import { StarterstoreHeaderComponent } from '@app/layout-components';
import {
  ApiUrlsService,
  ComponentMappingsService,
  InitializeSdkService,
  RequestContextService
} from 'bloomreach-experience-ng-sdk';
import { BaseLayoutComponent } from '../base-layout/base-layout.component';

@Component ( {
  selector: 'app-cart-page',
  templateUrl: './cart-page.component.html',
  styleUrls: [ './cart-page.component.scss' ]
} )
export class CartPageComponent extends BaseLayoutComponent implements OnInit {
  cartid = new FormControl('');
  cartData = {
    id: '163c97a5-e946-433a-a645-809bc88310ea',
    lineitems: [
      {
        id: 'c4f2df28-73e6-4663-b13a-19998b1d6892',
        pid: 'p10311',
        name: 'Fitbit Charge Wireless Activity Wristband, Black, Large',
        image: 'https://images-eu.ssl-images-amazon.com/images/I/41d92obyKqL.jpg',
        cost: 199.00,
        quantity: 1
      }
    ]
  };
  cartFound = false;

  starterstoreHeaderComponent = StarterstoreHeaderComponent;

  constructor ( router: Router,
                apiUrlsService: ApiUrlsService,
                componentMappingsService: ComponentMappingsService,
                initializeSdkService: InitializeSdkService,
                requestContextService: RequestContextService ) {
    super ( router, apiUrlsService, componentMappingsService, initializeSdkService, requestContextService );
  }

  ngOnInit () {
    super.ngOnInit();
  }

  findCart() {
    this.cartFound = true;
  }

  removeItem(itemId: String) {

  }

  updateItemCount(itemId: String) {

  }

}
