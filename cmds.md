caculate brck usage stats given JSON file

ss = pd.read_json("status.json")
s1 = pd.concat([pd.DataFrame.from_dict(item, orient='index').T for item in ss.statuses])

to = s1[['wan_rx','wan_tx' ]].sum()/1000000 # get MBs
to.sum()