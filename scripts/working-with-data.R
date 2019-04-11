## load the tidyverse
library(tidyverse)
interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")

## inspect the data
interviews

## select variables
select(interviews, village, no_membrs, years_liv)

## filter rows
filter(interviews, village == "God")

## both at the same time
interviews_god <- interviews %>%
  filter(village == "God") %>%
  select(no_membrs, years_liv)

## exercise
interviews %>% 
  filter(memb_assoc == "yes") %>% 
  select(affect_conflicts, liv_count, no_meals)

# create new variables
interviews %>%
  mutate(people_per_room = no_membrs / rooms)

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  mutate(people_per_room = no_membrs / rooms)

# exercise
interviews_total_meals <- interviews %>%
  mutate(total_meals = no_membrs * no_meals) %>% 
  filter(total_meals > 20) %>% 
  select(village, total_meals)

# summarise()
interviews %>%
	summarize(mean_no_membrs = mean(no_membrs))

# summarise() with group_by()
interviews %>%
	group_by(village) %>%
	summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
	filter(!is.na(memb_assoc)) %>%
	group_by(village, memb_assoc) %>%
	summarize(mean_no_membrs = mean(no_membrs))

interviews %>%
	filter(!is.na(memb_assoc)) %>%
	group_by(village, memb_assoc) %>%
	summarize(mean_no_membrs = mean(no_membrs),
						min_membrs = min(no_membrs))

interviews %>%
	filter(!is.na(memb_assoc)) %>%
	group_by(village, memb_assoc) %>%
	summarize(mean_no_membrs = mean(no_membrs), min_membrs = min(no_membrs)) %>%
	arrange(min_membrs)

interviews %>%
	filter(!is.na(memb_assoc)) %>%
	group_by(village, memb_assoc) %>%
	summarize(mean_no_membrs = mean(no_membrs),
						min_membrs = min(no_membrs)) %>%
	arrange(desc(min_membrs))

# count()
interviews %>%
	count(village)

interviews %>%
	count(village, sort = TRUE)

# exercises
interviews %>%
	count(no_meals)

interviews %>%
	group_by(village) %>%
	summarize(
		mean_no_membrs = mean(no_membrs),
		min_no_membrs = min(no_membrs),
		max_no_membrs = max(no_membrs),
		n = n()
	)

interviews %>%
	mutate(month = lubridate::month(interview_date),
				 year = lubridate::year(interview_date)) %>%
	group_by(year, month) %>%
	summarize(max_no_membrs = max(no_membrs))

## Reshaping with tidyr::gather() and tidyr::spread()
# spread() takes a column contining variable names and 'spreads' them out into separate variables
interviews_spread <- interviews %>%
	mutate(wall_type_logical = TRUE) %>%
	spread(key = respondent_wall_type, value = wall_type_logical, fill = FALSE)

# gather() does the opposite - it takes a group of variables representing different outcomes of the same variable and 
#  'gathers' them together into a single variable
interviews_gather <- interviews_spread %>%
	gather(key = "respondent_wall_type", value = "wall_type_logical",
				 burntbricks:sunbricks) %>%
	filter(wall_type_logical) %>%
	select(-wall_type_logical)

# spread() can be used to separate out multiple pieces of information recorded in a single cell of our data frame
interviews_items_owned <- interviews %>%
	mutate(split_items = strsplit(items_owned, ";")) %>% # splits the string list of items in 'items_owned' into a list of strings
	unnest() %>% # creates an 'observation' for each item in the list
	mutate(items_owned_logical = TRUE) %>%
	spread(key = split_items, value = items_owned_logical, fill = FALSE) %>% # spreads these into their own variables
	rename(no_listed_items = `<NA>`) # <NA> values represent households reporting none of the listed items

# create dataset for plotting in the next lesson
interviews_plotting <- interviews %>%
	## spread data by items_owned
	mutate(split_items = strsplit(items_owned, ";")) %>%
	unnest() %>%
	mutate(items_owned_logical = TRUE) %>%
	spread(key = split_items, value = items_owned_logical, fill = FALSE) %>%
	rename(no_listed_items = `<NA>`) %>%
	## spread data by months_lack_food
	mutate(split_months = strsplit(months_lack_food, ";")) %>%
	unnest() %>%
	mutate(months_lack_food_logical = TRUE) %>%
	spread(key = split_months, value = months_lack_food_logical, fill = FALSE) %>%
	## add some summary columns
	mutate(number_months_lack_food = rowSums(select(., Apr:Sept))) %>%
	mutate(number_items = rowSums(select(., bicycle:television)))

# save dataset to csv file (note: in new data_output directory, separate from the raw data in data/)
write_csv(interviews_plotting, path = "data_output/interviews_plotting.csv")