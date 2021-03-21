Hostinger
---------
Sana
SanaAdmin2020

CyberDuck(SSH)
---------
root
SanaAdmin2020##

tomcat
---------
admin
sanaAdmin2020##

DB
---------
root
SanaDB#2020#Admin

CMS
---------
sana
20sanacards20



Install Tomcat
sudo apt update
sudo apt install default-jdk
sudo useradd -r -m -U -d /opt/tomcat -s /bin/false tomcat
wget https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.44/bin/apache-tomcat-9.0.44.tar.gz -P /tmp
sudo tar xf /tmp/apache-tomcat-9*.tar.gz -C /opt/tomcat
sudo ln -s /opt/tomcat/apache-tomcat-9* /opt/tomcat/latest
sudo chown -RH tomcat: /opt/tomcat/latest
sudo sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
sudo nano /etc/systemd/system/tomcat.service
-----------Copy paste starts------------
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/default-java"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom -Djava.awt.headless=true"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
-----------Copy paste ends------------
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
sudo apt install ufw
sudo ufw allow 8080/tcp
sudo nano /opt/tomcat/latest/conf/tomcat-users.xml
-----------Insert starts------------
<tomcat-users>
<role rolename="admin-gui"/>
<role rolename="manager-gui"/>
<user username="admin" password="sanaAdmin2020##" roles="admin-gui,manager-gui"/>
</tomcat-users>
-----------Insert ends------------
sudo nano /opt/tomcat/latest/webapps/manager/META-INF/context.xml
-----------Update starts------------
<Context antiResourceLocking="false" privileged="true" >
<!--
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
</Context>
-----------Update ends------------
sudo nano /opt/tomcat/latest/webapps/host-manager/META-INF/context.xml
-----------Update starts------------
<Context antiResourceLocking="false" privileged="true" >
<!--
  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />
-->
</Context>
-----------Update ends------------
sudo systemctl restart tomcat


-------------------------------------------------------------------------------------------
MYSQL Installation

sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation




sudo mysql
SELECT user,authentication_string,plugin,host FROM mysql.user;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
FLUSH PRIVILEGES;
SELECT user,authentication_string,plugin,host FROM mysql.user;
exit

-------------------------------------------------------------------------------------------
Running on port 80

stop all process running in port 80 (nginx and apache2)
change tomcat port to 80 and add authbind --deep



WAR Update Size
nano /etc/nginx/nginx.conf
http {
    client_max_body_size 100M;
}

systemctl restart nginx
