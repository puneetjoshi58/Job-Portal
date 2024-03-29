package com.springstack.joblisting.controller;

import com.springstack.joblisting.model.Post;
import com.springstack.joblisting.repository.SearchRepository;
import com.springstack.joblisting.repository.PostRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import springfox.documentation.annotations.ApiIgnore;

import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpServletResponse;



@RestController
@CrossOrigin(origins = "http://localhost:3000")
public class PostController {

  @Autowired
  PostRepository repo;

  @Autowired
  SearchRepository srepo;

  @ApiIgnore
  @RequestMapping(value = "/")
  public void redirect(HttpServletResponse response) throws IOException {
    response.sendRedirect("/swagger-ui.html");
  }

  @GetMapping("/allPosts")
  @CrossOrigin
  public List<Post> getAllPosts() {
    return repo.findAll();
  }

 
  @GetMapping("/posts/{text}")
  @CrossOrigin
  public List<Post> search(@PathVariable String text) {
    return srepo.findByText(text);
  }

 
  @SuppressWarnings("null")
  @PostMapping("/post")
  @CrossOrigin
  public Post addPost(@RequestBody Post post) {
    return repo.save(post);
  }
}
