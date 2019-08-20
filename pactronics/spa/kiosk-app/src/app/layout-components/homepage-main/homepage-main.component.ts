import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import {
  ApiUrlsService,
  ComponentMappingsService,
  InitializeSdkService,
  RequestContextService
} from 'bloomreach-experience-ng-sdk';
import { environment } from '../../../environments/environment';
import { ComponentsCatalog } from '../../components-catalog';
import { StarterstoreHeaderComponent } from '../starterstore-header/starterstore-header.component';

@Component ( {
  selector: 'app-homepage-main',
  templateUrl: './homepage-main.component.html',
  styleUrls: [ './homepage-main.component.scss' ]
} )
export class HomepageMainComponent implements OnInit {

  starterstoreHeaderComponent = StarterstoreHeaderComponent;

  constructor ( protected router: Router,
                protected apiUrlsService: ApiUrlsService,
                protected componentMappingsService: ComponentMappingsService,
                protected initializeSdkService: InitializeSdkService,
                protected requestContextService: RequestContextService ) {
  }

  ngOnInit () {
    this.apiUrlsService.setApiUrls ( environment.apiUrls );
    this.componentMappingsService.setComponentMappings ( ComponentsCatalog.componentMappings );
    this.requestContextService.parseUrlPath ( this.router.url );
    this.initializeSdkService.initialize ();
  }

  findCart () {
    this.router.navigateByUrl ( '/cart' );
  }

  getHelp () {
    this.alertNotImplemented ( 'Get Associate' );
  }

  openChat () {
    this.alertNotImplemented ( 'Chat' );
  }

  shopStore () {
    this.router.navigateByUrl ( '/store' );
  }

  alertNotImplemented ( feature: string ): void {
    alert ( (feature ? feature + ' ' : '') + 'Feature Not Implemented' );
  }

}
