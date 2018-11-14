/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 50613
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 50613
 File Encoding         : 65001

 Date: 14/11/2018 09:26:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alarms_type
-- ----------------------------
DROP TABLE IF EXISTS `alarms_type`;
CREATE TABLE `alarms_type`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '报警编号ID',
  `alarm_code` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障编码',
  `alarm_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障/报警名称',
  `alarm_note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障/报警说明',
  `alarm_duration` int(5) NULL DEFAULT NULL COMMENT '故障报警有效时长',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报警记录表格' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of alarms_type
-- ----------------------------
INSERT INTO `alarms_type` VALUES (1, 'AM-0001', '供暖户回水温度低', '供暖住户回水温度低设定值', 120);
INSERT INTO `alarms_type` VALUES (2, 'AM-0002', '供暖户进回水温差大', '供暖住户进水温度和回水温度的差小于设定值', 120);
INSERT INTO `alarms_type` VALUES (3, 'AM-0003', '供暖户进回水温差小', '供暖住户进水温度和回水温度的差大于设定值', 120);
INSERT INTO `alarms_type` VALUES (4, 'AM-0004', '测温节点未固定', '测温节点未固定在指定安装位置', 360);
INSERT INTO `alarms_type` VALUES (5, 'AM-0005', '面板数据失联', '控制面板的数据已经失联，包括测温面板和阀门面板', 360);
INSERT INTO `alarms_type` VALUES (6, 'AM-0006', '测温节点电池欠压', ' 测温节点的电池电压低于设定值', 360);
INSERT INTO `alarms_type` VALUES (7, 'AM-0007', '报停户回水温度高', '报停住户的回水温度高于设定值', 360);
INSERT INTO `alarms_type` VALUES (8, 'AM-0008', '报停户日用热量高', '报停住户每日用热量高于设定值', 1500);
INSERT INTO `alarms_type` VALUES (9, 'AM-0009', '阀门电池欠压', '阀门供电电压低于设定值，针对无线电池供电阀门', 360);
INSERT INTO `alarms_type` VALUES (10, 'AM-0010', '热量表数据失联', '热量表数据失联超出设定时长，时长单位小时', 1500);
INSERT INTO `alarms_type` VALUES (11, 'AM-0011', '阀门数据失联', '阀门数据失联超出设定时长，时长单位小时', 1500);
INSERT INTO `alarms_type` VALUES (12, 'AM-0012', '测温数据失联', '测温数据失联超出设定时长，时长单位小时', 1500);
INSERT INTO `alarms_type` VALUES (13, 'AM-0013', '热量表负温差', '供暖住户热量表进水温度低于回水温度，且差值高于设定值', 360);
INSERT INTO `alarms_type` VALUES (14, 'AM-0014', '阀门状态异常', '阀门的开关状态异常，可能堵转', 360);
INSERT INTO `alarms_type` VALUES (15, 'AM-0015', '供暖户室温偏低', '供暖住户室内温度低于设定值', 360);
INSERT INTO `alarms_type` VALUES (16, 'AM-0016', '阀门控制器安装异常', '阀门控制器未安装到阀体上，或者转动电流低于设定电流值', 360);
INSERT INTO `alarms_type` VALUES (17, 'AM-0017', '热量表电池欠压', '热量表电池电压低于设定值或者欠压标志被置位', 3600);

-- ----------------------------
-- Table structure for branch_company
-- ----------------------------
DROP TABLE IF EXISTS `branch_company`;
CREATE TABLE `branch_company`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT '' COMMENT '热源厂名',
  `code` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT '0' COMMENT '热源厂编码',
  `heat_company_id` int(10) NULL DEFAULT NULL COMMENT '隶属热电厂ID',
  `available` int(1) NULL DEFAULT 0 COMMENT '是否可用 0:可用,1:不可用',
  `address` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分公司地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `heat_company_id`(`heat_company_id`) USING BTREE,
  CONSTRAINT `branch_company_ibfk_1` FOREIGN KEY (`heat_company_id`) REFERENCES `heat_company_info` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of branch_company
-- ----------------------------
INSERT INTO `branch_company` VALUES (1, '分公司1', '1', 1, 0, '');
INSERT INTO `branch_company` VALUES (28, '分公司2', '0', 1, 0, NULL);
INSERT INTO `branch_company` VALUES (29, '分公司3', '0', 1, 0, NULL);
INSERT INTO `branch_company` VALUES (30, '分公司4', '0', 1, 0, NULL);
INSERT INTO `branch_company` VALUES (31, '???2_del', '0', 1, 1, NULL);
INSERT INTO `branch_company` VALUES (32, '??_del', '0', 1, 1, NULL);
INSERT INTO `branch_company` VALUES (33, '分公司33', '0', 1, 0, NULL);
INSERT INTO `branch_company` VALUES (34, '分公司44', '0', 1, 0, NULL);
INSERT INTO `branch_company` VALUES (35, '测试分公司', '0', 1, 0, NULL);
INSERT INTO `branch_company` VALUES (36, '测试1', '0', 1, 0, NULL);

