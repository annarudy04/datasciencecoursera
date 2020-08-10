# create all 4 plots
plot_nums <- 1:6
for (plot in plot_nums){
  plotname <- paste0("plot", plot)
  print(paste("Creating", plotname, "..."))
  source(paste0("plot_files/plot", plot, ".R"))
}