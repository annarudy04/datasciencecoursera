if (!requireNamespace("BiocManager", quietly = TRUE)){
  install.packages("BiocManager")
}
if (!requireNamespace("rhdf5", quietly = TRUE)){
  BiocManager::install("rhdf5")
}
library(rhdf5)
# create an HDF5 file
if (!file.exists("example.h5")){
  created = h5createFile("example.h5")
  print(created)
}
# Create Groups within the File
h5createGroup("example.h5", "group1")
h5createGroup("example.h5", "group2")
h5createGroup("example.h5", "group1/subgroup1")

#list the contents of the HDF5 file
print(h5ls("example.h5"))

# write a dataset composed of a matrix of integers to group1/subgroup2
A <- matrix(1:10, nrow=5, ncol=2)
h5write(A, "example.h5", "group1/subgroup1/A")

# write a dataset composed of a 5 X 2 X 2 array to group2
# AND give the array an attribute indicating its unit is liters
B <- array(seq(0.1, 2, by=0.1), dim=c(5,2,2))
attr(B, "unit") <- "liter"
h5write(B, "example.h5", "group2/B")

# write a df with different types of data to the file (not within a group)
df <- data.frame(col1=c(1,2,3), col2=c('a', 'b', 'c'))
h5write(df, "example.h5", "df")
print(h5ls("example.h5"))


# read the datasets from the file
readA <- h5read("example.h5", "group1/subgroup1/A")
readB <- h5read("example.h5", "group2/B")
readdf <- h5read("example.h5", "df")
sapply(list(readA, readB, readdf), function(x){print(x);print(class(x))})

# read and write in chunks
# change the first three rows in column one to 13, 14, 15:
print(h5read(
  "example.h5", 
  "group1/subgroup1/A", 
  index=list(1:3, 1)
))
h5write(
  c(13, 14, 15),
  "example.h5", 
  "group1/subgroup1/A", 
  index=list(1:3, 1)
)
print(h5read(
  "example.h5", 
  "group1/subgroup1/A", 
  index=list(1:3, 1))
)
file.remove("example.h5")