package io.github.s0ooo0k.tftv2.controller;

import io.github.s0ooo0k.tftv2.model.dto.CommunityPostDTO;
import io.github.s0ooo0k.tftv2.model.repository.CommunityRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class MainController {
    @GetMapping("/")
    public String mainPage(Model model) throws Exception {
        // 이 부분 스프링으로 완전 전환 시 수정 필요...
        CommunityRepository communityRepository = new CommunityRepository();
        List<CommunityPostDTO> posts = communityRepository.findAll();
        model.addAttribute("posts", posts);
        return "main";
    }
}