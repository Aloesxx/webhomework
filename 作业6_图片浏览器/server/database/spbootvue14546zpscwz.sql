/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : spbootvue14546zpscwz

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2022-12-25 14:04:33
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `admins`
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '帐号',
  `pwd` varchar(50) NOT NULL COMMENT '密码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员';

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES ('1', 'admin', 'admin');

-- ----------------------------
-- Table structure for `dianzan`
-- ----------------------------
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

-- ----------------------------
-- Records of dianzan
-- ----------------------------
INSERT INTO `dianzan` VALUES ('2', '666', '2', 'zhaopianxinxi', '街头人物拍摄锦集', '2022-12-25 14:01:12');
INSERT INTO `dianzan` VALUES ('3', '666', '4', 'zhaopianxinxi', '非洲大草原动物锦集', '2022-12-25 14:01:48');

-- ----------------------------
-- Table structure for `lunbotu`
-- ----------------------------
DROP TABLE IF EXISTS `lunbotu`;
CREATE TABLE `lunbotu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `image` varchar(255) NOT NULL COMMENT '图片',
  `url` varchar(255) NOT NULL COMMENT '连接地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='轮播图';

-- ----------------------------
-- Records of lunbotu
-- ----------------------------
INSERT INTO `lunbotu` VALUES ('1', '1', '/upload/20221225/c6f28a5e-f2c8-46a0-9694-90b45f31c0a6.png', '#');
INSERT INTO `lunbotu` VALUES ('2', '2', '/upload/20221225/2ea416fa-9da5-4e03-8163-ca15e8739cfa.png', '#');
INSERT INTO `lunbotu` VALUES ('3', '3', '/upload/20221225/ad82eba3-3813-4bc1-a02b-192670b1927b.png', '#');

-- ----------------------------
-- Table structure for `pinglun`
-- ----------------------------
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

-- ----------------------------
-- Records of pinglun
-- ----------------------------
INSERT INTO `pinglun` VALUES ('1', 'zhaopianxinxi', '2', '街头人物拍摄锦集', '拍摄的太好看了', '666', '2022-12-25 14:00:18');

-- ----------------------------
-- Table structure for `shoucang`
-- ----------------------------
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

-- ----------------------------
-- Records of shoucang
-- ----------------------------
INSERT INTO `shoucang` VALUES ('3', '666', '2', 'zhaopianxinxi', '街头人物拍摄锦集', '2022-12-25 14:01:12');
INSERT INTO `shoucang` VALUES ('4', '666', '4', 'zhaopianxinxi', '非洲大草原动物锦集', '2022-12-25 14:01:47');

-- ----------------------------
-- Table structure for `yonghu`
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- ----------------------------
-- Records of yonghu
-- ----------------------------
INSERT INTO `yonghu` VALUES ('1', '999', '999', '小红', '女', '13423652312', '111@qq.com', '/upload/20221225/27e38ffd-e89d-427f-9626-c5ba5840a317.png');
INSERT INTO `yonghu` VALUES ('2', '666', '666', '小王', '男', '13423652361', '333@qq.com', '/upload/20221225/ea4cd9d4-5289-485c-9f6b-ca30274dd318.jpg');

-- ----------------------------
-- Table structure for `zhaopianfenlei`
-- ----------------------------
DROP TABLE IF EXISTS `zhaopianfenlei`;
CREATE TABLE `zhaopianfenlei` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fenleimingcheng` varchar(255) NOT NULL COMMENT '分类名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='照片分类';

-- ----------------------------
-- Records of zhaopianfenlei
-- ----------------------------
INSERT INTO `zhaopianfenlei` VALUES ('1', '风景');
INSERT INTO `zhaopianfenlei` VALUES ('2', '动物');
INSERT INTO `zhaopianfenlei` VALUES ('3', '城市');
INSERT INTO `zhaopianfenlei` VALUES ('4', '人物');

-- ----------------------------
-- Table structure for `zhaopianxinxi`
-- ----------------------------
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='照片信息';

-- ----------------------------
-- Records of zhaopianxinxi
-- ----------------------------
INSERT INTO `zhaopianxinxi` VALUES ('1', '122513435385', '云南风景照片锦集', '1', '/upload/20221225/13986871-c91b-433f-b8ab-960cdd729175.png,/upload/20221225/52069d24-e34f-47d8-86e7-5bc6babdcc9c.png,/upload/20221225/08cab5e2-bddc-4909-8e4d-20624c34dcf0.png,/upload/20221225/4774942b-d410-43cb-be96-c52b755452ba.png,/upload/20221225/1fc0eac5-704f-488a-b4cc-ca4e215e06fe.png,/upload/20221225/6e962f16-dbee-498d-bd7d-e4f687d01cfd.png', '2022-12-25 13:45:45', '云南', 'XXX', '999');
INSERT INTO `zhaopianxinxi` VALUES ('2', '122513492692', '街头人物拍摄锦集', '4', '/upload/20221225/6b2f7de8-af45-4dcc-8dbe-7b60a4738ca1.png,/upload/20221225/5c8ad63d-cfbf-448c-b1b3-b4b403ab9f83.png,/upload/20221225/659e16f7-bf09-4f61-8aa3-0cfc2e294c72.png,/upload/20221225/7c25a0ee-e6dd-416c-a45a-a11ee9beec11.png', '2022-12-25 13:51:11', '街头', 'XXXXXX', '999');
INSERT INTO `zhaopianxinxi` VALUES ('3', '122513511523', '上海城市拍摄照片锦集', '3', '/upload/20221225/3bbdaaf5-52d2-4b1d-9e92-c38a72177f27.png,/upload/20221225/4f4d89a3-0133-441d-9bb9-6d7e457bac3a.png,/upload/20221225/0d913103-deeb-4273-9ffd-ca3aa977320f.png,/upload/20221225/546ac659-4272-49f9-8a36-a281b6c76bd5.png', '2022-12-25 13:53:05', '上海', 'XXXX', '999');
INSERT INTO `zhaopianxinxi` VALUES ('4', '122513544995', '非洲大草原动物锦集', '2', '/upload/20221225/06afc0fb-fb95-4588-839f-52e57a92af7f.png,/upload/20221225/b02a0653-f71d-4461-b49d-6bc4d119c42a.png,/upload/20221225/ba2b4c0d-5d25-4aae-a1df-459831b60420.png,/upload/20221225/6a253921-39b8-4d4a-bf50-46b524f359c3.png', '2022-12-25 13:55:34', '非洲', 'XXXXX', '999');
INSERT INTO `zhaopianxinxi` VALUES ('5', '122514021973', '北京夜景照片锦集', '3', '/upload/20221225/f48c0e4d-c435-4064-88c1-95af9d470bdb.png,/upload/20221225/73cfafbe-1a3c-4558-ab75-79fc457fe0ea.png,/upload/20221225/98f80e4d-8e51-481a-babc-d15b61a0d76f.png', '2022-12-25 14:03:31', '北京', 'XXXX', '666');
