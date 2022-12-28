package com.spring.service;

import com.spring.entity.Dianzan;
import java.util.*;
import tk.mybatis.mapper.entity.Example;

public interface DianzanService {
    /**
     * 获取所有数据
     * @return
     */
    public List<Dianzan> select();

    /**
     * 根据Dianzan类搜索数据
     * @param y
     * @return
     */
    public List<Dianzan> select(Dianzan y);

    /**
     * 根据主键获取点赞一行数据
     * @param id
     * @return
     */
    public Dianzan find(Object id);

    /**
     * 根据点赞获取点赞类条件查询一行数据
     * @param id
     * @return
     */
    public Dianzan findEntity(Dianzan id);

    /**
     * 搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Dianzan> selectPage(Dianzan obj, int page, int pageSize);

    /**
     * 根据Example搜索分页
     * @param obj
     * @param page
     * @param pageSize
     * @return
     */
    public List<Dianzan> selectPageExample(Example obj, int page, int pageSize);

    /**
     * 根据主键删除一行数据
     * @param id
     * @return
     */
    public int delete(Object id);

    /**
     * 插入点赞     * @param y
     * @return
     */
    public int insert(Dianzan y);

    /**
     * 更新点赞     * @param y
     * @return
     */
    public int update(Dianzan y);
}
