/*
SQLyog Professional v12.09 (64 bit)
MySQL - 5.5.40 : Database - zpscwz
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`zpscwz` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `zpscwz`;

/*Table structure for table `admins` */

DROP TABLE IF EXISTS `admins`;

CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '帐号',
  `pwd` varchar(50) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员';

/*Data for the table `admins` */

insert  into `admins`(`id`,`username`,`pwd`) values (1,'admin','admin');

/*Table structure for table `dianzan` */

DROP TABLE IF EXISTS `dianzan`;

CREATE TABLE `dianzan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户',
  `biaoid` int(11) NOT NULL DEFAULT '0' COMMENT '关联表id',
  `biao` varchar(50) NOT NULL COMMENT '关联表',
  `biaoti` varchar(255) NOT NULL COMMENT '标题',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '点赞时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='点赞';

/*Data for the table `dianzan` */

insert  into `dianzan`(`id`,`username`,`biaoid`,`biao`,`biaoti`,`addtime`) values (2,'666',6,'zhaopianxinxi','重庆市市辖区渝北区','2022-12-25 14:01:12'),(3,'666',7,'zhaopianxinxi','山东省潍坊市诸城市','2022-12-25 14:01:48');

/*Table structure for table `lunbotu` */

DROP TABLE IF EXISTS `lunbotu`;

CREATE TABLE `lunbotu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `image` varchar(255) NOT NULL COMMENT '图片',
  `url` varchar(255) NOT NULL COMMENT '连接地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='轮播图';

/*Data for the table `lunbotu` */

insert  into `lunbotu`(`id`,`title`,`image`,`url`) values (1,'1','/upload/20221228/1.jpg','#'),(2,'2','/upload/20221228/5.jpg','#'),(3,'3','/upload/20221225/4.png','#'),(4,'4','/upload/20221228/3.jpg','#');

/*Table structure for table `pinglun` */

DROP TABLE IF EXISTS `pinglun`;

CREATE TABLE `pinglun` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `biao` varchar(50) NOT NULL COMMENT '表',
  `biaoid` int(11) NOT NULL DEFAULT '0' COMMENT '表id',
  `biaoti` varchar(255) NOT NULL COMMENT '标题',
  `pinglunneirong` text NOT NULL COMMENT '评论内容',
  `pinglunren` varchar(50) NOT NULL COMMENT '评论人',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='评论';

/*Data for the table `pinglun` */

insert  into `pinglun`(`id`,`biao`,`biaoid`,`biaoti`,`pinglunneirong`,`pinglunren`,`addtime`) values (1,'zhaopianxinxi',6,'重庆市市辖区渝北区','看上去真的好吃！','666','2022-12-25 14:00:18');

/*Table structure for table `shoucang` */

DROP TABLE IF EXISTS `shoucang`;

CREATE TABLE `shoucang` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户',
  `xwid` int(11) NOT NULL DEFAULT '0' COMMENT '关联表id',
  `biao` varchar(50) NOT NULL COMMENT '关联表',
  `biaoti` varchar(255) NOT NULL COMMENT '标题',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='收藏';

/*Data for the table `shoucang` */

insert  into `shoucang`(`id`,`username`,`xwid`,`biao`,`biaoti`,`addtime`) values (2,'666',7,'zhaopianxinxi','山东省潍坊市诸城市','2019-07-31 12:14:06'),(3,'666',6,'zhaopianxinxi','重庆市市辖区渝北区','2019-05-01 18:16:12');

/*Table structure for table `yonghu` */

DROP TABLE IF EXISTS `yonghu`;

CREATE TABLE `yonghu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `yonghuming` varchar(50) NOT NULL COMMENT '用户名',
  `mima` varchar(50) NOT NULL COMMENT '密码',
  `xingming` varchar(50) NOT NULL COMMENT '姓名',
  `xingbie` varchar(10) NOT NULL COMMENT '性别',
  `shouji` varchar(50) NOT NULL COMMENT '手机',
  `youxiang` varchar(50) NOT NULL COMMENT '邮箱',
  `touxiang` varchar(255) NOT NULL COMMENT '头像',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='用户';

/*Data for the table `yonghu` */

insert  into `yonghu`(`id`,`yonghuming`,`mima`,`xingming`,`xingbie`,`shouji`,`youxiang`,`touxiang`) values (1,'999','999','小红','女','13423652312','111@qq.com','/upload/20221225/27e38ffd-e89d-427f-9626-c5ba5840a317.png'),(2,'666','666','小王','男','13423652361','333@qq.com','/upload/20221225/ea4cd9d4-5289-485c-9f6b-ca30274dd318.jpg'),(3,'123','123','123','男','18223322919','','/upload/20221228/eb070664-7c32-4e30-ae22-e48dafd1e492.jpg');

/*Table structure for table `zhaopianfenlei` */

DROP TABLE IF EXISTS `zhaopianfenlei`;

CREATE TABLE `zhaopianfenlei` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fenleimingcheng` varchar(255) NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='照片分类';

/*Data for the table `zhaopianfenlei` */

insert  into `zhaopianfenlei`(`id`,`fenleimingcheng`) values (1,'风景'),(2,'美食'),(3,'城市'),(4,'人物');

/*Table structure for table `zhaopianxinxi` */

DROP TABLE IF EXISTS `zhaopianxinxi`;

CREATE TABLE `zhaopianxinxi` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `zhaopianbianhao` varchar(50) NOT NULL COMMENT '照片编号',
  `zhaopianmingcheng` varchar(255) NOT NULL COMMENT '照片名称',
  `fenlei` int(10) unsigned NOT NULL COMMENT '分类',
  `zhaopian` text NOT NULL COMMENT '照片',
  `paisheshijian` varchar(25) NOT NULL COMMENT '拍摄时间',
  `paishedidian` varchar(50) NOT NULL COMMENT '拍摄地点',
  `zhaopianjianjie` text NOT NULL COMMENT '照片简介',
  `faburen` varchar(50) NOT NULL COMMENT '发布人',
  PRIMARY KEY (`id`),
  KEY `zhaopianxinxi_fenlei_index` (`fenlei`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COMMENT='照片信息';

/*Data for the table `zhaopianxinxi` */

insert  into `zhaopianxinxi`(`id`,`zhaopianbianhao`,`zhaopianmingcheng`,`fenlei`,`zhaopian`,`paisheshijian`,`paishedidian`,`zhaopianjianjie`,`faburen`) values (6,'122812102365','重庆市市辖区渝北区',2,'/upload/20221228/1.jpg','2019-05-01 18:16:12','重庆','吃火锅','999'),(7,'122812193684','山东省潍坊市诸城市',1,'/upload/20221228/2.jpg','2019-07-31 12:14:06','山东','赶路','999'),(8,'122812221498','甘肃省庆阳市环县',1,'/upload/20221228/3.jpg','2019-08-13 09:31:35','甘肃','花草','999'),(9,'122812256578','河南省开封市龙亭区',1,'/upload/20221228/4.jpg','2019-01-20 13:54:28','河南','江边','999'),(10,'122812312186','甘肃省庆阳市庆城县',3,'/upload/20221228/5.jpg','2019-08-12 20:40:59','甘肃','街头','999'),(11,'122812380226','江西省上饶市广丰区',2,'/upload/20221228/7.jpg','2019:08:09 09:42:40','江西','聚餐','999');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
