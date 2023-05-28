package com.springstack.joblisting.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.springstack.joblisting.model.Post;

public interface PostRepository extends MongoRepository<Post, String> 
{
    
    
}
