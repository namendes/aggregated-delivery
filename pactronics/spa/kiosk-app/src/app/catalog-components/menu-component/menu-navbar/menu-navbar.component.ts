import { Component, Input, OnInit } from '@angular/core';
import { getNestedObject } from 'bloomreach-experience-ng-sdk';

@Component ( {
  selector: 'app-menu-navbar',
  templateUrl: './menu-navbar.component.html',
  styleUrls: [ './menu-navbar.component.scss' ]
} )
export class MenuNavbarComponent implements OnInit {

  @Input () content: any;
  @Input () configuration?: any;
  @Input () template: string;

  constructor () {
  }

  ngOnInit () {
  }

  getLinkUrl ( item: any ): string {
    const href = getNestedObject ( item, [ '_links', 'site', 'href' ] );
    return href.replace ( '/site/kiosk', '' );
  }

  hasSubMenu ( item: any ): boolean {
    const submenu = getNestedObject ( item, [ 'childMenuItems' ] );
    return submenu && submenu.length > 0;
  }

  onclick ( item: any ): void {
    const href = getNestedObject ( item, [ '_links', 'site', 'href' ] );
    location.href = href.replace ( '/site/kiosk', '' );
  }

}
