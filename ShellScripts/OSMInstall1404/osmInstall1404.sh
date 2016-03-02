#!/bin/bash
# update & upgrade (Optional) #
sudo apt-get update
sudo apt-get upgrade
# Install all dependencies #
sudo apt-get install libboost-all-dev subversion git-core tar unzip wget bzip2 build-essential autoconf libtool libxml2-dev libgeos-dev libgeos++-dev libpq-dev libbz2-dev libproj-dev munin-node munin libprotobuf-c0-dev protobuf-c-compiler libfreetype6-dev libpng12-dev libtiff4-dev libicu-dev libgdal-dev libcairo-dev libcairomm-1.0-dev apache2 apache2-dev libagg-dev liblua5.2-dev ttf-unifont lua5.1 liblua5.1-dev libgeotiff-epsg node-carto
# Installing postgresql / postgis #
sudo apt-get install postgresql postgresql-contrib postgis postgresql-9.3-postgis-2.1
# Create Database #
sudo -u postgres -i
# Set up PostGIS on the PostgreSQL database #
sudo -u postgres psql
# Installing osm2pgsql #
mkdir ~/src
cd ~/src
git clone git://github.com/openstreetmap/osm2pgsql.git
cd osm2pgsql
sudo apt-get install make cmake g++ libboost-dev libboost-system-dev \  
  libboost-filesystem-dev libexpat1-dev zlib1g-dev \                    
  libbz2-dev libpq-dev libgeos-dev libgeos++-dev libproj-dev lua5.2 \   
  liblua5.2-dev
mkdir build && cd build                                                 
cmake ..
make
sudo make install
# Install Mapnik library #
cd ~/src
git clone git://github.com/mapnik/mapnik
cd mapnikgit branch 2.3 origin/2.3.x
git checkout 2.3
python scons/scons.py configure INPUT_PLUGINS=all OPTIMIZATION=3 SYSTEM_FONTS=/usr/share/fonts/truetype/
make
sudo make install
sudo ldconfig
# Verify that Mapnik has been installed correctly #
python
# Install mod_tile and renderd #
cd ~/src
git clone git://github.com/openstreetmap/mod_tile.git
cd mod_tile
./autogen.sh
./configure
make
sudo make install
sudo make install-mod_tile
sudo ldconfig
# Download OSMBright #
sudo mkdir -p /usr/local/share/maps/style
sudo chown username /usr/local/share/maps/style
cd /usr/local/share/maps/style
wget https://github.com/mapbox/osm-bright/archive/master.zip
wget http://data.openstreetmapdata.com/simplified-land-polygons-complete-3857.zip
wget http://data.openstreetmapdata.com/land-polygons-split-3857.zip
mkdir ne_10m_populated_places_simple
cd ne_10m_populated_places_simple
wget http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places_simple.zip
unzip ne_10m_populated_places_simple.zip
rm ne_10m_populated_places_simple.zip
cd ..
# We then move the downloaded data into the osm-bright-master project directory: #
unzip '*.zip'
mkdir osm-bright-master/shp
mv land-polygons-split-3857 osm-bright-master/shp/
mv simplified-land-polygons-complete-3857 osm-bright-master/shp/
mv ne_10m_populated_places_simple osm-bright-master/shp/
# To improve performance, we create index files for the larger shapefiles: #
cd osm-bright-master/shp/land-polygons-split-3857
shapeindex land_polygons.shp
cd ../simplified-land-polygons-complete-3857/
shapeindex simplified_land_polygons.shp
cd ../..
# Configuring OSM Bright #
vim osm-bright/osm-bright.osm2pgsql.mml
# Compiling the stylesheet #
cp configure.py.sample configure.py
vim configure.py
# Run the pre-processor and then carto: #
./make.py
cd ../OSMBright/
carto project.mml > OSMBright.xml
# Configure renderd #
sudo vim /usr/local/etc/renderd.conf
# Create the files required for the mod_tile system to run #
sudo mkdir /var/run/renderd
sudo chown $USER /var/run/renderd
sudo mkdir /var/lib/mod_tile
sudo chown $USER /var/lib/mod_tile
# Configure mod_tile #
sudo vim /etc/apache2/conf-available/mod_tile.conf
sudo vim /etc/apache2/sites-available/000-default.conf
# Tell Apache that you have added the new module, and restart it: #
sudo a2enconf mod_tile
sudo service apache2 reload
# Tuning postgresql #
sudo vim /etc/postgresql/9.3/main/postgresql.conf
# Reboot your system and run the script two#
sudo reboot
