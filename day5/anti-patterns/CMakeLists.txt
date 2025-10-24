cmake_minimum_required(VERSION 3.30)
project(hello-nix)

add_executable(hello-nix hello.cpp)

install(TARGETS hello-nix)
