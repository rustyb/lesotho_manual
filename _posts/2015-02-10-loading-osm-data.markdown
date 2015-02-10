---
layout: post
title:  "Day 2 - Loading OSM Data to Database"
date:   2015-02-10
categories: update
---
**Loading your OSM Data for Students of planning course run by Fingal County Council in Maseru 09/02/2015**

## Requirements
- Must have OpenGeo Suite Installed - [Download OpenGeoSuite][open_geo]
- QGIS Installed - [Download QGIS][qgis]
- **Have a copy of lesotho_osm1.tar file from Colin**

### **Contents**

1. [Open PgAdmin](#open-pgadmin)
2. [Open PostGIS Database](#open-postgis-database)
3. [Create Lesotho Database](#create-lesotho-database)
4. [Load in data from tar file](#load-in-data-from-tar-file)
5. [Extra Resources](#extra-resources)


## Open PgAdmin
Go to the start menu and look for OpenGeoSuite 3.x. Under this group you will find **PgAdmin**. Click this to open it.

![open pg admin]({{site.baseurl}}/img/day2/pgadmin.png)

## Open PostGIS Database
Double click on **PostGIS** database on the left. 

Next a prompt will show asking for a password.

You should then enter whatever the password is for your normal windows login. Then click OK.

![open pg admin]({{site.baseurl}}/img/day2/login.png)

## Create Lesotho Database
{% highlight ruby %}
CREATE DATABASE lesotho;
{% endhighlight %}

Right click on the **Databases**. Then click **New Database**.
![open pg admin]({{site.baseurl}}/img/day2/newdb.png)

Enter **lesotho** as the name for the new database and **click OK**.
![open pg admin]({{site.baseurl}}/img/day2/newdb1.png)

Now click on the lesotho database to load it up.

Click on **SQL button** in the top bar.

![open pg admin]({{site.baseurl}}/img/day2/sqlq1.png)

Type in the following to window that is now open.

{% highlight ruby %}
CREATE EXTENSION postgis;
{% endhighlight %}

You must then click the **Execute Query** button at the top. When the query has finished running it looks like the image below.
![open pg admin]({{site.baseurl}}/img/day2/exc.png)

## Load in data from tar file
Now in this step we need to make sure we have a copy of the ```lesotho_osm1.tar``` file on our computer. This is required for the next few actions.

Close the SQL Query window. When prompted to save the query, **Click NO**.

Next right click on the lesotho database and choose **Restore **from the menu.

![restore db]({{site.baseurl}}/img/day2/restore.png)

This window will open. Now click the ```...``` and locate the ```lesotho_osm1.tar``` file. When you have selected the file click ok.

![restore db]({{site.baseurl}}/img/day2/restore1.png)

Now click **Restore**. This will take a few minutes before the query finishes.

![restore db]({{site.baseurl}}/img/day2/restore2.png)

When this finishes **click the X** to close the window. Now go to the tables section under the lesotho database (lesotho => Schemas => public => tables). You should now have the same tables as below:

![restore db]({{site.baseurl}}/img/day2/restore3.png)

Congratulations you now have your OSM data in a database which you can use with QGIS.

## Extra Resources
- [**An Introduction Course to OpenGeo Suite.** This will introduce you to the different tools which come with this package and how you can use them to serve up a web map][intro_opengeo]
- [**Introduction to PostGIS.** This course will show you each of the geospatial functions that are part of PostGIS and how you can use them under different scenarios][intro_postgis]






[open_geo]:        http://boundlessgeo.com/solutions/opengeo-suite/download/
[qgis]:	           http://www2.qgis.org/en/site/
[qgis_tuts]:       http://www.qgistutorials.com
[intro_opengeo]:   http://workshops.boundlessgeo.com/suiteintro/
[intro_postgis]:   http://workshops.boundlessgeo.com/postgis-intro/

[open_geo]:        http://boundlessgeo.com/solutions/opengeo-suite/download/
[qgis]:	           http://www2.qgis.org/en/site/
[qgis_tuts]:       http://www.qgistutorials.com
[intro_opengeo]:   http://workshops.boundlessgeo.com/suiteintro/
[intro_postgis]:   http://workshops.boundlessgeo.com/postgis-intro/