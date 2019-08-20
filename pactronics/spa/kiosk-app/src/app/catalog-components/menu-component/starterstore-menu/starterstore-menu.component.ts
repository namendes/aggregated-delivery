import { Component, Input, OnInit } from '@angular/core';

@Component ( {
  selector: 'app-starterstore-menu',
  templateUrl: './starterstore-menu.component.html',
  styleUrls: [ './starterstore-menu.component.scss' ]
} )
export class StarterstoreMenuComponent implements OnInit {

  @Input () content: any;
  @Input () configuration?: any;
  @Input () template: string;

  constructor () {
  }

  ngOnInit () {
  }

}
