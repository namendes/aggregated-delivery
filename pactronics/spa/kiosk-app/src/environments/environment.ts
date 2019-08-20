// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  apiUrls: {
    live: {
      apiPath: 'resourceapi',
      channelPath: 'kiosk',
      contextPath: 'site',
      hostname: 'localhost',
      port: 8080,
      previewPrefix: '_cmsinternal',
      scheme: 'http'
    },
    preview: {
      apiPath: 'resourceapi',
      channelPath: 'kiosk',
      contextPath: 'site',
      hostname: 'localhost',
      port: 8080,
      previewPrefix: '_cmsinternal',
      scheme: 'http'
    }
  },
  bloomreach: {
    accountId: 6212,
    apiBaseURL: 'http://brm-core-0.brsrvr.com/api/v1/core/',
    domainKey: 'pactronics'
  },
  sitelogo: {
    default: '//localhost:8080/site/binaries/content/gallery/brxforcdemo/logos/logo.svg',
    small: '//localhost:8080/site/binaries/content/gallery/brxforcdemo/logos/pactronics_logo.png',
    altText: 'Pacific Electronics'
  }
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.
