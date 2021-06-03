# Create iPLAss Environment instantly

## Over view
This module is for building the environment of ipalss at high speed.
For more information about iplass, please refer to [iplass-site](https://iplass.org/)

Create iPLAss Environment on Docker image(CentOS)
Running command on CentOS is Litted on `iplass-build/dockerfile`

This environment is used the following
- OS : CentOS8 : latest version
- Apache Httpd : latest version
- Apache Tomcat : 9.0.22
- Java : 1.8.0
- MySQL 8 : latest version
- Connector/j : latest version
- iPlass : latest version

## Note

### MySQL8 initial Error
Maybe mysql is failing to initialize because of the `ower_case_table_names=1` setting.

In that case, you need to initialize it again by following the steps below.

[In Docker Container]
```
# rm -rf /var/lib/mysql
# mkdir /var/lib/mysql
# chown mysql:mysql /var/lib/mysql
# chmod 700 /var/lib/mysql
# mysqld --defaults-file=/etc/my.cnf --initialize --lower_case_table_names=1 --user=mysql --console
# systemctl enable mysqld
# systemctl start mysqld
```

and Mysql root account setting.
```
# mysql -u root -p
> ALTER USER 'root'@'localhost' IDENTIFIED BY '<your password>';
```

### AJP
apache httpd config file : `iplass-build/apache`

AJP Path : `/iplass/ and /iplass`

### iPLAss Config
iPLAss config file : `iplass-conf/iplass-service-config.xml`
                      `iplass-conf/logback.xml`

iPLAss logs : in docker container path `/opt/iplass/logs`

### DB Time Zone
Mysql config : `iplass-build/mysql/my.cnf`

Default Time Zone : `+9:00`

### Container Initial Script 
Container initial script :  `iplass-build/container-start.sh`

### Use Mail on iPLAss
In this environment, iPLAss Mail use postfix on the docker container.

1, Edit `/home/tomcat/.iplass/iplass-service-config.xml` **the org.iplass.mtp.impl.mail.MailServiceImpl**

 　`<property name="mail.smtp.host" value="XXXXXXXX"/>`  ->  `<property name="mail.smtp.host" value="localhost"/>`

　 `<property name="mail.host" value="XXXXXXXX"/>`  ->  `<property name="mail.host" value="localhost"/>`

2, Login iPLAss and open **Admin Console**
3, In **tenant** property, edit **Mail Sending Settings**

## Usage
**0,Setting module**
##### iplass 
Access [iplass site](https://iplass.org/downloads/) and download iplass installer

Set **iplass.war** into `iplass-build/iplass` dir

##### Connector/J
Access [MySQL site](https://dev.mysql.com/downloads/connector/j/) and download Connector/J for RHEL

Set **mysql-connector-java-XXXXXXXXX.noarch.rpm** into `iplass-build/jdbc` dir

**1,Execute command** `sh docker-start.sh [jdbc file name]`

**2,Access "http://[your server IP]/iplass"**

**3,Input parameter**
- Database                       :Mysql
- DBA User Name                  :root
- DBA Password                   :[root password]
- Binary data file store location:/opt/iplass/upload
- Host Name                      :localhost
- User Name                      :[your iplass DBuser] (ex.iplass_user)
- Password                       :[your password]
- Tenant Name                    :[your tenant name] (ex. test_tenant)
- Administrator User ID          :[your user name] (ex. admin@test_tenant)
- Administrator Password         :[your password]

**4,[In Docker Container] systemctl restart tomcat  (and wait a few minuits)**

**5,Access http://[your server IP]/iplass**
  wait for auto redirection

**6,sh iplass-conf.sh**

**7,Access http://[your server IP]/iplass/[your tenant name]/gem/**

**8,Edit AdminConsole [mail]**

**9,Check Mail and Logs**

## License

iPLAss License is **AGPL** (As of June 2021)
