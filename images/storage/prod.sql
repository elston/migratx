-- ...
CREATE USER 'invoice'@'%' IDENTIFIED BY 'passinvoice';
-- ...
CREATE DATABASE IF NOT EXISTS `invoice`
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON `invoice`.* TO 'invoice'@'%';



-- mysql -h 127.0.0.1 -P 3306 -u invoice -p invoice
-- passinvoice
-- \s

-- ....
CREATE USER 'webinvoice'@'%' IDENTIFIED BY 'datapass';
-- ...
CREATE DATABASE IF NOT EXISTS `webinvoice`
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;
GRANT ALL ON `webinvoice`.* TO 'webinvoice'@'%';

-- ...
-- FLUSH PRIVILEGES;

-- mysql -h 127.0.0.1 -P 3306 -u webinvoice -p webinvoice
-- datapass
-- \s
