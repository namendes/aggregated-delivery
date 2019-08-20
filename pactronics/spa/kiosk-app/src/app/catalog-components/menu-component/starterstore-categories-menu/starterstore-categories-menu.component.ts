import { Component, Input, OnInit } from '@angular/core';

@Component ( {
  selector: 'app-starterstore-categories-menu',
  templateUrl: './starterstore-categories-menu.component.html',
  styleUrls: [ './starterstore-categories-menu.component.scss' ]
} )
export class StarterstoreCategoriesMenuComponent implements OnInit {

  @Input () content: any;
  @Input () configuration?: any;
  @Input () template: string;

  constructor () {
  }

  ngOnInit () {
  }

}
