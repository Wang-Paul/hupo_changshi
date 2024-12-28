library(tidyverse)
library(RODBC)
library(sf)
library(raster)
####shangjihu

mianji <- function(wenjian) {
  hu <- brick(wenjian)

  shijian <- seq.Date(ym('198403'), ym('202012'), by = 'month')

  shijian_xulie <- tibble(xulie = seq(1, 442, by = 1), yue= shijian)

  a <- c()

  for (i in seq(1:442)) {
    shuliang<- (hu[[i]] == 2) %>% values() %>% sum()
    b<- shuliang*300*300
    a <- c(a, b)
  }


  hu_mianji <- shijian_xulie %>% mutate(mianji = round(a/1000000,2))
}

########上级湖
shangjihu <- mianji('yishusi/ID_801383.tif')

########下级湖
xiajihu <- mianji('yishusi/ID_801388.tif')

xiajihu %>% ggplot(aes(yue, mianji)) + geom_line()
########骆马湖
luomahu <- mianji('yishusi/ID_801396.tif')

luomahu %>% ggplot(aes(yue, mianji)) + geom_line()
