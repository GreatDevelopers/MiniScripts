#!/bin/bash
# To verify that it displays as 268435456 #
sudo sysctl kernel.shmmax
# Loading data into your server #
udo mkdir /usr/local/share/maps/planet
sudo chown $USER /usr/local/share/maps/planet
cd /usr/local/share/maps/planet
# Importing data into the database #
osm2pgsql --slim -d gis -C 1500 --number-processes 4 /usr/local/share/maps/planet/*.osm.pbf
# Testing your tileserver #
sudo mkdir /var/run/renderd
sudo chown $USER /var/run/renderd
sudo -u $USER renderd -f -c /usr/local/etc/renderd.conf
# Setting it to run automatically #
sudo cp  ~/src/mod_tile/debian/renderd.init /etc/init.d/renderd
sudo chmod u+x /etc/init.d/renderd
sudo vim /etc/init.d/renderd
# start mapnik #
sudo /etc/init.d/renderd start
# stop mapnik #
sudo /etc/init.d/renderd stop
sudo ln -s /etc/init.d/renderd /etc/rc2.d/S20renderd
