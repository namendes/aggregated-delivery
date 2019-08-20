import {Component, Input, OnInit} from '@angular/core';

@Component({
  selector: 'app-base-logo',
  templateUrl: './base-logo.component.html',
  styleUrls: ['./base-logo.component.scss']
})
export class BaseLogoComponent implements OnInit {
  @Input() imageSrc: String;
  @Input() altText: String;

  constructor() { }

  ngOnInit() {
  }

}
