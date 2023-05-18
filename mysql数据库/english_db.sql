/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : english_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2019-08-22 19:01:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_infoclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_infoclass`;
CREATE TABLE `t_infoclass` (
  `infoClassId` int(11) NOT NULL auto_increment COMMENT '知识分类id',
  `infoClassName` varchar(20) NOT NULL COMMENT '知识分类名称',
  `classDesc` varchar(800) default NULL COMMENT '知识分类说明',
  PRIMARY KEY  (`infoClassId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_infoclass
-- ----------------------------
INSERT INTO `t_infoclass` VALUES ('1', '英语初级语法', '英语初级语法');
INSERT INTO `t_infoclass` VALUES ('2', '英语单词训练', '英语单词训练');

-- ----------------------------
-- Table structure for `t_leaveword`
-- ----------------------------
DROP TABLE IF EXISTS `t_leaveword`;
CREATE TABLE `t_leaveword` (
  `leaveWordId` int(11) NOT NULL auto_increment COMMENT '留言id',
  `leaveTitle` varchar(80) NOT NULL COMMENT '留言标题',
  `leaveContent` varchar(2000) NOT NULL COMMENT '留言内容',
  `userObj` varchar(30) NOT NULL COMMENT '留言人',
  `leaveTime` varchar(20) default NULL COMMENT '留言时间',
  `replyContent` varchar(1000) default NULL COMMENT '管理回复',
  `replyTime` varchar(20) default NULL COMMENT '回复时间',
  PRIMARY KEY  (`leaveWordId`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_leaveword_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_leaveword
-- ----------------------------
INSERT INTO `t_leaveword` VALUES ('1', '想学习英语', '不知道怎么入门', 'user1', '2019-08-19 23:02:28', '可以找对的老师', '2019-08-19 23:02:31');
INSERT INTO `t_leaveword` VALUES ('2', '英语学会多久呢', '多久和外国人可以交流', 'user1', '2019-08-22 15:31:32', '--', '--');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `noticePhoto` varchar(60) NOT NULL COMMENT '新闻公告图片',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '英语学习网站成立了', 'upload/3d0e7dcd-8e0a-4fed-9c8a-e9f63adc3c5e.jpg', '<p>同学们可以来这里学习英语</p>', '2019-08-19 23:02:41');
INSERT INTO `t_notice` VALUES ('2', '来这里学习英语吧', 'upload/3d0e7dcd-8e0a-4fed-9c8a-e9f63adc3c5e.jpg', '<p>这里好多的英语学习方法哦</p>', '2019-08-22 18:45:22');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '王夏刚', '男', '2019-08-19', 'upload/b1d0adaa-f604-4886-8b4e-20c206ab11f8.jpg', '13890825934', 'xiagang@163.com', '四川达州', '2019-08-19 23:00:07');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '张晓红', '女', '2019-08-21', 'upload/3dacf5e7-5619-4a03-aea1-29f830f1632f.jpg', '15290832034', 'xiaohong@163.com', '四川广安岳池县', '2019-08-22 15:16:10');

