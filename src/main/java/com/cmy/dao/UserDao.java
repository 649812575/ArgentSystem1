package com.cmy.dao;

import com.cmy.entity.User;

/**
 * Created by cmy on 2018/6/24.
 */
public interface UserDao {
    User login(String userCode);
}
