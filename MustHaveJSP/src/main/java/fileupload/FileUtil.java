package fileupload;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.PublicKey;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

public class FileUtil
{
	
	// 파일 업로드
	public static String uploadFile(HttpServletRequest req, String sDirectory) 
			throws ServletException, IOException
	{
		// Part 객체를 통해 서버로 전송된 파일명 읽어오기 
		Part part = req.getPart("ofile");

		// Part 객체의 헤더값 중 content-disposition 읽어오기  
		String partHeader = part.getHeader("content-disposition");
		//출력결과 => form-data; name="attachedFile"; filename="파일명.jpg"
		System.out.println("partHeader="+ partHeader);
		
		// 헤더값에서 파일명 잘라내기. split() 메서드로 분리한 후 더블쿼테이션을 제거
		String[] phArr = partHeader.split("filename=");
		String originalFileName = phArr[1].trim().replace("\"", "");
		
		// 전송된 파일이 있다면 디렉토리에 저장
		if(!originalFileName.isEmpty())
		{
			part.write(sDirectory + File.separator + originalFileName);
		}
		// 원본 파일명 반환
		return originalFileName;
	}
	
	// 파일명 변경
	public static String renameFile(String sDirectory, String fileName)
	{
		// 원본파일의 확장자 잘라내기.  
		// lastlndex() 메서드를 사용한 이유는 다음과 같이 파일명
		// 에 점(.)이 2개 이상 포함될 수 있기 때문. ex)2021년.가을하늘.jpg
		String ext = fileName.substring(fileName.lastIndexOf("."));
		// 날짜 및 시간을 통해 "현재날짜_시간" 형식의 문자열을 생성
		String now = new SimpleDateFormat("yyyyMMdd_HmmsS").format(new Date());
		// "날짜_시간.확장자" 형태의 새로운 파일명 생성
		String newFileName = now + ext;
		
		// 객체를 생성 후 기존 파일명을 새로운 파일명으로 변경
		File oldFile = new File(sDirectory + File.separator + fileName);
		File newFile = new File(sDirectory + File.separator + newFileName);
		oldFile.renameTo(newFile);
		
		//변경된 파일명 반환
		return newFileName;
	}
	
	//multiple 속성 추가로 2개 이상의 파일 업로드
	public static ArrayList<String> multipleFile(HttpServletRequest req, String sDirectory) 
			throws ServletException, IOException
	{
		//파일명 저장을 위한 컬렉션 생성
		ArrayList<String> listFileName = new ArrayList<>();
		//Part 객체를 통해 서버로 전송된 파일명 읽어오기 
		Collection<Part> parts = req.getParts();
		for (Part part : parts)
		{
			//파일이 아니라면 업로드의 대상이 아니므로 무시
			if (!part.getName().equals("ofile"))
				continue;
				
			//Part 객체의 헤더값 중 content-disposition 읽어오기 
			String partHeader = part.getHeader("content-disposition");
			//출력결과 => form-data; name="attachedFile"; filename="파일명.jpg"
			System.out.println("partHeader=" + partHeader);
			
			//헤더값에서 파일명 잘라내기
			String[] phArr = partHeader.split("filename=");
			String orinalFileName = phArr[1].trim().replace("\"", "");
			
			// 전송된 파일이 있다면 디렉토리에 저장
			if(!orinalFileName.isEmpty())
			{
				part.write(sDirectory + File.separator + orinalFileName);
			}
			
			//컬렉션에 추가
			listFileName.add(orinalFileName);
		}
		
		//원본 파일명 반환
		return listFileName;
	}
	
	public static void download(HttpServletRequest req, HttpServletResponse resp,
			String directory, String sfileName, String ofileName)
	{
		String sDirectory = req.getServletContext().getRealPath(directory);
		try
		{
			File file = new File(sDirectory, sfileName);
			InputStream iStream = new FileInputStream(file);
			
			String client = req.getHeader("User-Agent");
			if (client.indexOf("WOW64") == -1) { 
		    	// 익스플로러가 아닌 경우
		        ofileName = new String(ofileName.getBytes("UTF-8"), "ISO-8859-1");
		    } else 
		    {
		    	// 익스플로러 인 경우
		    	ofileName = new String(ofileName.getBytes("KSC5601"), "ISO-8859-1");
		    }
			   // 파일 다운로드용 응답 헤더 설정 
			resp.reset();	// 응답 헤더를 초기화
		    /*
		    	파일 다운로드 창을 뛰우기 위한 콘텐츠 타입을 지정.
		    	octet-stream은 8비트 단위의 바이너리 데이터를 의미하고 응답 헤더를 설정하게 되면
		    	파일의 종류에 상관 없이 웹 브라우저는 다운로드 창을 듸우게 됩니다.
		    */
			resp.setContentType("application/octet-stream");	
		    // 파일 다운로드 창이 뜰대 원본 파일명이 기본으로 입력되도록 설정
			resp.setHeader("Content-Disposition", 
		                       "attachment; filename=\"" + ofileName + "\"");
			resp.setHeader("Content-Length", "" + file.length() );
		    
//		    out.clear();  
		    
		    // response 내장 객체로부터 새로운 출력 스트림 생성
		    OutputStream oStream = resp.getOutputStream();  

		    // 출력 스트림에 파일 내용 출력
		    byte b[] = new byte[(int)file.length()];
		    int readBuffer = 0;    
		    while ( (readBuffer = iStream.read(b)) > 0 ) {
		        oStream.write(b, 0, readBuffer);
		    }
		        iStream.close();
		        oStream.close();
		   
		} 
		    
		catch (FileNotFoundException e)
		{
			System.out.println("파일을 찾을 수 없습니다.");
		}
		
		catch (Exception e)
		{
			System.out.println("예외가 발생했습니다");
		}
		
	}
	public static void deleteFile(HttpServletRequest req,
			String directory, String filename) 
	{
		String sDirectory = req.getServletContext().getRealPath(directory);
		File file = new File(sDirectory + File.separator + filename);
		if (file.exists()) {
			file.delete();
		}
	}
}