-- ----------------------------
-- Table structure for `t_video`
-- ----------------------------
DROP TABLE IF EXISTS `t_video`;
CREATE TABLE `t_video` (
  `videoId` int(11) NOT NULL auto_increment COMMENT '视频id',
  `title` varchar(80) NOT NULL COMMENT '视频标题',
  `infoClassObj` int(11) NOT NULL COMMENT '知识分类',
  `videoDesc` varchar(8000) NOT NULL COMMENT '视频介绍',
  `videoFile` varchar(60) NOT NULL COMMENT '视频文件',
  `hitNum` int(11) NOT NULL COMMENT '点击率',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  `videoPhoto` varchar(60) NOT NULL COMMENT '视频图片',
  PRIMARY KEY  (`videoId`),
  KEY `infoClassObj` (`infoClassObj`),
  CONSTRAINT `t_video_ibfk_1` FOREIGN KEY (`infoClassObj`) REFERENCES `t_infoclass` (`infoClassId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_video
-- ----------------------------
INSERT INTO `t_video` VALUES ('1', '被动语态学习', '1', '<p>被动语态学习，被动语态学习，被动语态学习，被动语态学习，被动语态学习，被动语态学习，被动语态学习，被动语态学习，被动语态学习，被动语态学习被动语态学习被动语态学习</p>', 'upload/100120f7-65c9-4acd-8693-698c3512cca6.mp4', '7', '2019-08-19 23:00:50', 'upload/54e95659-16e8-4780-aa2e-f5d48b77b01c.jpg');
INSERT INTO `t_video` VALUES ('2', '英语单词记忆方法', '2', '<p>一个很巧的方法学习英语单词，英语单词训练</p><p>一个很巧的方法学习英语单词，英语单词训练</p><p>一个很巧的方法学习英语单词，英语单词训练</p><p>一个很巧的方法学习英语单词，英语单词训练</p><p>一个很巧的方法学习英语单词，英语单词训练</p><p>一个很巧的方法学习英语单词，英语单词训练</p><p>一个很巧的方法学习英语单词，英语单词训练</p><p>一个很巧的方法学习英语单词，英语单词训练</p><p>一个很巧的方法学习英语单词，英语单词训练</p>', 'upload/684353a6-4818-47d5-b6c8-37c46cb3b5bc.mp4', '6', '2019-08-22 18:39:47', 'upload/56863cd8-bd8d-465e-94fa-9285bb7025f5.jpg');

-- ----------------------------
-- Table structure for `t_videocomment`
-- ----------------------------
DROP TABLE IF EXISTS `t_videocomment`;
CREATE TABLE `t_videocomment` (
  `commentId` int(11) NOT NULL auto_increment COMMENT '评论id',
  `videoObj` int(11) NOT NULL COMMENT '被评视频',
  `content` varchar(1000) NOT NULL COMMENT '评论内容',
  `userObj` varchar(30) NOT NULL COMMENT '评论用户',
  `commentTime` varchar(20) default NULL COMMENT '评论时间',
  PRIMARY KEY  (`commentId`),
  KEY `videoObj` (`videoObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_videocomment_ibfk_1` FOREIGN KEY (`videoObj`) REFERENCES `t_video` (`videoId`),
  CONSTRAINT `t_videocomment_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_videocomment
-- ----------------------------
INSERT INTO `t_videocomment` VALUES ('1', '1', '老师讲的非常好', 'user1', '2019-08-19 21:11:22');
INSERT INTO `t_videocomment` VALUES ('2', '1', '是的 很好呢', 'user2', '2019-08-22 18:56:28');
INSERT INTO `t_videocomment` VALUES ('3', '2', '这个方法非常不错！', 'user2', '2019-08-22 18:57:07');

-- ----------------------------
-- Table structure for `t_xiti`
-- ----------------------------
DROP TABLE IF EXISTS `t_xiti`;
CREATE TABLE `t_xiti` (
  `xitiId` int(11) NOT NULL auto_increment COMMENT '习题id',
  `infoClassObj` int(11) NOT NULL COMMENT '知识分类',
  `title` varchar(80) NOT NULL COMMENT '习题标题',
  `score` float NOT NULL COMMENT '分值',
  `content` varchar(8000) NOT NULL COMMENT '习题内容',
  `analysis` varchar(5000) NOT NULL COMMENT '习题解析',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`xitiId`),
  KEY `infoClassObj` (`infoClassObj`),
  CONSTRAINT `t_xiti_ibfk_1` FOREIGN KEY (`infoClassObj`) REFERENCES `t_infoclass` (`infoClassId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_xiti
-- ----------------------------
INSERT INTO `t_xiti` VALUES ('1', '2', '习题标题111111', '3.5', '<p>习题内容测试1111111111111</p><p>习题内容测试1111111111111</p><p>习题内容测试1111111111111</p><p>习题内容测试1111111111111</p><p>习题内容测试1111111111111</p><p>习题内容测试1111111111111</p><p>习题内容测试1111111111111</p>', '<p>习题答案解析111111111111111111111111111</p><p>习题答案解析111111111111111111111111111</p><p>习题答案解析111111111111111111111111111</p><p>习题答案解析111111111111111111111111111</p><p>习题答案解析111111111111111111111111111</p><p>习题答案解析111111111111111111111111111</p>', '2019-08-19 23:02:16');
INSERT INTO `t_xiti` VALUES ('2', '1', '习题标题22222', '4.5', '<p>习题内容2222222222222222222222222222222222</p><p>习题内容2222222222222222222222222222222222</p><p>习题内容2222222222222222222222222222222222</p><p>习题内容2222222222222222222222222222222222</p><p>习题内容2222222222222222222222222222222222</p><p>习题内容2222222222222222222222222222222222</p><p>习题内容2222222222222222222222222222222222</p><p>习题内容2222222222222222222222222222222222</p>', '<p>习题答案解析22222222222222222222</p><p>习题答案解析22222222222222222222</p><p>习题答案解析22222222222222222222</p><p>习题答案解析22222222222222222222</p><p>习题答案解析22222222222222222222</p><p>习题答案解析22222222222222222222</p>', '2019-08-22 18:42:44');
