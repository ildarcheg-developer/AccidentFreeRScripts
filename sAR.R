#load required libraries 
require(rvest)
require(RCurl)

#get incoming parameter 
Sys.setlocale("LC_ALL", "Arabic")
args <- commandArgs(TRUE)
car_num <- as.character(args[1])
UUID <- as.character(args[2])
n <- as.integer(args[3])
path <- as.character(args[4])

#get link
address <- paste0(path, car_num, "_", UUID, "_links", ".txt")
links <- readLines(address)
link <- links[n]

#get link content
pg <- read_html(link)
nodes <- html_nodes(pg, xpath=".//table[@id='ctl00_ContentPlaceHolder1_frvAccidientDetails']")
caption <- html_nodes(pg, xpath=".//span[@class='CaptionLabel']") %>% html_text()
value <- html_nodes(pg, xpath=".//span[@class='ValueLabel']") %>% html_text()
df <- data.frame(caption = caption, value = value)
write.csv2(df, paste0(path, car_num, "_", UUID, "_", n, ".csv"))

