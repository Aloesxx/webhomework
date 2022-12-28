package com.spring.controller;

import com.alibaba.fastjson.*;
import com.spring.util.*;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 首页控制器
 */
@Controller
public class IndexController extends BaseController {

    // 首页
    @RequestMapping(value = { "/", "index" })
    public String Index() {
        List<Map> bhtList = Query.make("lunbotu").order("id desc").limit(5).select();
        assign("bhtList", bhtList);

        List<Map> zhaopianxinxilist1 = Query.make("zhaopianxinxi").limit(20).order("id desc").select();
        assign("zhaopianxinxilist1", zhaopianxinxilist1);
        if (isAjax()) {
            return json();
        }
        return "index";
    }
}
