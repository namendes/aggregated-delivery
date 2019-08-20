import { Component, OnInit } from '@angular/core';
import { BaseCatalogComponent } from '@app/common';
import { BaseComponent, ImageUrlService, PageModelService } from 'bloomreach-experience-ng-sdk';

@Component ( {
  selector: 'app-menu-component',
  templateUrl: './menu.component.html',
  styleUrls: [ './menu.component.scss' ]
} )
export class MenuComponent extends BaseCatalogComponent implements BaseComponent, OnInit {

  constructor ( imageUrlService: ImageUrlService,
                pageModelService: PageModelService ) {
    super ( imageUrlService, pageModelService );
  }

  ngOnInit () {
    super.ngOnInit ();
  }

}
