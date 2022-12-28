package com.spring.service;

import com.spring.entity.Zhaopianfenlei;
import java.util.*;
import tk.mybatis.mapper.entity.Example;

public interface ZhaopianfenleiService {
    /**
     * 获取所有数据
     * @return
     */
    public List<Zhaopianfenlei> select();

    /**
     * 根据Zhaopianfenlei类搜索数据
     * @param y
     * @return
     */
    public List<Zhaopianfenlei> select(Zhaopianfenlei y);

    /**
     * 根据主键获取照片分类一行数据
     * @param id
     * @return
     */
    public Zhaopianfenlei find(Object id);

    /**
     * 根据照片分类获取照片分类类条件查询一行数据
     * @param id
     * @return
     */
    public Zhaopianfenlei findEntity(Zhaopianfenlei id);

    /**
     * 搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Zhaopianfenlei> selectPage(Zhaopianfenlei obj, int page, int pageSize);

    /**
     * 根据Example搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Zhaopianfenlei> selectPageExample(Example obj, int page, int pageSize);

    /**
     * 根据主键删除一行数据
     * @param id
     * @return
     */
    public int delete(Object id);

    /**
     * 插入照片分类     * @param y
     * @return
     */
    public int insert(Zhaopianfenlei y);

    /**
     * 更新照片分类     * @param y
     * @return
     */
    public int update(Zhaopianfenlei y);
}
