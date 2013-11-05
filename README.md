redmine-git-repository-import-cron
==================================

This bash script is called by a crontab to "git pull" all actives GIT repositories setup in Redmine database.
Just configure and add it on your system crontab:
f.e: */15 * * * * /bin/bash /path/to/redmine-gitrepo-import-cron.sh
