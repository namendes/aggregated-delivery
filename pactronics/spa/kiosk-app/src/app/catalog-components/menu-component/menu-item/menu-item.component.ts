import { Component, Input, OnInit } from '@angular/core';
import { getNestedObject } from 'bloomreach-experience-ng-sdk';

@Component ( {
  selector: 'app-menu-item',
  templateUrl: './menu-item.component.html',
  styleUrls: [ './menu-item.component.scss' ]
} )
export class MenuItemComponent implements OnInit {

  @Input () item: any;
  @Input () template?: string;
  link: any;

  constructor () {
  }

  ngOnInit () {
    this.getLink ();
  }

  getLink () {
    this.link = getNestedObject ( this.item, [ '_links', 'site' ] );
  }

}
