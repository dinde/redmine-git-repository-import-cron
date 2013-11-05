#!/bin/bash

## redmine-gitrepo-import-cron.sh 
# This script is called by a crontab to "git pull" all actives repositories setup in Redmine.
##
# Author: David "Dinde" OH <david@ows.fr> - http://www.owns.fr
# Date: 04/11/2013: Release 1
# Version: 1.0
# Licence: WTFPLv2 (More informations on footer)
##

### Configuration ###
# Define Redmine folder here with the ending /
FOLDER='/var/www/redmine/'
# Define your repository Redmine folder here with the ending /
GITFOLDER="${FOLDER}gitrepo/"
# Define the environnement you wanna pull (should be production)
# ONLY 1 ENV AT A TIME !!!
RAILS_ENV='production'
# Rake's location
RAKE='/usr/local/bin/rake'
#####################


# Let's select the path of the git repositories 
cd ${FOLDER}
DEPOTS=$(echo "SELECT url FROM repositories WHERE url LIKE '${GITFOLDER}%'" | RAILS_ENV=${RAILS_ENV} ./script/rails dbconsole -p | grep -v url | sed 's/\.git//g' )
# On rentre dans le loop pour la hype
for i in ${DEPOTS};
do
  # Hop dans le folder du depot
  cd ${i}
  # Pull !!! kwak ! Pan !
  git pull >> /dev/null 2>&1
done


## Redmine fetchs
${RAKE} -f ${FOLDER}Rakefile redmine:fetch_changesets RAILS_ENV=${RAILS_ENV} >> /dev/null 2>&1
