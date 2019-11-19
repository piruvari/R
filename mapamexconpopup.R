library(rgdal)
library(leaflet)

tmp <- tempdir()

url <- "http://personal.tcu.edu/kylewalker/data/mexico.zip"

file <- basename(url)

download.file(url, file)

unzip(file, exdir = tmp)

mexico <- readOGR(dsn = tmp, layer = "mexico", encoding = "UTF-8")
pal <- colorQuantile("YlGn", NULL, n =35)

state_popup <- paste0("<strong>Estado: </strong>", 
                      mexico$name, 
                      "<br><strong>PIB per c?pita, miles de pesos, 2008: </strong>", 
                      mexico$gdp08)

leaflet(data = mexico) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(fillColor = ~pal(gdp08), 
              fillOpacity = 0.8, 
              color = "#BDBDC3", 
              weight = 1, 
              popup = state_popup)

