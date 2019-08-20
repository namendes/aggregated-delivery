import { Component, OnInit } from '@angular/core';
import { BaseCatalogComponent } from '@app/common';
import { BaseComponent, ImageUrlService, PageModelService } from 'bloomreach-experience-ng-sdk';

@Component ( {
  selector: 'app-simple-content',
  templateUrl: './simple-content.component.html',
  styleUrls: [ './simple-content.component.scss' ]
} )
export class SimpleContentComponent extends BaseCatalogComponent implements BaseComponent, OnInit {

  constructor ( imageUrlService: ImageUrlService,
                pageModelService: PageModelService ) {
    super ( imageUrlService, pageModelService );
  }

  ngOnInit () {
    super.ngOnInit ();
  }

}
