Open Chrome and go to:
192.168.69.240:4000


BRCK ...F14E Pass:
maplesothoday2



SELECT highway, way 
FROM planet_osm_line
LIMIT 100

SELECT waterway, COUNT(*)
FROM planet_osm_line
WHERE waterway IS NOT NULL
GROUP BY waterway

CREATE TABLE leribe_line AS
SELECT * FROM planet_osm_line
WHERE ST_Intersects(
	(SELECT way AS the_geom
FROM planet_osm_polygon
WHERE 	admin_level = '5'  AND 
	boundary = 'administrative' AND 
	name = 'Leribe District'), way) 
	

CREATE TABLE leribe_river_buffer_300 AS
SELECT ST_Union(ST_Buffer(way, 300)) AS the_geom
FROM leribe_line
WHERE waterway IN ('stream', 'river')



building; count
house, 2
shed, 3







waterway = stream
waterway = river
waterway = drain

SELECT waterway, COUNT(*)
FROM planet_osm_line
WHERE waterway IS NOT NULL
GROUP BY waterway


CREATE TABLE river_buffer_300 AS
SELECT ST_Union(ST_Buffer(way, 300)) AS the_geom
FROM planet_osm_line
WHERE waterway IN ('stream', 'river')




SELECT building, COUNT (*)
FROM buildings_in_danger
GROUP BY building












SELECT COUNT(*)
FROM river_buffer_300 as rb, 
	lesotho_buildings as bs
WHERE ST_Intersects(rb.the_geom,bs.way)




CREATE TABLE buildings_in_danger
SELECT 
	bs.way
FROM 
	river_buffer_300 as rb, 
	lesotho_buildings as bs
WHERE 
	ST_Intersects(rb.the_geom,bs.way)

#### STEPS TO FOLLOW
rustyb.github.io/lesotho_manual



CREATE TABLE buildings_in_danger AS
(SELECT bs.way, bs.building
FROM 
	lirebe_river_buffer_300 as rb, 
	lesotho_buildings as bs
WHERE 
	ST_Intersects(bs.way,rb.the_geom))



39201/106155*100





# WiFi
BRCK_****_F14E
maplesotho

# Manual for this week
http://rustyb.github.io/lesotho_manual/

osm.org




### Road reservations
- Focusing on appropriate development distance from roads. Spec. Primary Roads.
- 15m either side from center line of road.
	- Building features
	- Power Lines
	- Any permanent structure.

Statistics on the number of permanent structures within this reservation.

**Key Steps**
1. Select all the primary roads. 
	```planet_osm_lines```
2. Create a 15m buffer around the roads.
3. Find all the buildings within the buffer zone.
4. Find all power lines (line, poles), sewer lines (line, manholes), trees, billboards.
5. Categorize structure distance from road centerline. (**0-5m, 6-10m, 11-15m**) 






DROP TABLE primary_roads;
CREATE TABLE primary_roads AS
SELECT highway, way
FROM planet_osm_line
WHERE highway = 'primary'

CREATE TABLE 
SELECT building, way FROM lesotho_buildings
WHERE ST_Intersects(
	(SELECT the_geom
		FROM road_buffer_151 
		WHERE dist = 25
), ST_Centroid(way));







CREATE TABLE power_features AS
SELECT power, way AS points
FROM planet_osm_point
WHERE power IS NOT NULL





SELECT highway, COUNT (*)
FROM planet_osm_line
WHERE highway IS NOT NULL
GROUP BY highway



- imagery VHSR from possibly....WorldView 2 or 3??
-


CREATE TABLE maseru_hospital AS
SELECT building, way
FROM lesotho_buildings
WHERE 
	building = 'hospital' AND
	ST_Intersects(
		(SELECT way AS the_geom
		FROM planet_osm_polygon
		WHERE 	admin_level = '5'  AND 
			boundary = 'administrative' AND 
			name = 'Maseru District'),
		way
	)



CREATE TABLE leribe_line AS
SELECT * FROM planet_osm_line
WHERE ST_Intersects(
	(, way) 



















