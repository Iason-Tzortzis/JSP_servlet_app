package my.restful.web.services;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import org.json.JSONObject;

@Path("Information")

public class Information {
	
	@GET
	@Path("/info/{shop_info}")
	@Produces(MediaType.APPLICATION_JSON)	
	
	public String sayHello(@PathParam("shop_info") String shop_info) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("hello", shop_info);
		return jsonObject.toString();
	}

}
