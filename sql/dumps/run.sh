
# Get MySQL server version
mysql_version=$(mysql --version | awk '{print $5}')

## Create db struct and mt2 user with limited privileges
mysql -uroot -pyour_password < base/db_create.sql


if [ "$(echo "$mysql_version" | awk -F'.' '{print $1"."$2}' )" = "8.0" ] || [ "$(echo "$mysql_version" | awk -F'.' '{print $1"."$2}' )" \> "8.0" ]; then
    # echo "MySQL version is 8.0 or higher: $mysql_version"
    mysql -uroot -pyour_password < base/mt2_user_g.sql
elif [ "$(echo "$mysql_version" | awk -F'.' '{print $1"."$2}' )" = "5.7" ] || [ "$(echo "$mysql_version" | awk -F'.' '{print $1"."$2}' )" \> "5.7" ]; then
    # echo "MySQL version is 5.7 or higher: $mysql_version"
    mysql -uroot -pyour_password < base/mt2_user_f.sql
elif [ "$(echo "$mysql_version" | awk -F'.' '{print $1"."$2}' )" = "5.6" ] || [ "$(echo "$mysql_version" | awk -F'.' '{print $1"."$2}' )" \> "5.6" ]; then
    # echo "MySQL version is 5.6 but not 5.7: $mysql_version"
    mysql -uroot -pyour_password < base/mt2_user_d.sql
elif echo "$mysql_version" | grep -q "MariaDB"; then
    # echo "MariaDB is installed: $mysql_version"
    mysql -uroot -pyour_password < base/mt2_user_g.sql
else
    echo "MySQL version is lower than 5.6 and not MariaDB: $mysql_version"
fi



## Create clean metin2 db struct
mysql -uroot -pyour_password srv1_account < srv1_account.sql
mysql -uroot -pyour_password srv1_common < srv1_common.sql
mysql -uroot -pyour_password srv1_hotbackup < srv1_hotbackup.sql
mysql -uroot -pyour_password srv1_log < srv1_log.sql
mysql -uroot -pyour_password srv1_player < srv1_player.sql

## Insert new features in metin2 db struct
mysql -uroot -pyour_password srv1_player < updates/player__skill_proto.sql

### NOTE: DON'T TOUCH updates/post/ queries! (they are just for rare cases!)
