import plotly.plotly as py
from plotly.graph_objs import *

from netCDF4 import Dataset
import xarray as xr
import numpy as np

f_path = 'data/sst.day.anom.2017.v2.nc'

f = Dataset(f_path)

ds2 = xr.open_dataset(xr.backends.NetCDF4DataStore(f))
df2 = ds2.to_dataframe()
df_sub = df2.iloc[df2.index.get_level_values('time') == '2017-12-16']

df_sub.tail()

len(df_sub.index.get_level_values('lon')), len(df_sub['anom'])

step = 1.0
to_bin = lambda x: np.floor(x / step) * step
df_sub["latbin"] = df_sub.index.get_level_values('lat').map(to_bin)
df_sub["lonbin"] = df_sub.index.get_level_values('lon').map(to_bin)
groups = df_sub.groupby(("latbin", "lonbin"))

df_flat = df_sub.drop_duplicates(subset=['latbin', 'lonbin'])

df_flat.head()

df_no_nan = df_flat[np.isfinite(df_flat['anom'])]

df_no_nan = df_no_nan[(df_no_nan.latbin < 76.0) & (df_no_nan.latbin > -66.0)]

df_no_nan.tail()

colorscale = [[0, 'rgb(54, 50, 153)'], [0.35, 'rgb(17, 123, 215)'],
                [0.5, 'rgb(37, 180, 167)'], [0.6, 'rgb(134, 191, 118)'],
                [0.7, 'rgb(249, 210, 41)'], [1.0, 'rgb(244, 236, 21)']]

data = []

data.append(
    Scattermapbox(
        lon=df_no_nan['lonbin'].values,
        lat=df_no_nan['latbin'].values,
        mode='markers',
        marker=Marker(
            color=df_no_nan['anom'].values,
            colorscale=colorscale
        ),
    )
)

layout = Layout(
    margin=dict(t=0, b=0, r=0, l=0),
    autosize=True,
    hovermode='closest',
    showlegend=False,
    mapbox=dict(
        accesstoken=mapbox_access_token,
        bearing=0,
        center=dict(
            lat=38,
            lon=-94
        ),
        pitch=0,
        zoom=0,
        style='light'
    ),
)

fig = dict(data=data, layout=layout)
py.iplot(fig, filename='Da_Weather_2.html')
