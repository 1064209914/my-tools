package util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Row;

public class Download {
		
	private static Logger logger = Logger.getLogger(Download.class);
	
	public void audioDownLoad(String excleSourcePath, String outAudio){
		logger.info("----------------读取"+excleSourcePath+"文件开始-----------------");
		ExcelUtil eu = new ExcelUtil();

		// 从第一行开始读取
		eu.setStartReadPos(1);

		String src_xlspath =excleSourcePath;
		List<Row> rowList = null;
		try {
			rowList = eu.readExcel(src_xlspath);
			// eu.writeExcel_xls(rowList, src_xlspath, dist_xlsPath);
		} catch (IOException e) {
			logger.info(e.getMessage());
		}
		logger.info("----------------读取"+excleSourcePath+"文件结束-----------------");
		logger.info("----------------下载开始-----------------");
		audioDownLoadNetAudioToLocal(eu,rowList,outAudio);
		logger.info("----------------下载结束-----------------");
		for (int i = 1; i < rowList.size(); i++) {
			Row obj = rowList.get(i);
			logger.info(eu.getCellValue(obj.getCell(1)) + "|" + eu.getCellValue(obj.getCell(3)));
		}
	} 

	public void audioDownLoadNetAudioToLocal(ExcelUtil eu,List<Row> rowList,String outAudio){
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		HttpURLConnection conn=null;
		try {
			if(rowList!=null&&rowList.size()>0){
				for (Row row : rowList) {
					String audioUrl=eu.getCellValue(row.getCell(3)).trim();
					if (audioUrl!=null) {
						logger.info("-----开始下载地址为："+audioUrl+"的录音------");
						String userName=eu.getCellValue(row.getCell(1));
						URL url=null;
						try {
							//String SuffixName=audioUrl.substring(audioUrl.length()-4, audioUrl.length());
							url = new URL(audioUrl);
							conn = (HttpURLConnection) url.openConnection();
							conn.setConnectTimeout(10 * 1000); ////设置超时间为10秒 
							//防止屏蔽程序抓取而返回403错误
							conn.setRequestProperty("User-Agent",
									"Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
							//得到输入流 
							bis = new BufferedInputStream(conn.getInputStream());
						} catch (Exception e) {
							logger.error(e.getMessage());
							logger.error("-----地址为："+audioUrl+"的录音下载失败------");
							continue;
						}
						//获取自己数组  
						//文件保存位置  
						File saveDir = new File(outAudio);  
						logger.info("文件夹创建："+outAudio);
						if(!saveDir.exists()){  
							saveDir.mkdirs();
							logger.info("创建成功："+outAudio);
						}  
						File file = new File(saveDir+File.separator+userName+"_"+audioUrl.substring(audioUrl.lastIndexOf("/")+1));   
						bos = new BufferedOutputStream(new FileOutputStream(file));
						byte[] b= new byte[1024];  
						int len = 0;
						while((len = bis.read(b)) != -1){  
							bos.write(b, 0, len);  
						} 
						logger.info("-----地址为："+audioUrl+"的录音下载成功------");
					}else{
						continue;
					}
				}
			}
		} catch (MalformedURLException e) {
			logger.info(e.getMessage());
		} catch (IOException e) {
			logger.info(e.getMessage());
		}finally {
			if(bos!=null){  
	        	try {
					bos.close();
					bos=null;
				} catch (IOException e) {
					logger.info(e.getMessage());
				} 
	        }
			if(bis!=null){  
	        	try {
					bis.close();
					bis=null;
				} catch (IOException e) {
					logger.info(e.getMessage());
				}  
	        }
			if(conn!=null){
				conn.disconnect();
			}
		}
	}

	 public  void showURL() throws IOException {

         // 第一种：获取类加载的根路径   D:\git\daotie\daotie\target\classes
         File f = new File(this.getClass().getResource("/").getPath());
         logger.info(f);

         // 获取当前类的所在工程路径; 如果不加“/”  获取当前类的加载目录  D:\git\daotie\daotie\target\classes\my
         File f2 = new File(this.getClass().getResource("").getPath());
         logger.info(f2);

         // 第二种：获取项目路径    D:\git\daotie\daotie
         File directory = new File("");// 参数为空
         String courseFile = directory.getCanonicalPath();
         logger.info(courseFile);

 
         // 第三种：  file:/D:/git/daotie/daotie/target/classes/
         URL xmlpath = this.getClass().getClassLoader().getResource("");
         logger.info(xmlpath);

 
         // 第四种： D:\git\daotie\daotie
         logger.info(System.getProperty("user.dir"));
         /*
          * 结果： C:\Documents and Settings\Administrator\workspace\projectName
          * 获取当前工程路径
          */

         // 第五种：  获取所有的类路径 包括jar包的路径
         logger.info(System.getProperty("java.class.path"));

     }
	 
		public static void main(String[] args) {
			Download download=new Download();
			File file=new File(System.getProperty("user.dir").replace("downloadaudio", "")+File.separator+"excel");
			logger.info("开始读取"+file.toString()+"------------------");
			File[] chidrenFiles=file.listFiles();
			if (chidrenFiles!=null&&chidrenFiles.length>0) {
				for (File chidFile : chidrenFiles) {
					logger.info("----------------下载任务开始-----------------");
					download.audioDownLoad(chidFile.getAbsolutePath(),System.getProperty("user.dir").replace("downloadaudio", "")+File.separator+"audio");
					logger.info("-------------下载任务结束--------------");
				}	
			}else {
				logger.info(file.toString()+"下没有Excel文件");
			}
		}
}




