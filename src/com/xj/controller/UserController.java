package com.xj.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.xj.entity.Product;
import com.xj.entity.User;
import com.xj.entity.view.AfficheView;
import com.xj.service.AfficheService;
import com.xj.service.ProductService;
import com.xj.service.UserService;
import com.xj.util.FileUtils;

import net.sf.json.JSONObject;

/**
 * 用户信息控制器
 * 
 * @author Darren
 * @Date 2018年4月27日 下午7:44:41
 */
@Controller
@Scope("prototype")
@ResponseBody()
public class UserController extends BaseController {
	@Autowired
	private UserService userService;

	@Autowired
	private ProductService productService;

	@Autowired
	private AfficheService afficheService;

	// 添加或者修改用户信息
	@RequestMapping(value = "/addOrUpdateUser", method = RequestMethod.POST)
	public Result addOrUpdateUser(HttpServletResponse response, HttpServletRequest request) {
		User user = new User();
		user.setLoginName(request.getParameter("username"));
		user.setPassword(request.getParameter("pwd"));
		user.setTelephone(request.getParameter("telephone"));
		user.setWechat(request.getParameter("wechat"));
		user.setQqNumber(request.getParameter("qqnum"));
		boolean data = userService.addOrUpdateUser(user);
		return result(data);
	}

	// 修改个人信息
	@RequestMapping(value = "/updateUser", method = RequestMethod.POST)
	public Result updateUser(HttpServletResponse response, HttpServletRequest request) {
		User user = new User();
		user.setId(request.getParameter("id"));
		user.setUserName(request.getParameter("userName"));
		user.setCollege(request.getParameter("college"));
		user.setTelephone(request.getParameter("telephone"));
		user.setWechat(request.getParameter("wechat"));
		user.setQqNumber(request.getParameter("qqnum"));
		user.setGender(request.getParameter("gender"));
		user.setSignature(request.getParameter("signature"));
		boolean data = userService.updateUser(user);
		return result(data);
	}
	
	//更新用户头像（存到服务器）
	@RequestMapping(value = "/updatePhoto", method = RequestMethod.POST)
    public String updatePhoto(MultipartFile file,HttpServletResponse response,HttpServletRequest request) throws IOException{ 
		//String contextPath = request.getContextPath();
        String fileName = file.getOriginalFilename();  
        InputStream inputStream = file.getInputStream();
        FileUtils.saveFile(inputStream, "E:\\software\\apache-tomcat-8.0.17\\wtpwebapps\\xkjy\\Resource\\img\\avatars\\"+fileName);
        return "ok";
    }  
	

	// 更新用户头像（存到数据库）
		@RequestMapping(value = "/save2Data", method = RequestMethod.POST)
		public Result save2Data(HttpServletResponse response, HttpServletRequest request) {
			User user = new User();
			user.setId(request.getParameter("id"));
			String s = request.getParameter("photourl");
			String[] split = s.split("\\\\");
			user.setPhotoUrl(split[split.length - 1]);
			boolean data = userService.updatePhoto(user);
			return result(data);
		}

	// 修改密码
	@RequestMapping(value = "/updatePwd", method = RequestMethod.POST)
	public Result updatePwd(HttpServletResponse response, HttpServletRequest request) {
		User user = new User();
		user.setId(request.getParameter("id"));
		user.setPassword(request.getParameter("password"));
		boolean data = userService.updatePwd(user);
		return result(data);
	}

	// 获取全部用户
	@RequestMapping("/getAllUser")
	public Result getAllUser() {
		errorMessage = "getAllUser";
		List<User> allUsers = userService.getAllUsers();
		System.out.println(allUsers.size());
		return result(allUsers);
	}

	// 根据ID获取用户
	@RequestMapping("/getUserById")
	public User getUserById(String id) {
		return userService.getUserById(id);
	}

	// 获取我的收藏
	@RequestMapping("/showMyCollect")
	public Result showMyCollect(String id) {
		List<Product> product = userService.showMyCollect(id);
		return result(product);
	}

