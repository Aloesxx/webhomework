package com.spring.entity;

import com.spring.util.*;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Table(name = "zhaopianxinxi")
public class Zhaopianxinxi implements Serializable {

    private static final long serialVersionUID = 1L;

    @GeneratedValue(generator = "JDBC") // 自增的主键映射
    @Id
    @Column(name = "id", insertable = false)
    private Integer id;

    @Column(name = "zhaopianbianhao")
    private String zhaopianbianhao;

    @Column(name = "zhaopianmingcheng")
    private String zhaopianmingcheng;

    @Column(name = "fenlei")
    private String fenlei;

    @Column(name = "zhaopian")
    private String zhaopian;

    @Column(name = "paisheshijian")
    private String paisheshijian;

    @Column(name = "paishedidian")
    private String paishedidian;

    @Column(name = "zhaopianjianjie")
    private String zhaopianjianjie;

    @Column(name = "faburen")
    private String faburen;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getZhaopianbianhao() {
        return zhaopianbianhao;
    }

    public void setZhaopianbianhao(String zhaopianbianhao) {
        this.zhaopianbianhao = zhaopianbianhao;
    }

    public String getZhaopianmingcheng() {
        return zhaopianmingcheng;
    }

    public void setZhaopianmingcheng(String zhaopianmingcheng) {
        this.zhaopianmingcheng = zhaopianmingcheng;
    }

    public String getFenlei() {
        return fenlei;
    }

    public void setFenlei(String fenlei) {
        this.fenlei = fenlei;
    }

    public String getZhaopian() {
        return zhaopian;
    }

    public void setZhaopian(String zhaopian) {
        this.zhaopian = zhaopian;
    }

    public String getPaisheshijian() {
        return paisheshijian;
    }

    public void setPaisheshijian(String paisheshijian) {
        this.paisheshijian = paisheshijian;
    }

    public String getPaishedidian() {
        return paishedidian;
    }

    public void setPaishedidian(String paishedidian) {
        this.paishedidian = paishedidian;
    }

    public String getZhaopianjianjie() {
        return zhaopianjianjie;
    }

    public void setZhaopianjianjie(String zhaopianjianjie) {
        this.zhaopianjianjie = zhaopianjianjie;
    }

    public String getFaburen() {
        return faburen;
    }

    public void setFaburen(String faburen) {
        this.faburen = faburen;
    }
}
