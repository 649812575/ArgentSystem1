package com.cmy.controller;

import com.cmy.entity.User;
import com.cmy.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by cmy on 2018/6/24.
 */

@Controller
@RequestMapping("user")
public class UserController {

    @Resource(name="userService")
    private UserService service;

    @RequestMapping("login")
    @ResponseBody
    public Object login(HttpServletRequest request){
        boolean flag=false;
        //获取验证码
        String str=request.getParameter("vCode");

        if(str.equalsIgnoreCase(request.getSession().getAttribute("vcode").toString())) {
            //验证码正确
            String username = request.getParameter("userName");
            User user = service.login(username);
            if(user!=null){
                if (user.getUserPassword().equals(request.getParameter("password"))) {
                    request.getSession().setAttribute("user",user);
                    flag = true;
                }
            }else{
                return false;
            }
        }
        return flag;
    }
}
