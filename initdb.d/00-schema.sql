-- create `User` table
CREATE TABLE TEST.User (
	id VARCHAR(255) NOT NULL,
	name VARCHAR(255),
	address VARCHAR(255),
	remark VARCHAR(255),
	updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
) ENGINE INNODB, CHARACTER SET = utf8;