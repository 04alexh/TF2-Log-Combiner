# TF2-Log-Combiner
Program I wrote awhile ago to learn R. Combines logs.tf logs and makes them into a spreadsheet you can upload to excel.


**HOW TO USE**

You need R obviously. These two R files create functions you can run in the terminal. For both, you need to input the link to the log's json (you can see how to get these
on logs.tf), what you want RED to be named, and what you want BLU to be named. Then the function will use its spaghetti code to create a large data frame you can analyze in R 
or even upload to excel. If you do the function multiple times, it will collate data if a player matches steam id, class, and team. If any of these differ, it creates a new member
on the data frame.

**COLLATOR PROGRAMS**

There are two collator programs that combine data frames in different ways if you desire to do so. 

The player collator will collapse data if a player's steamid is the same, so it combines
all the stats of one player regardless of classes and teams to show a players total stats across classes and teams.

The team collator will collapse data into each individual team to view team stats.

Both of these functions only need the name of whatever data frame you want to have collapsed.
