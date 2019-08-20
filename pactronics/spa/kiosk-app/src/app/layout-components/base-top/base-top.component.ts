import { Component, OnInit } from '@angular/core';
import { environment } from '../../../environments/environment';

@Component ( {
  selector: 'app-base-top',
  templateUrl: './base-top.component.html',
  styleUrls: [ './base-top.component.scss' ]
} )
export class BaseTopComponent implements OnInit {
  imageSrc: String;
  altText: String;

  constructor () {
  }

  ngOnInit () {
    this.altText = environment.sitelogo.altText;
    this.imageSrc = environment.sitelogo.small;
  }

}
