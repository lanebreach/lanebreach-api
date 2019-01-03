# API Endpoints

## Bikeway Networks

### GET /api/bikeway_networks

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

## SF 311 Cases

### GET /api/sf311_cases

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
