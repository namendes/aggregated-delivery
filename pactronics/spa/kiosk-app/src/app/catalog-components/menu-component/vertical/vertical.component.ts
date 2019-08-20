import { Component, Input, OnInit } from '@angular/core';

@Component ( {
  selector: 'app-vertical',
  templateUrl: './vertical.component.html',
  styleUrls: [ './vertical.component.scss' ]
} )
export class VerticalComponent implements OnInit {

  @Input () content: any;
  @Input () configuration?: any;
  @Input () template: string;

  constructor () {
  }

  ngOnInit () {
  }

}
