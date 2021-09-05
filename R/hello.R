library("rvest")
library("dplyr")
library("ggplot2")

url <-"https://www.gartner.com/en/newsroom/press-releases/2021-01-11-gartner-says-worldwide-pc-shipments-grew-10-point-7-percent-in-the-fourth-quarter-of-2020-and-4-point-8-percent-for-the-year"


gartnerTable <- read_html(url) %>%
  html_element("table") %>%
  html_table()

gartnerTable <- gartnerTable[-c(1,9),]
gartnerTable <- gartnerTable[-c(1)]

colnames(gartnerTable) <- c('4Q20 Shipments','4Q20 Market Share (%)','4Q19 Shipments','4Q19 Market Share (%)','4Q20-4Q19 Growth (%)')
rownames(gartnerTable) <- c("Lenovo", "HP Inc.", "Dell", "Apple", "Acer Group", "ASUS", "Others")

ggplot(gartnerTable) +
  aes(x = gartnerTable[[2]], y = gartnerTable[[3]]) +
  geom_point() +
  geom_label(aes(label = rownames(gartnerTable))) +
  ggtitle("Worldwide PC Shipments around the World") +
  xlab("4Q20 Shipments") +
  ylab("4Q20 Market Share (%)")
