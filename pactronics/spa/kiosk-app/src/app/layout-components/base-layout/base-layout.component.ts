import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { StarterstoreHeaderComponent } from '@app/layout-components';
import {
  ApiUrlsService,
  ComponentMappingsService,
  InitializeSdkService,
  RequestContextService
} from 'bloomreach-experience-ng-sdk';
import { environment } from '../../../environments/environment';
import { ComponentsCatalog } from '../../components-catalog';

@Component ( {
  selector: 'app-base-layout',
  templateUrl: './base-layout.component.html',
  styleUrls: [ './base-layout.component.scss' ]
} )
export class BaseLayoutComponent implements OnInit {

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

}
