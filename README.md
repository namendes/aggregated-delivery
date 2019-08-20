
This demo is configured to run in a URL like this: http://me
Please configure your local HOSTS file with this entry
 

###### Start OPEN-UI app
`cd frontend/ng-app`

`npm install`

`ng serve`

###### Start PREVIEW site (http://me:3001/site/_cmsinternal/external)
`cd frontend/proxy`

`npm install`

`npm run aggregator-preview`

###### Start CMS (http://me:3001/cms)

`cd pactronics`

`mvn -T 1C clean verify && mvn -T 1C -Pcargo.run`




###### Start LIVE site (http://me:3000)
`cd frontend/proxy`

`npm install`

`npm run aggregator`



