package com.mobile.npss;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.UnknownHostException;
import java.util.Calendar;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mongodb.DB;
import com.mongodb.DBCursor;
import com.mongodb.Mongo;
import com.mongodb.MongoException;
import com.mongodb.gridfs.GridFS;
import com.mongodb.gridfs.GridFSInputFile;

/**
 * Main Controller Servlet that implements the uploading the pdf files
 */
@WebServlet("/FileUploader")
public class MainController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Logger logger = Logger.getLogger(getClass().getName());

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// Compute the output file name extension based on image MIME type
		String mimeType = request.getContentType();
		String extension = null;
		String supportedFormatTable[][] = { { "application/pdf", "pdf" } };

		logger.info("Paste data of type: " + request.getContentType());

		for (int i = 0; i < supportedFormatTable.length; ++i) {
			if (supportedFormatTable[i][0].equals(mimeType)) {
				extension = supportedFormatTable[i][1];
				break;
			}
		}

		if (extension == null) {
			throw new IOException("Unsupported data type: " + mimeType);
		}

		// Read the file contents from the input stream
		File saveTo = new File(System.getProperty("user.dir") + "/image."
				+ extension);
		FileOutputStream os = new FileOutputStream(saveTo);
		InputStream is = request.getInputStream();
		byte buff[] = new byte[256];
		int len;

		while ((len = is.read(buff)) > 0) {
			os.write(buff, 0, len);
		}
		os.close();

		try {

			String[] monthName = { "January", "February", "March", "April",
					"May", "June", "July", "August", "September", "October",
					"November", "December" };

			Calendar cal = Calendar.getInstance();

			String newFileName = monthName[cal.get(Calendar.MONTH)];
			Mongo mongo = new Mongo("localhost", 27017);
			DB db = mongo.getDB("NPSS");

			File imageFile = new File(System.getProperty("user.dir")
					+ "/image." + extension);

			// create a "photo" namespace
			GridFS gfsPhoto = new GridFS(db, "photo");

			// get image file from local drive
			GridFSInputFile gfsFile = gfsPhoto.createFile(imageFile);

			// set a new filename for identify purpose
			gfsFile.setFilename(newFileName + System.currentTimeMillis());

			// save the image file into mongoDB
			gfsFile.save();

			// print the result

			DBCursor cursor = gfsPhoto.getFileList();
			String findName = " ";
			while (cursor.hasNext()) {
				findName = (String) cursor.curr().get("filename");
			}

		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (MongoException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}
