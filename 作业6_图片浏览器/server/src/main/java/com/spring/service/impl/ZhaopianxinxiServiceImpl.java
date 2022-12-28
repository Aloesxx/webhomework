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

@Service("ZhaopianxinxiService")
public class ZhaopianxinxiServiceImpl implements ZhaopianxinxiService {

    @Resource
    private ZhaopianxinxiMapper dao;

    /**
     * 获取所有数据
     * @return
     */
    public List<Zhaopianxinxi> select() {
        return dao.select(null);
    }

    /**
     * 根据Zhaopianxinxi类搜索数据
     * @param y
     * @return
     */
    public List<Zhaopianxinxi> select(Zhaopianxinxi y) {
        return dao.select(y);
    }

    /**
     * 根据主键获取照片信息一行数据
     * @param id
     * @return
     */
    public Zhaopianxinxi find(Object id) {
        return dao.selectByPrimaryKey(id);
    }

    /**
     * 根据照片信息获取照片信息类条件查询一行数据
     * @param id
     * @return
     */
    public Zhaopianxinxi findEntity(Zhaopianxinxi id) {
        return dao.selectOne(id);
    }

    /**
     * 搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Zhaopianxinxi> selectPage(Zhaopianxinxi obj, int page, int pageSize) {
        PageHelper.startPage(page, pageSize, true);
        List<Zhaopianxinxi> list = select(obj);
        PageInfo<Zhaopianxinxi> pageInfo = new PageInfo(list);
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
    public List<Zhaopianxinxi> selectPageExample(Example obj, int page, int pageSize) {
        PageHelper.startPage(page, pageSize, true);
        List<Zhaopianxinxi> list = dao.selectByExample(obj);
        PageInfo<Zhaopianxinxi> pageInfo = new PageInfo(list);
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
     * 插入照片信息     * @param y
     * @return
     */
    public int insert(Zhaopianxinxi y) {
        return dao.insertSelective(y);
    }

    /**
     * 更新照片信息     * @param y
     * @return
     */
    public int update(Zhaopianxinxi y) {
        return dao.updateByPrimaryKeySelective(y);
    }
}
