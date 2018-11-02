package com.ps.net.changeObject;

import org.apache.poi.hssf.record.aggregates.PageSettingsBlock;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExcelUntil {
   //private static HSSFWorkbook hssfWorkbook;
    public static   HSSFWorkbook getExcel(String title, String[] colsName, String[] colsType, List<Map<String, Object>> dataList) {
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet(title);
        //  for(int i=0;i<dataList.size();i++) {
        int cols = colsName.length;
        //设置表头
        HSSFCellStyle style1 = wb.createCellStyle();
        HSSFFont f1 = wb.createFont();
        f1.setBold(true);
        f1.setFontHeightInPoints((short) 16);
        style1.setAlignment(HorizontalAlignment.CENTER);
        style1.setVerticalAlignment(VerticalAlignment.CENTER);
        style1.setFont(f1);
        HSSFRow row = sheet.createRow(0);
        row.setRowStyle(style1);
        for (int col = 0; col < cols; col++) {
            sheet.autoSizeColumn(col);        //自动列宽
            row.createCell(col).setCellValue(colsName[col]);
        }

        //设置表内容
        HSSFCellStyle style2 = wb.createCellStyle();
        HSSFFont f2 = wb.createFont();
        f2.setBold(true);
        f2.setFontHeightInPoints((short) 15);
        style2.setAlignment(HorizontalAlignment.CENTER);
        style2.setVerticalAlignment(VerticalAlignment.CENTER);
        style2.setFont(f2);
        if(dataList.size()>0){
            for (int i = 0; i < dataList.size(); i++) {
                Map<String,Object> map=dataList.get(i);
                HSSFRow row1=sheet.createRow(i+1);
                row1.setRowStyle(style2);
                for(int k=0;k<cols;k++){
                    row1.createCell(k).setCellValue(String.valueOf(map.get(colsType[k])));
                }
            }
        }
        return wb;
    }
    public static List<Map<String,Object>> changeToMap(MultipartFile file, String[] arg1, String[] arg2){
        Workbook workbook = null;
        InputStream is=null;
        int cols=arg1.length;
        List<Map<String,Object>> list=new ArrayList<>();
       Map<String,Object> map=new HashMap<>();
        try{
            is=file.getInputStream();
            String n=file.getOriginalFilename();
            if (n.endsWith(".xls")) {
                workbook = new HSSFWorkbook(is);
            } else if (n.endsWith(".xlsx")) {
                workbook = new XSSFWorkbook(is);
            }
            if (workbook != null) {
                for(int i=0;i<workbook.getNumberOfSheets();i++){
                    Sheet sheet=workbook.getSheetAt(i);
                    if(sheet==null){
                        continue;
                    }else {
                        //根据表内容找出对应位置
                        Row header=sheet.getRow(0);
                        Integer[] sequence=getSequence(header,arg2);
                        for(int j=1;j<=sheet.getLastRowNum();j++){
                            Row row=sheet.getRow(j);
                            if(row!=null){
                                Map<String,Object> map1=new HashMap<>();
                                for(int k=0;k<cols;k++){
                                    if(sequence[k]!=-1) {
                                        Cell cell = row.getCell(sequence[k]);
                                        map1.put(arg1[k], getCellValue(cell));
                                    }
                                }
                                list.add(map1);
                            }

                        }
                    }
                }

            }
            return list;
        }catch (Exception e){
            return null;
        }
    }
    public static Integer[] getSequence(Row header,String[] arg2){
        Integer[] sequence=new Integer[arg2.length];
        if(header!=null){
            for(int k=0;k<arg2.length;k++){
                int flag=-1;
                String title=arg2[k];
                for(int j=0;j<header.getLastCellNum();j++){
                    if(title.equals(String.valueOf(getCellValue(header.getCell(j))))){
                       flag=j;
                        break;
                    }
                }
                sequence[k]=flag;
            }
        }
        return sequence;
    }
    public static String getCellValue(Cell cell){
        String cellValue = "";
        if(cell == null){
            return cellValue;
        }
        //把数字当成String来读，避免出现1读成1.0的情况
        if(cell.getCellType() == Cell.CELL_TYPE_NUMERIC){
            cell.setCellType(Cell.CELL_TYPE_STRING);
        }
        //判断数据的类型
        switch (cell.getCellType()){
            case Cell.CELL_TYPE_NUMERIC: //数字
                cellValue = String.valueOf(cell.getNumericCellValue());
                break;
            case Cell.CELL_TYPE_STRING: //字符串
                cellValue = String.valueOf(cell.getStringCellValue());
                break;
            case Cell.CELL_TYPE_BOOLEAN: //Boolean
                cellValue = String.valueOf(cell.getBooleanCellValue());
                break;
            case Cell.CELL_TYPE_FORMULA: //公式
                cellValue = String.valueOf(cell.getCellFormula());
                break;
            case Cell.CELL_TYPE_BLANK: //空值
                cellValue = "";
                break;
            case Cell.CELL_TYPE_ERROR: //故障
                cellValue = "非法字符";
                break;
            default:
                cellValue = "未知类型";
                break;
        }
        return cellValue;
    }


}
