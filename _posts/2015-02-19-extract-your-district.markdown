---
layout: post
title:  "How to extract your District"
date:   2015-02-19
categories: update
---
This section is very simple and will build upon what we have done all week. It will show you how to extract on the features you are interested in that are located in your district.

We use the intersects function to find only those features in our district.

Districts are in the polygons table and have the tag ```admin_level = 5```.

To find the names of the districts in our database we run the following query in our pgadmin window. It will output a list of the districts. You will need to copy the district name from it's respective row exactly as it is written.

{% highlight sql %}
SELECT name, admin_level, boundary
FROM planet_osm_polygon
WHERE admin_level = '5' 
{% endhighlight%}

As an example we are going to extract the ```lines```, ```points``` and ```polygons``` **Qacha's Nek District**. 

We first get the Qacha's Nek District polygon and then perform a spatial intersection on this with the geometries from our points, line and polygon tables.

We then use the intersection function to return only the geometries within the district.

{% highlight sql %}
DROP TABLE IF EXISTS my_district_point;
CREATE TABLE district_points AS
SELECT * 
FROM planet_osm_point
WHERE ST_Intersects(
	SELECT way
	FROM planet_osm_polygon
	WHERE admin_level = '5' AND
	name = 'Qacha''s Nek District', -- Qacha's Nek Polygon
	way -- geometry from points table
);

DROP TABLE IF EXISTS my_district_line;
CREATE TABLE my_district_line AS
SELECT * 
FROM planet_osm_line
WHERE ST_Intersects(
	SELECT way
	FROM planet_osm_polygon
	WHERE admin_level = '5' AND
	name = 'Qacha''s Nek District', -- Qacha's Nek Polygon
	way -- geometry from lines table
);

DROP TABLE IF EXISTS my_district_polygon;
CREATE TABLE my_district_polygon AS
SELECT * 
FROM planet_osm_polygon
WHERE ST_Intersects(
	SELECT way
	FROM planet_osm_polygon
	WHERE admin_level = '5' AND
	name = 'Qacha''s Nek District', -- Qacha's Nek Polygon
	way -- geometry from points table
);
{% endhighlight%}

This will create a line, point and polygon table just for Qacha's Nek or your respective district.