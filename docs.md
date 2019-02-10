# API Documentation

## REST API Endpoints

### Bikeway Networks

#### GET /api/bikeway_networks

**request:**
```
curl -XGET https://lane-breach.herokuapp.com/api/bikeway_networks?lat=37.74675537&long=-122.4587284
```

**response:**
```
{"id":648,"install_yr":"2010.0","streetname":"LAGUNA HONDA BLVD","symbology":"BIKE LANE","dist":0.00506722}
```

**request:**
```
curl -XGET https://lane-breach.herokuapp.com/api/bikeway_networks?lat=-122.4587284&long=37.74675537
```

**response:**
```
null
```

### SF 311 Cases

#### GET /api/sf311_cases

**request:**
```
curl -XGET https://lane-breach.herokuapp.com/api/sf311_cases?start_time=2018-6-15&end_time=2018-6-17
```

`page` and `per_page` query string parameters can also be specified for paging through the result set.
The default page size is 30 items.

**response:**
```
[
  {
    "id": 1,
    "service_request_id": 9145772,
    "requested_datetime": "2018-06-16T15:14:02.000Z",
    "closed_date": "2018-06-16T15:14:09.000Z",
    "updated_datetime": "2018-06-16T15:14:09.000Z",
    "status_description": "Closed",
    "status_notes": "The report has been logged and will help the City collect data on double parking and bike lane violations to determine target areas and future enforcement efforts. Thank you.",
    "agency_responsible": "Parking Enforcement Review Queue",
    "service_name": "Parking Enforcement",
    "service_subtype": "Blocking_Bicycle_Lane",
    "service_details": "Parking Enforcement",
    "address": "2927 FOLSOM ST, SAN FRANCISCO, CA, 94110",
    "supervisor_district": 9,
    "neighborhoods_sffind_boundaries": "Mission",
    "police_district": "MISSION",
    "lat": 37.75041,
    "long": -122.4138,
    "point": "POINT (-122.41369887 37.75039981)",
    "point_city": null,
    "source": "Mobile/Open311",
    "point_state": null,
    "point_address": null,
    "point_zip": null,
    "media_url_description": null,
    "media_url": null,
    "created_at": "2018-11-24T19:54:31.565Z",
    "updated_at": "2018-11-24T19:54:31.565Z"
  },
  ...
]
```

#### POST /api/sf311_cases

**request:**
```
curl -XPOST https://lane-breach.herokuapp.com/api/sf311_cases -H "Content-Type: application/json" -d
  '{
    "sf311_case": {
      "address": "326 14TH ST, SAN FRANCISCO, CA, 94103",
      "agency_responsible": "Parking Enforcement Review Queue",
      "lat": "37.76826",
      "long": "-122.4205",
      "neighborhoods_sffind_boundaries": "Mission",
      "police_district": "MISSION",
      "requested_datetime": "2018-07-11T16:41:59.000",
      "service_details": "Cream - Shitty new 2000s model vw bug - 6ncv876",
      "service_subtype": "Blocking_Bicycle_Lane",
      "source": "Mobile/Open311",
      }
    }'
```

**response:**
```
TBD
```

## GraphQL API Endpoints

If you haven't used GraphQL before, be sure to skim through [the documentation](https://graphql.org/) so you can hit the ground running.

The simplest way to run and test GraphQL queries is to use the [GraphiQL interface](https://github.com/graphql/graphiql). We'd normally rernder the GraphiQL console in browser, but this is an API-only application; instead, you can use the [Electron](https://github.com/electron/electron) based [graphiql-app](https://github.com/skevy/graphiql-app) wrapper for running queries.

### Bikeway Networks

#### Retreiving the nearest bikeway network

**request**:
```
{
  nearest_bikeway_network(lat: 37.74675537, long: -122.4587284) {
    install_yr
    symbology
    streetname
  }
}
```

**response**:
```
{
  "data": {
    "nearest_bikeway_network": [
      {
        "install_yr": 2010,
        "symbology": "BIKE LANE",
        "streetname": "LAGUNA HONDA BLVD"
      }
    ]
  }
}
```

#### Fetch the first 5 cases that took place between April and October 2018

**request:**

```
{
  sf311_cases_connection(start_time: "2018-4-1", end_time: "2018-10-22", first: 5) {
    totalCount
    
    pageInfo {
      startCursor
      endCursor
      hasNextPage
      hasPreviousPage
    }
    
    edges {
      node {
        service_request_id
        address
        requested_datetime

        sf311_case_metadatum {
          bikeway_network_id
        }
      }
    }	
  }
}
```

**response:**
```
{
  "data": {
    "sf311_cases_connection": {
      "totalCount": 32,
      "pageInfo": {
        "startCursor": "MQ==",
        "endCursor": "NQ==",
        "hasNextPage": true,
        "hasPreviousPage": false
      },
      "edges": [
        {
          "node": {
            "service_request_id": "9144235",
            "address": "Intersection of JOHN F KENNEDY DR and TRANSVERSE DR",
            "requested_datetime": "2018-06-16T06:55:38Z",
            "sf311_case_metadatum": {
              "bikeway_network_id": 2660
            }
          }
        },
        {
          "node": {
            "service_request_id": "9145772",
            "address": "2927 FOLSOM ST, SAN FRANCISCO, CA, 94110",
            "requested_datetime": "2018-06-16T15:14:02Z",
            "sf311_case_metadatum": {
              "bikeway_network_id": 741
            }
          }
        },
        {
          "node": {
            "service_request_id": "9514241",
            "address": "1710 MARKET ST, SAN FRANCISCO, CA, 94102",
            "requested_datetime": "2018-09-08T17:21:19Z",
            "sf311_case_metadatum": {
              "bikeway_network_id": 3384
            }
          }
        },
        {
          "node": {
            "service_request_id": "9692741",
            "address": "45 11TH ST, SAN FRANCISCO, CA, 94103",
            "requested_datetime": "2018-10-19T08:36:36Z",
            "sf311_case_metadatum": {
              "bikeway_network_id": 1132
            }
          }
        },
        {
          "node": {
            "service_request_id": "9692999",
            "address": "1810 CESAR CHAVEZ ST, SAN FRANCISCO, CA, 94124",
            "requested_datetime": "2018-10-19T09:12:00Z",
            "sf311_case_metadatum": {
              "bikeway_network_id": 1563
            }
          }
        }
      ]
    }
  }
}
```

See [the documentation on paging and connections](https://graphql.org/learn/pagination/#end-of-list-counts-and-connections) for more details.