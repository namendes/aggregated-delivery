import { Component, Input, OnInit } from '@angular/core';

@Component ( {
  selector: 'app-menu-default',
  templateUrl: './menu-default.component.html',
  styleUrls: [ './menu-default.component.scss' ]
} )
export class MenuDefaultComponent implements OnInit {

  @Input () content: any;
  @Input () configuration?: any;
  @Input () template: string;

  constructor () {
  }

  ngOnInit () {
  }

}
