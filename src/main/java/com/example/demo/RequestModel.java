package com.example.demo;

import lombok.Data;

import java.util.List;

@Data
public class RequestModel {
    List<WordPingyin> pywords;
    String title;
}
