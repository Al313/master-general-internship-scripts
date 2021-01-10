library(ggplot2)

viruses <- c(rep("MHV", 6), rep("DR13", 6), rep("IBV", 6))
cell_lines <- rep(c("Hela-R19", "SPPL3-KO", "MDH1-KO", "SPPL3-RE", "MDH1-RE", "Negative Control"), 3)
FACS_results <- c(4.65, 0.44, 3.39, 0.43, 4.56, 0.15, 2.12, 2.4, 2.1, 1.9, 2.5, 0.1, 7.36, 8.89, 0.94, 6.29, 7.79, 0.22)
FACS_results_normalized <- c((100/4.65)*4.65, (100/4.65)*0.44, (100/4.65)*3.39, (100/4.65)*0.43, (100/4.65)*4.56, (100/4.65)*0.15, 
                             (100/2.12)*2.12, (100/2.12)*2.4, (100/2.12)*2.1, (100/2.12)*1.9, (100/2.12)*2.5, (100/2.12)*0.1, 
                             (100/7.36)*7.36, (100/7.36)*8.89, (100/7.36)*0.94, (100/7.36)*6.29, (100/7.36)*7.79, (100/7.36)*0.22)

FACS_data <- data.frame(viruses, cell_lines, FACS_results_normalized)

FACS_data$viruses <- factor(FACS_data$viruses, levels = c("IBV", "DR13", "MHV"))

ggplot(FACS_data, aes(fill=viruses, y=FACS_results_normalized, x=cell_lines)) + 
  geom_bar(position="dodge", stat="identity", width = 0.8) +
  scale_fill_hue() +
  ylab("Percentage of Pos Cells (%)") +
  xlab("Cell Lines")+
  scale_x_discrete (limits = c("Hela-R19", "SPPL3-KO", "MDH1-KO", "SPPL3-RE", "MDH1-RE", "Negative Control"))+
  labs(fill = "Viruses")+
  ggtitle("FACS Results")+
  theme_minimal()+
  theme(plot.title = element_text(size = 20, face = "bold", hjust = 0.5))
  
  
