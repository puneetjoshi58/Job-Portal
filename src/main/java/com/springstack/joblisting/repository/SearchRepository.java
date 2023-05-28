package com.springstack.joblisting.repository;

import java.util.List;

import com.springstack.joblisting.model.Post;

public interface SearchRepository {
    
   
        List<Post> findByText(String text);
    
}
