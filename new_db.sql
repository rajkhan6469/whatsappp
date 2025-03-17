-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versi server:                 5.7.24 - MySQL Community Server (GPL)
-- OS Server:                    Win64
-- HeidiSQL Versi:               11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE IF NOT EXISTS `tb_gdrive_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_secret` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `refresh_token` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` int(11) NOT NULL DEFAULT '0',
  `modified` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `bypass` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `FK_tb_gdrive_auth_tb_users` (`uid`),
  CONSTRAINT `FK_tb_gdrive_auth_tb_users` FOREIGN KEY (`uid`) REFERENCES `tb_users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_gdrive_duplicate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gdrive_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gdrive_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `desc` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `fileSize` bigint(20) NOT NULL DEFAULT '0',
  `md5Checksum` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sha1Checksum` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `sha256Checksum` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gdrive_id` (`gdrive_id`),
  KEY `gdrive_email` (`gdrive_email`),
  CONSTRAINT `FK_tb_gdrive_duplicate_tb_gdrive_auth` FOREIGN KEY (`gdrive_email`) REFERENCES `tb_gdrive_auth` (`email`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_gdrive_mirrors` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gdrive_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mirror_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mirror_email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `added` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `mirror_id_idx` (`mirror_id`),
  KEY `gdrive_id_idx` (`gdrive_id`),
  KEY `FK_tb_gdrive_mirrors_tb_gdrive_auth` (`mirror_email`),
  CONSTRAINT `FK_tb_gdrive_mirrors_tb_gdrive_auth` FOREIGN KEY (`mirror_email`) REFERENCES `tb_gdrive_auth` (`email`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_gdrive_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `gdrive_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `delayed` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gdrive_id_idx` (`gdrive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_loadbalancers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `public` tinyint(1) NOT NULL DEFAULT '0',
  `added` int(11) NOT NULL DEFAULT '0',
  `updated` int(11) NOT NULL DEFAULT '0',
  `disallow_hosts` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `disallow_continent` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `link_idx` (`link`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_maxmind` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix_len` int(11) DEFAULT NULL,
  `asn` int(11) DEFAULT NULL,
  `continent` char(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` char(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_maxmind_asn` (
  `id` int(11) NOT NULL,
  `name` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_plugins` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_sessions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `useragent` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` int(11) NOT NULL DEFAULT '0',
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expired` int(11) NOT NULL DEFAULT '0',
  `token` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stat` tinyint(1) NOT NULL DEFAULT '9',
  PRIMARY KEY (`id`),
  KEY `ip_idx` (`ip`),
  KEY `username_idx` (`username`),
  FULLTEXT KEY `useragent_idx` (`useragent`),
  CONSTRAINT `FK_tb_sessions_tb_users` FOREIGN KEY (`username`) REFERENCES `tb_users` (`user`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `key_idx` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_stats` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vid` bigint(20) NOT NULL,
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ua` bigint(20) NOT NULL,
  `created` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `vid_idx` (`vid`),
  KEY `ua_idx` (`ua`),
  CONSTRAINT `FK_tb_stats_tb_stats_ua` FOREIGN KEY (`ua`) REFERENCES `tb_stats_ua` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_tb_stats_tb_videos` FOREIGN KEY (`vid`) REFERENCES `tb_videos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_stats_ua` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ua` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_subtitles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `language` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `vid` bigint(20) NOT NULL,
  `added` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL,
  `order` int(11) NOT NULL DEFAULT '0',
  `updated` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `vid_idx` (`vid`),
  KEY `uid_idx` (`uid`),
  CONSTRAINT `FK_tb_subtitles_tb_users` FOREIGN KEY (`uid`) REFERENCES `tb_users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_tb_subtitles_tb_videos` FOREIGN KEY (`vid`) REFERENCES `tb_videos` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_subtitle_manager` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_size` int(11) NOT NULL DEFAULT '0',
  `file_type` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `added` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL,
  `host` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_tb_subtitle_manager_tb_users` (`uid`),
  FULLTEXT KEY `file_name_idx` (`file_name`),
  CONSTRAINT `FK_tb_subtitle_manager_tb_users` FOREIGN KEY (`uid`) REFERENCES `tb_users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_tmp_videos_sources` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `host` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host_id` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gdrive_email` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `added` int(11) NOT NULL DEFAULT '0',
  `updated` int(15) NOT NULL DEFAULT '0',
  `role` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_videos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host_id` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uid` int(11) NOT NULL,
  `added` int(11) NOT NULL DEFAULT '0',
  `updated` int(11) NOT NULL DEFAULT '0',
  `poster` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `views` int(11) NOT NULL DEFAULT '0',
  `dmca` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `host_idx` (`host`),
  KEY `uid_idx` (`uid`),
  FULLTEXT KEY `title_idx` (`title`),
  FULLTEXT KEY `host_id_idx` (`host_id`),
  CONSTRAINT `FK_tb_videos_tb_users` FOREIGN KEY (`uid`) REFERENCES `tb_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_videos_alternatives` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vid` bigint(20) NOT NULL,
  `host` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host_id` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `vid_idx` (`vid`),
  CONSTRAINT `FK_tb_videos_alternatives_tb_videos` FOREIGN KEY (`vid`) REFERENCES `tb_videos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_videos_hash` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `host` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host_id` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gdrive_email` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `host_idx` (`host`),
  FULLTEXT KEY `host_id_idx` (`host_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_videos_short` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `key` varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key_idu` (`key`),
  KEY `vid_idx` (`vid`),
  FULLTEXT KEY `key_idx` (`key`),
  FULLTEXT KEY `key_fidx` (`key`),
  CONSTRAINT `FK_tb_videos_short_tb_videos` FOREIGN KEY (`vid`) REFERENCES `tb_videos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

CREATE TABLE IF NOT EXISTS `tb_videos_sources` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `host` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host_id` varchar(1500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `dl` tinyint(1) NOT NULL DEFAULT '0',
  `sid` int(11) DEFAULT '0',
  `created` int(11) NOT NULL DEFAULT '0',
  `expired` int(11) NOT NULL DEFAULT '0',
  `ua` text COLLATE utf8mb4_unicode_ci,
  `lang` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `host_idx` (`host`),
  KEY `lang_idx` (`lang`),
  KEY `sid_idx` (`sid`),
  KEY `ip_idx` (`ip`),
  FULLTEXT KEY `host_id_idx` (`host_id`),
  FULLTEXT KEY `ua_idx` (`ua`),
  CONSTRAINT `FK_tb_videos_sources_tb_loadbalancers` FOREIGN KEY (`sid`) REFERENCES `tb_loadbalancers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Pengeluaran data tidak dipilih.

-- membuang struktur untuk view db_gdplayer.vw_loadbalancers
DROP VIEW IF EXISTS `vw_loadbalancers`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_loadbalancers` AS select `l`.`id` AS `id`,`l`.`name` AS `name`,`l`.`link` AS `link`,`l`.`public` AS `public`,`l`.`status` AS `status`,`l`.`added` AS `added`,`l`.`updated` AS `updated`,`l`.`disallow_hosts` AS `disallow_hosts`,`l`.`disallow_continent` AS `disallow_continent`,cast((select `c`.`value` from `tb_settings` `c` where (`c`.`key` = concat('active_connections_',`l`.`id`))) as unsigned) AS `connections`,(select count(1) from `tb_videos_sources` `v` where (`l`.`id` = `v`.`sid`)) AS `playbacks` from `tb_loadbalancers` `l`;

-- membuang struktur untuk view db_gdplayer.vw_stats
DROP VIEW IF EXISTS `vw_stats`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_stats` AS select `s`.`id` AS `id`,`s`.`vid` AS `vid`,`v`.`uid` AS `uid`,`s`.`created` AS `created` from (`tb_stats` `s` join `tb_videos` `v` on((`s`.`vid` = `v`.`id`)));

-- membuang struktur untuk view db_gdplayer.vw_stats_ua
DROP VIEW IF EXISTS `vw_stats_ua`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_stats_ua` AS select `a`.`id` AS `id`,`a`.`ua` AS `ua`,(select count(1) from `tb_stats` `b` where (`b`.`ua` = `a`.`id`)) AS `jml` from `tb_stats_ua` `a`;

-- membuang struktur untuk view db_gdplayer.vw_subtitle_manager
DROP VIEW IF EXISTS `vw_subtitle_manager`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_subtitle_manager` AS select `s`.`id` AS `id`,`s`.`file_name` AS `file_name`,`s`.`language` AS `language`,`s`.`host` AS `host`,`s`.`added` AS `added`,`s`.`updated` AS `updated`,`u`.`id` AS `uid`,`u`.`name` AS `name` from (`tb_subtitle_manager` `s` join `tb_users` `u` on((`s`.`uid` = `u`.`id`)));

-- membuang struktur untuk view db_gdplayer.vw_users
DROP VIEW IF EXISTS `vw_users`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_users` AS select `u`.`id` AS `id`,`u`.`name` AS `name`,`u`.`user` AS `user`,`u`.`email` AS `email`,`u`.`status` AS `status`,`u`.`added` AS `added`,`u`.`updated` AS `updated`,`u`.`role` AS `role`,(select count(1) from `tb_videos` `v` where (`v`.`uid` = `u`.`id`)) AS `videos` from `tb_users` `u`;

-- membuang struktur untuk view db_gdplayer.vw_videos
DROP VIEW IF EXISTS `vw_videos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_videos` AS select `v`.`id` AS `id`,`v`.`title` AS `title`,`v`.`host` AS `host`,`v`.`host_id` AS `host_id`,`v`.`status` AS `status`,`v`.`added` AS `added`,`v`.`updated` AS `updated`,`v`.`dmca` AS `dmca`,`v`.`views` AS `views`,`u`.`name` AS `name`,`v`.`uid` AS `uid`,`v`.`poster` AS `poster`,`s`.`key` AS `slug`,(select `x`.`language` from `tb_subtitles` `x` where (`x`.`vid` = `v`.`id`) limit 1) AS `subtitle` from ((`tb_videos` `v` join `tb_users` `u` on((`v`.`uid` = `u`.`id`))) left join `tb_videos_short` `s` on((`v`.`id` = `s`.`vid`)));

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