-- ----------------------------
-- Table structure for branch_data
-- ----------------------------
DROP TABLE IF EXISTS `branch_data`;
CREATE TABLE `branch_data`  (
  `branch_id` int(10) NOT NULL COMMENT '分支编号，外键branchs->id',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '累计热量,-1失联',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '累计流量,-1失联',
  `power` double(8, 4) NULL DEFAULT NULL COMMENT '热功率,-1失联',
  `flow` double(8, 4) NULL DEFAULT NULL COMMENT '瞬时流量,-1失联',
  `in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '进水温度,-1失联',
  `out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '回水温度,-1失联',
  `valve_status` tinyint(2) NULL DEFAULT NULL COMMENT '阀门状态,-1失联；0：开；1：关；2：开度；3：异常',
  `scale` int(3) NULL DEFAULT NULL COMMENT '开度',
  `in_mano` double(5, 3) NULL DEFAULT NULL COMMENT '进水压力,-1失联',
  `out_mano` double(5, 3) NULL DEFAULT NULL COMMENT '回水压力,-1失联',
  `error_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障列表',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`branch_id`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for branch_data_last
-- ----------------------------
DROP TABLE IF EXISTS `branch_data_last`;
CREATE TABLE `branch_data_last`  (
  `branch_id` int(10) NOT NULL COMMENT '分支编号，外键branchs->id',
  `data_time` datetime(0) NULL DEFAULT NULL COMMENT '数据时间',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '累计热量,-1失联',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '累计流量,-1失联',
  `power` double(8, 4) NULL DEFAULT NULL COMMENT '热功率,-1失联',
  `flow` double(8, 4) NULL DEFAULT NULL COMMENT '瞬时流量,-1失联',
  `in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '进水温度,-1失联',
  `out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '回水温度,-1失联',
  `valve_status` tinyint(2) NULL DEFAULT NULL COMMENT '阀门状态,-1失联；0：开；1：关；2：开度；3：异常',
  `scale` int(3) NULL DEFAULT NULL COMMENT '开度',
  `in_mano` double(5, 3) NULL DEFAULT NULL COMMENT '进水压力,-1失联',
  `out_mano` double(5, 3) NULL DEFAULT NULL COMMENT '回水压力,-1失联',
  `error_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障列表',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`branch_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for branch_day_data
-- ----------------------------
DROP TABLE IF EXISTS `branch_day_data`;
CREATE TABLE `branch_day_data`  (
  `branch_id` int(10) NOT NULL COMMENT '分支表id',
  `date` date NOT NULL COMMENT '添加时间',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '供暖面积',
  `day_heat` double(12, 2) NULL DEFAULT NULL COMMENT '热用量',
  `day_flow` double(12, 2) NULL DEFAULT NULL COMMENT '水用量',
  `avg_energy` double(6, 2) NULL DEFAULT NULL COMMENT '平均单耗（w/m2）',
  `avg_flow` double(6, 2) NULL DEFAULT NULL COMMENT '日单位水量',
  `avg_outdoor_temp` double(6, 2) NULL DEFAULT NULL COMMENT '日平均室外温度',
  `avg_in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均供水温度',
  `avg_out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均回水温度',
  `avg_room_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均室内温度',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`branch_id`, `date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for branch_heat_info
-- ----------------------------
DROP TABLE IF EXISTS `branch_heat_info`;
CREATE TABLE `branch_heat_info`  (
  `branch_id` int(10) NOT NULL COMMENT '分支编号',
  `total_count` int(10) NULL DEFAULT NULL COMMENT '总户数',
  `total_room_area` double(10, 2) NULL DEFAULT NULL COMMENT '总建筑面积',
  `total_heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '总供暖面积',
  `heat_count` int(10) NULL DEFAULT NULL COMMENT '供暖户数',
  `real_heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '实际供暖面积',
  PRIMARY KEY (`branch_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of branch_heat_info
-- ----------------------------
INSERT INTO `branch_heat_info` VALUES (140, 2, 264.22, 137.00, 1, 111.00);
INSERT INTO `branch_heat_info` VALUES (141, 4, 519.22, 444.00, 3, 333.00);
INSERT INTO `branch_heat_info` VALUES (142, 4, 496.22, 336.00, 2, 211.00);
INSERT INTO `branch_heat_info` VALUES (144, 8, 1036.22, 566.00, 7, 455.00);
INSERT INTO `branch_heat_info` VALUES (145, 4, 528.22, 274.00, 2, 137.00);
INSERT INTO `branch_heat_info` VALUES (147, 15, 1849.17, 1694.00, 5, 565.00);
INSERT INTO `branch_heat_info` VALUES (150, 2, 232.00, 210.00, 1, 111.00);
INSERT INTO `branch_heat_info` VALUES (151, 2, 345.22, 333.00, 1, 222.00);

-- ----------------------------
-- Table structure for branch_mano
-- ----------------------------
DROP TABLE IF EXISTS `branch_mano`;
CREATE TABLE `branch_mano`  (
  `branch_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分支编号',
  `in_mano` char(14) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '进水压力表具地址',
  `out_mano` char(14) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '出水压力表具名称',
  `mano_note` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL COMMENT '表具信息备注',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '表具更新时间',
  PRIMARY KEY (`branch_id`, `in_mano`) USING BTREE,
  CONSTRAINT `branch_mano_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci COMMENT = '大表详细信息，包括表号、厂家及通信协议等' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for branch_meter
-- ----------------------------
DROP TABLE IF EXISTS `branch_meter`;
CREATE TABLE `branch_meter`  (
  `branch_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分支编号',
  `meter_addr` char(14) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '表具地址',
  `meter_name` varchar(45) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '表具名称',
  `meter_note` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL COMMENT '表具信息备注',
  `stopped` int(1) NULL DEFAULT NULL COMMENT '是否已停用[0:未停用;1:已停用;]',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '表具使用起始时间',
  `stop_time` datetime(0) NULL DEFAULT NULL COMMENT '表具使用截止时间',
  PRIMARY KEY (`branch_id`, `meter_addr`) USING BTREE,
  CONSTRAINT `meter_branch` FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci COMMENT = '大表详细信息，包括表号、厂家及通信协议等' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for branch_room
-- ----------------------------
DROP TABLE IF EXISTS `branch_room`;
CREATE TABLE `branch_room`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) NOT NULL COMMENT '分支编号',
  `room_id` int(10) NOT NULL COMMENT '房间ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 136 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of branch_room
-- ----------------------------
INSERT INTO `branch_room` VALUES (94, 140, 13326);
INSERT INTO `branch_room` VALUES (95, 140, 13339);
INSERT INTO `branch_room` VALUES (96, 145, 13345);
INSERT INTO `branch_room` VALUES (97, 145, 13344);
INSERT INTO `branch_room` VALUES (98, 145, 13348);
INSERT INTO `branch_room` VALUES (99, 145, 13349);
INSERT INTO `branch_room` VALUES (101, 147, 13863);
INSERT INTO `branch_room` VALUES (102, 147, 13864);
INSERT INTO `branch_room` VALUES (103, 147, 13865);
INSERT INTO `branch_room` VALUES (104, 147, 13866);
INSERT INTO `branch_room` VALUES (105, 147, 13867);
INSERT INTO `branch_room` VALUES (106, 147, 13868);
INSERT INTO `branch_room` VALUES (107, 147, 13869);
INSERT INTO `branch_room` VALUES (108, 147, 13870);
INSERT INTO `branch_room` VALUES (109, 147, 13871);
INSERT INTO `branch_room` VALUES (110, 147, 13872);
INSERT INTO `branch_room` VALUES (111, 147, 13873);
INSERT INTO `branch_room` VALUES (112, 147, 13874);
INSERT INTO `branch_room` VALUES (113, 147, 13875);
INSERT INTO `branch_room` VALUES (114, 147, 13876);
INSERT INTO `branch_room` VALUES (115, 147, 13877);
INSERT INTO `branch_room` VALUES (116, 144, 13329);
INSERT INTO `branch_room` VALUES (117, 144, 13330);
INSERT INTO `branch_room` VALUES (118, 144, 13337);
INSERT INTO `branch_room` VALUES (119, 144, 13894);
INSERT INTO `branch_room` VALUES (120, 144, 13895);
INSERT INTO `branch_room` VALUES (121, 144, 13331);
INSERT INTO `branch_room` VALUES (122, 144, 13340);
INSERT INTO `branch_room` VALUES (123, 144, 13341);
INSERT INTO `branch_room` VALUES (124, 150, 13325);
INSERT INTO `branch_room` VALUES (125, 150, 13358);
INSERT INTO `branch_room` VALUES (126, 142, 13325);
INSERT INTO `branch_room` VALUES (127, 142, 13326);
INSERT INTO `branch_room` VALUES (128, 142, 13339);
INSERT INTO `branch_room` VALUES (129, 142, 13359);
INSERT INTO `branch_room` VALUES (130, 141, 13358);
INSERT INTO `branch_room` VALUES (131, 141, 13339);
INSERT INTO `branch_room` VALUES (132, 141, 13893);
INSERT INTO `branch_room` VALUES (133, 141, 13898);
INSERT INTO `branch_room` VALUES (134, 151, 14025);
INSERT INTO `branch_room` VALUES (135, 151, 14026);

-- ----------------------------
-- Table structure for branch_season_data
-- ----------------------------
DROP TABLE IF EXISTS `branch_season_data`;
CREATE TABLE `branch_season_data`  (
  `branch_id` int(10) NOT NULL COMMENT '分支id',
  `season` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采暖季名称',
  `date` date NOT NULL COMMENT '数据记录时间',
  `heat_day` int(10) NULL DEFAULT NULL COMMENT '已供暖天数',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '采暖季供暖面积(M2)',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '总用热量(kWh)',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '总循环水量(M3)',
  `avg_flow` double(6, 2) NULL DEFAULT NULL COMMENT '平均单位循环水量(M3/(M2*H))',
  `avg_energy` double(6, 2) NULL DEFAULT NULL COMMENT '平均单耗(W/(M2*H))',
  `time_heat` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算用热量',
  `time_flow` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算循环水量',
  `cur_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前热量读数,记录时的表具读数',
  `last_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次热量读数,上一次记录时的表具读数',
  `cur_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前流量读数，本次记录时的表具读数',
  `last_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次流量读数，上次记录时的表具读数',
  `cur_time` datetime(0) NULL DEFAULT NULL COMMENT '本次热量表数据时间',
  `last_time` datetime(0) NULL DEFAULT NULL COMMENT '上次热量表数据时间',
  `cur_meter` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '热量表地址',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`branch_id`, `date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for branch_season_data_last
-- ----------------------------
DROP TABLE IF EXISTS `branch_season_data_last`;
CREATE TABLE `branch_season_data_last`  (
  `branch_id` int(10) NOT NULL COMMENT '分支id',
  `season` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采暖季名称',
  `date` date NULL DEFAULT NULL COMMENT '数据记录时间',
  `heat_day` int(10) NULL DEFAULT NULL COMMENT '已供暖天数',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '采暖季供暖面积(M2)',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '总用热量(kWh)',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '总循环水量(M3)',
  `avg_flow` double(6, 2) NULL DEFAULT NULL COMMENT '平均单位循环水量(M3/(M2*H))',
  `avg_energy` double(6, 2) NULL DEFAULT NULL COMMENT '平均单耗(W/(M2*H))',
  `time_heat` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算用热量',
  `time_flow` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算循环水量',
  `cur_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前热量读数,记录时的表具读数',
  `last_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次热量读数,上一次记录时的表具读数',
  `cur_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前流量读数，本次记录时的表具读数',
  `last_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次流量读数，上次记录时的表具读数',
  `cur_time` datetime(0) NULL DEFAULT NULL COMMENT '本次热量表数据时间',
  `last_time` datetime(0) NULL DEFAULT NULL COMMENT '上次热量表数据时间',
  `cur_meter` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '热量表地址',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`branch_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for branch_valve
-- ----------------------------
DROP TABLE IF EXISTS `branch_valve`;
CREATE TABLE `branch_valve`  (
  `branch_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分支编号',
  `valve_addr` char(14) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '表具地址',
  `valve_name` varchar(45) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL COMMENT '表具名称',
  `valve_note` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL COMMENT '表具信息备注',
  `stopped` int(1) NULL DEFAULT NULL COMMENT '是否已停用[0:未停用;1:已停用;]',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '表具使用起始时间',
  `stop_time` datetime(0) NULL DEFAULT NULL COMMENT '表具使用截止时间',
  PRIMARY KEY (`branch_id`) USING BTREE,
  CONSTRAINT `valve_branch` FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = gbk COLLATE = gbk_chinese_ci COMMENT = '大表详细信息，包括表号、厂家及通信协议等' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for branchs
-- ----------------------------
DROP TABLE IF EXISTS `branchs`;
CREATE TABLE `branchs`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分支编号',
  `zone_id` int(10) NULL DEFAULT NULL COMMENT '小区编号',
  `branch_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分支名称',
  `cal_mode` int(2) NULL DEFAULT NULL COMMENT '计算模式[0:分户累加;1:分支计算;2:自身表计]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of branchs
-- ----------------------------
INSERT INTO `branchs` VALUES (140, 45, '分支1', 1);
INSERT INTO `branchs` VALUES (141, 45, '分支2', 1);
INSERT INTO `branchs` VALUES (142, 45, '分支3', 2);
INSERT INTO `branchs` VALUES (144, 46, '分支22', 1);
INSERT INTO `branchs` VALUES (145, 48, '分支23', 2);
INSERT INTO `branchs` VALUES (146, 51, '分支4', 0);
INSERT INTO `branchs` VALUES (148, 54, '1号楼低区', 0);
INSERT INTO `branchs` VALUES (149, 55, '分支11', 0);
INSERT INTO `branchs` VALUES (150, 45, '1', 0);
INSERT INTO `branchs` VALUES (151, 61, '分支12', 1);
INSERT INTO `branchs` VALUES (152, 45, '分支22', 0);

-- ----------------------------
-- Table structure for build_branch
-- ----------------------------
DROP TABLE IF EXISTS `build_branch`;
CREATE TABLE `build_branch`  (
  `build_id` int(10) NOT NULL,
  `branch_id` int(11) UNSIGNED NOT NULL,
  `plus_minus` int(2) NOT NULL COMMENT '0:加;1:减',
  PRIMARY KEY (`build_id`, `branch_id`) USING BTREE,
  INDEX `meter_index`(`branch_id`) USING BTREE,
  CONSTRAINT `build_branch_ibfk_1` FOREIGN KEY (`build_id`) REFERENCES `builds` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `build_branch_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of build_branch
-- ----------------------------
INSERT INTO `build_branch` VALUES (224, 140, 1);
INSERT INTO `build_branch` VALUES (256, 151, 0);

-- ----------------------------
-- Table structure for build_cal
-- ----------------------------
DROP TABLE IF EXISTS `build_cal`;
CREATE TABLE `build_cal`  (
  `build_id` int(10) NOT NULL COMMENT '楼栋编号',
  `cal_mode` int(3) NULL DEFAULT NULL COMMENT '计算模式[0:分户累加;1:分支计算;2:自身表计]',
  PRIMARY KEY (`build_id`) USING BTREE,
  CONSTRAINT `cal_build` FOREIGN KEY (`build_id`) REFERENCES `builds` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for build_day_data
-- ----------------------------
DROP TABLE IF EXISTS `build_day_data`;
CREATE TABLE `build_day_data`  (
  `build_id` int(10) NOT NULL COMMENT '楼宇编号,对应builds内的id',
  `date` date NOT NULL COMMENT '数据日期',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '供暖面积',
  `day_heat` double(10, 2) NULL DEFAULT NULL COMMENT '用热量',
  `day_flow` double(10, 2) NULL DEFAULT NULL COMMENT '用水量',
  `avg_energy` double(6, 2) NULL DEFAULT NULL COMMENT '平均单耗',
  `avg_flow` double(6, 2) NULL DEFAULT NULL COMMENT '日单位水量',
  `avg_outdoor_temp` double(6, 2) NULL DEFAULT NULL COMMENT '日平均室外温度',
  `avg_in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均供水温度',
  `avg_out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均回水温度',
  `avg_room_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均室内温度',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`build_id`, `date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for build_heat_info
-- ----------------------------
DROP TABLE IF EXISTS `build_heat_info`;
CREATE TABLE `build_heat_info`  (
  `build_id` int(10) NOT NULL COMMENT '楼栋编号',
  `total_count` int(10) NULL DEFAULT NULL COMMENT '总户数',
  `total_room_area` double(10, 2) NULL DEFAULT NULL COMMENT '总建筑面积',
  `total_heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '总供暖面积',
  `heat_count` int(10) NULL DEFAULT NULL COMMENT '供暖户数',
  `real_heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '实际供暖面积',
  PRIMARY KEY (`build_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of build_heat_info
-- ----------------------------
INSERT INTO `build_heat_info` VALUES (223, 5, 642.22, 444.00, 2, 222.00);
INSERT INTO `build_heat_info` VALUES (224, 2, 232.00, 210.00, 1, 111.00);
INSERT INTO `build_heat_info` VALUES (225, 3, 396.22, 237.00, 2, 211.00);
INSERT INTO `build_heat_info` VALUES (226, 1, 132.00, 111.00, 1, 111.00);
INSERT INTO `build_heat_info` VALUES (227, 8, 1007.00, 694.00, 8, 694.00);
INSERT INTO `build_heat_info` VALUES (228, 2, 273.00, 137.00, 2, 137.00);
INSERT INTO `build_heat_info` VALUES (229, 3, 369.44, 333.00, 1, 111.00);
INSERT INTO `build_heat_info` VALUES (232, 2, 273.00, 27.00, 2, 27.00);
INSERT INTO `build_heat_info` VALUES (233, 3, 385.22, 248.00, 2, 137.00);
INSERT INTO `build_heat_info` VALUES (234, 2, 264.22, 137.00, 1, 26.00);
INSERT INTO `build_heat_info` VALUES (236, 3, 420.36, 343.12, 3, 343.12);
INSERT INTO `build_heat_info` VALUES (240, 4, 528.22, 274.00, 3, 163.00);
INSERT INTO `build_heat_info` VALUES (242, 1, 120.00, 103.20, 0, 0.00);
INSERT INTO `build_heat_info` VALUES (243, 30, 3698.36, 3389.00, 10, 1130.00);
INSERT INTO `build_heat_info` VALUES (244, 2, 264.00, 222.00, 1, 111.00);
INSERT INTO `build_heat_info` VALUES (245, 1, 1.00, 1.00, 1, 1.00);
INSERT INTO `build_heat_info` VALUES (246, 4, 528.22, 274.00, 3, 163.00);
INSERT INTO `build_heat_info` VALUES (256, 2, 345.22, 333.00, 1, 222.00);

-- ----------------------------
-- Table structure for build_season_data
-- ----------------------------
DROP TABLE IF EXISTS `build_season_data`;
CREATE TABLE `build_season_data`  (
  `build_id` int(10) NOT NULL COMMENT '楼宇id',
  `season` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采暖季id',
  `date` date NOT NULL COMMENT '数据记录时间',
  `heat_day` int(10) NULL DEFAULT NULL COMMENT '已供暖天数',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '采暖季供暖面积(M2)',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '用热量(kWh)',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '循环水量(M3)',
  `avg_flow` double(10, 2) NULL DEFAULT NULL COMMENT '单位循环水量(M3/(M2*H))',
  `avg_energy` double(10, 2) NULL DEFAULT NULL COMMENT '平均单耗(W/(M2*H))',
  `time_heat` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算用热量',
  `time_flow` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算循环水量',
  `cur_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前热量读数,记录时的表具读数',
  `last_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次热量读数,上一次记录时的表具读数',
  `cur_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前流量读数，本次记录时的表具读数',
  `last_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次流量读数，上次记录时的表具读数',
  `cur_time` datetime(0) NULL DEFAULT NULL COMMENT '本次热量表数据时间',
  `last_time` datetime(0) NULL DEFAULT NULL COMMENT '上次热量表数据时间',
  `cur_meter` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '热量表地址',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`build_id`, `date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for build_season_data_last
-- ----------------------------
DROP TABLE IF EXISTS `build_season_data_last`;
CREATE TABLE `build_season_data_last`  (
  `build_id` int(10) NOT NULL COMMENT '楼宇id',
  `season` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采暖季id',
  `date` date NOT NULL COMMENT '数据记录时间',
  `heat_day` int(10) NULL DEFAULT NULL COMMENT '已供暖天数',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '采暖季供暖面积(M2)',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '用热量(kWh)',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '循环水量(M3)',
  `avg_flow` double(10, 2) NULL DEFAULT NULL COMMENT '单位循环水量(M3/(M2*H))',
  `avg_energy` double(10, 2) NULL DEFAULT NULL COMMENT '平均单耗(W/(M2*H))',
  `time_heat` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算用热量',
  `time_flow` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算循环水量',
  `cur_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前热量读数,记录时的表具读数',
  `last_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次热量读数,上一次记录时的表具读数',
  `cur_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前流量读数，本次记录时的表具读数',
  `last_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次流量读数，上次记录时的表具读数',
  `cur_time` datetime(0) NULL DEFAULT NULL COMMENT '本次热量表数据时间',
  `last_time` datetime(0) NULL DEFAULT NULL COMMENT '上次热量表数据时间',
  `cur_meter` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '热量表地址',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`build_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for builds
-- ----------------------------
DROP TABLE IF EXISTS `builds`;
CREATE TABLE `builds`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `build_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '楼宇名称',
  `build_num` int(4) NULL DEFAULT 0 COMMENT '楼宇号',
  `zone_id` int(10) NOT NULL COMMENT '小区ID',
  `cal_mode` int(3) NULL DEFAULT NULL COMMENT '计算模式[0:分户累加;1:分支计算;2:自身表计]',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `zone_id`(`zone_id`, `build_name`) USING BTREE,
  CONSTRAINT `builds_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 258 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of builds
-- ----------------------------
INSERT INTO `builds` VALUES (224, '2号楼', 2, 45, 1);
INSERT INTO `builds` VALUES (225, '3号楼', 3, 45, 1);
INSERT INTO `builds` VALUES (227, '1号楼', 1, 46, 0);
INSERT INTO `builds` VALUES (228, '4号楼', 4, 46, 1);
INSERT INTO `builds` VALUES (229, '1号楼', 1, 47, 0);
INSERT INTO `builds` VALUES (230, '4号楼', 4, 47, NULL);
INSERT INTO `builds` VALUES (231, '2号楼', 2, 47, NULL);
INSERT INTO `builds` VALUES (232, '2号楼', 2, 46, 0);
INSERT INTO `builds` VALUES (233, '3号楼', 3, 46, NULL);
INSERT INTO `builds` VALUES (234, '3号楼', 3, 47, NULL);
INSERT INTO `builds` VALUES (235, '3号楼', 3, 48, NULL);
INSERT INTO `builds` VALUES (236, '1号楼', 1, 48, NULL);
INSERT INTO `builds` VALUES (237, '2号楼', 2, 48, NULL);
INSERT INTO `builds` VALUES (238, '3号楼', 3, 49, NULL);
INSERT INTO `builds` VALUES (239, '1号楼', 1, 50, NULL);
INSERT INTO `builds` VALUES (240, '1号楼', 1, 51, NULL);
INSERT INTO `builds` VALUES (242, '2号楼', 2, 54, 1);
INSERT INTO `builds` VALUES (243, 'A区1号楼', 1, 54, 0);
INSERT INTO `builds` VALUES (244, '1号楼', 1, 45, 0);
INSERT INTO `builds` VALUES (246, '1号楼', 1, 55, NULL);
INSERT INTO `builds` VALUES (247, '4号楼', 4, 45, NULL);
INSERT INTO `builds` VALUES (248, '5号楼', 5, 45, NULL);
INSERT INTO `builds` VALUES (249, '6号楼', 6, 45, NULL);
INSERT INTO `builds` VALUES (250, '7号楼', 7, 45, NULL);
INSERT INTO `builds` VALUES (251, '8号楼', 8, 45, NULL);
INSERT INTO `builds` VALUES (252, '9号楼', 9, 45, NULL);
INSERT INTO `builds` VALUES (253, '10号楼', 10, 45, NULL);
INSERT INTO `builds` VALUES (254, '11号楼', 11, 45, NULL);
INSERT INTO `builds` VALUES (255, '12号楼', 12, 45, NULL);
INSERT INTO `builds` VALUES (256, '1号楼', 1, 61, 0);
INSERT INTO `builds` VALUES (257, '0号楼', 0, 45, NULL);

-- ----------------------------
-- Table structure for charge_type
-- ----------------------------
DROP TABLE IF EXISTS `charge_type`;
CREATE TABLE `charge_type`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收费方式名称',
  `code` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收费方式编码',
  `available` int(1) NULL DEFAULT 0 COMMENT '是否有效：0：有效 1：无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of charge_type
-- ----------------------------
INSERT INTO `charge_type` VALUES (4, '刷卡', '1', 0);
INSERT INTO `charge_type` VALUES (5, '现金', '2', 0);
INSERT INTO `charge_type` VALUES (6, '支付宝', '3', 0);

-- ----------------------------
-- Table structure for city_weather
-- ----------------------------
DROP TABLE IF EXISTS `city_weather`;
CREATE TABLE `city_weather`  (
  `city_code` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '城市编码',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `temperature` double(4, 1) NULL DEFAULT NULL COMMENT '温度',
  `humidity` int(3) UNSIGNED NULL DEFAULT NULL COMMENT '湿度',
  `wind_dirc` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '风向',
  `wind_force` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '风力',
  `weather` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '天气类型',
  PRIMARY KEY (`city_code`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for custom_type
-- ----------------------------
DROP TABLE IF EXISTS `custom_type`;
CREATE TABLE `custom_type`  (
  `id` int(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号，主键，自动递增',
  `type_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户类型名称',
  `type_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户类型编码',
  `available` int(1) NULL DEFAULT 0 COMMENT '记录是否有效：0：有效 1：无效',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type_name`(`type_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of custom_type
-- ----------------------------
INSERT INTO `custom_type` VALUES (25, '住户1', '1', 0);
INSERT INTO `custom_type` VALUES (26, '住户2', '2', 0);
INSERT INTO `custom_type` VALUES (27, '民用', '03', 0);
INSERT INTO `custom_type` VALUES (28, '商用', '04', 0);

-- ----------------------------
-- Table structure for device
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device`  (
  `device_net` int(10) NOT NULL COMMENT '设备网络号',
  `device_type` tinyint(2) NULL DEFAULT NULL COMMENT '设备类型[0:网络基站，1：集抄器]',
  `device_id` int(10) NULL DEFAULT NULL COMMENT '设备网络内部编号',
  `device_code` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL COMMENT '备设编码',
  `device_ip` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL COMMENT '设备网络地址',
  `device_port` int(6) NULL DEFAULT NULL COMMENT '设备网络连接端口号',
  `period` int(10) NULL DEFAULT NULL COMMENT '数据传输周期',
  `heart_time` timestamp(0) NULL DEFAULT NULL COMMENT '网络最后一次握手时间',
  `share_period` int(10) NULL DEFAULT NULL COMMENT '分摊周期',
  `firmware` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL COMMENT '固件名称',
  `major_version` int(3) NULL DEFAULT NULL COMMENT '主版本号',
  `minor_version` int(3) NULL DEFAULT NULL COMMENT '次版本号',
  `revision` int(3) NULL DEFAULT NULL COMMENT '修订版本号',
  `period_type` int(3) NULL DEFAULT NULL COMMENT '周期模式',
  `location` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL COMMENT '安装位置',
  `reconfiguration` int(2) NULL DEFAULT 0 COMMENT '是否重新配置集抄器',
  PRIMARY KEY (`device_net`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES (1, 0, NULL, NULL, NULL, NULL, NULL, '2018-08-09 11:14:13', NULL, NULL, NULL, NULL, NULL, NULL, '1', 0);
INSERT INTO `device` VALUES (2, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2', 0);
INSERT INTO `device` VALUES (10025, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1号楼3楼', 0);

-- ----------------------------
-- Table structure for functions
-- ----------------------------
DROP TABLE IF EXISTS `functions`;
CREATE TABLE `functions`  (
  `id` int(4) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号，主键，自动递增',
  `function_code` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '功能编码',
  `function_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '功能名称',
  `module_id` int(3) UNSIGNED NOT NULL COMMENT '模块编号',
  `sequence` int(2) NULL DEFAULT 1 COMMENT '侧边栏显示顺序',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `function_module`(`module_id`) USING BTREE,
  CONSTRAINT `function_module` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of functions
-- ----------------------------
INSERT INTO `functions` VALUES (1, 'sysIndex', '组织架构管理', 1, 1);
INSERT INTO `functions` VALUES (2, 'heatSeason', '采暖季管理', 1, 3);
INSERT INTO `functions` VALUES (3, 'heatType', '采暖类型管理', 1, 4);
INSERT INTO `functions` VALUES (4, 'customType', '住户类型管理', 1, 5);
INSERT INTO `functions` VALUES (5, 'valveModel', '阀门型号管理', 1, 6);
INSERT INTO `functions` VALUES (6, 'roomLocation', '房屋位置管理', 1, 7);
INSERT INTO `functions` VALUES (7, 'chargeType', '收费方式管理', 1, 8);
INSERT INTO `functions` VALUES (8, 'roleSet', '角色设置', 2, 1);
INSERT INTO `functions` VALUES (9, 'userSet', '用户管理', 2, 2);
INSERT INTO `functions` VALUES (15, 'device', '基站管理', 1, 2);

-- ----------------------------
-- Table structure for gis_view
-- ----------------------------
DROP TABLE IF EXISTS `gis_view`;
CREATE TABLE `gis_view`  (
  `hsp_name` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `hsp_id` int(10) NULL DEFAULT NULL,
  `hes_name` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `hes_id` int(10) NULL DEFAULT NULL,
  `z_id` int(10) NULL DEFAULT NULL,
  `z_name` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  `b_id` int(10) NOT NULL,
  `b_num` tinyint(4) NULL DEFAULT NULL,
  `b_name` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL,
  PRIMARY KEY (`b_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for heat_area
-- ----------------------------
DROP TABLE IF EXISTS `heat_area`;
CREATE TABLE `heat_area`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT '' COMMENT '换热站名称',
  `code` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT '0' COMMENT '换热站编码',
  `branch_company_id` int(10) NULL DEFAULT NULL COMMENT '隶属热源厂ID',
  `initial_heat` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'CURRENT_TIMESTAMP' COMMENT '起始供暖时间',
  `end_heat` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'CURRENT_TIMESTAMP' COMMENT '截至供暖时间',
  `available` int(1) NULL DEFAULT 0 COMMENT '是否有效 0:有效,1:无效',
  `address` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '换热站地址',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `heat_s_plant_id`(`branch_company_id`) USING BTREE,
  CONSTRAINT `heat_area_ibfk_2` FOREIGN KEY (`branch_company_id`) REFERENCES `branch_company` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of heat_area
-- ----------------------------
INSERT INTO `heat_area` VALUES (25, '区域11', '0', 1, '08-02', '09-08', 0, '');
INSERT INTO `heat_area` VALUES (26, '区域21', '0', 28, 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', 0, NULL);
INSERT INTO `heat_area` VALUES (27, '区域12', '0', 1, 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', 0, NULL);
INSERT INTO `heat_area` VALUES (28, '区域31', '0', 29, 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', 0, NULL);
INSERT INTO `heat_area` VALUES (29, '测试区域', '0', 30, 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', 0, '');
INSERT INTO `heat_area` VALUES (30, '2444', '0', 1, 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', 0, NULL);
INSERT INTO `heat_area` VALUES (31, 'q1', '0', 28, 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', 0, NULL);
INSERT INTO `heat_area` VALUES (32, '区域66', '0', 33, 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', 0, NULL);
INSERT INTO `heat_area` VALUES (33, '区域44', '0', 34, 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', 0, NULL);
INSERT INTO `heat_area` VALUES (34, '区域1', '0', 36, 'CURRENT_TIMESTAMP', 'CURRENT_TIMESTAMP', 0, NULL);

-- ----------------------------
-- Table structure for heat_company_info
-- ----------------------------
DROP TABLE IF EXISTS `heat_company_info`;
CREATE TABLE `heat_company_info`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` char(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT '' COMMENT '热电公司名称',
  `pic_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of heat_company_info
-- ----------------------------
INSERT INTO `heat_company_info` VALUES (1, '公司1', NULL);

-- ----------------------------
-- Table structure for heat_season
-- ----------------------------
DROP TABLE IF EXISTS `heat_season`;
CREATE TABLE `heat_season`  (
  `season_id` int(10) NOT NULL AUTO_INCREMENT COMMENT '采暖季编号',
  `season_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '采暖季名称',
  `start_date` date NULL DEFAULT NULL COMMENT '采暖季开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '采暖季结束日期',
  PRIMARY KEY (`season_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of heat_season
-- ----------------------------
INSERT INTO `heat_season` VALUES (19, '2017-2018', '2017-11-11', '2019-02-23');

-- ----------------------------
-- Table structure for heat_type
-- ----------------------------
DROP TABLE IF EXISTS `heat_type`;
CREATE TABLE `heat_type`  (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '取暖类型名称',
  `type_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '取暖类型编码',
  `available` int(1) NULL DEFAULT 0 COMMENT '记录是否有效：0：有效 1：无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of heat_type
-- ----------------------------
INSERT INTO `heat_type` VALUES (13, '地暖', '1', 0);
INSERT INTO `heat_type` VALUES (14, '片暖', '2', 1);

-- ----------------------------
-- Table structure for is_show
-- ----------------------------
DROP TABLE IF EXISTS `is_show`;
CREATE TABLE `is_show`  (
  `zone_id` int(10) NOT NULL COMMENT '小区id',
  `cu_heat` int(1) NULL DEFAULT 1 COMMENT '累积热量',
  `cu_flow` int(1) NULL DEFAULT 1 COMMENT '累积流量',
  `heat_power` int(1) NULL DEFAULT 1 COMMENT '热功率',
  `instant_flow` int(1) NULL DEFAULT 1 COMMENT '瞬时流速',
  `in_temp` int(1) NULL DEFAULT 1 COMMENT '进水温度',
  `out_temp` int(1) NULL DEFAULT 1 COMMENT '回水温度',
  `set_temp` int(1) NULL DEFAULT 1 COMMENT '设置温度',
  `room_temp` int(1) NULL DEFAULT 1 COMMENT '室内温度',
  `valve_status` int(1) NULL DEFAULT 1 COMMENT '阀门状态',
  `scale` int(1) NULL DEFAULT 1 COMMENT '开度',
  `err_list` int(1) NULL DEFAULT 1 COMMENT '故障列表',
  `data_time` int(1) NULL DEFAULT 1 COMMENT '数据时间',
  PRIMARY KEY (`zone_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for mano_data_hist
-- ----------------------------
DROP TABLE IF EXISTS `mano_data_hist`;
CREATE TABLE `mano_data_hist`  (
  `mano_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '压力表地址',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `pressure` double(5, 3) NULL DEFAULT NULL COMMENT '压强',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障列表',
  PRIMARY KEY (`mano_addr`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for mano_data_last
-- ----------------------------
DROP TABLE IF EXISTS `mano_data_last`;
CREATE TABLE `mano_data_last`  (
  `mano_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '压力表地址',
  `data_time` datetime(0) NULL DEFAULT NULL COMMENT '数据时间',
  `pressure` double(5, 3) NULL DEFAULT NULL COMMENT '压强',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障列表',
  PRIMARY KEY (`mano_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for meter_data_hist
-- ----------------------------
DROP TABLE IF EXISTS `meter_data_hist`;
CREATE TABLE `meter_data_hist`  (
  `meter_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表具地址',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `cu_heat` double(14, 2) NULL DEFAULT NULL COMMENT '累计热量',
  `cu_cool` double(14, 2) NULL DEFAULT NULL COMMENT '累计冷量',
  `heat_power` double(8, 2) NULL DEFAULT NULL COMMENT '热功率',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '累计流量',
  `flow_rate` double(8, 2) NULL DEFAULT NULL COMMENT '瞬时流速',
  `in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '进水温度',
  `out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '回水温度',
  `diff_temp` double(6, 2) NULL DEFAULT NULL COMMENT '温差',
  `battery_status` int(11) NULL DEFAULT NULL COMMENT '电池状态[0:正常;1:欠压;]',
  `hours` int(10) NULL DEFAULT NULL COMMENT '工作时间',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '错误列表，以‘|’为分隔符',
  PRIMARY KEY (`meter_addr`, `data_time`) USING BTREE,
  INDEX `meter_data_last_index`(`meter_addr`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for meter_data_last
-- ----------------------------
DROP TABLE IF EXISTS `meter_data_last`;
CREATE TABLE `meter_data_last`  (
  `meter_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表具地址',
  `data_time` datetime(0) NULL DEFAULT NULL COMMENT '数据时间',
  `cu_heat` double(14, 2) NULL DEFAULT NULL COMMENT '累计热量',
  `cu_cool` double(14, 2) NULL DEFAULT NULL COMMENT '累计冷量',
  `heat_power` double(8, 2) NULL DEFAULT NULL COMMENT '热功率',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '累计流量',
  `flow_rate` double(8, 2) NULL DEFAULT NULL COMMENT '瞬时流速',
  `in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '进水温度',
  `out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '回水温度',
  `diff_temp` double(6, 2) NULL DEFAULT NULL COMMENT '温差',
  `battery_status` int(11) NULL DEFAULT NULL COMMENT '电池状态[0:正常;1:欠压;]',
  `hours` int(10) NULL DEFAULT NULL COMMENT '工作时间',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '错误列表，以‘|’为分隔符',
  PRIMARY KEY (`meter_addr`) USING BTREE,
  INDEX `meter_data_last_index`(`meter_addr`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of meter_data_last
-- ----------------------------
INSERT INTO `meter_data_last` VALUES ('1111', '2018-08-21 20:17:37', 22.00, 22.00, 22.00, 22.00, 22.00, 22.00, 22.00, 22.00, NULL, NULL, NULL);
INSERT INTO `meter_data_last` VALUES ('11121523645210', '2018-08-24 10:31:40', 123.32, NULL, 5.10, 1253.21, NULL, NULL, NULL, NULL, 1, NULL, NULL);
INSERT INTO `meter_data_last` VALUES ('12032545211111', '2018-08-24 10:30:49', 1232.02, NULL, 5.20, 1253.25, 0.62, 45.00, 25.00, 20.00, 0, NULL, NULL);

-- ----------------------------
-- Table structure for meters
-- ----------------------------
DROP TABLE IF EXISTS `meters`;
CREATE TABLE `meters`  (
  `meter_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '热量表地址',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '阀门网络号',
  `coll_num` int(6) NULL DEFAULT NULL COMMENT '阀门集抄器号',
  `prot_num` int(5) NULL DEFAULT NULL COMMENT '阀门协议号',
  `signal_status` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信号状态',
  `path_status` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传路径状态',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '状态更新时间',
  PRIMARY KEY (`meter_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for modules
-- ----------------------------
DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules`  (
  `id` int(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号，主键，自动递增',
  `module_code` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块编码',
  `module_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '模块名称',
  `sequence` int(2) NOT NULL DEFAULT 1 COMMENT '侧边栏显示顺序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of modules
-- ----------------------------
INSERT INTO `modules` VALUES (1, 'basic', '基础信息模块', 1);
INSERT INTO `modules` VALUES (2, 'permiss', '权限设置模块', 2);

-- ----------------------------
-- Table structure for outtemp_ctrl
-- ----------------------------
DROP TABLE IF EXISTS `outtemp_ctrl`;
CREATE TABLE `outtemp_ctrl`  (
  `valve_addr` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阀门地址',
  `ctrl_time` datetime(0) NULL DEFAULT NULL COMMENT '控制时间',
  `net_num` int(6) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(5) NULL DEFAULT NULL COMMENT '集抄器号',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '阀门协议',
  `set_outtemp` double(4, 1) NULL DEFAULT NULL COMMENT '设定回水温度',
  `temp_limit` double(4, 1) NULL DEFAULT NULL COMMENT '回水温度允许误差',
  `ctrl_is_over` int(2) NULL DEFAULT NULL COMMENT '是否处理结束 0：未结束；1：结束',
  `ctrl_exec_time` datetime(0) NULL DEFAULT NULL COMMENT '控制执行时间',
  `ctrl_exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`valve_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for outtemp_ctrl_hist
-- ----------------------------
DROP TABLE IF EXISTS `outtemp_ctrl_hist`;
CREATE TABLE `outtemp_ctrl_hist`  (
  `control_id` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '控制编号',
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阀门地址',
  `ctrl_time` datetime(0) NOT NULL COMMENT '控制时间',
  `net_num` int(6) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(5) NULL DEFAULT NULL COMMENT '集抄器号',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '阀门协议',
  `set_outtemp` double(4, 1) NULL DEFAULT NULL COMMENT '设定回水温度',
  `temp_limit` double(4, 1) NULL DEFAULT NULL COMMENT '回水温度允许误差',
  `ctrl_is_over` int(2) NULL DEFAULT NULL COMMENT '是否处理结束 0：未结束；1：结束',
  `ctrl_exec_time` datetime(0) NULL DEFAULT NULL COMMENT '控制执行时间',
  `ctrl_exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`control_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for outtemp_mode
-- ----------------------------
DROP TABLE IF EXISTS `outtemp_mode`;
CREATE TABLE `outtemp_mode`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `temp_mode` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `available` int(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for outtemp_mode_index
-- ----------------------------
DROP TABLE IF EXISTS `outtemp_mode_index`;
CREATE TABLE `outtemp_mode_index`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `temp_mode_id` int(10) NULL DEFAULT NULL COMMENT '回水温度曲线编号',
  `outdoor_temp` double(4, 1) NULL DEFAULT NULL COMMENT '户外温度',
  `set_out_temp` double(4, 1) NULL DEFAULT NULL COMMENT '设定回水温度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for period_mode
-- ----------------------------
DROP TABLE IF EXISTS `period_mode`;
CREATE TABLE `period_mode`  (
  `id` int(3) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `per1` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期1',
  `per2` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期2',
  `per3` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期3',
  `per4` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期4',
  `per5` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期5',
  `per6` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期6',
  `per7` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期7',
  `per8` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期8',
  `per9` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期9',
  `per10` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期10',
  `per11` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期11',
  `per12` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期12',
  `per13` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期13',
  `per14` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据上传周期14',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for pressure_ctrl
-- ----------------------------
DROP TABLE IF EXISTS `pressure_ctrl`;
CREATE TABLE `pressure_ctrl`  (
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阀门地址',
  `ctrl_time` datetime(0) NULL DEFAULT NULL COMMENT '控制时间',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(5) NULL DEFAULT NULL COMMENT '阀门集抄器编号',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '协议编码',
  `pressure_diff` int(4) NULL DEFAULT 0 COMMENT '设定压差，单位kPa',
  `pressure_limit` int(4) NULL DEFAULT 0 COMMENT '压差允许偏差范围，单位kPa',
  `ctrl_is_over` int(1) NULL DEFAULT 0 COMMENT '控制是否完成[0:未完成;1:完成]',
  `ctrl_exec_time` datetime(0) NULL DEFAULT NULL COMMENT '控制执行时间',
  `ctrl_exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '控制执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '控制更新时间',
  PRIMARY KEY (`valve_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for pressure_ctrl_hist
-- ----------------------------
DROP TABLE IF EXISTS `pressure_ctrl_hist`;
CREATE TABLE `pressure_ctrl_hist`  (
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阀门地址',
  `ctrl_time` datetime(0) NOT NULL COMMENT '控制时间',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(5) NULL DEFAULT NULL COMMENT '阀门集抄器编号',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '协议编码',
  `pressure_diff` int(4) NULL DEFAULT 0 COMMENT '设定压差，单位kPa',
  `pressure_limit` int(4) NULL DEFAULT 0 COMMENT '压差允许偏差范围，单位kPa',
  `ctrl_is_over` int(1) NULL DEFAULT 0 COMMENT '控制是否完成[0:未完成;1:完成]',
  `ctrl_exec_time` datetime(0) NULL DEFAULT NULL COMMENT '控制执行时间',
  `ctrl_exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '控制执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '控制更新时间',
  PRIMARY KEY (`valve_addr`, `ctrl_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for rate
-- ----------------------------
DROP TABLE IF EXISTS `rate`;
CREATE TABLE `rate`  (
  `id` int(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `rate_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '费率名称',
  `custom_type` tinyint(1) NOT NULL COMMENT '客户类型 ',
  `area_price` double(6, 2) NULL DEFAULT NULL COMMENT '面积收费单价，元/平米',
  `fix_area_price` tinyint(1) NULL DEFAULT NULL COMMENT '固定热费面积单价，元/平米',
  `heat_price` double(6, 2) NULL DEFAULT NULL COMMENT '热量单价 元/kWh',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for role_function
-- ----------------------------
DROP TABLE IF EXISTS `role_function`;
CREATE TABLE `role_function`  (
  `role_id` int(5) UNSIGNED NOT NULL COMMENT '角色编号',
  `function_id` int(4) UNSIGNED NOT NULL COMMENT '功能编号',
  `add_time` datetime(0) NULL DEFAULT NULL COMMENT '记录添加时间',
  PRIMARY KEY (`role_id`, `function_id`) USING BTREE,
  INDEX `funcction_key`(`function_id`) USING BTREE,
  CONSTRAINT `funcction_key` FOREIGN KEY (`function_id`) REFERENCES `functions` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `role_key` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_function
-- ----------------------------
INSERT INTO `role_function` VALUES (1, 1, '2018-10-10 13:20:59');
INSERT INTO `role_function` VALUES (1, 2, '2018-10-10 13:20:59');
INSERT INTO `role_function` VALUES (1, 3, '2018-10-10 13:20:59');
INSERT INTO `role_function` VALUES (1, 4, '2018-10-10 13:20:59');
INSERT INTO `role_function` VALUES (1, 6, '2018-10-10 13:20:59');
INSERT INTO `role_function` VALUES (1, 7, '2018-10-10 13:20:59');
INSERT INTO `role_function` VALUES (1, 8, '2018-10-10 13:20:59');
INSERT INTO `role_function` VALUES (1, 9, '2018-10-10 13:20:59');
INSERT INTO `role_function` VALUES (1, 15, '2018-10-10 13:20:59');
INSERT INTO `role_function` VALUES (2, 1, '2018-10-10 14:06:59');
INSERT INTO `role_function` VALUES (2, 2, '2018-10-10 14:06:59');
INSERT INTO `role_function` VALUES (2, 3, '2018-10-10 14:06:59');
INSERT INTO `role_function` VALUES (2, 4, '2018-10-10 14:06:59');
INSERT INTO `role_function` VALUES (2, 5, '2018-10-10 14:06:59');
INSERT INTO `role_function` VALUES (2, 6, '2018-10-10 14:06:59');
INSERT INTO `role_function` VALUES (2, 7, '2018-10-10 14:06:59');
INSERT INTO `role_function` VALUES (2, 8, '2018-10-10 14:06:59');
INSERT INTO `role_function` VALUES (2, 9, '2018-10-10 14:06:59');

-- ----------------------------
-- Table structure for role_service_role
-- ----------------------------
DROP TABLE IF EXISTS `role_service_role`;
CREATE TABLE `role_service_role`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_id` int(10) NULL DEFAULT NULL COMMENT '角色id   roles中id',
  `service_role_id` int(10) NULL DEFAULT NULL COMMENT '服务角色id   service_role中的id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of role_service_role
-- ----------------------------
INSERT INTO `role_service_role` VALUES (2, 1, 1);
INSERT INTO `role_service_role` VALUES (3, 1, 2);
INSERT INTO `role_service_role` VALUES (4, 2, 3);
INSERT INTO `role_service_role` VALUES (6, 1, 4);
INSERT INTO `role_service_role` VALUES (11, 1, 3);
INSERT INTO `role_service_role` VALUES (13, 3, 1);
INSERT INTO `role_service_role` VALUES (14, 3, 3);
INSERT INTO `role_service_role` VALUES (15, 6, 2);
INSERT INTO `role_service_role` VALUES (16, 8, 3);
INSERT INTO `role_service_role` VALUES (17, 2, 2);
INSERT INTO `role_service_role` VALUES (18, 2, 4);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号，主键，自动递增',
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名称',
  `role_code` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, '超级管理员1', '1');
INSERT INTO `roles` VALUES (2, '管理员', '2');

-- ----------------------------
-- Table structure for room_alarm_filter
-- ----------------------------
DROP TABLE IF EXISTS `room_alarm_filter`;
CREATE TABLE `room_alarm_filter`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号，自增',
  `room_id` int(10) NOT NULL COMMENT '房间编号',
  `alarm_code` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报警编码',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '过滤开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '过滤结束时间',
  `over` int(2) NULL DEFAULT 0 COMMENT '过滤是否已终止[0:过滤有效;1:过滤已终止]',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_alarms_record
-- ----------------------------
DROP TABLE IF EXISTS `room_alarms_record`;
CREATE TABLE `room_alarms_record`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `room_id` int(10) NULL DEFAULT NULL COMMENT '房间编号',
  `alarm_code` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报警编码',
  `season` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '采暖季名称',
  `device_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报警的表具地址',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '报警第一次发生时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '报警事件最后一次时间',
  `alarm_cnt` int(5) NULL DEFAULT NULL COMMENT '持续报警次数',
  `data_time` datetime(0) NULL DEFAULT NULL COMMENT '最后一次报警对应的数据时间',
  `alarm_message` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'alarm报警说明',
  `disposed` int(2) NULL DEFAULT 0 COMMENT '是否被处理[0:未处理;1:被处理]',
  `dispose_time` datetime(0) NULL DEFAULT NULL COMMENT '处理时间',
  `dispose_user` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障处理人员',
  `dispose_result` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障处理结果',
  `filtered` int(2) NULL DEFAULT 0 COMMENT '是否被屏蔽[0:未屏蔽;1:被屏蔽]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报警记录表格' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_data
-- ----------------------------
DROP TABLE IF EXISTS `room_data`;
CREATE TABLE `room_data`  (
  `room_id` int(10) NOT NULL COMMENT '房间编号，外键rooms->id',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '累计热量,-1失联',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '累计流量,-1失联',
  `power` double(8, 4) NULL DEFAULT NULL COMMENT '热功率,-1失联',
  `flow` double(8, 4) NULL DEFAULT NULL COMMENT '瞬时流量,-1失联',
  `in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '进水温度,-1失联',
  `out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '回水温度,-1失联',
  `set_temp` double(4, 2) NULL DEFAULT NULL COMMENT '设置温度,-1失联',
  `room_temp` double(4, 2) NULL DEFAULT NULL COMMENT '室内温度,-1失联',
  `valve_status` tinyint(2) NULL DEFAULT NULL COMMENT '阀门状态,-1失联；0：开；1：关；2：开度；3：异常',
  `scale` int(3) NULL DEFAULT NULL COMMENT '开度',
  `error_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障列表',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`room_id`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_data_last
-- ----------------------------
DROP TABLE IF EXISTS `room_data_last`;
CREATE TABLE `room_data_last`  (
  `room_id` int(10) NOT NULL COMMENT '房间编号，外键rooms->id',
  `data_time` datetime(0) NULL DEFAULT NULL COMMENT '数据时间',
  `meter_time` datetime(0) NULL DEFAULT NULL COMMENT '热量表数据时间',
  `valve_time` datetime(0) NULL DEFAULT NULL COMMENT '阀门数据时间',
  `temp_time` datetime(0) NULL DEFAULT NULL COMMENT '测温数据时间',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '累计热量,-1失联',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '累计流量,-1失联',
  `power` double(8, 4) NULL DEFAULT NULL COMMENT '热功率,-1失联',
  `flow` double(8, 4) NULL DEFAULT NULL COMMENT '瞬时流量,-1失联',
  `in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '进水温度,-1失联',
  `out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '回水温度,-1失联',
  `set_temp` double(4, 2) NULL DEFAULT NULL COMMENT '设置温度,-1失联',
  `room_temp` double(4, 2) NULL DEFAULT NULL COMMENT '室内温度,-1失联',
  `valve_status` tinyint(2) NULL DEFAULT NULL COMMENT '阀门状态,-1失联；0：开；1：关；2：开度；3：异常',
  `scale` int(3) NULL DEFAULT NULL COMMENT '开度',
  `error_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障列表',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_data_source
-- ----------------------------
DROP TABLE IF EXISTS `room_data_source`;
CREATE TABLE `room_data_source`  (
  `zone_id` int(10) NOT NULL COMMENT '小区编号，外键zones->id',
  `flow` int(8) NULL DEFAULT NULL COMMENT '瞬时流量,1：热量表；2：流量调节阀',
  `in_temp` int(6) NULL DEFAULT NULL COMMENT '进水温度,1：热量表；2：阀门',
  `out_temp` int(6) NULL DEFAULT NULL COMMENT '回水温度,1：热量表；2：阀门',
  `room_temp` int(4) NULL DEFAULT NULL COMMENT '室内温度,1：阀门；2：室温节点；3：阀门与室温节点平均值',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`zone_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_data_source
-- ----------------------------
INSERT INTO `room_data_source` VALUES (45, NULL, 1, 1, 1, '2018-09-30 08:45:34');
INSERT INTO `room_data_source` VALUES (46, NULL, 2, 2, 2, '2018-09-19 14:54:55');
INSERT INTO `room_data_source` VALUES (61, NULL, 1, 1, 1, '2018-10-08 16:36:35');

-- ----------------------------
-- Table structure for room_day_data
-- ----------------------------
DROP TABLE IF EXISTS `room_day_data`;
CREATE TABLE `room_day_data`  (
  `room_id` int(10) NOT NULL COMMENT '用户ID',
  `date` date NOT NULL COMMENT '添加时间',
  `day_heat` double(10, 2) NULL DEFAULT NULL COMMENT '热用量',
  `day_flow` double(10, 2) NULL DEFAULT NULL COMMENT '水用量',
  `avg_energy` double(6, 2) NULL DEFAULT NULL COMMENT '平均单耗（w/m2）',
  `avg_flow` double(6, 2) NULL DEFAULT NULL COMMENT '日单位水量',
  `avg_outdoor_temp` double(6, 2) NULL DEFAULT NULL COMMENT '日平均室外温度',
  `avg_in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均供水温度',
  `avg_out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均回水温度',
  `avg_room_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均室内温度',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`room_id`, `date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_heat_status
-- ----------------------------
DROP TABLE IF EXISTS `room_heat_status`;
CREATE TABLE `room_heat_status`  (
  `room_id` int(10) NOT NULL,
  `heat_season_id` int(5) NOT NULL,
  `heat_status` int(2) NULL DEFAULT NULL COMMENT '供暖状态[0:不供暖;1:供暖;]',
  PRIMARY KEY (`room_id`, `heat_season_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_location
-- ----------------------------
DROP TABLE IF EXISTS `room_location`;
CREATE TABLE `room_location`  (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `code` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间位置代码',
  `location` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间位置',
  `available` int(1) NULL DEFAULT 0 COMMENT '记录是否有效：0：有效 1：无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_location
-- ----------------------------
INSERT INTO `room_location` VALUES (14, '1', '底层', 0);
INSERT INTO `room_location` VALUES (15, '2', '中层', 0);
INSERT INTO `room_location` VALUES (16, '3', '高层', 0);
INSERT INTO `room_location` VALUES (17, '4', '测试1', 1);

-- ----------------------------
-- Table structure for room_meter_addr
-- ----------------------------
DROP TABLE IF EXISTS `room_meter_addr`;
CREATE TABLE `room_meter_addr`  (
  `room_id` int(10) NOT NULL,
  `meter_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stopped` int(1) NULL DEFAULT NULL COMMENT '是否已停用[0:未停用;1:已停用;]',
  `start_time` datetime(0) NULL DEFAULT NULL,
  `stop_time` datetime(0) NULL DEFAULT NULL,
  `meter_model` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '表具型号',
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_meter_addr
-- ----------------------------
INSERT INTO `room_meter_addr` VALUES (13325, '1111', NULL, NULL, NULL, 'S01');
INSERT INTO `room_meter_addr` VALUES (13358, '2', NULL, NULL, NULL, 'S02');
INSERT INTO `room_meter_addr` VALUES (13863, '12032545211111', NULL, NULL, NULL, 'S01');
INSERT INTO `room_meter_addr` VALUES (13864, '11121523645210', NULL, NULL, NULL, 'S02');
INSERT INTO `room_meter_addr` VALUES (13865, '11134523524524', NULL, NULL, NULL, 'S03');
INSERT INTO `room_meter_addr` VALUES (13866, '11141245253421', NULL, NULL, NULL, 'S04');
INSERT INTO `room_meter_addr` VALUES (13867, '11152454523454', NULL, NULL, NULL, 'S05');
INSERT INTO `room_meter_addr` VALUES (13868, '11161020305242', NULL, NULL, NULL, 'S06');
INSERT INTO `room_meter_addr` VALUES (13893, '1111', NULL, NULL, NULL, 'S01');

-- ----------------------------
-- Table structure for room_option_ctrl
-- ----------------------------
DROP TABLE IF EXISTS `room_option_ctrl`;
CREATE TABLE `room_option_ctrl`  (
  `room_id` int(10) NOT NULL,
  `ctrl_time` datetime(0) NULL DEFAULT NULL COMMENT '控制时间',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(3) NULL DEFAULT NULL COMMENT '阀门集抄器ID',
  `build_num` int(4) NULL DEFAULT NULL COMMENT '楼宇',
  `unit_num` int(6) NULL DEFAULT NULL COMMENT '单元',
  `room_num` int(4) NULL DEFAULT NULL COMMENT '房间',
  `heat_valve_addr` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阀门地址',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '阀门协议号',
  `ctrl_type` int(2) NULL DEFAULT NULL COMMENT '设置类型[13:温度设置;14:显示设置]',
  `temp_mode` int(2) NULL DEFAULT 1 COMMENT '调温模式[1、自由调节，2、固定温，3、高低温]',
  `max_temp` int(3) NULL DEFAULT NULL COMMENT '最大温度',
  `min_temp` int(3) NULL DEFAULT NULL COMMENT '最小温度',
  `fix_temp` int(3) NULL DEFAULT NULL COMMENT '固定温度',
  `display_mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示模式[8位0,1字符串]',
  `option_is_over` int(2) NULL DEFAULT NULL COMMENT '调温模式是否已设置[0、未设置，1：设置完成]',
  `exec_time` datetime(0) NULL DEFAULT NULL COMMENT '执行时间',
  `exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '数据记录更新时间',
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_option_ctrl_hist
-- ----------------------------
DROP TABLE IF EXISTS `room_option_ctrl_hist`;
CREATE TABLE `room_option_ctrl_hist`  (
  `room_id` int(10) NOT NULL,
  `ctrl_time` datetime(0) NOT NULL COMMENT '控制时间',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(3) NULL DEFAULT NULL COMMENT '阀门集抄器ID',
  `build_num` int(4) NULL DEFAULT NULL COMMENT '楼宇',
  `unit_num` int(6) NULL DEFAULT NULL COMMENT '单元',
  `room_num` int(4) NULL DEFAULT NULL COMMENT '房间',
  `heat_valve_addr` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阀门地址',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '阀门协议号',
  `ctrl_type` int(2) NULL DEFAULT NULL COMMENT '设置类型',
  `temp_mode` int(2) NULL DEFAULT 1 COMMENT '调温模式[1、自由调节，2、固定温，3、高低温]',
  `max_temp` int(3) NULL DEFAULT NULL COMMENT '最大温度',
  `min_temp` int(3) NULL DEFAULT NULL COMMENT '最小温度',
  `fix_temp` int(3) NULL DEFAULT NULL COMMENT '固定温度',
  `display_mode` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示模式[8位0,1字符串]',
  `option_is_over` int(2) NULL DEFAULT NULL COMMENT '调温模式是否已设置[0、未设置，1：设置完成]',
  `exec_time` datetime(0) NULL DEFAULT NULL COMMENT '执行时间',
  `exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '数据记录更新时间',
  PRIMARY KEY (`room_id`, `ctrl_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_season_data
-- ----------------------------
DROP TABLE IF EXISTS `room_season_data`;
CREATE TABLE `room_season_data`  (
  `room_id` int(10) NOT NULL COMMENT '楼宇id',
  `date` date NOT NULL COMMENT '数据记录时间',
  `season` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采暖季名称',
  `normal_day` int(10) NULL DEFAULT NULL COMMENT '达标天数',
  `heat_day` int(10) NULL DEFAULT NULL COMMENT '已供暖天数',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '采暖季供暖面积(M2)',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '用热量(kWh)',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '循环水量(M3)',
  `avg_flow` double(10, 2) NULL DEFAULT NULL COMMENT '单位循环水量(M3/(M2*H))',
  `avg_energy` double(10, 2) NULL DEFAULT NULL COMMENT '平均单耗(W/(M2*H))',
  `time_flow` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算循环水量',
  `time_heat` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算用热量',
  `cur_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前热量读数,记录时的表具读数',
  `last_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次热量读数,上一次记录时的表具读数',
  `cur_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前流量读数，本次记录时的表具读数',
  `last_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次流量读数，上次记录时的表具读数',
  `cur_time` datetime(0) NULL DEFAULT NULL COMMENT '本次热量表数据时间',
  `last_time` datetime(0) NULL DEFAULT NULL COMMENT '上次热量表数据时间',
  `cur_meter` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '热量表地址',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`room_id`, `date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_season_data_last
-- ----------------------------
DROP TABLE IF EXISTS `room_season_data_last`;
CREATE TABLE `room_season_data_last`  (
  `room_id` int(10) NOT NULL COMMENT '楼宇id',
  `season` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '采暖季名称',
  `normal_day` int(10) NULL DEFAULT NULL COMMENT '达标天数',
  `date` date NOT NULL COMMENT '数据记录时间',
  `heat_day` int(10) NULL DEFAULT NULL COMMENT '已供暖天数',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '采暖季供暖面积(M2)',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '用热量(kWh)',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '循环水量(M3)',
  `avg_flow` double(10, 2) NULL DEFAULT NULL COMMENT '单位循环水量(M3/(M2*H))',
  `avg_energy` double(10, 2) NULL DEFAULT NULL COMMENT '平均单耗(W/(M2*H))',
  `time_flow` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算循环水量',
  `time_heat` double(8, 2) NULL DEFAULT NULL COMMENT '本次结算用热量',
  `cur_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前热量读数,记录时的表具读数',
  `last_heat_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次热量读数,上一次记录时的表具读数',
  `cur_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '当前流量读数，本次记录时的表具读数',
  `last_flow_index` double(8, 2) NULL DEFAULT NULL COMMENT '上次流量读数，上次记录时的表具读数',
  `cur_time` datetime(0) NULL DEFAULT NULL COMMENT '本次热量表数据时间',
  `last_time` datetime(0) NULL DEFAULT NULL COMMENT '上次热量表数据时间',
  `cur_meter` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '热量表地址',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_temp_addr
-- ----------------------------
DROP TABLE IF EXISTS `room_temp_addr`;
CREATE TABLE `room_temp_addr`  (
  `room_id` int(10) NOT NULL,
  `index` int(3) NOT NULL,
  `temp_addr` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stopped` int(1) NULL DEFAULT NULL COMMENT '是否已停用[0:未停用;1:已停用;]',
  `start_time` datetime(0) NULL DEFAULT NULL,
  `stop_time` datetime(0) NULL DEFAULT NULL,
  `temp_model` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`, `index`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_temp_addr
-- ----------------------------
INSERT INTO `room_temp_addr` VALUES (13325, 2, '222', NULL, NULL, NULL, 'X02');
INSERT INTO `room_temp_addr` VALUES (13330, 1, '111', NULL, NULL, NULL, 'X01');
INSERT INTO `room_temp_addr` VALUES (13338, 2, '222', NULL, NULL, NULL, 'X02');
INSERT INTO `room_temp_addr` VALUES (13862, 1, '02202018215325', NULL, NULL, NULL, 'X02');
INSERT INTO `room_temp_addr` VALUES (13863, 1, '02202018265232', NULL, NULL, NULL, 'X01');
INSERT INTO `room_temp_addr` VALUES (13864, 1, '02202018526365', NULL, NULL, NULL, 'X03');
INSERT INTO `room_temp_addr` VALUES (13865, 1, '02202018526325', NULL, NULL, NULL, 'X04');
INSERT INTO `room_temp_addr` VALUES (13893, 1, '111', NULL, NULL, NULL, 'X01');

-- ----------------------------
-- Table structure for room_thermostat_addr
-- ----------------------------
DROP TABLE IF EXISTS `room_thermostat_addr`;
CREATE TABLE `room_thermostat_addr`  (
  `room_id` int(10) NOT NULL,
  `node_addr` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '温控面板地址',
  `stopped` int(1) NULL DEFAULT NULL COMMENT '是否已停用[0:未停用;1:已停用;]',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '启用时间',
  `stop_time` datetime(0) NULL DEFAULT NULL COMMENT '停用时间',
  `thermostat_model` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`) USING BTREE,
  CONSTRAINT `room_thermostat_addr_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_thermostat_addr
-- ----------------------------
INSERT INTO `room_thermostat_addr` VALUES (13330, '111', NULL, NULL, NULL, 'M1');
INSERT INTO `room_thermostat_addr` VALUES (13338, '222', NULL, NULL, NULL, 'M2');
INSERT INTO `room_thermostat_addr` VALUES (13862, '10201825632125', NULL, NULL, NULL, 'M4');
INSERT INTO `room_thermostat_addr` VALUES (13863, '10201832123251', NULL, NULL, NULL, 'M1');
INSERT INTO `room_thermostat_addr` VALUES (13864, '10201878523695', NULL, NULL, NULL, 'M2');
INSERT INTO `room_thermostat_addr` VALUES (13865, '10201812365425', NULL, NULL, NULL, 'M3');
INSERT INTO `room_thermostat_addr` VALUES (13893, '111', NULL, NULL, NULL, 'M1');

-- ----------------------------
-- Table structure for room_valve_addr
-- ----------------------------
DROP TABLE IF EXISTS `room_valve_addr`;
CREATE TABLE `room_valve_addr`  (
  `room_id` int(10) NOT NULL,
  `valve_addr` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `stopped` int(1) NULL DEFAULT NULL COMMENT '是否已停用[0:未停用;1:已停用;]',
  `start_time` datetime(0) NULL DEFAULT NULL,
  `stop_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of room_valve_addr
-- ----------------------------
INSERT INTO `room_valve_addr` VALUES (13325, 'F01', 1, '2018-06-20 16:38:43', '2018-09-02 16:38:48');
INSERT INTO `room_valve_addr` VALUES (13358, 'F01', 0, '2018-09-30 15:18:28', NULL);
INSERT INTO `room_valve_addr` VALUES (13862, '10201825425121', NULL, NULL, NULL);
INSERT INTO `room_valve_addr` VALUES (13863, '10201852645232', NULL, NULL, NULL);
INSERT INTO `room_valve_addr` VALUES (13864, '10201826534524', NULL, NULL, NULL);
INSERT INTO `room_valve_addr` VALUES (13865, '10201852645231', NULL, NULL, NULL);
INSERT INTO `room_valve_addr` VALUES (13866, '10201825645265', NULL, NULL, NULL);
INSERT INTO `room_valve_addr` VALUES (13867, '10201826524521', NULL, NULL, NULL);
INSERT INTO `room_valve_addr` VALUES (13868, '10201826514562', NULL, NULL, NULL);
INSERT INTO `room_valve_addr` VALUES (13893, 'F01', NULL, NULL, NULL);
INSERT INTO `room_valve_addr` VALUES (13898, 'F01', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for room_valve_ctrl
-- ----------------------------
DROP TABLE IF EXISTS `room_valve_ctrl`;
CREATE TABLE `room_valve_ctrl`  (
  `room_id` int(10) NOT NULL,
  `set_time` datetime(0) NULL DEFAULT NULL COMMENT '阀控模式设置时间',
  `control_mode` int(2) NULL DEFAULT NULL COMMENT '控制模式。[0:未设定;1:常开;2:常关;3:自由调节;4:固定回水温度;5:回水温度曲线;6:流量曲线;]',
  `scale` int(3) NULL DEFAULT NULL COMMENT '设定开度',
  `outtemp_mode` int(2) NULL DEFAULT NULL COMMENT '回水温度曲线编号',
  `flow_mode` int(2) NULL DEFAULT NULL COMMENT '流量曲线编号',
  `outtemp` double(5, 2) NULL DEFAULT NULL COMMENT '给定回水温度',
  `min_scale` int(3) NULL DEFAULT NULL COMMENT '最小开度',
  `max_scale` int(3) NULL DEFAULT NULL COMMENT '最大开度',
  `operator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人员',
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for room_valve_ctrl_hist
-- ----------------------------
DROP TABLE IF EXISTS `room_valve_ctrl_hist`;
CREATE TABLE `room_valve_ctrl_hist`  (
  `room_id` int(10) NOT NULL,
  `set_time` datetime(0) NOT NULL COMMENT '阀控模式设置时间',
  `control_mode` int(2) NULL DEFAULT NULL COMMENT '控制模式。[0:未设定;1:常开;2:常关;3:自由调节;4:固定回水温度;5:回水温度曲线;6:流量曲线;]',
  `scale` int(3) NULL DEFAULT NULL COMMENT '设定开度',
  `outtemp_mode` int(2) NULL DEFAULT NULL COMMENT '回水温度曲线编号',
  `flow_mode` int(2) NULL DEFAULT NULL COMMENT '流量曲线编号',
  `outtemp` double(5, 2) NULL DEFAULT NULL COMMENT '给定回水温度',
  `min_scale` int(3) NULL DEFAULT NULL COMMENT '最小开度',
  `max_scale` int(3) NULL DEFAULT NULL COMMENT '最大开度',
  `operator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人员',
  PRIMARY KEY (`room_id`, `set_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for rooms
-- ----------------------------
DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `unit_id` int(10) NOT NULL COMMENT '单元ID',
  `floor` int(3) NOT NULL COMMENT '楼层',
  `room_num` int(6) NOT NULL COMMENT '房间编号',
  `room_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间名称',
  `location` int(3) NULL DEFAULT NULL COMMENT '房间位置',
  `user_code` varchar(20) CHARACTER SET euckr COLLATE euckr_korean_ci NULL DEFAULT '' COMMENT '用户编码',
  `host_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户主名称',
  `contact_info` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT '' COMMENT '联系方式',
  `room_area` double(6, 2) NULL DEFAULT NULL COMMENT '房屋面积',
  `heat_area` double(6, 2) NULL DEFAULT 0.00 COMMENT '取暖面积',
  `user_type` int(2) NULL DEFAULT NULL COMMENT '客户类型',
  `heat_type` int(2) NULL DEFAULT NULL COMMENT '取暖类型',
  `is_supply` tinyint(2) NULL DEFAULT 1 COMMENT '是否供暖 0不供暖 1供暖',
  `contract_num` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL COMMENT '合同号',
  `notes` varchar(30) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT '' COMMENT '注备',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '用户信息更新时间',
  `special_mark` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '特殊标识',
  `charge_mode` tinyint(2) NULL DEFAULT 0 COMMENT '计费方式 [0:面积计费 1:计量计费 ]',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unit_id`(`unit_id`, `room_num`) USING BTREE,
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 14072 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of rooms
-- ----------------------------
INSERT INTO `rooms` VALUES (13325, 344, 1, 101, NULL, 15, '12121', '任彦兵', '152455845541', 98.29, 98.29, 27, 14, 1, NULL, '', '2018-08-09 10:07:18', '1', 0);
INSERT INTO `rooms` VALUES (13326, 345, 1, 101, NULL, 16, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 0, NULL, '', '2018-08-09 10:07:37', '3', 1);
INSERT INTO `rooms` VALUES (13329, 347, 3, 301, NULL, 15, '222', '2', '111111', 122.00, 90.00, 25, 14, 1, NULL, '', '2018-08-09 17:44:43', '1', 1);
INSERT INTO `rooms` VALUES (13330, 347, 1, 101, NULL, 16, '00000', '111', '1111111', 123.00, 111.00, 26, 13, 1, NULL, '', '2018-08-09 17:44:43', '2', 1);
INSERT INTO `rooms` VALUES (13331, 348, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-09 17:44:43', '3', 1);
INSERT INTO `rooms` VALUES (13332, 349, 3, 301, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 25, 14, 0, NULL, '', '2018-08-09 17:47:27', '1', 0);
INSERT INTO `rooms` VALUES (13333, 349, 1, 101, NULL, 15, '00000', '111', '1111111', 123.00, 111.00, 26, 13, 1, NULL, '', '2018-08-09 17:47:27', '2', 1);
INSERT INTO `rooms` VALUES (13334, 350, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-09 17:47:27', '3', 1);
INSERT INTO `rooms` VALUES (13335, 349, 3, 302, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 25, 14, 0, NULL, '', '2018-08-09 17:48:46', '1', 0);
INSERT INTO `rooms` VALUES (13336, 351, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-09 17:50:18', '3', 1);
INSERT INTO `rooms` VALUES (13337, 347, 3, 302, NULL, 15, '222', '2', '111111', 122.00, 90.00, 25, 14, 1, NULL, '', '2018-08-10 09:26:32', '1', 1);
INSERT INTO `rooms` VALUES (13338, 352, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-10 09:26:35', '3', 1);
INSERT INTO `rooms` VALUES (13339, 345, 3, 302, NULL, 14, '12121', '112', '152455845541', 123.22, 111.00, 25, 13, 1, NULL, '', '2018-08-10 09:31:47', '1', 1);
INSERT INTO `rooms` VALUES (13340, 353, 3, 302, NULL, 14, '12121', '111', '152455845541', 123.22, 111.00, 25, 14, 0, NULL, '', '2018-08-10 09:32:58', '1', 0);
INSERT INTO `rooms` VALUES (13341, 353, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-10 09:32:58', '3', 1);
INSERT INTO `rooms` VALUES (13342, 354, 3, 302, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 25, 14, 0, NULL, '', '2018-08-10 09:34:07', '1', 0);
INSERT INTO `rooms` VALUES (13343, 354, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-10 09:34:07', '3', 1);
INSERT INTO `rooms` VALUES (13344, 355, 3, 302, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 25, 14, 1, NULL, '', '2018-08-10 09:35:09', '1', 0);
INSERT INTO `rooms` VALUES (13345, 355, 1, 101, NULL, 15, '00000', '111', '1111111', 123.00, 111.00, 26, 13, 0, NULL, '', '2018-08-10 09:35:09', '2', 1);
INSERT INTO `rooms` VALUES (13348, 356, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 0, NULL, '', '2018-08-10 13:04:50', '3', 1);
INSERT INTO `rooms` VALUES (13349, 357, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-10 13:04:50', '3', 1);
INSERT INTO `rooms` VALUES (13350, 358, 1, 101, NULL, 15, '11111', '李华', '1212121212', 132.00, 100.00, 25, 13, 1, NULL, '', '2018-08-10 13:05:01', '1', 0);
INSERT INTO `rooms` VALUES (13351, 359, 1, 101, NULL, NULL, '', NULL, '', NULL, 0.00, NULL, NULL, 0, NULL, '', '2018-08-10 13:05:01', NULL, 0);
INSERT INTO `rooms` VALUES (13352, 358, 1, 103, NULL, 15, '11111', '张三', '1212121212', 156.36, 132.12, 26, 14, 1, NULL, '', '2018-08-10 13:05:01', '1', 0);
INSERT INTO `rooms` VALUES (13353, 360, 3, 302, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 25, 14, 0, NULL, '', '2018-08-10 14:13:51', '1', 0);
INSERT INTO `rooms` VALUES (13354, 360, 1, 101, NULL, 15, '00000', '111', '1111111', 123.00, 111.00, 26, 13, 0, NULL, '', '2018-08-10 14:13:51', '2', 1);
INSERT INTO `rooms` VALUES (13355, 361, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-10 14:13:51', '3', 1);
INSERT INTO `rooms` VALUES (13356, 362, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-10 14:13:51', '3', 1);
INSERT INTO `rooms` VALUES (13358, 344, 1, 102, NULL, 15, '12121', '李建斌', '152455845541', 97.52, 97.52, 27, 14, 1, NULL, '', '2018-08-13 11:02:53', '1', 0);
INSERT INTO `rooms` VALUES (13359, 345, 1, 102, NULL, 14, '11111', '李华', '1212121212', 132.00, 100.00, 25, 13, 1, NULL, '', '2018-08-13 11:03:15', '2', 1);
INSERT INTO `rooms` VALUES (13361, 363, 1, 101, NULL, 14, '11111', '李华', '1212121212', 132.00, 111.00, 25, 13, 1, NULL, '', '2018-08-15 13:57:58', '1', 1);
INSERT INTO `rooms` VALUES (13362, 364, 1, 102, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 25, 14, 0, NULL, '', '2018-08-15 14:00:56', '1', 0);
INSERT INTO `rooms` VALUES (13363, 364, 1, 101, NULL, 15, '00000', '111', '1111111', 123.00, 111.00, 26, 13, 1, NULL, '', '2018-08-15 14:00:56', '2', 1);
INSERT INTO `rooms` VALUES (13364, 365, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-15 14:00:56', '3', 1);
INSERT INTO `rooms` VALUES (13365, 365, 1, 102, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-15 14:00:56', '3', 1);
INSERT INTO `rooms` VALUES (13366, 366, 1, 102, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 25, 14, 0, NULL, '', '2018-08-15 14:04:28', '1', 0);
INSERT INTO `rooms` VALUES (13367, 366, 1, 101, NULL, 15, '00000', '111', '1111111', 123.00, 111.00, 26, 13, 1, NULL, '', '2018-08-15 14:04:28', '2', 1);
INSERT INTO `rooms` VALUES (13368, 367, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-15 14:04:28', '3', 1);
INSERT INTO `rooms` VALUES (13369, 367, 1, 102, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-15 14:04:28', '3', 1);
INSERT INTO `rooms` VALUES (13862, 369, 1, 101, NULL, 14, '120125', '王老师', '123456', 120.00, 103.20, 25, 13, 0, NULL, '', '2018-08-24 09:52:43', '', 0);
INSERT INTO `rooms` VALUES (13863, 370, 1, 101, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '1', 0);
INSERT INTO `rooms` VALUES (13864, 370, 1, 102, NULL, 16, '12121', '111', '152455845541', 123.23, 112.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '2', 1);
INSERT INTO `rooms` VALUES (13865, 370, 1, 103, NULL, 16, '12121', '111', '152455845541', 123.24, 113.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:23', '3', 0);
INSERT INTO `rooms` VALUES (13866, 370, 2, 201, NULL, 16, '12121', '111', '152455845541', 123.25, 114.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '4', 0);
INSERT INTO `rooms` VALUES (13867, 370, 2, 202, NULL, 16, '12121', '111', '152455845541', 123.22, 115.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '5', 1);
INSERT INTO `rooms` VALUES (13868, 370, 2, 203, NULL, 16, '12121', '111', '152455845541', 123.23, 111.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:23', '6', 0);
INSERT INTO `rooms` VALUES (13869, 370, 4, 401, NULL, 16, '12121', '111', '152455845541', 123.25, 113.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '8', 1);
INSERT INTO `rooms` VALUES (13870, 370, 4, 402, NULL, 16, '12121', '111', '152455845541', 123.30, 114.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:23', '9', 0);
INSERT INTO `rooms` VALUES (13871, 370, 4, 403, NULL, 16, '12121', '111', '152455845541', 123.31, 115.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '10', 0);
INSERT INTO `rooms` VALUES (13872, 370, 5, 501, NULL, 16, '12121', '111', '152455845541', 123.32, 111.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '11', 1);
INSERT INTO `rooms` VALUES (13873, 370, 5, 502, NULL, 16, '12121', '111', '152455845541', 123.33, 112.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:23', '12', 0);
INSERT INTO `rooms` VALUES (13874, 370, 5, 503, NULL, 16, '12121', '111', '152455845541', 123.34, 113.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '13', 0);
INSERT INTO `rooms` VALUES (13875, 370, 6, 601, NULL, 16, '12121', '111', '152455845541', 123.35, 114.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '14', 1);
INSERT INTO `rooms` VALUES (13876, 370, 6, 602, NULL, 16, '12121', '111', '152455845541', 123.36, 115.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:23', '15', 0);
INSERT INTO `rooms` VALUES (13877, 370, 6, 603, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:23', '16', 0);
INSERT INTO `rooms` VALUES (13878, 370, 7, 701, NULL, 16, '12121', '111', '152455845541', 123.23, 112.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '17', 1);
INSERT INTO `rooms` VALUES (13879, 370, 7, 702, NULL, 16, '12121', '111', '152455845541', 123.24, 113.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:24', '18', 0);
INSERT INTO `rooms` VALUES (13880, 370, 7, 703, NULL, 16, '12121', '111', '152455845541', 123.25, 114.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '19', 0);
INSERT INTO `rooms` VALUES (13881, 370, 8, 801, NULL, 16, '12121', '111', '152455845541', 123.22, 115.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '20', 1);
INSERT INTO `rooms` VALUES (13882, 370, 8, 802, NULL, 16, '12121', '111', '152455845541', 123.23, 111.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:24', '21', 0);
INSERT INTO `rooms` VALUES (13883, 370, 8, 803, NULL, 16, '12121', '111', '152455845541', 123.24, 112.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '22', 0);
INSERT INTO `rooms` VALUES (13884, 370, 9, 901, NULL, 16, '12121', '111', '152455845541', 123.25, 113.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '23', 1);
INSERT INTO `rooms` VALUES (13885, 370, 9, 902, NULL, 16, '12121', '111', '152455845541', 123.30, 114.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:24', '24', 0);
INSERT INTO `rooms` VALUES (13886, 370, 9, 903, NULL, 16, '12121', '111', '152455845541', 123.31, 115.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '25', 0);
INSERT INTO `rooms` VALUES (13887, 370, 10, 1001, NULL, 16, '12121', '111', '152455845541', 123.32, 111.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '26', 1);
INSERT INTO `rooms` VALUES (13888, 370, 10, 1002, NULL, 16, '12121', '111', '152455845541', 123.33, 112.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:24', '27', 0);
INSERT INTO `rooms` VALUES (13889, 370, 10, 1003, NULL, 16, '12121', '111', '152455845541', 123.34, 113.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '28', 0);
INSERT INTO `rooms` VALUES (13890, 370, 11, 1101, NULL, 16, '12121', '111', '152455845541', 123.35, 114.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '29', 1);
INSERT INTO `rooms` VALUES (13891, 370, 11, 1102, NULL, 16, '12121', '111', '152455845541', 123.36, 115.00, 27, 14, 1, NULL, '', '2018-08-24 10:04:24', '30', 0);
INSERT INTO `rooms` VALUES (13892, 370, 11, 1103, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 27, 14, 0, NULL, '', '2018-08-24 10:04:24', '31', 0);
INSERT INTO `rooms` VALUES (13893, 371, 1, 101, NULL, 15, '1', '郭天龙', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-08-27 17:43:10', '1', 0);
INSERT INTO `rooms` VALUES (13894, 347, 1, 102, NULL, 14, '11111', '李华', '1212121212', 132.00, 111.00, 25, 13, 1, NULL, '', '2018-08-27 17:45:18', '1', 1);
INSERT INTO `rooms` VALUES (13895, 347, 2, 201, NULL, 14, '11111', '李华', '1', 132.00, 1.00, 25, 13, 1, NULL, '', '2018-08-27 17:45:39', '1', 1);
INSERT INTO `rooms` VALUES (13896, 352, 1, 102, NULL, 14, '11111', '李华1', '1212121212', 132.00, 1.00, 25, 13, 1, NULL, '', '2018-08-27 17:46:10', '1', 1);
INSERT INTO `rooms` VALUES (13897, 353, 1, 102, NULL, 16, '33', '张三', '1212121212', 121.00, 111.00, 25, 13, 1, NULL, '', '2018-08-27 17:46:40', '1', 0);
INSERT INTO `rooms` VALUES (13898, 371, 1, 102, NULL, 15, '2', '许琪', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-08-28 08:49:53', '1', 0);
INSERT INTO `rooms` VALUES (13901, 347, 4, 401, NULL, 15, '222', '2', '121121', 122.00, 90.00, 25, 13, 1, NULL, '', '2018-08-28 09:56:53', '1', 1);
INSERT INTO `rooms` VALUES (13902, 347, 4, 402, NULL, 15, '222', '2', '111111', 122.00, 90.00, 25, 14, 1, NULL, '', '2018-08-28 09:56:53', '1', 1);
INSERT INTO `rooms` VALUES (13903, 347, 2, 202, NULL, 14, '11111', '李华', '1212121212', 132.00, 111.00, 25, 14, 1, NULL, '', '2018-08-28 10:00:05', '1', 1);
INSERT INTO `rooms` VALUES (13904, 348, 1, 102, NULL, 14, '11111', '李华', '1212121212', 132.00, 111.00, 25, 13, 1, NULL, '', '2018-08-28 10:00:55', '1', 1);
INSERT INTO `rooms` VALUES (13906, 373, 1, 102, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 25, 14, 0, NULL, '', '2018-08-30 08:45:49', '1', 0);
INSERT INTO `rooms` VALUES (13907, 373, 1, 101, NULL, 15, '00000', '111', '1111111', 123.00, 111.00, 26, 13, 1, NULL, '', '2018-08-30 08:45:49', '2', 1);
INSERT INTO `rooms` VALUES (13908, 374, 1, 101, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-30 08:45:49', '3', 1);
INSERT INTO `rooms` VALUES (13909, 374, 1, 102, NULL, 15, '000001', '121', '1111112', 141.00, 26.00, 26, 13, 1, NULL, '', '2018-08-30 08:45:49', '3', 1);
INSERT INTO `rooms` VALUES (13910, 371, 4, 401, NULL, 15, '7', '沈延宁', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:20:20', '1', 0);
INSERT INTO `rooms` VALUES (13911, 371, 4, 402, NULL, 15, '8', '许广玉', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:20:37', '1', 0);
INSERT INTO `rooms` VALUES (13912, 371, 5, 501, NULL, 15, '9', '梁静', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:21:00', '1', 0);
INSERT INTO `rooms` VALUES (13913, 371, 5, 502, NULL, 15, '10', '刘世武', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:21:15', '1', 0);
INSERT INTO `rooms` VALUES (13914, 371, 3, 301, NULL, 15, '5', '都占华', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:50:22', '1', 0);
INSERT INTO `rooms` VALUES (13915, 371, 2, 201, NULL, 15, '3', '黄海渊', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:30', '1', 0);
INSERT INTO `rooms` VALUES (13916, 371, 2, 202, NULL, 15, '4', '郭治枢', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:30', '1', 0);
INSERT INTO `rooms` VALUES (13917, 371, 3, 302, NULL, 15, '6', '刘勇', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:30', '1', 0);
INSERT INTO `rooms` VALUES (13918, 371, 6, 601, NULL, 15, '11', '李启文', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:30', '1', 0);
INSERT INTO `rooms` VALUES (13919, 371, 6, 602, NULL, 15, '12', '倪磊磊', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:30', '1', 0);
INSERT INTO `rooms` VALUES (13920, 376, 1, 101, NULL, 15, '26', '苏秀芳', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:30', '1', 0);
INSERT INTO `rooms` VALUES (13921, 376, 1, 102, NULL, 15, '27', '黄国柱', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:30', '1', 0);
INSERT INTO `rooms` VALUES (13922, 376, 2, 201, NULL, 15, '28', '黄文成', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:30', '1', 0);
INSERT INTO `rooms` VALUES (13923, 376, 2, 202, NULL, 15, '29', '任永肖', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13924, 376, 3, 301, NULL, 15, '30', '于学礼', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13925, 376, 3, 302, NULL, 15, '31', '胡兴智', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13926, 376, 4, 401, NULL, 15, '32', '武海国', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13927, 376, 4, 402, NULL, 15, '33', '都金芳', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13928, 376, 5, 501, NULL, 15, '34', '任保存', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13929, 376, 5, 502, NULL, 15, '35', '慕占发', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13930, 376, 6, 601, NULL, 15, '36', '许红梅', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13931, 376, 6, 602, NULL, 15, '37', '慕占兴', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13932, 377, 1, 101, NULL, 15, '12121', '董彦军', '152455845541', 115.43, 115.43, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', NULL, 0);
INSERT INTO `rooms` VALUES (13933, 377, 1, 102, NULL, 15, '50', '张明富', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13934, 377, 2, 201, NULL, 15, '12121', '韩永婷', '152455845541', 115.43, 115.43, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', NULL, 0);
INSERT INTO `rooms` VALUES (13935, 377, 2, 202, NULL, 15, '51', '马海清', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13936, 377, 3, 301, NULL, 15, '52', '刘世峰', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13937, 377, 3, 302, NULL, 15, '53', '崔登举', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13938, 377, 4, 401, NULL, 15, '54', '张宗军', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13939, 377, 4, 402, NULL, 15, '55', '史万琴', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13940, 377, 5, 501, NULL, 15, '56', '张玉杰', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13941, 377, 5, 502, NULL, 15, '57', '高宇峰', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13942, 377, 6, 601, NULL, 15, '58', '胡建为', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13943, 377, 6, 602, NULL, 15, '59', '陈建新', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:31', '1', 0);
INSERT INTO `rooms` VALUES (13944, 344, 2, 201, NULL, 15, '12121', '王柱良', '152455845541', 98.29, 98.29, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', NULL, 0);
INSERT INTO `rooms` VALUES (13945, 344, 2, 202, NULL, 15, '12121', '李建光', '152455845541', 97.52, 97.52, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', NULL, 0);
INSERT INTO `rooms` VALUES (13946, 344, 3, 301, NULL, 15, '73', '崔雪萍', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13947, 344, 3, 302, NULL, 15, '74', '胡云鹏', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13948, 344, 4, 401, NULL, 15, '75', '郭志洲', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13949, 344, 4, 402, NULL, 15, '76', '许涛涛', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13950, 344, 5, 501, NULL, 15, '77', '杨讨讨', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13951, 344, 5, 502, NULL, 15, '78', '赵丽芳', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13952, 344, 6, 601, NULL, 15, '79', '贺东旭', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13953, 344, 6, 602, NULL, 15, '80', '张瑞', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13954, 375, 1, 101, NULL, 15, '12121', '杨兴国', '152455845541', 97.52, 97.52, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', NULL, 0);
INSERT INTO `rooms` VALUES (13955, 375, 1, 102, NULL, 15, '12121', '王维英', '152455845541', 98.29, 98.29, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', NULL, 0);
INSERT INTO `rooms` VALUES (13956, 375, 2, 201, NULL, 15, '12121', '陈建民', '152455845541', 97.52, 97.52, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', NULL, 0);
INSERT INTO `rooms` VALUES (13957, 375, 2, 202, NULL, 15, '12121', '路便英', '152455845541', 98.29, 98.29, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', NULL, 0);
INSERT INTO `rooms` VALUES (13958, 375, 3, 301, NULL, 15, '85', '赫耀有', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13959, 375, 3, 302, NULL, 15, '12121', '高建军', '152455845541', 98.29, 98.29, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', NULL, 0);
INSERT INTO `rooms` VALUES (13960, 375, 4, 401, NULL, 15, '86', '鄂德江', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13961, 375, 4, 402, NULL, 15, '12121', '王晋青', '152455845541', 98.29, 98.29, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', NULL, 0);
INSERT INTO `rooms` VALUES (13962, 375, 5, 501, NULL, 15, '87', '刘金成', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13963, 375, 5, 502, NULL, 15, '12121', '张进荣', '152455845541', 98.29, 98.29, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', NULL, 0);
INSERT INTO `rooms` VALUES (13964, 375, 6, 601, NULL, 15, '88', '杨婧文', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-10-04 15:52:32', '1', 0);
INSERT INTO `rooms` VALUES (13965, 375, 6, 602, NULL, 15, '12121', '李福荣', '152455845541', 98.29, 98.29, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13966, 378, 1, 101, NULL, 15, '12121', '马永华', '152455845541', 264.62, 264.62, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13967, 378, 1, 102, NULL, 15, '12121', '李莉', '152455845541', 262.18, 262.18, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13968, 378, 1, 103, NULL, 15, '12121', '郭爱明', '152455845541', 222.92, 222.92, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13969, 378, 1, 104, NULL, 15, '12121', '李鑫', '152455845541', 223.40, 223.40, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13970, 378, 1, 105, NULL, 15, '12121', '李彦丽', '152455845541', 223.40, 223.40, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13971, 378, 1, 106, NULL, 15, '12121', '闫志辉', '152455845541', 223.99, 223.99, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13972, 378, 1, 107, NULL, 15, '12121', '赵爱兵', '152455845541', 263.01, 263.01, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13973, 378, 1, 108, NULL, 15, '12121', '王永录', '152455845541', 264.62, 264.62, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13974, 379, 1, 101, NULL, 15, '12121', '韩新华', '152455845541', 223.52, 223.52, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13975, 379, 1, 102, NULL, 15, '12121', '尚金平', '152455845541', 223.05, 223.05, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13976, 379, 1, 103, NULL, 15, '12121', '赵首贺', '152455845541', 223.28, 223.28, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13977, 379, 1, 104, NULL, 15, '12121', '瞿保华', '152455845541', 224.84, 224.84, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13978, 380, 1, 101, NULL, 15, '12121', '田云峰', '152455845541', 222.50, 222.50, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13979, 380, 1, 102, NULL, 15, '12121', '宋林祥', '152455845541', 220.45, 220.45, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13980, 380, 1, 103, NULL, 15, '12121', '张迎红', '152455845541', 220.55, 220.55, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13981, 380, 1, 104, NULL, 15, '12121', '李明华', '152455845541', 220.07, 220.07, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13982, 380, 1, 105, NULL, 15, '12121', '李海珍', '152455845541', 220.07, 220.07, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13983, 380, 1, 106, NULL, 15, '12121', '李伟', '152455845541', 220.07, 220.07, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13984, 380, 1, 107, NULL, 15, '12121', '张千柱', '152455845541', 220.07, 220.07, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13985, 380, 1, 108, NULL, 15, '12121', '李俊英', '152455845541', 220.07, 220.07, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13986, 380, 1, 109, NULL, 15, '12121', '张鹏', '152455845541', 220.07, 220.07, 27, 14, 1, NULL, '', '2018-10-04 15:52:33', NULL, 0);
INSERT INTO `rooms` VALUES (13987, 380, 1, 110, NULL, 15, '12121', '贾如杰', '152455845541', 223.50, 223.50, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13988, 381, 1, 101, NULL, 15, '12121', '赵来成', '152455845541', 256.53, 256.53, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13989, 381, 1, 102, NULL, 15, '12121', '王朝霞', '152455845541', 253.29, 253.29, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13990, 381, 1, 103, NULL, 15, '12121', '睦紫朝', '152455845541', 253.29, 253.29, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13991, 381, 1, 104, NULL, 15, '12121', '李秋华', '152455845541', 251.84, 251.84, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13992, 381, 1, 105, NULL, 15, '12121', '王维周', '152455845541', 251.94, 251.94, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13993, 381, 1, 106, NULL, 15, '12121', '张宏', '152455845541', 254.03, 254.03, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13994, 381, 1, 107, NULL, 15, '12121', '物业', '152455845541', 253.70, 253.70, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13995, 381, 1, 108, NULL, 15, '12121', '光向东', '152455845541', 256.53, 256.53, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13996, 382, 1, 101, NULL, 15, '12121', '王喜明', '152455845541', 223.01, 223.01, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13997, 382, 1, 102, NULL, 15, '12121', '黄祥苗', '152455845541', 220.59, 220.59, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13998, 382, 1, 103, NULL, 15, '12121', '黄祥苗', '152455845541', 220.59, 220.59, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (13999, 382, 1, 104, NULL, 15, '12121', '赵庆军', '152455845541', 220.59, 220.59, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14000, 382, 1, 105, NULL, 15, '12121', '赵玮', '152455845541', 220.59, 220.59, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14001, 382, 1, 106, NULL, 15, '12121', '杜利峰', '152455845541', 223.05, 223.05, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14002, 383, 1, 101, NULL, 15, '12121', '陈思东', '152455845541', 224.84, 224.84, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14003, 383, 1, 102, NULL, 15, '12121', '陈思东', '152455845541', 223.28, 223.28, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14004, 383, 1, 103, NULL, 15, '12121', '王志军', '152455845541', 223.05, 223.05, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14005, 383, 1, 104, NULL, 15, '12121', '张彦福', '152455845541', 223.52, 223.52, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14006, 384, 1, 101, NULL, 15, '12121', '王贵平', '152455845541', 221.03, 221.03, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14007, 384, 1, 102, NULL, 15, '12121', '张文珍', '152455845541', 220.45, 220.45, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14008, 384, 1, 103, NULL, 15, '12121', '张开林', '152455845541', 220.15, 220.15, 27, 14, 1, NULL, '', '2018-10-04 15:52:34', NULL, 0);
INSERT INTO `rooms` VALUES (14009, 384, 1, 104, NULL, 15, '12121', '张晋平', '152455845541', 220.15, 220.15, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14010, 384, 1, 105, NULL, 15, '12121', '王志宏', '152455845541', 220.15, 220.15, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14011, 384, 1, 106, NULL, 15, '12121', '王伟', '152455845541', 220.15, 220.15, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14012, 384, 1, 107, NULL, 15, '12121', '李爱祥', '152455845541', 220.15, 220.15, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14013, 384, 1, 108, NULL, 15, '12121', '苏玉兰', '152455845541', 222.58, 222.58, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14014, 385, 1, 101, NULL, 15, '12121', '于志珍', '152455845541', 238.41, 238.41, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14015, 385, 1, 102, NULL, 15, '12121', '王彦文', '152455845541', 208.41, 208.41, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14016, 385, 1, 103, NULL, 15, '12121', '王保军', '152455845541', 222.43, 222.43, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14017, 385, 1, 104, NULL, 15, '12121', '凌怀斌', '152455845541', 246.12, 246.12, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14018, 385, 1, 105, NULL, 15, '12121', '闫荣荣', '152455845541', 264.86, 264.86, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14019, 386, 1, 101, NULL, 15, '12121', '王强', '152455845541', 253.28, 253.28, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14020, 386, 1, 102, NULL, 15, '12121', '田剑华', '152455845541', 253.07, 253.07, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14021, 386, 1, 103, NULL, 15, '12121', '王京京', '152455845541', 252.19, 252.19, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14022, 386, 1, 104, NULL, 15, '12121', '物业', '152455845541', 254.26, 254.26, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14023, 386, 1, 105, NULL, 15, '12121', '王强', '152455845541', 254.37, 254.37, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14024, 386, 1, 106, NULL, 15, '12121', '张建忠', '152455845541', 253.07, 253.07, 27, 14, 1, NULL, '', '2018-10-04 15:52:35', NULL, 0);
INSERT INTO `rooms` VALUES (14025, 387, 1, 101, NULL, 15, '11111', '张迪', '212232131', 222.00, 222.00, 27, 14, 1, NULL, '', '2018-10-08 16:31:11', '321', 1);
INSERT INTO `rooms` VALUES (14026, 387, 1, 103, NULL, 16, '12121', '111', '152455845541', 123.22, 111.00, 27, 14, 0, NULL, '', '2018-10-08 16:32:22', '1', 1);
INSERT INTO `rooms` VALUES (14027, 371, 7, 701, NULL, 15, '13', '刘义军', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14028, 371, 7, 702, NULL, 15, '14', '慕臣', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14029, 371, 8, 801, NULL, 15, '15', '樊潇', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14030, 371, 8, 802, NULL, 15, '16', '梁红梅', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14031, 371, 9, 901, NULL, 15, '17', '胡志凌', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14032, 371, 9, 902, NULL, 15, '18', '徐万奇', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14033, 371, 10, 1001, NULL, 15, '19', '吴录成', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14034, 371, 10, 1002, NULL, 15, '20', '马生精', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14035, 371, 11, 1101, NULL, 15, '21', '贾世聪', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14036, 371, 11, 1102, NULL, 15, '22', '樊志锋', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14037, 371, 12, 1201, NULL, 15, '23', '杨亚莉', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:17', '1', 0);
INSERT INTO `rooms` VALUES (14038, 371, 12, 1202, NULL, 15, '24', '王长发', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:18', '1', 0);
INSERT INTO `rooms` VALUES (14039, 371, 13, 1301, NULL, 15, '25', '刘涛', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:18', '1', 0);
INSERT INTO `rooms` VALUES (14040, 376, 7, 701, NULL, 15, '38', '陈宝亮', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:18', '1', 0);
INSERT INTO `rooms` VALUES (14041, 376, 7, 702, NULL, 15, '39', '张宸', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:18', '1', 0);
INSERT INTO `rooms` VALUES (14042, 376, 8, 801, NULL, 15, '40', '韩雅琴', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:18', '1', 0);
INSERT INTO `rooms` VALUES (14043, 376, 8, 802, NULL, 15, '41', '胡彩萍', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:18', '1', 0);
INSERT INTO `rooms` VALUES (14044, 376, 9, 901, NULL, 15, '42', '王平', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:18', '1', 0);
INSERT INTO `rooms` VALUES (14045, 376, 9, 902, NULL, 15, '43', '许亚军', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:19', '1', 0);
INSERT INTO `rooms` VALUES (14046, 376, 10, 1001, NULL, 15, '44', '王文平', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:19', '1', 0);
INSERT INTO `rooms` VALUES (14047, 376, 10, 1002, NULL, 15, '45', '董海荣', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:19', '1', 0);
INSERT INTO `rooms` VALUES (14048, 376, 11, 1101, NULL, 15, '46', '赵丽君', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:19', '1', 0);
INSERT INTO `rooms` VALUES (14049, 376, 11, 1102, NULL, 15, '47', '黄永功', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:19', '1', 0);
INSERT INTO `rooms` VALUES (14050, 376, 12, 1201, NULL, 15, '48', '耿彦勤', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:19', '1', 0);
INSERT INTO `rooms` VALUES (14051, 376, 12, 1202, NULL, 15, '49', '杨文兴', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:19', '1', 0);
INSERT INTO `rooms` VALUES (14052, 377, 7, 701, NULL, 15, '60', '刘昌', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:20', '1', 0);
INSERT INTO `rooms` VALUES (14053, 377, 7, 702, NULL, 15, '61', '赵利军', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:20', '1', 0);
INSERT INTO `rooms` VALUES (14054, 377, 8, 801, NULL, 15, '62', '刘世鸿', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:20', '1', 0);
INSERT INTO `rooms` VALUES (14055, 377, 8, 802, NULL, 15, '63', '刘涛', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:20', '1', 0);
INSERT INTO `rooms` VALUES (14056, 377, 9, 901, NULL, 15, '64', '刘翔', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:20', '1', 0);
INSERT INTO `rooms` VALUES (14057, 377, 9, 902, NULL, 15, '65', '赵鑫', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:20', '1', 0);
INSERT INTO `rooms` VALUES (14058, 377, 10, 1001, NULL, 15, '66', '刘世录', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:21', '1', 0);
INSERT INTO `rooms` VALUES (14059, 377, 10, 1002, NULL, 15, '67', '靳馨', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:21', '1', 0);
INSERT INTO `rooms` VALUES (14060, 377, 11, 1101, NULL, 15, '68', '杨显林', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:22', '1', 0);
INSERT INTO `rooms` VALUES (14061, 377, 11, 1102, NULL, 15, '69', '敬文钊', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:22', '1', 0);
INSERT INTO `rooms` VALUES (14062, 377, 12, 1201, NULL, 15, '70', '张翼翔', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:22', '1', 0);
INSERT INTO `rooms` VALUES (14063, 377, 12, 1202, NULL, 15, '71', '田柏君', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:22', '1', 0);
INSERT INTO `rooms` VALUES (14064, 377, 13, 1301, NULL, 15, '72', '刘鑫', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:23', '1', 0);
INSERT INTO `rooms` VALUES (14065, 344, 7, 701, NULL, 15, '81', '赵小峰', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:25', '1', 0);
INSERT INTO `rooms` VALUES (14066, 344, 7, 702, NULL, 15, '82', '杨玲', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:25', '1', 0);
INSERT INTO `rooms` VALUES (14067, 344, 8, 801, NULL, 15, '83', '梁丫丫', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:25', '1', 0);
INSERT INTO `rooms` VALUES (14068, 344, 8, 802, NULL, 15, '84', '王贵玉', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:25', '1', 0);
INSERT INTO `rooms` VALUES (14069, 375, 7, 701, NULL, 15, '89', '郭富堂', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:25', '1', 0);
INSERT INTO `rooms` VALUES (14070, 375, 8, 801, NULL, 15, '90', '许义', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:25', '1', 0);
INSERT INTO `rooms` VALUES (14071, 388, 1, 101, NULL, 15, '91', '韩惠霞', '152455845541', 100.00, 100.00, 27, 14, 1, NULL, '', '2018-11-02 16:00:25', '1', 0);

-- ----------------------------
-- Table structure for scale_ctrl
-- ----------------------------
DROP TABLE IF EXISTS `scale_ctrl`;
CREATE TABLE `scale_ctrl`  (
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阀门地址',
  `ctrl_time` datetime(0) NULL DEFAULT NULL COMMENT '控制时间',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(5) NULL DEFAULT NULL COMMENT '阀门集抄器编号',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '协议编码',
  `ctrl_type` int(2) NULL DEFAULT NULL COMMENT '控制类型[15:阀门开度控制;16:阀门开度限值控制]',
  `ctrl_scale` int(3) NULL DEFAULT NULL COMMENT '阀门开度',
  `min_scale` int(3) NULL DEFAULT 0 COMMENT '最小开度值',
  `max_scale` int(3) NULL DEFAULT 100 COMMENT '最大开度值',
  `scale_is_over` int(1) NULL DEFAULT 0,
  `scale_exec_time` datetime(0) NULL DEFAULT NULL COMMENT '开度控制执行时间',
  `scale_exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开度控制执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '控制更新时间',
  PRIMARY KEY (`valve_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for scale_ctrl_hist
-- ----------------------------
DROP TABLE IF EXISTS `scale_ctrl_hist`;
CREATE TABLE `scale_ctrl_hist`  (
  `control_id` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阀门地址',
  `ctrl_time` datetime(0) NOT NULL COMMENT '控制时间',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(5) NULL DEFAULT NULL COMMENT '阀门集抄器编号',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '协议编码',
  `ctrl_scale` int(3) NULL DEFAULT NULL COMMENT '阀门开度',
  `ctrl_is_over` int(1) NULL DEFAULT NULL,
  `ctrl_exec_time` datetime(0) NULL DEFAULT NULL COMMENT '开度控制执行时间',
  `ctrl_exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开度控制执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '控制更新时间',
  PRIMARY KEY (`control_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for service_role
-- ----------------------------
DROP TABLE IF EXISTS `service_role`;
CREATE TABLE `service_role`  (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '服务角色id',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '服务角色名称',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of service_role
-- ----------------------------
INSERT INTO `service_role` VALUES (1, 'ROLE_ADMIN', '管理员角色，可调用管理接口');
INSERT INTO `service_role` VALUES (2, 'ROLE_OPER', '操作员角色，可以对系统进行一些操作，比如开关阀');
INSERT INTO `service_role` VALUES (3, 'ROLE_USER', '用户角色，只能浏览数据');
INSERT INTO `service_role` VALUES (4, 'ROLE_SERV', '服务角色，主要是营收人员或者客户服务人员');

-- ----------------------------
-- Table structure for sqlcheck
-- ----------------------------
DROP TABLE IF EXISTS `sqlcheck`;
CREATE TABLE `sqlcheck`  (
  `id` int(10) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for station
-- ----------------------------
DROP TABLE IF EXISTS `station`;
CREATE TABLE `station`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `station_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '换热站名称',
  `zone_id` int(10) NULL DEFAULT NULL COMMENT '隶属小区id',
  `manager` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '换热站负责人',
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '负责人联系方式',
  `meter_addr` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '热量表地址',
  `water_addr` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '水表地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for station_season_data
-- ----------------------------
DROP TABLE IF EXISTS `station_season_data`;
CREATE TABLE `station_season_data`  (
  `station_id` int(10) NOT NULL COMMENT '换热站id',
  `heat_season_id` int(10) NOT NULL COMMENT '采暖季id',
  `date` date NULL DEFAULT NULL COMMENT '数据记录时间',
  `heat_day` int(10) NULL DEFAULT NULL COMMENT '已供暖天数',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '采暖季供暖面积(M2)',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '用热量(kWh)',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '循环水量(M3)',
  `avg_flow` double(10, 2) NULL DEFAULT NULL COMMENT '单位循环水量(M3/(M2*H))',
  `avg_energy` double(10, 2) NULL DEFAULT NULL COMMENT '平均单耗(W/(M2*H))',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `add_water` double(10, 2) NULL DEFAULT NULL COMMENT '补水量',
  `electricity` double(10, 2) NULL DEFAULT NULL COMMENT '耗电量',
  PRIMARY KEY (`station_id`, `heat_season_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for temp_data_hist
-- ----------------------------
DROP TABLE IF EXISTS `temp_data_hist`;
CREATE TABLE `temp_data_hist`  (
  `temp_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '温度节点地址',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `temp` double(5, 2) NULL DEFAULT NULL COMMENT '温度值',
  `battery` double(4, 2) NULL DEFAULT NULL COMMENT '电池电压',
  `fixture` int(2) NULL DEFAULT NULL COMMENT '固定标识[0:固定状态;1:移动状态;]',
  `fixture_num` int(3) NULL DEFAULT NULL COMMENT '固定标识序列号',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点故障列表',
  PRIMARY KEY (`temp_addr`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for temp_data_last
-- ----------------------------
DROP TABLE IF EXISTS `temp_data_last`;
CREATE TABLE `temp_data_last`  (
  `temp_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '温度节点地址',
  `data_time` datetime(0) NULL DEFAULT NULL COMMENT '数据时间',
  `temp` double(5, 2) NULL DEFAULT NULL COMMENT '温度值',
  `battery` double(4, 2) NULL DEFAULT NULL COMMENT '电池电压',
  `fixture` int(2) NULL DEFAULT NULL COMMENT '固定标识[0:固定状态;1:移动状态;]',
  `fixture_num` int(3) NULL DEFAULT NULL COMMENT '固定标识序列号',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节点故障列表',
  PRIMARY KEY (`temp_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of temp_data_last
-- ----------------------------
INSERT INTO `temp_data_last` VALUES ('02202018215325', '2018-08-24 10:54:42', 21.50, 1.00, 1, 1, NULL);
INSERT INTO `temp_data_last` VALUES ('02202018265232', '2018-08-24 10:55:08', 19.90, 3.20, 0, 2, NULL);
INSERT INTO `temp_data_last` VALUES ('111', '2018-08-10 11:14:17', 21.00, 1.00, 1, 1, '111');

-- ----------------------------
-- Table structure for temp_nodes
-- ----------------------------
DROP TABLE IF EXISTS `temp_nodes`;
CREATE TABLE `temp_nodes`  (
  `temp_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '测温节点地址',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '阀门网络号',
  `coll_num` int(6) NULL DEFAULT NULL COMMENT '阀门集抄器号',
  `prot_num` int(5) NULL DEFAULT NULL COMMENT '阀门协议号',
  `signal_status` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信号状态',
  `path_status` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传路径状态',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '状态更新时间',
  PRIMARY KEY (`temp_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for thermostat_data_hist
-- ----------------------------
DROP TABLE IF EXISTS `thermostat_data_hist`;
CREATE TABLE `thermostat_data_hist`  (
  `node_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '节点地址',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `room_temp` double(5, 2) NULL DEFAULT NULL COMMENT '室内温度',
  `set_temp` double(5, 2) NULL DEFAULT NULL COMMENT '设置温度',
  `battery` double(3, 1) NULL DEFAULT NULL COMMENT '电池电压',
  `battery_status` int(1) NULL DEFAULT NULL COMMENT '电池状态',
  `fixture` int(2) NULL DEFAULT NULL COMMENT '固定标识[0:固定状态;1:移动状态;]',
  `fixture_num` int(3) NULL DEFAULT NULL COMMENT '固定标识序列号',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障列表',
  PRIMARY KEY (`node_addr`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for thermostat_data_last
-- ----------------------------
DROP TABLE IF EXISTS `thermostat_data_last`;
CREATE TABLE `thermostat_data_last`  (
  `node_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '节点地址',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `room_temp` double(5, 2) NULL DEFAULT NULL COMMENT '室内温度',
  `set_temp` double(5, 2) NULL DEFAULT NULL COMMENT '设置温度',
  `battery` double(3, 1) NULL DEFAULT NULL COMMENT '电池电压',
  `battery_status` int(1) NULL DEFAULT NULL COMMENT '电池状态',
  `fixture` int(2) NULL DEFAULT NULL COMMENT '固定标识[0:固定状态;1:移动状态;]',
  `fixture_num` int(3) NULL DEFAULT NULL COMMENT '固定标识序列号',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '故障列表',
  PRIMARY KEY (`node_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of thermostat_data_last
-- ----------------------------
INSERT INTO `thermostat_data_last` VALUES ('10201825632125', '2018-08-24 11:00:38', 23.50, 25.00, 3.6, 1, 1, 2, NULL);
INSERT INTO `thermostat_data_last` VALUES ('10201832123251', '2018-08-24 10:59:40', 25.60, 26.00, 3.8, 0, 0, 1, NULL);
INSERT INTO `thermostat_data_last` VALUES ('111', '2018-08-22 10:29:15', 32.00, 21.00, 1.0, 1, 1, 1, '1');

-- ----------------------------
-- Table structure for time_outtemp_mode
-- ----------------------------
DROP TABLE IF EXISTS `time_outtemp_mode`;
CREATE TABLE `time_outtemp_mode`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `mode_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `available` int(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for time_outtemp_mode_index
-- ----------------------------
DROP TABLE IF EXISTS `time_outtemp_mode_index`;
CREATE TABLE `time_outtemp_mode_index`  (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `mode_id` int(4) NOT NULL DEFAULT 1 COMMENT '时间段温度设定模式编号',
  `index` int(4) NOT NULL DEFAULT 1 COMMENT '时间段索引值，按时间段由小到大',
  `start_hour` int(4) NOT NULL DEFAULT 0 COMMENT '时间段起始时间',
  `set_outtemp` double(4, 1) NOT NULL DEFAULT 50.0 COMMENT '设定回水温度',
  PRIMARY KEY (`id`, `mode_id`, `index`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for units
-- ----------------------------
DROP TABLE IF EXISTS `units`;
CREATE TABLE `units`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `unit_num` int(3) NOT NULL COMMENT '单元编号',
  `unit_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '单元名称',
  `build_id` int(10) NOT NULL COMMENT '楼宇ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `build_id`(`build_id`, `unit_name`) USING BTREE,
  CONSTRAINT `units_ibfk_1` FOREIGN KEY (`build_id`) REFERENCES `builds` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 389 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of units
-- ----------------------------
INSERT INTO `units` VALUES (344, 1, '1单元', 224);
INSERT INTO `units` VALUES (345, 1, '1单元', 225);
INSERT INTO `units` VALUES (347, 1, '1单元', 227);
INSERT INTO `units` VALUES (348, 1, '1单元', 228);
INSERT INTO `units` VALUES (349, 1, '1单元', 229);
INSERT INTO `units` VALUES (350, 1, '1单元', 230);
INSERT INTO `units` VALUES (351, 1, '1单元', 231);
INSERT INTO `units` VALUES (352, 1, '1单元', 232);
INSERT INTO `units` VALUES (353, 1, '1单元', 233);
INSERT INTO `units` VALUES (354, 1, '1单元', 234);
INSERT INTO `units` VALUES (355, 1, '1单元', 235);
INSERT INTO `units` VALUES (356, 2, '2单元', 235);
INSERT INTO `units` VALUES (357, 3, '3单元', 235);
INSERT INTO `units` VALUES (358, 1, '1单元', 236);
INSERT INTO `units` VALUES (359, 1, '1单元', 237);
INSERT INTO `units` VALUES (360, 1, '1单元', 238);
INSERT INTO `units` VALUES (361, 2, '2单元', 238);
INSERT INTO `units` VALUES (362, 3, '3单元', 238);
INSERT INTO `units` VALUES (363, 2, '2单元', 236);
INSERT INTO `units` VALUES (364, 1, '1单元', 239);
INSERT INTO `units` VALUES (365, 2, '2单元', 239);
INSERT INTO `units` VALUES (366, 1, '1单元', 240);
INSERT INTO `units` VALUES (367, 2, '2单元', 240);
INSERT INTO `units` VALUES (369, 1, '1单元', 242);
INSERT INTO `units` VALUES (370, 1, '1单元', 243);
INSERT INTO `units` VALUES (371, 1, '1单元', 244);
INSERT INTO `units` VALUES (373, 1, '1单元', 246);
INSERT INTO `units` VALUES (374, 2, '2单元', 246);
INSERT INTO `units` VALUES (375, 2, '2??', 224);
INSERT INTO `units` VALUES (376, 2, '2单元', 244);
INSERT INTO `units` VALUES (377, 3, '3单元', 244);
INSERT INTO `units` VALUES (378, 1, '1单元', 247);
INSERT INTO `units` VALUES (379, 1, '1单元', 248);
INSERT INTO `units` VALUES (380, 1, '1单元', 249);
INSERT INTO `units` VALUES (381, 1, '1单元', 250);
INSERT INTO `units` VALUES (382, 1, '1单元', 251);
INSERT INTO `units` VALUES (383, 1, '1单元', 252);
INSERT INTO `units` VALUES (384, 1, '1单元', 253);
INSERT INTO `units` VALUES (385, 1, '1单元', 254);
INSERT INTO `units` VALUES (386, 1, '1单元', 255);
INSERT INTO `units` VALUES (387, 1, '1单元', 256);
INSERT INTO `units` VALUES (388, 1, '1单元', 257);

-- ----------------------------
-- Table structure for user_branch
-- ----------------------------
DROP TABLE IF EXISTS `user_branch`;
CREATE TABLE `user_branch`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NULL DEFAULT NULL,
  `branch_id` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_branch
-- ----------------------------
INSERT INTO `user_branch` VALUES (1, 4, 34);
INSERT INTO `user_branch` VALUES (2, 4, 35);
INSERT INTO `user_branch` VALUES (3, 5, 36);

-- ----------------------------
-- Table structure for user_station
-- ----------------------------
DROP TABLE IF EXISTS `user_station`;
CREATE TABLE `user_station`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NULL DEFAULT NULL COMMENT '用户id',
  `station_id` int(10) NULL DEFAULT NULL COMMENT '小区id',
  `station_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '小区名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user_station
-- ----------------------------
INSERT INTO `user_station` VALUES (43, 2, 25, '区域11');
INSERT INTO `user_station` VALUES (44, 2, 26, '区域21');
INSERT INTO `user_station` VALUES (45, 2, 27, '区域12');
INSERT INTO `user_station` VALUES (46, 2, 30, '2444');
INSERT INTO `user_station` VALUES (47, 2, 31, 'q1');
INSERT INTO `user_station` VALUES (64, 5, 34, '区域1');
INSERT INTO `user_station` VALUES (67, 4, 25, '区域11');
INSERT INTO `user_station` VALUES (68, 4, 26, '区域21');
INSERT INTO `user_station` VALUES (69, 4, 27, '区域12');
INSERT INTO `user_station` VALUES (70, 4, 31, 'q1');
INSERT INTO `user_station` VALUES (71, 4, 33, '区域44');

-- ----------------------------
-- Table structure for user_zone
-- ----------------------------
DROP TABLE IF EXISTS `user_zone`;
CREATE TABLE `user_zone`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NULL DEFAULT NULL COMMENT '用户id',
  `zone_id` int(10) NULL DEFAULT NULL COMMENT '小区id',
  `zone_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '小区名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号，主键，自动递增',
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `user_passwd` char(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户密码',
  `real_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '真实姓名',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` char(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `role_id` int(5) UNSIGNED NOT NULL COMMENT '对应角色',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_role`(`role_id`) USING BTREE,
  CONSTRAINT `user_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (2, 'superadmin', '1111111', 'a22', '1321556042@qq.com', '421111', 1);
INSERT INTO `users` VALUES (4, 'admin1', '1111111', 'a', '1321556042@qq.com', '7876587', 2);
INSERT INTO `users` VALUES (5, 'demo', 'demo', 'demo', '2551642@qq.com', '15165212525', 2);

-- ----------------------------
-- Table structure for valve_ctrl
-- ----------------------------
DROP TABLE IF EXISTS `valve_ctrl`;
CREATE TABLE `valve_ctrl`  (
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ctrl_time` datetime(0) NULL DEFAULT NULL COMMENT '控制时间',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(5) NULL DEFAULT NULL COMMENT '集抄器号',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '阀门协议号',
  `ctrl_state` int(3) NULL DEFAULT NULL COMMENT '阀门开关控制命令，[3:普通开阀;4:强制关阀;18:强制开阀;19:普通关阀;]',
  `ctrl_is_over` int(2) NULL DEFAULT NULL COMMENT '是否执行完成，[0:未执行;1:执行完成]',
  `ctrl_exec_time` datetime(0) NULL DEFAULT NULL COMMENT '阀门控制执行时间',
  `ctrl_exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阀门控制执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '控制状态更新时间',
  PRIMARY KEY (`valve_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for valve_ctrl_hist
-- ----------------------------
DROP TABLE IF EXISTS `valve_ctrl_hist`;
CREATE TABLE `valve_ctrl_hist`  (
  `control_id` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ctrl_time` datetime(0) NOT NULL COMMENT '控制时间',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '网络号',
  `coll_num` int(5) NULL DEFAULT NULL COMMENT '集抄器号',
  `valve_prot` int(5) NULL DEFAULT NULL COMMENT '阀门协议号',
  `ctrl_cmd` int(3) NULL DEFAULT NULL COMMENT '阀门开关控制命令，[3:普通开阀;4:强制关阀;18:强制开阀;19:普通关阀;]',
  `ctrl_is_over` int(2) NULL DEFAULT NULL COMMENT '是否执行完成，[0:未执行;1:执行完成]',
  `ctrl_exec_time` datetime(0) NULL DEFAULT NULL COMMENT '阀门控制执行时间',
  `ctrl_exec_result` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '阀门控制执行结果',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '控制状态更新时间',
  PRIMARY KEY (`control_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for valve_data_hist
-- ----------------------------
DROP TABLE IF EXISTS `valve_data_hist`;
CREATE TABLE `valve_data_hist`  (
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阀门地址',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `set_temp` double(10, 2) NULL DEFAULT NULL,
  `room_temp` double(10, 2) NULL DEFAULT NULL,
  `valve_state` int(1) NULL DEFAULT NULL COMMENT '阀门状态[0:开;1:关;2:开度;3:异常;]',
  `scale` int(3) NULL DEFAULT NULL COMMENT '当前开度值',
  `open_hours` double(10, 2) NULL DEFAULT NULL COMMENT '开阀时间',
  `in_temp` double(6, 1) NULL DEFAULT NULL COMMENT '进水温度',
  `out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '回水温度',
  `given_out_temp` double(6, 0) NULL DEFAULT NULL COMMENT '给定回水温度',
  `power_status` int(1) NULL DEFAULT NULL COMMENT '电源状态[0:正常;1:欠压;]',
  `controler_status` int(1) NULL DEFAULT NULL COMMENT '面板是否连线[0:连线;1:离线;]',
  `min_scale` int(3) NULL DEFAULT NULL COMMENT '最小开度值',
  `max_scale` int(3) NULL DEFAULT NULL COMMENT '最大开度值',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '错误列表，以‘|’为分隔符',
  PRIMARY KEY (`valve_addr`, `data_time`) USING BTREE,
  INDEX `valve_data_last_index`(`valve_addr`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for valve_data_last
-- ----------------------------
DROP TABLE IF EXISTS `valve_data_last`;
CREATE TABLE `valve_data_last`  (
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阀门地址',
  `data_time` datetime(0) NOT NULL COMMENT '数据时间',
  `set_temp` double(10, 2) NULL DEFAULT NULL,
  `room_temp` double(10, 2) NULL DEFAULT NULL,
  `valve_state` int(1) NULL DEFAULT NULL COMMENT '阀门状态[0:开;1:关;2:开度;3:异常;]',
  `scale` int(3) NULL DEFAULT NULL COMMENT '当前开度值',
  `open_hours` double(10, 2) NULL DEFAULT NULL COMMENT '开阀时间',
  `in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '进水温度',
  `out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '回水温度',
  `given_out_temp` double(6, 0) NULL DEFAULT NULL COMMENT '给定回水温度',
  `power_status` int(1) NULL DEFAULT NULL COMMENT '电源状态[0:正常;1:欠压;]',
  `controler_status` int(1) NULL DEFAULT NULL COMMENT '面板是否连线[0:连线;1:离线;]',
  `min_scale` int(3) NULL DEFAULT NULL COMMENT '最小开度值',
  `max_scale` int(3) NULL DEFAULT NULL COMMENT '最大开度值',
  `err_list` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '错误列表，以‘|’为分隔符',
  PRIMARY KEY (`valve_addr`) USING BTREE,
  INDEX `valve_data_last_index`(`valve_addr`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of valve_data_last
-- ----------------------------
INSERT INTO `valve_data_last` VALUES ('10201825425121', '2018-08-24 10:39:11', 25.00, 20.50, 0, NULL, NULL, 45.00, 30.00, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `valve_data_last` VALUES ('10201826534524', '2018-08-24 10:40:05', 24.00, 18.90, 2, 50, 20.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `valve_data_last` VALUES ('10201852645231', '2018-08-24 10:40:32', 25.00, 19.90, 3, 33, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `valve_data_last` VALUES ('10201852645232', '2018-08-24 10:39:48', 26.00, 21.00, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `valve_data_last` VALUES ('F01', '2018-08-15 16:39:11', 22.00, -1.00, 1, 22, 1.00, -1.00, -1.00, 22, 2, 2, 2, 2, NULL);

-- ----------------------------
-- Table structure for valve_info
-- ----------------------------
DROP TABLE IF EXISTS `valve_info`;
CREATE TABLE `valve_info`  (
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `net_num` int(6) NULL DEFAULT NULL,
  `coll_num` int(6) NULL DEFAULT NULL,
  `valve_model` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`valve_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of valve_info
-- ----------------------------
INSERT INTO `valve_info` VALUES ('F01', 0, 0, 'SCALE_VALVE', '2018-09-30 15:18:28');

-- ----------------------------
-- Table structure for valve_model
-- ----------------------------
DROP TABLE IF EXISTS `valve_model`;
CREATE TABLE `valve_model`  (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `model_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '型号名称',
  `model_manu` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生产厂家',
  `comm_mode` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通讯方式',
  `prot_num` int(5) NULL DEFAULT NULL COMMENT '协议编号',
  `caliber` int(5) NULL DEFAULT NULL COMMENT '阀门口径，单位mm',
  `ctrl_time` int(4) NULL DEFAULT NULL COMMENT '开关控制时长，单位s',
  `available` int(1) NULL DEFAULT 0 COMMENT '记录是否有效：0：有效 1：无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of valve_model
-- ----------------------------
INSERT INTO `valve_model` VALUES (16, 'S11', 'MODEL1', 'NBIot', 20125, 2, 2, 0);

-- ----------------------------
-- Table structure for valves
-- ----------------------------
DROP TABLE IF EXISTS `valves`;
CREATE TABLE `valves`  (
  `valve_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '阀门地址',
  `net_num` int(5) NULL DEFAULT NULL COMMENT '阀门网络号',
  `coll_num` int(6) NULL DEFAULT NULL COMMENT '阀门集抄器号',
  `prot_num` int(5) NULL DEFAULT NULL COMMENT '阀门协议号',
  `signal_status` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '信号状态',
  `path_status` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传路径状态',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '状态更新时间',
  PRIMARY KEY (`valve_addr`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zone_alarm_value
-- ----------------------------
DROP TABLE IF EXISTS `zone_alarm_value`;
CREATE TABLE `zone_alarm_value`  (
  `zone_id` int(10) UNSIGNED NOT NULL COMMENT '小区编号',
  `alarm_code` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '故障代码',
  `alarm_value` double(10, 2) NULL DEFAULT NULL COMMENT '故障报警阈值',
  `available` int(1) NULL DEFAULT 0 COMMENT '记录是否有效：0：有效 1：无效',
  PRIMARY KEY (`zone_id`, `alarm_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of zone_alarm_value
-- ----------------------------
INSERT INTO `zone_alarm_value` VALUES (45, 'AM-0001', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (45, 'AM-0002', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0001', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0002', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0003', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0004', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0005', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0006', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0007', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0008', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0009', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0010', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0011', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0012', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0013', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0014', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0015', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0016', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (46, 'AM-0017', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0001', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0002', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0003', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0004', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0005', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0006', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0007', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0008', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0009', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0010', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0011', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0012', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0013', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0014', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0015', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0016', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (47, 'AM-0017', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0001', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0002', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0003', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0004', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0005', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0006', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0007', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0008', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0009', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0010', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0011', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0012', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0013', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0014', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0015', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0016', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (48, 'AM-0017', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0001', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0002', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0003', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0004', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0005', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0006', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0007', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0008', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0009', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0010', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0011', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0012', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0013', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0014', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0015', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0016', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (49, 'AM-0017', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0001', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0002', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0003', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0004', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0005', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0006', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0007', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0008', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0009', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0010', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0011', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0012', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0013', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0014', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0015', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0016', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (50, 'AM-0017', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0001', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0002', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0003', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0004', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0005', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0006', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0007', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0008', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0009', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0010', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0011', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0012', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0013', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0014', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0015', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0016', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (51, 'AM-0017', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0001', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0002', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0003', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0004', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0005', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0006', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0007', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0008', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0009', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0010', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0011', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0012', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0013', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0014', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0015', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0016', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (52, 'AM-0017', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0001', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0002', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0003', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0004', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0005', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0006', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0007', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0008', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0009', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0010', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0011', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0012', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0013', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0014', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0015', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0016', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (53, 'AM-0017', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0001', 20.00, 0);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0002', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0003', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0004', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0005', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0006', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0007', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0008', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0009', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0010', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0011', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0012', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0013', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0014', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0015', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0016', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (54, 'AM-0017', NULL, 1);
INSERT INTO `zone_alarm_value` VALUES (55, 'AM-0001', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (55, 'AM-0002', 22.00, 0);
INSERT INTO `zone_alarm_value` VALUES (61, 'AM-0001', NULL, 0);
INSERT INTO `zone_alarm_value` VALUES (61, 'AM-0005', NULL, 1);

-- ----------------------------
-- Table structure for zone_alarms_record
-- ----------------------------
DROP TABLE IF EXISTS `zone_alarms_record`;
CREATE TABLE `zone_alarms_record`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '编号',
  `zone_id` int(10) NULL DEFAULT NULL COMMENT '小区编号',
  `alarm_type` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报警编码',
  `season` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '采暖季名称',
  `device_addr` char(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '报警的表具地址',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '报警第一次发生时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '报警事件最后一次时间',
  `alarm_cnt` int(5) NULL DEFAULT NULL COMMENT '持续报警次数',
  `data_time` datetime(0) NULL DEFAULT NULL COMMENT '最后一次报警对应的数据时间',
  `alarm_message` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'alarm报警说明',
  `disposed` int(2) NULL DEFAULT 0 COMMENT '是否被处理[0:未处理;1:被处理]',
  `dispose_time` datetime(0) NULL DEFAULT NULL COMMENT '处理时间',
  `filtered` int(2) NULL DEFAULT 0 COMMENT '是否被屏蔽[0:未屏蔽;1:被屏蔽]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '报警记录表格' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zone_cal
-- ----------------------------
DROP TABLE IF EXISTS `zone_cal`;
CREATE TABLE `zone_cal`  (
  `zone_id` int(10) NOT NULL COMMENT '小区编号',
  `cal_mode` int(3) NULL DEFAULT NULL COMMENT '计算模式[0:分户累加;1:分支计算;]',
  PRIMARY KEY (`zone_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zone_day_data
-- ----------------------------
DROP TABLE IF EXISTS `zone_day_data`;
CREATE TABLE `zone_day_data`  (
  `zone_id` int(10) NOT NULL COMMENT '小区编号,对应zones内的id',
  `date` date NOT NULL COMMENT '数据日期',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '供暖面积',
  `day_heat` double(12, 2) NULL DEFAULT NULL COMMENT '用热量',
  `day_flow` double(12, 2) NULL DEFAULT NULL COMMENT '用水量',
  `aver_energy` double(6, 2) NULL DEFAULT NULL COMMENT '平均单耗',
  `avg_flow` double(6, 2) NULL DEFAULT NULL COMMENT '日单位水量',
  `avg_outdoor_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均室外温度',
  `avg_in_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均供水温度',
  `avg_out_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均回水温度',
  `avg_room_temp` double(6, 2) NULL DEFAULT NULL COMMENT '平均室内温度',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '数据更新时间',
  PRIMARY KEY (`zone_id`, `date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zone_display
-- ----------------------------
DROP TABLE IF EXISTS `zone_display`;
CREATE TABLE `zone_display`  (
  `zone_id` int(10) NOT NULL,
  `display` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '显示设置。gson格式',
  PRIMARY KEY (`zone_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zone_heat_info
-- ----------------------------
DROP TABLE IF EXISTS `zone_heat_info`;
CREATE TABLE `zone_heat_info`  (
  `build_id` int(10) NOT NULL COMMENT '楼栋编号',
  `total_count` int(10) NULL DEFAULT NULL COMMENT '总户数',
  `total_room_area` double(10, 2) NULL DEFAULT NULL COMMENT '总建筑面积',
  `total_heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '总供暖面积',
  `heat_count` int(10) NULL DEFAULT NULL COMMENT '供暖户数',
  `real_heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '实际供暖面积',
  PRIMARY KEY (`build_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zone_meters
-- ----------------------------
DROP TABLE IF EXISTS `zone_meters`;
CREATE TABLE `zone_meters`  (
  `zone_id` int(10) NOT NULL,
  `branch_id` int(11) UNSIGNED NOT NULL,
  `plus_minus` int(2) NOT NULL COMMENT '0:加;1:减',
  PRIMARY KEY (`zone_id`, `branch_id`) USING BTREE,
  INDEX `meter_index`(`branch_id`) USING BTREE,
  CONSTRAINT `zone_meters_ibfk_1` FOREIGN KEY (`zone_id`) REFERENCES `builds` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `zone_meters_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `meter_list` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zone_mount
-- ----------------------------
DROP TABLE IF EXISTS `zone_mount`;
CREATE TABLE `zone_mount`  (
  `zone_id` int(10) NOT NULL,
  `heat_meter` int(2) NOT NULL DEFAULT 0,
  `heat_valve` int(2) NOT NULL DEFAULT 0,
  `temp_node` int(2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`zone_id`) USING BTREE,
  CONSTRAINT `mount_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zone_out_temp
-- ----------------------------
DROP TABLE IF EXISTS `zone_out_temp`;
CREATE TABLE `zone_out_temp`  (
  `zone_id` int(10) NOT NULL COMMENT '小区编号',
  `data_time` datetime(0) NOT NULL COMMENT '温度时间',
  `outdoor_temp` double(6, 2) NULL DEFAULT NULL COMMENT '户外温度',
  PRIMARY KEY (`zone_id`, `data_time`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zone_outtemp_set
-- ----------------------------
DROP TABLE IF EXISTS `zone_outtemp_set`;
CREATE TABLE `zone_outtemp_set`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `start` int(10) NULL DEFAULT NULL,
  `end` int(10) NULL DEFAULT NULL,
  `color` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zone_id` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of zone_outtemp_set
-- ----------------------------
INSERT INTO `zone_outtemp_set` VALUES (6, 0, 25, '498bba', 45);
INSERT INTO `zone_outtemp_set` VALUES (7, 25, 55, '8f478f', 45);
INSERT INTO `zone_outtemp_set` VALUES (8, 55, 66, 'bababa', 45);

-- ----------------------------
-- Table structure for zone_roomtemp_set
-- ----------------------------
DROP TABLE IF EXISTS `zone_roomtemp_set`;
CREATE TABLE `zone_roomtemp_set`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `start` int(10) NULL DEFAULT NULL,
  `end` int(10) NULL DEFAULT NULL,
  `color` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `zone_id` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of zone_roomtemp_set
-- ----------------------------
INSERT INTO `zone_roomtemp_set` VALUES (1, 0, 20, 'cfe31e', 45);
INSERT INTO `zone_roomtemp_set` VALUES (3, 20, 25, '1f8f62', 45);
INSERT INTO `zone_roomtemp_set` VALUES (4, 25, 66, '1581cf', 45);
INSERT INTO `zone_roomtemp_set` VALUES (5, 0, 21, '9caeba', 61);
INSERT INTO `zone_roomtemp_set` VALUES (6, 21, 22, '', 61);

-- ----------------------------
-- Table structure for zone_season_data
-- ----------------------------
DROP TABLE IF EXISTS `zone_season_data`;
CREATE TABLE `zone_season_data`  (
  `zone_id` int(10) NOT NULL COMMENT '小区id',
  `heat_season_id` int(10) NOT NULL COMMENT '采暖季id',
  `date` date NULL DEFAULT NULL COMMENT '数据记录时间',
  `heat_day` int(10) NULL DEFAULT NULL COMMENT '已供暖天数',
  `heat_area` double(10, 2) NULL DEFAULT NULL COMMENT '采暖季供暖面积(M2)',
  `cu_heat` double(10, 2) NULL DEFAULT NULL COMMENT '用热量(kWh)',
  `cu_flow` double(10, 2) NULL DEFAULT NULL COMMENT '循环水量(M3)',
  `avg_flow` double(10, 2) NULL DEFAULT NULL COMMENT '单位循环水量(M3/(M2*H))',
  `avg_energy` double(10, 2) NULL DEFAULT NULL COMMENT '平均单耗(W/(M2*H))',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`zone_id`, `heat_season_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for zones
-- ----------------------------
DROP TABLE IF EXISTS `zones`;
CREATE TABLE `zones`  (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `z_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小区名称',
  `code` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT '0' COMMENT '小区编码',
  `city_code` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '城市编码',
  `heat_e_station_id` int(10) NULL DEFAULT NULL COMMENT '隶属换热站ID',
  `data_period` varchar(4) CHARACTER SET gbk COLLATE gbk_chinese_ci NULL DEFAULT NULL COMMENT '数据上传周期',
  `available` int(1) NULL DEFAULT 0 COMMENT '记录是否有效：0：有效 1：无效',
  `address` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '小区地址',
  `creator` int(10) NULL DEFAULT NULL COMMENT '创建小区的用户id',
  `note` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `min_indoor_temp` double(6, 1) NULL DEFAULT 18.0 COMMENT '最低室温',
  `max_indoor_temp` double(6, 1) NULL DEFAULT 28.0 COMMENT '最高室温',
  `max_flow` double(6, 1) NULL DEFAULT 0.5 COMMENT '最高流量',
  `min_return_temp` double(6, 1) NULL DEFAULT 35.0 COMMENT '最低回水温度',
  `heat_type` int(2) NULL DEFAULT NULL,
  `adviced_indoor_temp` double(4, 1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `heat_e_station_id`(`heat_e_station_id`) USING BTREE,
  CONSTRAINT `zones_ibfk_2` FOREIGN KEY (`heat_e_station_id`) REFERENCES `heat_area` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of zones
-- ----------------------------
INSERT INTO `zones` VALUES (45, '小区1', '0', NULL, 25, NULL, 0, '济南市历下区新泺大街开拓路2', NULL, NULL, 12.0, 12.0, 12.0, 12.0, 1, 12.0);
INSERT INTO `zones` VALUES (46, '小区2', '0', NULL, 25, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (47, '小区211', '0', NULL, 26, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (48, '小区212', '0', NULL, 26, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (49, '区域121', '0', NULL, 27, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (50, '小区311', '0', NULL, 28, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (51, '小区312', '0', NULL, 28, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (52, '小区3', '0', NULL, 25, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (53, '小区213', '0', NULL, 26, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (54, '测试小区', '0', NULL, 29, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (55, '小区4', '0', NULL, 25, NULL, 0, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (56, '??5_del', '0', NULL, 25, NULL, 1, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (57, '55_del', '0', NULL, 25, NULL, 1, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (58, '??_del', '0', NULL, 25, NULL, 1, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (59, '??_del', '0', NULL, 25, NULL, 1, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (60, '二分_del', '0', NULL, 25, NULL, 1, NULL, NULL, NULL, 18.0, 28.0, 0.5, 35.0, NULL, NULL);
INSERT INTO `zones` VALUES (61, '小区88', '0', NULL, 32, NULL, 0, '济南市历下区新泺大街开拓路5', NULL, NULL, 18.0, 28.0, 0.5, 35.0, 0, 21.0);

-- ----------------------------
-- View structure for gis_view_tep
-- ----------------------------
DROP VIEW IF EXISTS `gis_view_tep`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `gis_view_tep` AS select `hsp`.`name` AS `hsp_name`,`hsp`.`id` AS `hsp_id`,`hes`.`name` AS `hes_name`,`hes`.`id` AS `hes_id`,`z`.`id` AS `z_id`,`z`.`z_name` AS `z_name`,`b`.`id` AS `b_id`,`b`.`build_num` AS `b_num`,`b`.`build_name` AS `b_name` from (((`branch_company` `hsp` join `heat_area` `hes`) join `zones` `z`) join `builds` `b`) where ((`hsp`.`id` = `hes`.`branch_company_id`) and (`hes`.`id` = `z`.`heat_e_station_id`) and (`z`.`id` = `b`.`zone_id`) and (`hsp`.`available` = 0) and (`hes`.`available` = 0) and (`z`.`available` = 0)) ; ;

-- ----------------------------
-- View structure for node_list_view
-- ----------------------------
DROP VIEW IF EXISTS `node_list_view`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `node_list_view` AS select `hsp`.`name` AS `branch_name`,`hes`.`id` AS `area_id`,`hes`.`name` AS `area_name`,`z`.`id` AS `zone_id`,`z`.`z_name` AS `z_name`,`b`.`id` AS `build_id`,`b`.`build_num` AS `b_num`,`b`.`build_name` AS `b_name`,`u`.`id` AS `unit_id`,`u`.`unit_name` AS `u_name`,`u`.`unit_num` AS `u_num`,`r`.`id` AS `id`,`r`.`room_num` AS `r_num`,`r`.`room_name` AS `room_name`,`r`.`location` AS `location`,`r`.`user_code` AS `user_code`,`r`.`host_name` AS `host_name`,`r`.`contact_info` AS `contact_info`,`r`.`floor` AS `floor`,`r`.`room_area` AS `room_area`,`r`.`heat_area` AS `heat_area`,`r`.`is_supply` AS `is_supply`,`r`.`user_type` AS `user_type`,`r`.`contract_num` AS `contract_num`,`r`.`heat_type` AS `heat_type`,`r`.`notes` AS `notes`,`r`.`update_time` AS `update_time`,`r`.`special_mark` AS `special_mark`,`r`.`charge_mode` AS `charge_mode` from (((((`branch_company` `hsp` join `heat_area` `hes`) join `zones` `z`) join `builds` `b`) join `units` `u`) join `rooms` `r`) where ((`hsp`.`id` = `hes`.`branch_company_id`) and (`hes`.`id` = `z`.`heat_e_station_id`) and (`z`.`id` = `b`.`zone_id`) and (`b`.`id` = `u`.`build_id`) and (`u`.`id` = `r`.`unit_id`) and (`hsp`.`available` = 0) and (`hes`.`available` = 0) and (`z`.`available` = 0)) ;

-- ----------------------------
-- Procedure structure for NewProc
-- ----------------------------
DROP PROCEDURE IF EXISTS `NewProc`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `NewProc`()
BEGIN
	declare i int;
  declare addr varchar(100);
	DECLARE m VARCHAR(10);
		set addr="D:/temp/1.csv";
  	set i = 0;
       while i < 100 do
			 set m=i;
            /* set addr=SELECT CONCAT('"D:/temp/',m,'.csv"');*/
						
           select * from users where id=i into outfile "D:/temp/1.csv" ;
            set i = i + 1;
        end while;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
