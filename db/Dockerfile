FROM postgres:10.5

RUN apt-get update && apt-get install -y postgresql-10-postgis-2.4 unzip curl postgis

ENV POSTGRES_USER bikelanes
ENV POSTGRES_PASSWORD bike_pass
ENV POSTGRES_DB bikelanes

# The postgis extension is necessary for working with geographical data:
RUN echo 'CREATE EXTENSION postgis;'

# Uncomment the below if you want to download the latest bikelane data and convert to a sql file that we can ingest
# RUN mkdir /data
# RUN cd /data && curl "https://data.sfgov.org/api/geospatial/4jy4-tbju?method=export&format=Shapefile" > /data/data.zip && unzip /data/data.zip
# RUN shp2pgsql -s 4326 /data/*.shp public.bikeway_networks > /data/bikeway_networks.sql
# RUN echo 'CREATE EXTENSION postgis;' | cat - /data/bikeway_networks.sql > /data/temp && mv /data/temp /data/bikeway_networks.sql