import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component ( {
  selector: 'app-breadcrumb',
  templateUrl: './breadcrumb.component.html',
  styleUrls: [ './breadcrumb.component.scss' ]
} )

export class BreadcrumbComponent implements OnInit {
  crumbs = [];
  skipLabels = ['site','_cmsinternal','kioskapp'];

  constructor ( private router: Router ) {
  }

  ngOnInit () {
    this.getCrumbsFromUrl ();
  }

  getCrumbsFromUrl () {
    const labels = this.router.url.split ( '/' );
    let path = '/';
    let crumb = {
      label: 'home',
      path: path
    };

    for (let idx=0; idx<labels.length; idx++) {

      const label = labels[idx];

      if ( idx > 0 ) {
        let skipCrumb = false;
        this.skipLabels.forEach( skipLabel => {
          if (skipLabel == label) {
            skipCrumb = true;
          }
        });

        if (skipCrumb) {
          continue;
        }

        if ( !path.endsWith ( '/' ) ) {
          path = path.concat ( '/' );
        }

        path = path.concat ( label );

        crumb = {
          label: label,
          path: path
        };
      }

      this.crumbs.push ( crumb );
    }
  }
}
