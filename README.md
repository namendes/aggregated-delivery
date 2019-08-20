

###### Start OPEN-UI app
`cd frontend/ng-app`

`npm install`

`ng serve`

###### Start PREVIEW site (http://localhost:3001/site/_cmsinternal/external)
`cd frontend/proxy`

`npm install`

`npm run aggregator-preview`

###### Start CMS (http://localhost:3001/cms)

`cd demo`

`mvn -T 1C clean verify && mvn -T 1C -Pcargo.run`




###### Start LIVE site (http://localhost:3000)
`cd frontend/proxy`

`npm install`

`npm run aggregator`



### The relevance configuration of the aggregator can be found here: `frontend/site-proxy/proxy/src/config.json`
