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

@Service("DianzanService")
public class DianzanServiceImpl implements DianzanService {

    @Resource
    private DianzanMapper dao;

    /**
     * 获取所有数据
     * @return
     */
    public List<Dianzan> select() {
        return dao.select(null);
    }

    /**
     * 根据Dianzan类搜索数据
     * @param y
     * @return
     */
    public List<Dianzan> select(Dianzan y) {
        return dao.select(y);
    }

    /**
     * 根据主键获取点赞一行数据
     * @param id
     * @return
     */
    public Dianzan find(Object id) {
        return dao.selectByPrimaryKey(id);
    }

    /**
     * 根据点赞获取点赞类条件查询一行数据
     * @param id
     * @return
     */
    public Dianzan findEntity(Dianzan id) {
        return dao.selectOne(id);
    }

    /**
     * 搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Dianzan> selectPage(Dianzan obj, int page, int pageSize) {
        PageHelper.startPage(page, pageSize, true);
        List<Dianzan> list = select(obj);
        PageInfo<Dianzan> pageInfo = new PageInfo(list);
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
    public List<Dianzan> selectPageExample(Example obj, int page, int pageSize) {
        PageHelper.startPage(page, pageSize, true);
        List<Dianzan> list = dao.selectByExample(obj);
        PageInfo<Dianzan> pageInfo = new PageInfo(list);
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
     * 插入点赞     * @param y
     * @return
     */
    public int insert(Dianzan y) {
        return dao.insertSelective(y);
    }

    /**
     * 更新点赞     * @param y
     * @return
     */
    public int update(Dianzan y) {
        return dao.updateByPrimaryKeySelective(y);
    }
}
