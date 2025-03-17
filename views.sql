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
