import { Component, Input, OnInit } from '@angular/core';
import { BaseComponent } from 'bloomreach-experience-ng-sdk';

@Component ( {
  selector: 'app-starterstore-header',
  templateUrl: './starterstore-header.component.html',
  styleUrls: [ './starterstore-header.component.scss' ]
} )
export class StarterstoreHeaderComponent implements BaseComponent, OnInit {

  @Input () configuration: any;

  constructor () {
  }

  ngOnInit () {
  }

}
