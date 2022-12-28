package com.spring.service;

import com.spring.entity.Zhaopianxinxi;
import java.util.*;
import tk.mybatis.mapper.entity.Example;

public interface ZhaopianxinxiService {
    /**
     * 获取所有数据
     * @return
     */
    public List<Zhaopianxinxi> select();

    /**
     * 根据Zhaopianxinxi类搜索数据
     * @param y
     * @return
     */
    public List<Zhaopianxinxi> select(Zhaopianxinxi y);

    /**
     * 根据主键获取照片信息一行数据
     * @param id
     * @return
     */
    public Zhaopianxinxi find(Object id);

    /**
     * 根据照片信息获取照片信息类条件查询一行数据
     * @param id
     * @return
     */
    public Zhaopianxinxi findEntity(Zhaopianxinxi id);

    /**
     * 搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Zhaopianxinxi> selectPage(Zhaopianxinxi obj, int page, int pageSize);

    /**
     * 根据Example搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Zhaopianxinxi> selectPageExample(Example obj, int page, int pageSize);

    /**
     * 根据主键删除一行数据
     * @param id
     * @return
     */
    public int delete(Object id);

    /**
     * 插入照片信息     * @param y
     * @return
     */
    public int insert(Zhaopianxinxi y);

    /**
     * 更新照片信息     * @param y
     * @return
     */
    public int update(Zhaopianxinxi y);
}
