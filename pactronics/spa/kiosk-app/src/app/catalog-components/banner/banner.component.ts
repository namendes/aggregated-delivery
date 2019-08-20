import { Component, OnInit } from '@angular/core';
import { BaseCatalogComponent } from '@app/common';
import { BaseComponent, ImageUrlService, PageModelService } from 'bloomreach-experience-ng-sdk';

@Component ( {
  selector: 'app-banner',
  templateUrl: './banner.component.html',
  styleUrls: [ './banner.component.scss' ]
} )
export class BannerComponent extends BaseCatalogComponent implements BaseComponent, OnInit {

  constructor ( imageUrlService: ImageUrlService,
                pageModelService: PageModelService ) {
    super ( imageUrlService, pageModelService );
  }

  ngOnInit () {
    super.ngOnInit ();
  }

  getLinkUrl (): string {
    if ( this.content[ 0 ].link ) {
      return this.getLinkedContentUrl ( this.content[ 0 ] );
    } else if ( this.content[ 0 ].externalLink ) {
      return this.content[ 0 ].externalLink;
    } else {
      return '#';
    }
  }

  hasLink (): boolean {
    return this.content[ 0 ].link || this.content[ 0 ].externalLink;
  }

}
