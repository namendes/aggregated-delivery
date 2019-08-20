import { Component, OnInit } from '@angular/core';
import {
  BaseComponent,
  getNestedObject,
  ImageUrlService,
  PageModelService,
  SingleContentComponent
} from 'bloomreach-experience-ng-sdk';

@Component ( {
  selector: 'app-base-catalog-component',
  template: `<p>BaseCatalogComponent must be extended</p>`,
  styles: []
} )
export class BaseCatalogComponent extends SingleContentComponent implements BaseComponent, OnInit {

  content: any[] = [];
  template: string;

  constructor ( imageUrlService: ImageUrlService,
                pageModelService: PageModelService ) {
    super ( imageUrlService, pageModelService );
  }

  ngOnInit () {
    super.ngOnInit ();
    this._getTemplate();
  }

  getContent (): void {
    const type = this._getContentType ();
    if ( type !== '' ) {
      switch ( type ) {
        case 'pageable':
          this._getPageableItems ();
          return;
        case 'menu':
          this._getMenuItems ();
          return;
        case 'documents':
          this._getDocuments ();
          return;
        default:
          this._getDocument ();
      }
    }
  }

  getLinkedContentUrl ( content: any ): string {
    const contentRef = getNestedObject ( content, [ 'link', '$ref' ] );
    if ( contentRef ) {
      const linkedContent = this.pageModelService.getContentViaReference ( contentRef );
      const href = getNestedObject ( linkedContent, [ '_links', 'site', 'href' ] );
      return href.replace('/site/kiosk','');
    }
  }

  getLinkUrl ( item: any ): string {
    const href = getNestedObject ( item, [ '_links', 'site', 'href' ] );
    return href.replace('/site/kiosk','');
  }

  hasContent (): boolean {
    return this.content.length > 0;
  }

  _getContentType (): string {
    if ( getNestedObject ( this.configuration, [ 'models', 'document', '$ref' ] ) ) {
      return 'document';
    } else if ( getNestedObject ( this.configuration, [ 'models', 'menu', 'siteMenuItems' ] ) ) {
      return 'menu';
    } else if ( getNestedObject ( this.configuration, [ 'models', 'pageable', 'items' ] ) ) {
      return 'pageable';
    } else if ( getNestedObject ( this.configuration, [ 'models', 'documents' ] ) ) {
      return 'documents';
    } else {
      return '';
    }
  }

  _getDocument (): void {
    const contentRef = getNestedObject ( this.configuration, [ 'models', 'document', '$ref' ] );
    if ( contentRef ) {
      this.content.push ( this.pageModelService.getContentViaReference ( contentRef ) );
    }
  }

  _getDocuments (): void {
    const documentsRef = getNestedObject ( this.configuration, [ 'models', 'documents' ] );
    if ( documentsRef && documentsRef instanceof Array ) {
      documentsRef.forEach ( item => {
        this.content.push ( this.pageModelService.getContentViaReference ( item[ '$ref' ] ) );
      } );
    }
  }

  _getMenuItems (): void {
    const itemsRef = getNestedObject ( this.configuration, [ 'models', 'menu', 'siteMenuItems' ] );
    if ( itemsRef && itemsRef instanceof Array ) {
      itemsRef.forEach ( item => {
        this.content.push ( item );
      } );
    }
  }

  _getPageableItems (): void {
    const itemsRef = getNestedObject ( this.configuration, [ 'models', 'pageable', 'items' ] );
    if ( itemsRef && itemsRef instanceof Array ) {
      itemsRef.forEach ( item => {
        this.content.push ( this.pageModelService.getContentViaReference ( item[ '$ref' ] ) );
      } );
    }
  }

  _getTemplate (): void {
    const t = getNestedObject ( this.configuration, [ '_meta', 'params', 'org.hippoecm.hst.core.component.template' ] );
    if (t) {
      const start = t.valueOf().lastIndexOf('/')+1;
      const filename = t.valueOf().substring(start);
      this.template = filename.replace('.ftl','');
    }
  }

}
