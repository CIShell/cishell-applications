package edu.iu.epic.site.search;

import java.io.IOException;

import org.apache.lucene.index.CorruptIndexException;
import org.apache.lucene.queryParser.ParseException;
import org.json.JSONObject;
import org.restlet.Restlet;
import org.restlet.data.MediaType;
import org.restlet.data.Request;
import org.restlet.data.Response;

public class MyRestlet extends Restlet {

	@Override
	public void handle(Request request, Response response) {
		Searcher searcher = new Searcher();
		try {
			String search_string = (String) request.getAttributes().get("search_string");
			if(search_string == null){
				search_string = "data";
			}
			JSONObject json = searcher.searchItemIndex(search_string, "all", "index");
			response.setEntity("" + json, MediaType.TEXT_PLAIN);
		} catch (CorruptIndexException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}