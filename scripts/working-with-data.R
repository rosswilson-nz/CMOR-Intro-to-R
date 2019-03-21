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
