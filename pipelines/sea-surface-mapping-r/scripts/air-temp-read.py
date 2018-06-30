import numpy as np
from scipy.io import netcdf

f_path = 'air-temp.nc'  # your file from the NCEP reanalysis plotter

# Retrieve data from NetCDF file
with netcdf.netcdf_file(f_path, 'r') as f:
    lon = f.variables['lon'][::]  # copy as list
    lat = f.variables['lat'][::-1]  # invert the latitude vector -> South to North
    air = f.variables['air'][0, ::-1, :]

# Shift 'lon' from [0,360] to [-180,180], make numpy array
tmp_lon = np.array([lon[n] - 360 if l >= 180 else lon[n]
                    for n, l in enumerate(lon)])  # => [0,180]U[-180,2.5]

i_east, = np.where(tmp_lon >= 0)  # indices of east lon
i_west, = np.where(tmp_lon < 0)  # indices of west lon
lon = np.hstack((tmp_lon[i_west], tmp_lon[i_east]))  # stack the 2 halves

# Correspondingly, shift the 'air' array
tmp_air = np.array(air)
air = np.hstack((tmp_air[:, i_west], tmp_air[:, i_east]))