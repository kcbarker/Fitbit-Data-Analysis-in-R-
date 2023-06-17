# Fitbit-Data-Analysis-in-R-

This was a project in R as part of the Google Data Analytics Professional Certificate using data from the following source on Kaggle: https://www.kaggle.com/datasets/arashnic/fitbit

The task was to identify trends in the device usage and consider how the trends could be applied to the customers and marketing strategy. 

I decided to focus on analysing the following: 

* Analysing the hourly data to consider when the most popular time for exercise is
* Analysing the sleep data to consider whether Total Steps, Calories or Sedentary Minutes had an impact on the time spent asleep

I had to clean and format the data, particularly the dates and times formats so that the data in the different files could be merged properly. 

I used ggplot to visualise the data to consider any trends in usage based on hourly data and time spent asleep: 

![image](https://github.com/kcbarker/Fitbit-Data-Analysis-in-R-/assets/132820225/b829adf1-f821-4893-b211-71dc454e75f6)

![image](https://github.com/kcbarker/Fitbit-Data-Analysis-in-R-/assets/132820225/bc12fe8c-fcd0-47f0-a19e-ec47fa9ccbce)

There was no correlation between Total Steps and time spent asleep, nor between Calories burned and the time spent asleep. However the analysis showed the following: 

* Evenings are more popular for tracking exercise
* Fewer sedentary minutes during the day correlates to more time spent asleep

This analysis could be used to inform marketing strategy as the company could focus on trying to encourage more tracking of exercise in the mornings (for example with reminders) and/or focus on encouraging users to move more throughout the day to limit their number of sedentary minutes to promte better sleep. 
