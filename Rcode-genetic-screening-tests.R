library(plotrix)
library(ggplot2)
library(gg.gap)
library(ggrepel)


my_data <- read.delim("/home/ali313/genetic-screening-tests.txt")  #Reading the results as data frame into an R object

# Separating the two tests from each other
sub1 <- my_data[,c(1,2)]
sub2 <- my_data[,c(3,4)]

# ordering results based on their gene id
sub1_ordered <- sub1[order(sub1$id1),]
sub1_ordered[sub1_ordered$id1 == "ZNF791",]

# recombining the ordered results in one object
my_data_ordered <- cbind(sub1_ordered, sub2_ordered)
my_data_ordered <- my_data_ordered[,-3] # removing the extra column
colnames(my_data_ordered)[1] <- "id" # changing the column name

# identifying the common genes with highest scores in the 70 first hits of each test
strong_hits <- intersect(sub1$id1[1:70], sub2$id2[1:70])

par(bty = "n") # channging the layout of the plot

# saving the plot into a ggplot object
my_plot <- ggplot(my_data_ordered) +
  geom_point(aes(x=-log10(pos.score.exp1), y=-log10(pos.score.exp2)), size=0.5) +
  geom_text_repel(data = subset(my_data_ordered, id %in% strong_hits),
                  aes(x=-log10(pos.score.exp1), y=-log10(pos.score.exp2), label = id, col = "red"), 
                  size = 5,
                  box.padding = unit(0.35, "lines"),
                  point.padding = unit(0.3, "lines")) +
  ggtitle("Genetic Screen Results") +
#  geom_hline(yintercept=3, linetype="dashed", color = "grey")+
#  geom_vline(xintercept=3, linetype="dashed", color = "grey")+
  theme_classic() +
  theme(plot.title = element_text(size = 20, face = "bold", hjust = 0.5))

my_plot
# creating a gap in the y-axis
gg.gap(my_plot, ylim = c(0,40), xlim = c(0,40), 
       segments = c(15,35), tick_width = 5,
       c(0.7,0,0.3))

