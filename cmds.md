caculate brck usage stats given JSON file

ss = pd.read_json("status2.json")
s1 = pd.concat([pd.DataFrame.from_dict(item, orient='index').T for item in ss.statuses])

to = s1[['wan_rx','wan_tx' ]].sum()/1000000 # get MBs
to2 = to.sum()


ss = pd.read_json("status1.json")
s1 = pd.concat([pd.DataFrame.from_dict(item, orient='index').T for item in ss.statuses])

to = s1[['wwan_rx_total','wwan_tx_total' ]].sum()/1000000 # get MBs
to3 = to.sum()
ss = pd.read_json("status2.json")
s1 = pd.concat([pd.DataFrame.from_dict(item, orient='index').T for item in ss.statuses])

to = s1[['wwan_rx_total','wwan_tx_total' ]].sum()/1000000 # get MBs
to4 = to.sum()

# Buffer all buildings by 100m
CREATE TABLE test AS
SELECT ST_Union(ST_Buffer(way, 100)) AS the_geom
FROM planet_osm_polygon
WHERE building = 'yes'