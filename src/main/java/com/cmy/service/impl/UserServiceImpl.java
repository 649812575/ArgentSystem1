package com.cmy.service.impl;

import com.cmy.dao.UserDao;
import com.cmy.entity.User;
import com.cmy.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by cmy on 2018/6/24.
 */


@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao dao;

    @Override
    public User login(String userCode) {
        return dao.login(userCode);
    }
}
