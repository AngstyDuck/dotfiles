-- default mysql configurations

UPDATE mysql.user SET authentication_string=PASSWORD('password') WHERE User='root';  -- set root password as password
DELETE FROM mysql.user WHERE User='';  -- remove anonymous users
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');  -- root can only connect locally
DROP DATABASE IF EXISTS test;  -- drop test db
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;

-- create user for remote connection
CREATE USER 'remote'@'0.0.0.0' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'remote'@'0.0.0.0';
