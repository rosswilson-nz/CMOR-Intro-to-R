library(tidyverse)

fertility_data <- tibble(
	year = c(2015.5, 2015, 2004.5, 1999, 1996, 1991.5),
	year_label = factor(c("2015-2016", "2015", "2004-2005", "1999", "1996", "1991-1992"),
											levels = c("2015-2016", "2015", "2004-2005", "1999", "1996", "1991-1992")),
	fertility_rate = c(5.2, 5.4, 5.7, 5.6, 5.8, 6.2),
	modern_contraception = c(38.4, 23.6, 17.6, 15.6, 11.7, 5.9),
	unmet_need = c(22.1, 22.3, 24.3, 22.3, 26.0, 27.8)
)

write_rds(fertility_data, "data/fertility_data.rds")