package.name <- "silentmut"

# takes the first path with a positive hit for the silentmut package
indexes <- which(dir.exists(paste(.libPaths(),"/",package.name,sep="")))
rnai.file <- paste(.libPaths()[indexes[1]],"/",package.name,"/data/panos_rnai",sep="")
cdna.file <- paste(.libPaths()[indexes[1]],"/",package.name,"/data/panos_cdna",sep="")

replace.alignment(c(cdna.file,rnai.file) )



