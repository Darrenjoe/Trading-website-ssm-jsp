package com.xj.util;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class FileUtils {
	public static void saveFile(InputStream inputStream, String strNewPath) {
		FileOutputStream fileOutputStream;
		try {
			fileOutputStream = new FileOutputStream(strNewPath);
			int bytesum = 0;
			int byteread = 0;
			byte[] buffer = new byte[1444];
			while ((byteread = inputStream.read(buffer)) != -1) {
				bytesum += byteread; // 这一行是记录文件大小的，可以删去
				fileOutputStream.write(buffer, 0, byteread);// 三个参数，第一个参数是写的内容，
				// 第二个参数是从什么地方开始写，第三个参数是需要写的大小
			}
			inputStream.close();
			fileOutputStream.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		
	}
}
