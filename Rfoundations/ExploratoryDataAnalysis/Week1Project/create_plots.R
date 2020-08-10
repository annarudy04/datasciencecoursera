# create all 4 plots
plot_nums <- c(1, 2, 3, 4)
for (plot in plot_nums){
  plotname <- paste0("plot", plot)
  print(paste("Creating", plotname, "..."))
  source(paste0("plot", plot, ".R"))
}