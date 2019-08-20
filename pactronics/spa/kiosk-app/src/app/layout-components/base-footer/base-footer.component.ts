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

@Component ( {
  selector: 'app-base-footer',
  templateUrl: './base-footer.component.html',
  styleUrls: [ './base-footer.component.scss' ]
} )
export class BaseFooterComponent implements OnInit {

  constructor ( private router: Router,
                private apiUrlsService: ApiUrlsService,
                private componentMappingsService: ComponentMappingsService,
                private initializeSdkService: InitializeSdkService,
                private requestContextService: RequestContextService ) {
  }

  ngOnInit () {
    this.apiUrlsService.setApiUrls ( environment.apiUrls );
    this.componentMappingsService.setComponentMappings ( ComponentsCatalog.componentMappings );
    this.requestContextService.parseUrlPath ( this.router.url );
    this.initializeSdkService.initialize ();
  }

}
