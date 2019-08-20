
###### Start CMS

`cd pactronics`

`mvn -T 1C clean verify && mvn -T 1C -Pcargo.run`


###### Start OPEN-UI app
`cd frontend/ng-app`

`npm install`

`ng serve`


###### Start PREVIEW site (http://me:3001/site/_cmsinternal/external)
`cd frontend/proxy`

`npm install`

`npm run aggregator-preview`


###### Start LIVE site (http://me:3000)
`cd frontend/proxy`

`npm install`

`npm run aggregator`



