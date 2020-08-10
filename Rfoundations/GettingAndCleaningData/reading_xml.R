fileUrl <- "http://www.w3schools.com/xml/simple.xml"
download.file(fileUrl, destfile="simple.xml")
doc <- xmlTreeParse("simple.xml", useInternal=TRUE)

rootNode <- xmlRoot(doc)
print("Name of Root Node:")
print(xmlName(rootNode))

print("First Nested Element in Root Node")
print(rootNode[[1]])

print("Names of Elements")
print(xpathSApply(rootNode, "//name", xmlValue))

print("Prices of Elements")
print(xpathSApply(rootNode, "//price", xmlValue))
