---
layout: post
title:  "Day 2 - Counting Nearby Features"
date:   2015-02-10
categories: update
---
**THIS IS A DRAFT AND THEREFORE NOT COMPLETE**

## Requirements
- Must have OpenGeo Suite Installed - [Download OpenGeoSuite][open_geo]
- QGIS Installed - [Download QGIS][qgis]
- Must have loaded the lesotho database into PostGIS. For instructions see - [**Day 2 - Loading OSM Data to Database**]({% post_url 2015-02-10-loading-osm-data %})

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


Above are two examples of how the buffer works visually. You can apply it to points, lines and polygons. The query will return **polygon geometry type**.

## Creating Buffers
We can create buffers of a certain distance around any spatial row within the database. To do this we use a function call ```ST_Buffer()```. So first a bit about how the SQL queries work when using ```ST_Buffer()```.

You need to supply it the geometry for each row and then the GIS create a polygon buffer of as many meters you specify around the features. An illustration of how this works is in the image below:

![stbuffer1]({{site.baseurl}}/img/day2/st_buffer01.png)
![stbuffer1]({{site.baseurl}}/img/day2/st_buffer03.png)

The query takes this form below, where:

- *geometry* = the input table geometry
- *geometry g1* = the input geometry field 
- *float radius_of_buffer* = a real number in distance such as 100 or 200.

{% highlight ruby %}
geometry ST_Buffer(geometry g1, float radius_of_buffer);
{% endhighlight %}

**For a full reference manual on buffering see [ST_Buffer_Manual][st_buff_link]**

## Find potential flood zones
The key steps for this are as follows:

- Open QGIS and add your ```buildings``` and ```waterways``` as separate layers.
- Open PgAdmin and load up the ```lesotho``` database.
- Create table of **300m buffers** around each of the waterways.
- Use Postgres to count the number of buildings located in this flooding buffer area.
- Show only the buildings located within the flooding buffer area.

### Load buildings and waterways
Add PostGIS Layers of the 

Right click on the planet_osm_line then **click filter** and then filter for the streams and rivers.

Use the following query to do so:

	"waterways" IN ('stream', 'river')

This will allow us to only show streams and rivers throughout Lesotho.

### Load Lesotho Database

Extract all features for Leribe.

{% highlight ruby %}
CREATE TABLE leribe AS
SELECT * FROM planet_osm_line
WHERE ST_Intersects(
(SELECT way AS the_geom
FROM planet_osm_polygon
WHERE 	admin_level = '5'  AND 
	boundary = 'administrative' AND 
	name = 'Leribe District'), way) 
{% endhighlight %}

### Create the 300m waterway buffers / potential flood areas
{% highlight ruby %}
CREATE TABLE river_buffer_300 AS
SELECT ST_Union(ST_Buffer(way, 300)) AS the_geom
FROM planet_osm_line
WHERE waterway IN ('stream', 'river')
{% endhighlight %}

### Count the buildings within flood area.

### ss


# Buffer all buildings by 100m
{% highlight ruby %}
CREATE TABLE test AS
SELECT ST_Union(ST_Buffer(way, 100)) AS the_geom
FROM planet_osm_polygon
WHERE building = 'yes'
{% endhighlight %}

## Extra Resources
- [**An Introduction Course to OpenGeo Suite.** This will introduce you to the different tools which come with this package and how you can use them to serve up a web map][intro_opengeo]
- [**Introduction to PostGIS.** This course will show you each of the geospatial functions that are part of PostGIS and how you can use them under different scenarios][intro_postgis]

[st_buff_link]: http://postgis.refractions.net/documentation/manual-1.4/ST_Buffer.html