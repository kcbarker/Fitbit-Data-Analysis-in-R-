install.packages("tidyverse")
install.packages("lubridate")
install.packages("dplyr")

library(tidyverse)
library(lubridate)
library(dplyr)

# once packages loaded uploading datasets for analysis 

daily_activity <-read_csv("dailyActivity_merged.csv")
daily_sleep <- read_csv("sleepDay_merged.csv")
hourly_calories <- read_csv("hourlyCalories_merged.csv")
hourly_steps <- read_csv("hourlySteps_merged.csv")
hourly_intensities <- read_csv("hourlyIntensities_merged.csv")

#viewing detail of datasets 

head(daily_activity)
head(daily_sleep)
head(hourly_calories)
head(hourly_steps)
head(hourly_intensities)

#dates/times need formatting so data can be merged 

daily_sleep$SleepDay <- as.Date(daily_sleep$SleepDay, "%m/%d/%y")
daily_activity$ActivityDate <- as.Date(daily_activity$ActivityDate, "%m/%d/%y")
hourly_calories$ActivityHour <- mdy_hms(hourly_calories$ActivityHour,tz=Sys.timezone())
hourly_steps$ActivityHour <- mdy_hms(hourly_steps$ActivityHour,tz=Sys.timezone())
hourly_intensities$ActivityHour <- mdy_hms(hourly_intensities$ActivityHour,tz=Sys.timezone())

#updating column names in daily_activity and daily_sleep so that "Date" is the same 

colnames(daily_activity)[2] = "Date"
colnames(daily_sleep) [2] = "Date"

#merging daily_activity and daily_sleep dataframes for analysis 

merged_activity_and_sleep <- merge(daily_activity, daily_sleep, by = c("Id", "Date"))

head(merged_activity_and_sleep)

#analysis of merged_activity_and_sleep data by ID 

summary_by_id <- merged_activity_and_sleep %>% 
  group_by (Id) %>% 
  summarise (average_steps = mean(TotalSteps),
             average_sleep = mean(TotalMinutesAsleep),
             average_calories = mean(Calories),
             average_sedentary_time = mean(SedentaryMinutes),
             average_active_minutes = mean(sum(VeryActiveMinutes, FairlyActiveMinutes, LightlyActiveMinutes)))

view(summary_by_id)

#merging all hourly data - as three dataframes using list and reduce method 

all_hourly_data <- list(hourly_calories, hourly_intensities, hourly_steps) %>%
  reduce(inner_join, by = c("Id", "ActivityHour"))

head(all_hourly_data)

#creating data showing all hourly data but with the date removed and showing the time of day only for analysis

all_hourly_data_time_only <- all_hourly_data

all_hourly_data_time_only$ActivityHour <- format(as.POSIXct(all_hourly_data$ActivityHour), format = "%H:%M:%S")

head(all_hourly_data_time_only)

#analysis of data with visualisations 

ggplot(data=all_hourly_data_time_only) + geom_point(mapping = aes(x = ActivityHour, y = Calories, colour = TotalIntensity)) + labs(title = "Hourly Data: Calories Burned and Total Intensity", subtitle = "Analysis of most popular times of day for tracking exercise") + annotate("text", x=10, y=1000, label = "Evenings are more popular than mornings for tracking exercise", colour = "blue")
ggsave("Hourly Analysis.png")

ggplot(data=merged_activity_and_sleep) + geom_point(mapping = aes(x = TotalSteps, y = TotalMinutesAsleep))

ggplot(data=merged_activity_and_sleep) + geom_point(mapping = aes(x = Calories, y = TotalMinutesAsleep))

ggplot(data=merged_activity_and_sleep, aes (x = TotalMinutesAsleep, y = SedentaryMinutes)) + geom_point(colour="grey") + geom_smooth(colour="red") + labs(title = "Sedentary Minutes vs Time Asleep")
ggsave("Sedentary Minutes vs Time Asleep.png")

