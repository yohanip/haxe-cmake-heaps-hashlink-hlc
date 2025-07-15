cmake_minimum_required(VERSION 3.26)

include("../cmake/HunterGate.cmake")

HunterGate(
    URL "https://github.com/cpp-pm/hunter/archive/v0.26.1.tar.gz"
    SHA1 "e41ac7a18c49b35ebac99ff2b5244317b2638a65"
)

project(MyAndroidApp)
    
hunter_add_package(PNG)
hunter_add_package(Jpeg)
hunter_add_package(libjpeg-turbo)

add_subdirectory(hashlink)
# add_subdirectory(.. main_project)