import { Component, OnInit } from '@angular/core';
import { BaseCatalogComponent } from '@app/common';
import {
  BaseComponent,
  getNestedObject,
  ImageUrlService,
  PageModelService
} from 'bloomreach-experience-ng-sdk';

@Component ( {
  selector: 'app-logo',
  templateUrl: './logo.component.html',
  styleUrls: [ './logo.component.scss' ]
} )
export class LogoComponent extends BaseCatalogComponent implements BaseComponent, OnInit {

  constructor ( imageUrlService: ImageUrlService,
                pageModelService: PageModelService ) {
    super ( imageUrlService, pageModelService );
  }

  ngOnInit () {
    super.ngOnInit ();
  }

  getImageUrl (): string {
    if ( this.configuration ) {
      const imageRef = getNestedObject ( this.configuration, [ 'models', 'document' ] );
      if ( imageRef ) {
        return super.getImageUrl ( imageRef );
      }
    }
  }

  hasImage (): boolean {
    if ( this.configuration ) {
      const imageRef = getNestedObject ( this.configuration, [ 'models', 'document' ] );
      if ( imageRef ) {
        return true;
      }
    }
    return false;
  }

}
