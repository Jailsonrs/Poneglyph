tema1 <- theme(
  panel.background = element_rect(fill="mistyrose2"),
  axis.text.x=element_text(angle=0,hjust=1,face=6,size=5),
  legend.position= "none",
  axis.title.y = element_blank(),
  axis.ticks=element_blank(),
  axis.text.y=element_text(colour=c(rep("black",17),"red",rep("black",10))),
  panel.grid.minor.y=element_blank(),
  panel.grid.minor.x=element_blank(),
  panel.grid.major.x=element_line(linetype=2,size=0.3,colour="grey49"),
  panel.grid.major.y=element_line(linetype=2,size=0.3,colour="grey49"))

tema2 <- theme(
  panel.background = element_rect(fill="white"),
  plot.background = element_rect(fill="white"),
  axis.title = element_text(colour="grey50",vjust=0.2),
  axis.text.x=element_text(angle=45,hjust=1,face=2,size=10,colour="grey30"),
  axis.text.y=element_text(colour="grey30",face=2,size=10),
  axis.ticks.y=element_line(colour="royalblue",size=2),
  axis.ticks.length=unit(.1,"cm"),
  panel.grid.minor.y=element_blank(),
  panel.grid.minor.x=element_blank(),
  text=element_text(family="Georgia"),
  ##panel.grid.major.x=element_line(linetype=2,size=0.1,colour="grey95" ),
  panel.grid.major.y=element_line(linetype=2, size=0.1,colour="grey95"),
  plot.title = element_text(size = 16,colour="grey60"),
  axis.title.y = element_text(size=10),
  axis.title.x = element_text(size=10),
  plot.subtitle = element_text(size = 12, color = "darkslategrey", margin = ggplot2::margin(b = 25)),
  plot.caption = element_text(size = 8, margin = ggplot2::margin(t = 10), color = "slategray4", hjust = 0),
  plot.margin = unit(c(.1,.1,.1,.1),"cm")
)
