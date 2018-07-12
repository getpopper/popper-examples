library(ncdf4) # package for netcdf manipulation
library(raster) # package for raster manipulation
library(rgdal) # package for geospatial analysis
library(ggplot2) # package for plotting

nc_data <- nc_open('scripts/data/gimms3g_ndvi_1982-2012.nc4')
# Save the print(nc) dump to a text file
{
    sink('gimms3g_ndvi_1982-2012_metadata.txt')
 print(nc_data)
    sink()
}


lon <- ncvar_get(nc_data, "lon")
lat <- ncvar_get(nc_data, "lat", verbose = F)
t <- ncvar_get(nc_data, "time")

head(lon) # look at the first few entries in the longitude vector

ndvi.array <- ncvar_get(nc_data, "NDVI") # store the data in a 3-dimensional array
dim(ndvi.array)

fillvalue <- ncatt_get(nc_data, "NDVI", "_FillValue")
fillvalue

nc_close(nc_data)

ndvi.array[ndvi.array == fillvalue$value] <- NA

ndvi.slice <- ndvi.array[, , 1]

dim(ndvi.slice)

r <- raster(t(ndvi.slice), xmn=min(lon), xmx=max(lon), ymn=min(lat), ymx=max(lat), crs=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs+ towgs84=0,0,0"))

r <- flip(r, direction='y')

plot(r)

writeRaster(r, "GIMMS3g_1982.tif", "GTiff", overwrite=TRUE)