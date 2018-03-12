/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : salesuat

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-03-07 12:06:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `customer_info`
-- ----------------------------
DROP TABLE IF EXISTS `customer_info`;
CREATE TABLE `customer_info` (
  `customer_id` int(100) NOT NULL AUTO_INCREMENT,
  `customer_name` char(30) DEFAULT NULL COMMENT '店名',
  `customer_second_name` varchar(30) DEFAULT NULL COMMENT '分店名',
  `customer_help_count_date` varchar(30) DEFAULT NULL COMMENT '辅助统计日期',
  `customer_contact` char(20) DEFAULT NULL COMMENT '联系人称呼',
  `customer_contact_phone` char(20) DEFAULT NULL,
  `customer_notes` varchar(200) DEFAULT NULL COMMENT '总备注',
  `customer_district` char(5) DEFAULT NULL COMMENT '地区外键',
  `customer_street` varchar(50) DEFAULT NULL COMMENT '区域街道',
  `customer_create_date` timestamp NULL DEFAULT NULL COMMENT '创建拜访的日期',
  `customer_create_sellers_id` int(100) DEFAULT NULL,
  `visit_kinds` int(5) DEFAULT NULL COMMENT '类型',
  `customer_kinds` int(5) DEFAULT NULL COMMENT '客户种类',
  `city` char(5) DEFAULT NULL COMMENT '城市',
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer_info
-- ----------------------------
INSERT INTO `customer_info` VALUES ('220', '海底捞', '海底捞3分店', '1705', '小明', '13895648548', '总备注', '青羊区', '北大街', '2018-02-15 00:00:00', '1', '5', '11', 'HK');
INSERT INTO `customer_info` VALUES ('221', '客户名称', '海底捞3分店', '1705', 'json测试014', '13859568485', '啊总备注', 'json测', '旺泉街', '2018-03-13 00:00:00', '1', '3', '8', 'HK');

-- ----------------------------
-- Table structure for `customer_kinds`
-- ----------------------------
DROP TABLE IF EXISTS `customer_kinds`;
CREATE TABLE `customer_kinds` (
  `customer_kinds_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '客户种类',
  `customer_kinds_name` varchar(30) DEFAULT NULL COMMENT '客户种类',
  PRIMARY KEY (`customer_kinds_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer_kinds
-- ----------------------------
INSERT INTO `customer_kinds` VALUES ('1', '粤菜');
INSERT INTO `customer_kinds` VALUES ('2', '烧烤');
INSERT INTO `customer_kinds` VALUES ('3', '西餐');
INSERT INTO `customer_kinds` VALUES ('4', '火锅');
INSERT INTO `customer_kinds` VALUES ('5', '网吧');
INSERT INTO `customer_kinds` VALUES ('6', '影院');
INSERT INTO `customer_kinds` VALUES ('7', '酒吧');
INSERT INTO `customer_kinds` VALUES ('8', '其它');
INSERT INTO `customer_kinds` VALUES ('9', 'ktv');
INSERT INTO `customer_kinds` VALUES ('10', '茶餐厅');
INSERT INTO `customer_kinds` VALUES ('11', '江浙菜');
INSERT INTO `customer_kinds` VALUES ('12', '美容院');
INSERT INTO `customer_kinds` VALUES ('13', '饮品店');
INSERT INTO `customer_kinds` VALUES ('14', '咖啡厅');
INSERT INTO `customer_kinds` VALUES ('15', '清真菜');
INSERT INTO `customer_kinds` VALUES ('16', '俱乐部');
INSERT INTO `customer_kinds` VALUES ('17', '快/简餐');
INSERT INTO `customer_kinds` VALUES ('18', '川/辣菜');
INSERT INTO `customer_kinds` VALUES ('19', '日本料理');
INSERT INTO `customer_kinds` VALUES ('20', '水疗会所');
INSERT INTO `customer_kinds` VALUES ('21', '韩国料理');
INSERT INTO `customer_kinds` VALUES ('22', '面包甜点');
INSERT INTO `customer_kinds` VALUES ('23', '星马越泰菜');
INSERT INTO `customer_kinds` VALUES ('24', '东/西北菜');

-- ----------------------------
-- Table structure for `new_service_info`
-- ----------------------------
DROP TABLE IF EXISTS `new_service_info`;
CREATE TABLE `new_service_info` (
  `new_service_info_id` int(200) NOT NULL AUTO_INCREMENT COMMENT '服务主键',
  `new_visit_info_pid` int(100) DEFAULT NULL COMMENT '拜访外键',
  `new_service_money` varchar(50) DEFAULT NULL COMMENT '服务总金额',
  `new_services_kinds` varchar(200) DEFAULT NULL COMMENT '服务存入数量与类别',
  `new_services_kind` varchar(20) DEFAULT NULL COMMENT '类别',
  PRIMARY KEY (`new_service_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of new_service_info
-- ----------------------------
INSERT INTO `new_service_info` VALUES ('1', '1', '123123', 'matong*123-', '0');
INSERT INTO `new_service_info` VALUES ('2', '1', '1000', 'fengshanji*123-TChaohua*123-shuixingpenji*1651-', '1');
INSERT INTO `new_service_info` VALUES ('3', '2', '534', 'fengshanji*543-TChaohua*543-', '1');
INSERT INTO `new_service_info` VALUES ('4', '2', '453543', 'matong*14-niaodou*453-shuipen*45354-', '0');
INSERT INTO `new_service_info` VALUES ('5', '3', '45245', 'fengshanji*4245-TChaohua*452-', '1');
INSERT INTO `new_service_info` VALUES ('6', '3', '452452', 'laoshu*542-zhanglang*0-', '2');

-- ----------------------------
-- Table structure for `order_customer_info`
-- ----------------------------
DROP TABLE IF EXISTS `order_customer_info`;
CREATE TABLE `order_customer_info` (
  `order_customer_info_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '订单客户信息主键',
  `order_customer_name` varchar(50) DEFAULT NULL COMMENT '订单客户姓名',
  `order_customer_phone` varchar(20) DEFAULT NULL COMMENT '订单客户电话',
  `order_customer_rural` varchar(50) DEFAULT NULL COMMENT '订单客户区域',
  `order_customer_street` varchar(20) DEFAULT NULL COMMENT '订单客户街道',
  `order_customer_seller_id` int(20) DEFAULT NULL COMMENT '订单销售外键',
  `order_customer_total_money` varchar(100) DEFAULT NULL COMMENT '订单客户订单总额',
  `city` char(5) DEFAULT NULL,
  `order_detail` varchar(100) DEFAULT NULL COMMENT '订货详情'',''号分隔',
  `order_info_date` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '订单日期',
  PRIMARY KEY (`order_customer_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_customer_info
-- ----------------------------

-- ----------------------------
-- Table structure for `order_info`
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
  `order_info_id` int(100) NOT NULL AUTO_INCREMENT COMMENT '销售订单主键',
  `seller_id` int(20) DEFAULT NULL COMMENT '销售外键',
  `order_info_seller_name` varchar(50) DEFAULT NULL COMMENT '销售姓名',
  `order_info_customer_pid` varchar(20) DEFAULT NULL COMMENT '客户外键',
  `order_customer_name` varchar(50) DEFAULT NULL COMMENT '客户姓名',
  `order_info_rural` varchar(50) DEFAULT NULL COMMENT '订单区域',
  `order_info_rural_location` varchar(50) DEFAULT NULL COMMENT '订单街道地址',
  `order_info_code_number` varchar(150) DEFAULT NULL COMMENT '订单编号',
  `order_info_money_total` varchar(30) DEFAULT NULL COMMENT '销售姓名',
  `order_info_date` varchar(30) DEFAULT NULL COMMENT '订单生成日期',
  `order_goods_code_number` varchar(50) DEFAULT NULL COMMENT '订货编号',
  `order_per_price` varchar(20) DEFAULT NULL,
  `order_free` varchar(20) DEFAULT NULL,
  `order_count` varchar(20) DEFAULT NULL,
  `city` char(5) DEFAULT NULL,
  PRIMARY KEY (`order_info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of order_info
-- ----------------------------

-- ----------------------------
-- Table structure for `sales_kinds`
-- ----------------------------
DROP TABLE IF EXISTS `sales_kinds`;
CREATE TABLE `sales_kinds` (
  `kinds_id` int(20) NOT NULL AUTO_INCREMENT,
  `kinds_name` char(20) DEFAULT NULL,
  `kinds_pid` int(20) DEFAULT NULL,
  PRIMARY KEY (`kinds_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sales_kinds
-- ----------------------------
INSERT INTO `sales_kinds` VALUES ('1', '拜访类型', '0');
INSERT INTO `sales_kinds` VALUES ('2', '拜访目的', '0');
INSERT INTO `sales_kinds` VALUES ('3', '客户种类', '0');
INSERT INTO `sales_kinds` VALUES ('4', '清洁', '0');
INSERT INTO `sales_kinds` VALUES ('5', '灭虫', '0');
INSERT INTO `sales_kinds` VALUES ('6', '飘盈香', '0');
INSERT INTO `sales_kinds` VALUES ('7', '甲醛', '0');
INSERT INTO `sales_kinds` VALUES ('8', '服务类别  合计金额', '0');
INSERT INTO `sales_kinds` VALUES ('9', '纸品', '0');
INSERT INTO `sales_kinds` VALUES ('10', '一次性售卖', '0');
INSERT INTO `sales_kinds` VALUES ('11', '陌拜', '1');
INSERT INTO `sales_kinds` VALUES ('12', '日常跟进', '1');
INSERT INTO `sales_kinds` VALUES ('13', '客户资源', '1');
INSERT INTO `sales_kinds` VALUES ('14', '电话上门', '1');
INSERT INTO `sales_kinds` VALUES ('15', '首次', '2');
INSERT INTO `sales_kinds` VALUES ('16', '报价', '2');
INSERT INTO `sales_kinds` VALUES ('17', '客诉', '2');
INSERT INTO `sales_kinds` VALUES ('18', '收款', '2');
INSERT INTO `sales_kinds` VALUES ('19', '追款', '2');
INSERT INTO `sales_kinds` VALUES ('20', '签单', '2');
INSERT INTO `sales_kinds` VALUES ('21', '续约', '2');
INSERT INTO `sales_kinds` VALUES ('22', '回访', '2');
INSERT INTO `sales_kinds` VALUES ('23', '其他', '2');
INSERT INTO `sales_kinds` VALUES ('24', '更改项目', '2');
INSERT INTO `sales_kinds` VALUES ('25', '粤菜', '3');
INSERT INTO `sales_kinds` VALUES ('26', '烧烤', '3');
INSERT INTO `sales_kinds` VALUES ('27', '西餐', '3');
INSERT INTO `sales_kinds` VALUES ('28', '火锅', '3');
INSERT INTO `sales_kinds` VALUES ('29', '网吧', '3');
INSERT INTO `sales_kinds` VALUES ('30', '影院', '3');
INSERT INTO `sales_kinds` VALUES ('31', '酒吧', '3');
INSERT INTO `sales_kinds` VALUES ('32', '其它', '3');
INSERT INTO `sales_kinds` VALUES ('33', 'ktv', '3');
INSERT INTO `sales_kinds` VALUES ('34', '茶餐厅', '3');
INSERT INTO `sales_kinds` VALUES ('35', '江浙菜', '3');
INSERT INTO `sales_kinds` VALUES ('36', '美容院', '3');
INSERT INTO `sales_kinds` VALUES ('37', '饮品店', '3');
INSERT INTO `sales_kinds` VALUES ('38', '咖啡厅', '3');
INSERT INTO `sales_kinds` VALUES ('39', '清真菜', '3');
INSERT INTO `sales_kinds` VALUES ('40', '俱乐部', '3');
INSERT INTO `sales_kinds` VALUES ('41', '快/简餐', '3');
INSERT INTO `sales_kinds` VALUES ('42', '川/辣菜', '3');
INSERT INTO `sales_kinds` VALUES ('43', '日本料理', '3');
INSERT INTO `sales_kinds` VALUES ('44', '水疗会所', '3');
INSERT INTO `sales_kinds` VALUES ('45', '韩国料理', '3');
INSERT INTO `sales_kinds` VALUES ('46', '面包甜点', '3');
INSERT INTO `sales_kinds` VALUES ('47', '星马越泰菜', '3');
INSERT INTO `sales_kinds` VALUES ('48', '东/西北菜', '3');
INSERT INTO `sales_kinds` VALUES ('49', '马桶', '4');
INSERT INTO `sales_kinds` VALUES ('50', '尿斗', '4');
INSERT INTO `sales_kinds` VALUES ('51', '水盆', '4');
INSERT INTO `sales_kinds` VALUES ('52', '清新机', '4');
INSERT INTO `sales_kinds` VALUES ('53', '皂液机', '4');
INSERT INTO `sales_kinds` VALUES ('54', '租赁机器', '4');
INSERT INTO `sales_kinds` VALUES ('55', '年金额', '4');
INSERT INTO `sales_kinds` VALUES ('56', '老鼠', '5');
INSERT INTO `sales_kinds` VALUES ('57', '蟑螂', '5');
INSERT INTO `sales_kinds` VALUES ('58', '果蝇', '5');
INSERT INTO `sales_kinds` VALUES ('59', '租灭蝇灯', '5');
INSERT INTO `sales_kinds` VALUES ('60', '老鼠蟑螂', '5');
INSERT INTO `sales_kinds` VALUES ('61', '老鼠果蝇', '5');
INSERT INTO `sales_kinds` VALUES ('62', '老鼠蟑螂果蝇', '5');
INSERT INTO `sales_kinds` VALUES ('63', '老鼠蟑螂+租灯', '5');
INSERT INTO `sales_kinds` VALUES ('64', '老鼠果蝇+租灯', '5');
INSERT INTO `sales_kinds` VALUES ('65', '老鼠蟑螂果蝇+租灯', '5');
INSERT INTO `sales_kinds` VALUES ('66', '小机', '6');
INSERT INTO `sales_kinds` VALUES ('67', '中机', '6');
INSERT INTO `sales_kinds` VALUES ('68', '大机', '6');
INSERT INTO `sales_kinds` VALUES ('69', '迷你小机', '6');
INSERT INTO `sales_kinds` VALUES ('70', '除甲醛', '7');
INSERT INTO `sales_kinds` VALUES ('71', 'AC30', '7');
INSERT INTO `sales_kinds` VALUES ('72', '迷你清洁炮', '7');

-- ----------------------------
-- Table structure for `sellers_info`
-- ----------------------------
DROP TABLE IF EXISTS `sellers_info`;
CREATE TABLE `sellers_info` (
  `sellers_id` int(12) NOT NULL AUTO_INCREMENT COMMENT '销售员主键',
  `sellers_name` varchar(20) DEFAULT NULL COMMENT '销售员名',
  `city` char(5) DEFAULT NULL COMMENT '城市权限',
  PRIMARY KEY (`sellers_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sellers_info
-- ----------------------------
INSERT INTO `sellers_info` VALUES ('1', '小明', 'HK');
INSERT INTO `sellers_info` VALUES ('2', '小王', 'HK');
INSERT INTO `sellers_info` VALUES ('3', '小李', 'HK');

-- ----------------------------
-- Table structure for `sellers_user_bind_v`
-- ----------------------------
DROP TABLE IF EXISTS `sellers_user_bind_v`;
CREATE TABLE `sellers_user_bind_v` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `sellers_id` int(20) DEFAULT NULL COMMENT '销售员外键',
  `sellers_name` varchar(15) DEFAULT NULL COMMENT '销售员姓名',
  `user_id` varchar(20) DEFAULT NULL COMMENT '登录的销售员账号主键',
  `user_name` varchar(30) DEFAULT NULL COMMENT '登录的销售员disp_name',
  `user_position` varchar(50) DEFAULT NULL COMMENT '职位',
  `user_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '入职时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sellers_user_bind_v
-- ----------------------------
INSERT INTO `sellers_user_bind_v` VALUES ('1', '1', '小明', 'admin', 'administrator', '销售员1', '2018-03-22 15:47:14');
INSERT INTO `sellers_user_bind_v` VALUES ('2', '2', '小张', 'json', 'jsonZhang', '销售员2', '2018-03-06 15:49:14');

-- ----------------------------
-- Table structure for `service_history`
-- ----------------------------
DROP TABLE IF EXISTS `service_history`;
CREATE TABLE `service_history` (
  `service_history_id` int(100) NOT NULL AUTO_INCREMENT COMMENT '跟进服务主键',
  `service_history_name` varchar(20) DEFAULT NULL COMMENT '拜访服务名',
  `service_history_count` varchar(10) DEFAULT NULL COMMENT '服务',
  `service_history_money` varchar(20) DEFAULT NULL COMMENT '服务金额',
  `service_visit_pid` char(5) DEFAULT NULL COMMENT '跟进外键',
  PRIMARY KEY (`service_history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=142 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of service_history
-- ----------------------------
INSERT INTO `service_history` VALUES ('1', '清洁(清新机)', '4654$', '1111', '6');
INSERT INTO `service_history` VALUES ('2', '清洁(清新机)', '4654$', '1111', '7');
INSERT INTO `service_history` VALUES ('3', '清洁(清新机)', '4654$', '1111', '8');
INSERT INTO `service_history` VALUES ('4', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '9');
INSERT INTO `service_history` VALUES ('5', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '10');
INSERT INTO `service_history` VALUES ('6', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '11');
INSERT INTO `service_history` VALUES ('7', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '12');
INSERT INTO `service_history` VALUES ('8', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '13');
INSERT INTO `service_history` VALUES ('9', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '14');
INSERT INTO `service_history` VALUES ('10', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '15');
INSERT INTO `service_history` VALUES ('11', '灭虫(老鼠蟑螂)', '第一次跟进的第而次服', '第一次跟进的第二次服务价格', '15');
INSERT INTO `service_history` VALUES ('12', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '16');
INSERT INTO `service_history` VALUES ('13', '灭虫(老鼠蟑螂)', '第一次跟进的第而次服', '第一次跟进的第二次服务价格', '16');
INSERT INTO `service_history` VALUES ('14', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '17');
INSERT INTO `service_history` VALUES ('15', '灭虫(老鼠蟑螂)', '第一次跟进的第而次服', '第一次跟进的第二次服务价格', '17');
INSERT INTO `service_history` VALUES ('16', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '18');
INSERT INTO `service_history` VALUES ('17', '灭虫(老鼠蟑螂)', '第一次跟进的第而次服', '第一次跟进的第二次服务价格', '18');
INSERT INTO `service_history` VALUES ('18', '清洁(租赁机器)', '第一次跟进的第一次服', '第一次跟进的第一次服务数量', '20');
INSERT INTO `service_history` VALUES ('19', '灭虫(老鼠蟑螂)', '第一次跟进的第而次服', '第一次跟进的第二次服务价格', '20');
INSERT INTO `service_history` VALUES ('20', '清洁(皂液机)', '第一个价格', '0333333333', '33');
INSERT INTO `service_history` VALUES ('21', '清洁(皂液机)', '第一个价格', '0333333333', '34');
INSERT INTO `service_history` VALUES ('22', '清洁(租赁机器)', '第一个价格', '0333333333', '35');
INSERT INTO `service_history` VALUES ('23', '清洁(租赁机器)', '第一个价格', '0333333333', '36');
INSERT INTO `service_history` VALUES ('24', '清洁(租赁机器)', '第一个价格', '0333333333', '37');
INSERT INTO `service_history` VALUES ('25', '清洁(租赁机器)', '第一个价格', '0333333333', '38');
INSERT INTO `service_history` VALUES ('26', '清洁(租赁机器)', '第一个价格', '0333333333', '39');
INSERT INTO `service_history` VALUES ('27', '清洁(租赁机器)', '第一个价格', '0333333333', '40');
INSERT INTO `service_history` VALUES ('28', '清洁(租赁机器)', '第一个价格', '0333333333', '41');
INSERT INTO `service_history` VALUES ('29', '清洁(租赁机器)', '第一个价格', '0333333333', '42');
INSERT INTO `service_history` VALUES ('30', '清洁(租赁机器)', '第一个价格', '0333333333', '43');
INSERT INTO `service_history` VALUES ('31', '清洁(皂液机)', '232323', '232323', '44');
INSERT INTO `service_history` VALUES ('32', '清洁(租赁机器)', '第一个价格', '0333333333', '45');
INSERT INTO `service_history` VALUES ('33', '清洁(水盆)', '跟进二服务22', '第一次跟进的第二次服务价格', '45');
INSERT INTO `service_history` VALUES ('34', '清洁(租赁机器)', '第一个价格', '0333333333', '47');
INSERT INTO `service_history` VALUES ('35', '清洁(水盆)', '跟进二服务22', '第一次跟进的第二次服务价格', '47');
INSERT INTO `service_history` VALUES ('36', '清洁(皂液机)', '9', '130', '48');
INSERT INTO `service_history` VALUES ('37', '清洁(清新机)', '9', '130', '48');
INSERT INTO `service_history` VALUES ('38', '清洁(皂液机)', '14141', '4141', '48');
INSERT INTO `service_history` VALUES ('39', '灭虫(老鼠)', '14141', '170', '49');
INSERT INTO `service_history` VALUES ('40', '清洁(皂液机)', '232323', '0333333333', '50');
INSERT INTO `service_history` VALUES ('41', '清洁(尿斗)', '跟进二服务22', '跟进二服务222', '50');
INSERT INTO `service_history` VALUES ('42', '清洁(水盆)', '跟进三服务22', '跟进二服务222', '50');
INSERT INTO `service_history` VALUES ('43', '清洁(皂液机)', '撒大大', '130', '51');
INSERT INTO `service_history` VALUES ('44', '清洁(清新机)', '撒搭', '130', '51');
INSERT INTO `service_history` VALUES ('45', '清洁(租赁机器)', '14141', '170', '51');
INSERT INTO `service_history` VALUES ('46', '清洁(租赁机器)', '14141', '4141', '52');
INSERT INTO `service_history` VALUES ('47', '清洁(租赁机器)', '第一个价格', '0333333333', '53');
INSERT INTO `service_history` VALUES ('48', '清洁(清新机)', '第一个价格', '232323', '54');
INSERT INTO `service_history` VALUES ('49', '清洁(皂液机)', '跟进三服务22', '第一次跟进的第二次服务价格', '54');
INSERT INTO `service_history` VALUES ('50', '清洁(皂液机)', '跟进三服务22', '跟进三服务222', '54');
INSERT INTO `service_history` VALUES ('51', '清洁(清新机)', '第一个价格', '232323', '55');
INSERT INTO `service_history` VALUES ('52', '清洁(皂液机)', '跟进三服务22', '第一次跟进的第二次服务价格', '55');
INSERT INTO `service_history` VALUES ('53', '清洁(皂液机)', '跟进三服务22', '跟进三服务222', '55');
INSERT INTO `service_history` VALUES ('54', '清洁(清新机)', '第一个价格', '232323', '56');
INSERT INTO `service_history` VALUES ('55', '清洁(皂液机)', '跟进三服务22', '第一次跟进的第二次服务价格', '56');
INSERT INTO `service_history` VALUES ('56', '清洁(皂液机)', '跟进三服务22', '跟进三服务222', '56');
INSERT INTO `service_history` VALUES ('57', '清洁(清新机)', '第一个价格', '232323', '58');
INSERT INTO `service_history` VALUES ('58', '清洁(皂液机)', '跟进三服务22', '第一次跟进的第二次服务价格', '58');
INSERT INTO `service_history` VALUES ('59', '清洁(皂液机)', '跟进三服务22', '跟进三服务222', '58');
INSERT INTO `service_history` VALUES ('60', '清洁(清新机)', '第一个价格', '232323', '59');
INSERT INTO `service_history` VALUES ('61', '清洁(皂液机)', '跟进三服务22', '第一次跟进的第二次服务价格', '59');
INSERT INTO `service_history` VALUES ('62', '清洁(皂液机)', '跟进三服务22', '跟进三服务222', '59');
INSERT INTO `service_history` VALUES ('63', '清洁(清新机)', '第一个价格', '232323', '61');
INSERT INTO `service_history` VALUES ('64', '清洁(皂液机)', '跟进三服务22', '第一次跟进的第二次服务价格', '61');
INSERT INTO `service_history` VALUES ('65', '清洁(皂液机)', '跟进三服务22', '跟进三服务222', '61');
INSERT INTO `service_history` VALUES ('66', '清洁(清新机)', '第一个价格', '232323', '62');
INSERT INTO `service_history` VALUES ('67', '清洁(皂液机)', '跟进三服务22', '第一次跟进的第二次服务价格', '62');
INSERT INTO `service_history` VALUES ('68', '清洁(皂液机)', '跟进三服务22', '跟进三服务222', '62');
INSERT INTO `service_history` VALUES ('69', '清洁(皂液机)', '9', '130', '63');
INSERT INTO `service_history` VALUES ('70', '清洁(水盆)', '9', '130', '63');
INSERT INTO `service_history` VALUES ('71', '清洁(清新机)', '8', '4141', '63');
INSERT INTO `service_history` VALUES ('72', '灭虫(租灭蝇灯)', '第二次跟进第一个服务', '4141', '64');
INSERT INTO `service_history` VALUES ('73', '清洁(清新机)', '232323', '0333333333', '65');
INSERT INTO `service_history` VALUES ('74', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '65');
INSERT INTO `service_history` VALUES ('75', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '65');
INSERT INTO `service_history` VALUES ('76', '清洁(皂液机)', '9安全区群', '130啊啊', '66');
INSERT INTO `service_history` VALUES ('77', '灭虫(老鼠)', '9阿斯达', '130sadad', '66');
INSERT INTO `service_history` VALUES ('78', '清洁(租赁机器)', '14141', '第二次跟进第一个服务价格', '66');
INSERT INTO `service_history` VALUES ('79', '清洁(尿斗)', '14141', '4141', '67');
INSERT INTO `service_history` VALUES ('80', '清洁(清新机)', '232323', '0333333333', '68');
INSERT INTO `service_history` VALUES ('81', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '68');
INSERT INTO `service_history` VALUES ('82', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '68');
INSERT INTO `service_history` VALUES ('83', '清洁(清新机)', '232323', '0333333333', '69');
INSERT INTO `service_history` VALUES ('84', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '69');
INSERT INTO `service_history` VALUES ('85', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '69');
INSERT INTO `service_history` VALUES ('86', '清洁(清新机)', '232323', '0333333333', '70');
INSERT INTO `service_history` VALUES ('87', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '70');
INSERT INTO `service_history` VALUES ('88', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '70');
INSERT INTO `service_history` VALUES ('89', '清洁(清新机)', '232323', '0333333333', '71');
INSERT INTO `service_history` VALUES ('90', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '71');
INSERT INTO `service_history` VALUES ('91', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '71');
INSERT INTO `service_history` VALUES ('92', '清洁(清新机)', '232323', '0333333333', '73');
INSERT INTO `service_history` VALUES ('93', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '73');
INSERT INTO `service_history` VALUES ('94', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '73');
INSERT INTO `service_history` VALUES ('95', '清洁(清新机)', '232323', '0333333333', '75');
INSERT INTO `service_history` VALUES ('96', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '75');
INSERT INTO `service_history` VALUES ('97', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '75');
INSERT INTO `service_history` VALUES ('98', '清洁(清新机)', '232323', '0333333333', '77');
INSERT INTO `service_history` VALUES ('99', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '77');
INSERT INTO `service_history` VALUES ('100', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '77');
INSERT INTO `service_history` VALUES ('101', '灭虫(老鼠蟑螂)', '4141', '第二次跟进第二个服务价格', '78');
INSERT INTO `service_history` VALUES ('102', '清洁(水盆)', '85', '第二次跟进第三个服务价格', '78');
INSERT INTO `service_history` VALUES ('103', '清洁(租赁机器)', '14141', '第二次跟进第一个服务价格', '78');
INSERT INTO `service_history` VALUES ('104', '清洁(皂液机)', '9安全区群', '130啊啊', '79');
INSERT INTO `service_history` VALUES ('105', '灭虫(老鼠)', '9阿斯达', '130sadad', '79');
INSERT INTO `service_history` VALUES ('106', '清洁(尿斗)', '14141', '4141', '79');
INSERT INTO `service_history` VALUES ('107', '清洁(清新机)', '232323', '0333333333', '80');
INSERT INTO `service_history` VALUES ('108', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '80');
INSERT INTO `service_history` VALUES ('109', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '80');
INSERT INTO `service_history` VALUES ('110', '灭虫(老鼠蟑螂)', '4141', '第二次跟进第二个服务价格', '81');
INSERT INTO `service_history` VALUES ('111', '清洁(水盆)', '85', '第二次跟进第三个服务价格', '81');
INSERT INTO `service_history` VALUES ('112', '清洁(租赁机器)', '14141', '第二次跟进第一个服务价格', '81');
INSERT INTO `service_history` VALUES ('113', '清洁(皂液机)', '9安全区群', '130啊啊', '82');
INSERT INTO `service_history` VALUES ('114', '灭虫(老鼠)', '9阿斯达', '130sadad', '82');
INSERT INTO `service_history` VALUES ('115', '清洁(尿斗)', '14141', '4141', '82');
INSERT INTO `service_history` VALUES ('116', '清洁(清新机)', '第一个价格', '0333333333', '83');
INSERT INTO `service_history` VALUES ('117', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '83');
INSERT INTO `service_history` VALUES ('118', '清洁(租赁机器)', '跟进二服务22', '第一次跟进的第二次服务价格', '83');
INSERT INTO `service_history` VALUES ('119', '清洁(皂液机)', '第二次跟进第二个服务', '第二次跟进第二个服务价格', '84');
INSERT INTO `service_history` VALUES ('120', '灭虫(老鼠)', '第二次跟进第二个服务', '第二次跟进第二个服务价格', '84');
INSERT INTO `service_history` VALUES ('121', '清洁(水盆)', '第二次跟进第一个服务', '第二次跟进第一个服务价格', '84');
INSERT INTO `service_history` VALUES ('122', '灭虫(蟑螂)', '撒大大', '撒大大', '85');
INSERT INTO `service_history` VALUES ('123', '清洁(马桶)', '阿斯达多所', '撒大大撒多', '85');
INSERT INTO `service_history` VALUES ('124', '清洁(租赁机器)', '第二次跟进第一个服务', '撒大大', '85');
INSERT INTO `service_history` VALUES ('125', '清洁(清新机)', '232323', '0333333333', '86');
INSERT INTO `service_history` VALUES ('126', '清洁(皂液机)', '跟进二服务22', '第一次跟进的第二次服务价格', '86');
INSERT INTO `service_history` VALUES ('127', '灭虫(果蝇)', '跟进三服务22', '跟进三服务222', '86');
INSERT INTO `service_history` VALUES ('128', '清洁(水盆)', '4141', '第二次跟进第二个服务价格', '87');
INSERT INTO `service_history` VALUES ('129', '清洁(皂液机)', '第二次跟进第二个服务', '414141', '87');
INSERT INTO `service_history` VALUES ('130', '清洁(皂液机)', '第二次跟进第一个服务', '第二次跟进第一个服务价格', '87');
INSERT INTO `service_history` VALUES ('131', '清洁(水盆)', '第一个价格', '0333333333', '88');
INSERT INTO `service_history` VALUES ('132', '清洁(皂液机)', '跟进三服务22', '第一次跟进的第二次服务价格', '88');
INSERT INTO `service_history` VALUES ('133', '清洁(租赁机器)', '第一次跟进的第而次服', '跟进二服务222', '88');
INSERT INTO `service_history` VALUES ('136', '灭虫(蟑螂)', '修改测试adasd', '啊实打实大', '90');
INSERT INTO `service_history` VALUES ('137', '灭虫(老鼠蟑螂果蝇)', '修改测试', '修改数据测试', '90');
INSERT INTO `service_history` VALUES ('138', '飘盈香(迷你机)', '撒大受打击爱哦集合', '啊实打实大', '90');
INSERT INTO `service_history` VALUES ('139', '清洁(水盆)', '232323', '撒打算大', '92');
INSERT INTO `service_history` VALUES ('140', '清洁(皂液机)', '232323', '0333333333', '93');
INSERT INTO `service_history` VALUES ('141', '灭虫(老鼠)', '跟进三服务22', '第一次跟进的第二次服务价格', '93');

-- ----------------------------
-- Table structure for `video_info`
-- ----------------------------
DROP TABLE IF EXISTS `video_info`;
CREATE TABLE `video_info` (
  `video_info_id` int(150) NOT NULL AUTO_INCREMENT COMMENT '文件主键',
  `video_info_url` varchar(280) DEFAULT NULL COMMENT '文件路径',
  `seller_pid` int(100) DEFAULT NULL COMMENT '销售员外键',
  `seller_notes` varchar(100) DEFAULT NULL COMMENT '备注信息',
  `city_privileges` char(5) DEFAULT NULL COMMENT '城市外键',
  `video_info_date` timestamp NULL DEFAULT NULL COMMENT '上传时间',
  `video_info_statue` varchar(20) DEFAULT NULL COMMENT '五部曲步骤',
  `video_info_manager_grades` varchar(20) DEFAULT NULL COMMENT '总经理评分',
  `video_info_directer_grades` varchar(20) DEFAULT NULL COMMENT '总监评分',
  `video_info_user_position` varchar(50) DEFAULT NULL COMMENT '职位',
  `video_info_user_name` varchar(20) DEFAULT NULL COMMENT '员工姓名',
  PRIMARY KEY (`video_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of video_info
-- ----------------------------

-- ----------------------------
-- Table structure for `visit_definition`
-- ----------------------------
DROP TABLE IF EXISTS `visit_definition`;
CREATE TABLE `visit_definition` (
  `visit_definition_id` int(5) NOT NULL AUTO_INCREMENT,
  `visit_definition_name` varchar(25) DEFAULT NULL COMMENT '拜访目的',
  PRIMARY KEY (`visit_definition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of visit_definition
-- ----------------------------
INSERT INTO `visit_definition` VALUES ('1', '首次');
INSERT INTO `visit_definition` VALUES ('2', '报价');
INSERT INTO `visit_definition` VALUES ('3', '客诉');
INSERT INTO `visit_definition` VALUES ('4', '收款');
INSERT INTO `visit_definition` VALUES ('5', '追款');
INSERT INTO `visit_definition` VALUES ('6', '签单');
INSERT INTO `visit_definition` VALUES ('7', '续约');
INSERT INTO `visit_definition` VALUES ('8', '回访');
INSERT INTO `visit_definition` VALUES ('9', '其他');
INSERT INTO `visit_definition` VALUES ('10', '更改项目');
INSERT INTO `visit_definition` VALUES ('11', '拜访目的');
INSERT INTO `visit_definition` VALUES ('12', '陌拜');
INSERT INTO `visit_definition` VALUES ('13', '日常跟进');
INSERT INTO `visit_definition` VALUES ('14', '客户资源');
INSERT INTO `visit_definition` VALUES ('15', '电话上门');

-- ----------------------------
-- Table structure for `visit_info`
-- ----------------------------
DROP TABLE IF EXISTS `visit_info`;
CREATE TABLE `visit_info` (
  `visit_info_id` int(100) NOT NULL AUTO_INCREMENT,
  `visit_customer_fid` char(5) DEFAULT NULL COMMENT '客户外键',
  `visit_seller_fid` char(5) DEFAULT NULL COMMENT '销售外键',
  `visit_notes` varchar(100) DEFAULT NULL COMMENT '单次跟进备注',
  `visit_service_money` varchar(50) DEFAULT NULL COMMENT '单次跟进备注',
  `visit_date` varchar(50) DEFAULT NULL COMMENT '单次跟进日期',
  `visit_definition` varchar(20) DEFAULT NULL COMMENT '拜访目的',
  PRIMARY KEY (`visit_info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of visit_info
-- ----------------------------
INSERT INTO `visit_info` VALUES ('1', '220', '1', '第一次跟进备注', '124123', '2018/03/14', '追款');
INSERT INTO `visit_info` VALUES ('2', '221', '1', 'json测试99', '454077', '2018/03/14', '签单');
INSERT INTO `visit_info` VALUES ('3', '221', '1', '第一次跟进备注', '498691', '2018/03/21', '签单');
