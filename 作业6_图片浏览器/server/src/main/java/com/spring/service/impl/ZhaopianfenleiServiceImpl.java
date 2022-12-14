package com.spring.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.spring.dao.*;
import com.spring.entity.*;
import com.spring.service.*;
import com.spring.util.*;
import java.util.*;
import java.util.*;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

@Service("ZhaopianfenleiService")
public class ZhaopianfenleiServiceImpl implements ZhaopianfenleiService {

    @Resource
    private ZhaopianfenleiMapper dao;

    /**
     * 获取所有数据
     * @return
     */
    public List<Zhaopianfenlei> select() {
        return dao.select(null);
    }

    /**
     * 根据Zhaopianfenlei类搜索数据
     * @param y
     * @return
     */
    public List<Zhaopianfenlei> select(Zhaopianfenlei y) {
        return dao.select(y);
    }

    /**
     * 根据主键获取照片分类一行数据
     * @param id
     * @return
     */
    public Zhaopianfenlei find(Object id) {
        return dao.selectByPrimaryKey(id);
    }

    /**
     * 根据照片分类获取照片分类类条件查询一行数据
     * @param id
     * @return
     */
    public Zhaopianfenlei findEntity(Zhaopianfenlei id) {
        return dao.selectOne(id);
    }

    /**
     * 搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Zhaopianfenlei> selectPage(Zhaopianfenlei obj, int page, int pageSize) {
        PageHelper.startPage(page, pageSize, true);
        List<Zhaopianfenlei> list = select(obj);
        PageInfo<Zhaopianfenlei> pageInfo = new PageInfo(list);
        PageInfoUtil pageInfoUtil = new PageInfoUtil(page);
        pageInfoUtil.setPageInfo(Request.getRequest(), pageInfo.getTotal(), pageSize);
        return list;
    }

    /**
     * 根据Example搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Zhaopianfenlei> selectPageExample(Example obj, int page, int pageSize) {
        PageHelper.startPage(page, pageSize, true);
        List<Zhaopianfenlei> list = dao.selectByExample(obj);
        PageInfo<Zhaopianfenlei> pageInfo = new PageInfo(list);
        PageInfoUtil pageInfoUtil = new PageInfoUtil(page);
        pageInfoUtil.setPageInfo(Request.getRequest(), pageInfo.getTotal(), pageSize);
        return list;
    }

    /**
     * 根据主键删除一行数据
     * @param id
     * @return
     */
    public int delete(Object id) {
        return dao.deleteByPrimaryKey(id);
    }

    /**
     * 插入照片分类     * @param y
     * @return
     */
    public int insert(Zhaopianfenlei y) {
        return dao.insertSelective(y);
    }

    /**
     * 更新照片分类     * @param y
     * @return
     */
    public int update(Zhaopianfenlei y) {
        return dao.updateByPrimaryKeySelective(y);
    }
}
