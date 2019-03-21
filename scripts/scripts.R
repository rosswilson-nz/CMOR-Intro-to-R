area_hectares <- 1 # land area in hectares

area_acres <- 2.47 * area_hectares # convert to acres

area_acres # print land area in acres

area_hectares <- 2.5

area_acres <- 2.47 * area_hectares

round(3.14159)

round(3.14159, digits = 3)

no_membrs <- c(3, 7, 10, 6)

respondent_wall_type <- c("muddaub", "burntbricks", "sunbricks")

length(no_membrs)

length(respondent_wall_type)

class(no_membrs)

class(respondent_wall_type)

possessions <- c("bicycle", "radio", "television")

possessions <- c(possessions, "mobile_phone") # add to the end of the vector

possessions <- c("car", possessions) # add to the beginning of the vector

possessions

num_char <- c(1, 2, 3, "a")
num_logical <- c(1, 2, 3, TRUE)
char_logical <- c("a", "b", "c", TRUE)
tricky <- c(1, 2, 3, "4")

respondent_wall_type[2]

respondent_wall_type[c(3, 2)]

fewer_members <- no_membrs[c(TRUE, FALSE, TRUE, TRUE)]

rooms <- c(2, 1, 1, NA, 4)

max(rooms)

mean(rooms, na.rm = TRUE)
