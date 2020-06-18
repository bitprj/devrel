import numpy as np
import requests
import pandas as pd
from bs4 import BeautifulSoup

#columns we want to extract
features = {'player','season','team_id','pts_per_g'}

#dataframe to store temp and final data
final_df = pd.DataFrame(columns = features)

#numpy tool to iterate over for loop by 100 (9 pages in this example)
pages = np.arange(0,900,100)
for i in pages:
   #get url, use .get() to pass into Beautiful soup parser
   #allows us to look at metadata
   url = "https://www.basketball-reference.com/play-index/psl_finder.cgi?request=1&match=single&type=per_game&per_minute_base=36&per_poss_base=100&lg_id=NBA&is_playoffs=N&year_min=1985&year_max=2020&franch_id=&season_start=1&season_end=-1&age_min=0&age_max=99&shoot_hand=&height_min=0&height_max=99&birth_country_is=Y&birth_country=&birth_state=&college_id=&draft_year=&is_active=&debut_yr_nba_start=&debut_yr_nba_end=&is_hof=&is_as=&as_comp=gt&as_val=0&award=&pos_is_g=Y&pos_is_gf=Y&pos_is_f=Y&pos_is_fg=Y&pos_is_fc=Y&pos_is_c=Y&pos_is_cf=Y&qual=&c1stat=pts_per_g&c1comp=gt&c1val=20&c2stat=&c2comp=&c2val=&c3stat=&c3comp=&c3val=&c4stat=&c4comp=&c4val=&c5stat=&c5comp=&c6mult=&c6stat=&order_by=pts_per_g&order_by_asc=&offset="+str(i)
   page = requests.get(url)
   soup = BeautifulSoup(page.text,'html.parser')
   
   #stats loops over the features we picked, matches them to headers
   #If matched with headers, returns that column of data
   stats = [[td.getText() for td in soup.findAll('td', {'data-stat': f})] for f in features]
   
   #convert to dataframe, rename columns and flip information to append easily
   stats_df = pd.DataFrame(stats)
   stats_df = stats_df.transpose()
   stats_df.columns = features
   final_df = final_df.append(stats_df)
   
#isin, dropna function for dirty data
new_df = final_df[final_df.team_id.isin(['CHI','LAL','BOS','NYK','PHO'])]
new_df = new_df.append(pd.Series(dtype='object'),ignore_index=True)
new_df = new_df.dropna()
final_df = final_df.dropna()

#display the information and pass files into csv's
final_df.head();
new_df.head();

final_df.to_csv('20ppg.csv')
