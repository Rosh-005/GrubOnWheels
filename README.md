Download and extract the file “mysql-5.0.22-win32.rar” from master branch in GitHub. Install the setup file from the extracted folder. 
Enter password as “root” when asked while installing. 
Install the “mysqlquerybrowser5.0” and “mysql-gui-tools-5.0” from the extracted folder. Open the Mysql query browser using host as “localhost”, 
port as “3306”, username and password as “root” and open a new script tab from file. 
Enter the below script to increase database packet size to handle large volumes of data. Feel free to increase the packet size if needed.
SET GLOBAL max_allowed_packet = 67108864; --64MB in bytes
After installation, open the MySQL Administrator and enter the credentials, host as “localhost”, username and password as “root”. 
Click “Restore” tab from the left panel of the window and click on “Open Backup File”. 
Download and extract the database backup file from the master branch of GitHub named as “New Project 20230907 1446.rar”. 
Now select this backup file from its location in the MySQL administrator and restore. 
To view the database schema, open MySQL Query Browser to view all the database tables under “gow” schema.
Open Eclipse IDE for Enterprise Java and Web developers. Import the project “GrubOnWheels”. 
Download the Tomcat server 9.0.76 from master branch of GitHub. Extract and install the server. 
In eclipse, add the server in Servers tab and in project’s runtimes. Add jar files to project’s build path from project’s src  main  webapp  WEB-INF  lib. 
Clean the project, start the server and run the project on server.
