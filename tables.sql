CREATE TABLE `warehouse` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`location` INT(11) NULL DEFAULT NULL,
	`citizenid` VARCHAR(50) NULL DEFAULT NULL COLLATE 'latin1_swedish_ci',
	`name` VARCHAR(255) NOT NULL COLLATE 'latin1_swedish_ci',
	`password` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	PRIMARY KEY (`id`) USING BTREE
)
COLLATE='latin1_swedish_ci'
ENGINE=InnoDB
AUTO_INCREMENT=0
;