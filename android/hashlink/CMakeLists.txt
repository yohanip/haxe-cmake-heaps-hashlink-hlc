cmake_minimum_required(VERSION 3.26)

project(AndroidHashlink)

set(HL_DIR $ENV{HASLINK_DIR})
set(BUILD_TESTING false)
set(WITH_VM false)

add_subdirectory(${HL_DIR} hshlink)