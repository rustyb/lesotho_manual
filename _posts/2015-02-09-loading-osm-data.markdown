---
layout: post
title:  "Day 2 - Counting Nearby Features"
date:   2015-02-10 08:00:00
categories: update
---
**THIS IS A DRAFT AND THERFORE NOT COMPLETE**

## Requirements
- Must have OpenGeo Suite Installed - [Download OpenGeoSuite][open_geo]
- QGIS Installed - [Download QGIS][qgis]
- Must have loaded the lesotho database into PostGIS. For instructions see - [**Day 2 - Loading OSM Data to Database**]({% post_url 2015-02-09-loading-osm-data %})

### **Contents**

5. [Extra Resources](#extra-resources)


Today we are going to find out how many buildings there are within 100 meters of road (highway) in all of Lesotho. To do this we will use the functionality of PostGIS and then we will use QGIS to view the results of this.

Furthermore we can then update our query to show us the numbers of each type of building which are within 100m of the road.

First we must understand one thing about PostGIS. This is how does it store it's geometry. It does this in a format called **WKB** (Well Known Binary). It the column of our table which contains this information which makes our GIS database so powerful. We run all our spatial queries against it.

| Tables        | Geometry Column           | CRS Projection  |
| ------------- |:-------------:| -----:|
| planet_osm_line      | **way** | 900913 - Google Mercator (m) |
| planet_osm_point      | **way**      |   900913 - Google Mercator (m) |
| planet_osm_polygon |  **way**     |    900913 - Google Mercator (m) | 


To do this we will use the ```ST_Buffer``` function from PostGIS. This create a buffer around the objects just like you would do in a desktop GIS.

Using ```ST_Buffer``` is as simple as below. We supply it some geometry and then set the distance we would like to buffer. In our case we will use 100m as we know the data is stored with a CRS where the unit of measurement is in meters.

{% highlight ruby %}
geometry ST_Buffer(geometry g1, float radius_of_buffer);
{% endhighlight %}

![stbuffer1]({{site.baseurl}}/img/day2/st_buffer01.png)
![stbuffer1]({{site.baseurl}}/img/day2/st_buffer03.png)

Above are two examples of how the buffer works visually. You can apply it to points, lines and polygons. The query will return **polygon geometry type**.

## Extra Resources
- [**An Introduction Course to OpenGeo Suite.** This will introduce you to the different tools which come with this package and how you can use them to serve up a web map][intro_opengeo]
- [**Introduction to PostGIS.** This course will show you each of the geospatial functions that are part of PostGIS and how you can use them under different scenarios][intro_postgis]


[open_geo]:        http://boundlessgeo.com/solutions/opengeo-suite/download/
[qgis]:	           http://www2.qgis.org/en/site/
[qgis_tuts]:       http://www.qgistutorials.com
[intro_opengeo]:   http://workshops.boundlessgeo.com/suiteintro/
[intro_postgis]:   http://workshops.boundlessgeo.com/postgis-intro/