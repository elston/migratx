-- ...
CREATE USER 'invoice'@'%' IDENTIFIED BY 'passinvoice';
GRANT ALL PRIVILEGES ON *.* TO 'invoice'@'%' WITH GRANT OPTION;
-- ...
CREATE DATABASE IF NOT EXISTS `invoice`
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON `invoice`.* TO 'invoice'@'%';



-- mysql -h 127.0.0.1 -P 3306 -u invoice -p invoice
-- passinvoice
-- \s


-- ...
-- FLUSH PRIVILEGES;

