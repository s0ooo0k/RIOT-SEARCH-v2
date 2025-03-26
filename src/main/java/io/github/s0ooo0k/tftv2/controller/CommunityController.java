package io.github.s0ooo0k.tftv2.controller;

import io.github.s0ooo0k.tftv2.model.dto.CommunityPostDTO;
import io.github.s0ooo0k.tftv2.model.repository.CommunityRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/community")
public class CommunityController {
    final CommunityRepository communityRepository;

    public CommunityController(CommunityRepository communityRepository) {
        this.communityRepository = communityRepository;
    }

    // 커뮤니티 전체 글 보기
    @GetMapping
    public String root(Model model) throws Exception {
        List<CommunityPostDTO> posts = communityRepository.findAll();
        model.addAttribute("posts", posts);
        return "community";
    }

    // 저장
    @PostMapping("/post")
    // RequestParam(단일 파라미터 바인딩) vs ModelAttribute(dto 단위로 바인딩)
    public String save(
            @RequestParam("summonerName") String summonerName,
            @RequestParam("tier") String tier,
            @RequestParam("rank") String rank,
            @RequestParam("wins") int wins,
             @RequestParam("losses") int losses
    ) throws Exception {
        String imagePath = "/resources/static/tier/"+tier+".png";
        CommunityPostDTO post = new CommunityPostDTO(
                0, summonerName, tier, rank, wins, losses, imagePath,null
        );

        communityRepository.save(post);
        return "redirect:/community";
    }

//    @GetMapping("/delete")
//    public String delete(@RequestParam("id") long id) throws Exception {
//        communityRepository.delete(id);
//        return "redirect:/";
//    }
}