	// 删除我的收藏
	@RequestMapping("/deleteMyCollect")
	public Result deleteMyCollect(String id) {
		boolean deleteMyCollect = userService.deleteMyCollect(id);
		return result(deleteMyCollect);
	}

	// 获取我的商品
	@RequestMapping("/showMyProduct")
	public Result showMyProduct(String id) {
		List<Product> product = userService.showMyProduct(id);
		return result(product);
	}

	// 删除我的商品
	@RequestMapping("/deleteMyProduct")
	public Result deleteMyProduct(String id) {
		boolean deleteMyProduct = userService.deleteMyProduct(id);
		return result(deleteMyProduct);
	}
	
	//添加商品（存到服务器）
	@RequestMapping(value = "/addProduct", method = RequestMethod.POST)
    public String addProduct(MultipartFile file,HttpServletResponse response,HttpServletRequest request) throws IOException{ 
        String fileName = file.getOriginalFilename();  
        InputStream inputStream = file.getInputStream();
        FileUtils.saveFile(inputStream, "E:\\software\\apache-tomcat-8.0.17\\wtpwebapps\\xkjy\\Resource\\img\\"+fileName);
        return "ok";
    }  
	
	// 添加商品（存到数据库）
	@RequestMapping(value = "/savaProduct", method = RequestMethod.POST)
	public Result savaProduct(HttpServletResponse response, HttpServletRequest request) {
		Product product = new Product();
		product.setName(request.getParameter("name"));
		product.setGategory(request.getParameter("gategory"));
		product.setPrice(request.getParameter("price"));
		product.setInventory(Integer.parseInt(request.getParameter("inventory")));
		String s = request.getParameter("imgUrl");
		String[] split = s.split("\\\\");
		product.setImgUrl(split[split.length - 1]);
		product.setProductDesc(request.getParameter("productDesc"));
		product.setUserId(request.getParameter("userId"));
		boolean data = productService.addProduct(product);
		return result(data);
	}

	//获取我的需求
	@RequestMapping("/showMyAffiche")
	public Result showMyAffiche(String id){
		errorMessage = "showMyAffiche";
		List<AfficheView> affiche = afficheService.getAfficheByUserId(id);
		return result(affiche);
	}

	// 删除我的需求
	@RequestMapping("/delMyAffiche")
	public Result delMyAffiche(String id) {
		boolean afficheById = afficheService.deleteAfficheById(id);
		return result(afficheById);
	}

	/**
	 * 登录系统
	 * 
	 * @param response
	 * @param request
	 * @param out
	 * @param session
	 * @param model
	 * @param username
	 * @param password
	 */
	@RequestMapping("/loginsubmit")
	public void loginsubmit(HttpServletResponse response, HttpServletRequest request, PrintWriter out,
			HttpSession session, Model model, String username, String password) {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("application/json; charset=utf-8");
		JSONObject responseJSONObject = null;
		Map<String, String> errmap = new HashMap<String, String>();
		try {
			List<?> list = userService.getUserByName(username);
			if (list != null && list.size() > 0) {
				User p = (User) list.get(0);
				if (password.equals(p.getPassword().trim())) {
					request.getSession().setAttribute("userId", p.getId());
					errmap.put("success", "true");
					errmap.put("id", p.getId());
				} else {
					errmap.put("success", "false");
					errmap.put("message", "1");
				}
			} else {
				errmap.put("success", "false");
				errmap.put("message", "0");
			}
		} catch (Exception e) { //
			errmap.put("success", "false");
			errmap.put("message", "2");
			e.printStackTrace();
		} finally {
			responseJSONObject = JSONObject.fromObject(errmap);
			try {
				out = response.getWriter();
			} catch (IOException e) {
				e.printStackTrace();
			}
			out.append(responseJSONObject.toString());
		}
	}

	/**
	 * 退出登录
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:login.jsp";
	}

}
