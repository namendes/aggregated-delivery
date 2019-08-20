import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Logger } from '@app/services/logger.service';
import { environment } from '@env/environment';
import { Observable, of } from 'rxjs';

@Injectable ( {
  providedIn: 'root'
} )
export class BrsmService {

  constructor ( private http: HttpClient, private logger: Logger ) {
  }

  executeSearch ( searchType: string, query: string, widgetId: string, pageSize: number ): Observable<any> {
    const requestURL = this.buildQueryURL ( searchType, query, widgetId, pageSize );
    return this.http.jsonp ( requestURL, 'callback' );
  }

  callback () {
    console.log ( 'received callback' );
  }

  private buildQueryURL ( searchType: string, query: string, widgetId: string, pageSize: number ): string {
    let url = environment.bloomreach.apiBaseURL +
      '?account_id=' + environment.bloomreach.accountId +
      '&domain_key=' + environment.bloomreach.domainKey +
      '&request_id=8438674518839' +
      // '_br_uid_2=uid%3D4886666976926%3Av%3D11.8%3Ats%3D1553615078160%3Ahc%3D16&' +
      '&url=pactronics-poc.onehippo.io/site/kiosk' +
      '&rows=' + pageSize +
      '&start=0' +
      '&fl=pid%2Ctitle%2Cbrand%2Cprice%2Csale_price%2Cpromotions%2Cthumb_image%2Csku_thumb_images%2Csku_swatch_images%2Csku_color_group%2Curl%2Cprice_range%2Csale_price_range%2Cdescription&' +
      '&q=' + query +
      '&search_type=' + searchType +
      '&request_type=search';
    if ( widgetId !== undefined && widgetId !== '' ) {
      url = url + '&widget_id=' + widgetId;
    }
    return url;
  }

  private handleError<T> ( operation = 'operation', result?: T ) {
    return ( error: any ): Observable<T> => {
      console.error ( error );
      this.logger.error ( `${ operation } failed: ${ error.message }` );
      return of ( result as T );
    };
  }

}
