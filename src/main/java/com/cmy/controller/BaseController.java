package com.cmy.controller;

import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.cmy.util.VCodeGenerator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("base")
public class BaseController {

	@RequestMapping("getImg")
	public void getImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setHeader("Expires", "-1");
		response.setHeader("cache-control", "no-cahce");
		response.setHeader("pragma", "no-cache");
		VCodeGenerator vcg = new VCodeGenerator();
		String vcode = vcg.generatorVCode();
		BufferedImage vcodeImage = vcg.generatorVCodeImage(vcode, true);
		request.getSession().setAttribute("vcode", vcode);
		ImageIO.write(vcodeImage, "gif", response.getOutputStream());
	}

}
