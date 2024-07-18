package com.human.bts.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
import com.human.bts.dao.FacilityDao;
import com.human.bts.vo.FacilityVO;
import java.util.List;



@RestController
@RequestMapping("/facility")
public class FacilityController {

    @Autowired
    private FacilityDao fcDao;

    @GetMapping("/getAllFacilities.bts")
    public List<FacilityVO> getFacilities() {
        return fcDao.getFcList();
    }
}




